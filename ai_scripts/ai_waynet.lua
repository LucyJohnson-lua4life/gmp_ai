require "helper/lua_helper"
local ai_helper = require "ai_scripts/ai_helper"
local ai_waynet = {}
local freepoints = {}
local waynet = {}
local MAX_DISTANCE = 9999999999999



function ai_waynet.loadFreePoints(file, world)
    local fh = io.open(file, "r")
    local world_name = string.upper(trim(world))
    freepoints[world_name] = {}
    for line in fh:lines() do
        local values = string.split(line, ";")
        local fp = {}
        fp.name = string.upper(trim(values[1]))
        fp.x = tonumber(values[2])
        fp.y = tonumber(values[3])
        fp.z = tonumber(values[4])
        fp.dir_x = tonumber(values[5])
        fp.dir_z = tonumber(values[6])
        freepoints[world_name][fp.name] = fp
    end
    fh:close()
end


function ai_waynet.loadWaynet(file, world)
    local fh = io.open(file, "r")
    local world_name = string.upper(trim(world))
    waynet[world_name] = {}
    for line in fh:lines() do
        local values = string.split(line, ";")
        local wp = {}
        wp.name = string.upper(trim(values[1]))
        wp.x = tonumber(values[2])
        wp.y = tonumber(values[3])
        wp.z = tonumber(values[4])
        wp.dir_x = tonumber(values[5])
        wp.dir_z = tonumber(values[6])
        -- list of wp names
        --Remove the first 4 values from 4 to 1. After that the table includes only the next waypoints
        table.remove(values, 6)
        table.remove(values, 5)
        table.remove(values, 4)
        table.remove(values, 3)
        table.remove(values, 2)
        table.remove(values, 1)
        
        wp.next_wps = values
        
        waynet[world_name][wp.name] = wp
    
    end
    fh:close();
end


local function createNodeByWpName(wp_name, world)
    local node = table.copy(waynet[world][wp_name])
    node.aproximate_abs_distance = 0 
    node.distance_to_start = 0 
    node.distance_to_end = 0 
    return node
end


local function deleteNodeByWpName(node_list, wp_name)
    for index, node in pairs(node_list) do
        if node.name == wp_name then
            node_list[index] = nil
        end
    end
end

local function popNodeWithMinFlightDistance(nodes_to_visit)
    local lowest_distance = MAX_DISTANCE
    local closest_node_to_goal = nil

    for _, node in pairs(nodes_to_visit) do
        if node.aproximate_abs_distance < lowest_distance then
            lowest_distance = node.aproximate_abs_distance
            closest_node_to_goal = node
        end
    end

    if closest_node_to_goal ~= nil then
        deleteNodeByWpName(nodes_to_visit, closest_node_to_goal.name)
    end

    return closest_node_to_goal
end


-- expands current node and puts them in a list of next routes to visit, while adding heuristal data to these nodes for ordering later
local function getNextNodesToVisit(nodes_to_visit, route_nodes, current_node, target_wp_name, world)
    if #current_node.next_wps == 0 then
        return route_nodes
    end

    local result = {}

    for _, neighbor_wp_name in pairs(current_node.next_wps) do
        local neighbor_wp = waynet[world][neighbor_wp_name] 
        
        if route_nodes[neighbor_wp_name] == nil and neighbor_wp ~= nil then
            local neighbor_node = nodes_to_visit[neighbor_wp_name]
            local distance_to_neighbor = ai_helper.getDistance(current_node.x, current_node.y, current_node.z, neighbor_wp.x, neighbor_wp.y, neighbor_wp.z)
            local distance_to_start = current_node.distance_to_start + distance_to_neighbor

            -- check if distance_to_start is NOT greater than neighbor_node.distance_to_start
            if (neighbor_node ~= nil and distance_to_start > neighbor_node.distance_to_start) == false then
                --aproximate means, that we are measuring the distance straight between point a to b, without measuring the distances of the nodes in between
                --measuring the aproximate absolute distance is enough of an heuristic for us to decide which node to chose next*/
                local target_wp = waynet[world][target_wp_name]
                local approximate_distance_to_end = ai_helper.getDistance(target_wp.x, target_wp.y, target_wp.z, neighbor_wp.x, neighbor_wp.y, neighbor_wp.z)
                local aproximate_abs_distance  = distance_to_start + approximate_distance_to_end
                local new_node_to_visit = createNodeByWpName(neighbor_wp_name, world)
                new_node_to_visit.distance_to_start = distance_to_start
                new_node_to_visit.aproximate_abs_distance = aproximate_abs_distance
                result[neighbor_wp_name] = new_node_to_visit
            end
        end
        
    end
    return result
end


function ai_waynet.getUnorderedWayRoute(start_wp_name, target_wp_name, world)
    local nodes_to_visit = {}
    local result = {}
    nodes_to_visit[start_wp_name] = createNodeByWpName(start_wp_name, world)

    while next(nodes_to_visit) ~= nil do
        local current_node = popNodeWithMinFlightDistance(nodes_to_visit)
        if current_node == nil then
            result = {}
            break
        end

        if current_node.name == target_wp_name then
            result[current_node.name] = current_node
            break
        end

        local next_nodes_to_visit = getNextNodesToVisit(nodes_to_visit, result, current_node, target_wp_name, world)

        for k,v in pairs(next_nodes_to_visit) do
            nodes_to_visit[k] = v
        end
        result[current_node.name] = current_node

    end

    return result
end

local function getNeighborWithMinNetDistance(current_wp_name, route_nodes, world)
    local smallest_distance = MAX_DISTANCE
    local next_min_wp = nil

    local current_wp = waynet[world][current_wp_name]
    for _,neighbor_wp_name in pairs(current_wp.next_wps) do
        local neighbor_node = route_nodes[neighbor_wp_name]

        if neighbor_node ~= nil then
            local distance = ai_helper.getDistance(current_wp.x,current_wp.y, current_wp.z, neighbor_node.x, neighbor_node.y, neighbor_node.z)
            local current_node = route_nodes[current_wp_name]

            if current_node ~= nil and neighbor_node ~= nil then
                local abs_distance = current_node.distance_to_end + distance + neighbor_node.distance_to_start

                if smallest_distance > abs_distance then
                    smallest_distance = abs_distance
                    next_min_wp = waynet[world][neighbor_wp_name]
                    route_nodes[neighbor_wp_name].distance_to_end = current_node.distance_to_end + distance
                end
            end
        end
        
    end

    return next_min_wp
end

local function getNodeRoutesOrderedByMinNetDistance(route_nodes, start_wp_name, target_wp_name, world)
    local wayroute = {}
    local current_wp = waynet[world][target_wp_name]

    if current_wp ~= nil then
        table.insert(wayroute, current_wp)

        while current_wp.name ~= start_wp_name do
            local last_current_wp = current_wp
            current_wp = getNeighborWithMinNetDistance(current_wp.name, route_nodes, world)

            if current_wp == nil then
                return {}
            end

            table.insert(wayroute, current_wp)
            route_nodes[last_current_wp.name] = nil
        end
        
    end

    return table.reverse(wayroute)

end

function ai_waynet.getWayRoute(start_wp_name, target_wp_name, world)
    local unordered_way_route = ai_waynet.getUnorderedWayRoute(start_wp_name, target_wp_name, world)
    local way_route = {}

    if waynet[world][start_wp_name] == nil or waynet[world][target_wp_name] == nil then
        print("start -, or target waypoint is wrong")
        return nil
    end

    if unordered_way_route ~= nil then
        local node_route = getNodeRoutesOrderedByMinNetDistance(unordered_way_route, start_wp_name, target_wp_name, world)

        for _,v in pairs(node_route) do
            table.insert(way_route, v.name)
        end
        return way_route
    end

    return nil
end


function ai_waynet.getNearestWaypointNameByCoordinates(x, y, z, world)
    local nearest_wp = nil
    local shortest_distance = MAX_DISTANCE

    for k,v in pairs(waynet[world]) do
        local distance = ai_helper.getDistance(v.x, v.y, v.z, x, y, z)
        if distance < shortest_distance then
            shortest_distance = distance
            nearest_wp = v
        end
    end
    return nearest_wp.name
end

function ai_waynet.getNearestWaypointNameByFp(fp_name, world)
    if waynet[world][fp_name] == nil then
        local fp = freepoints[world][fp_name]
        if fp ~= nil then
            return ai_waynet.getNearestWaypointNameByCoordinates(fp.x, fp.y, fp.z, world)
        else
            print("Freepoint: " .. fp_name .. " not found.")
            return "START"
        end
    end
end

function ai_waynet.getWaynet()
    return waynet
end

function ai_waynet.getPositionObject(position_name, world)
    local target_position = nil

    if waynet[world][position_name] ~= nil then
        target_position = waynet[world][position_name]
    elseif freepoints[world][position_name] ~= nil then
        target_position = freepoints[world][position_name]
    end
    return target_position
end

function ai_waynet.getFreePoints()
    return freepoints
end

return ai_waynet
