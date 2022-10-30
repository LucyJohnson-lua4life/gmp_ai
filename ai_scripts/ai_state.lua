local ai_waynet_object = require "ai_scripts/ai_waynet"
local ai_state = {}
local character_list = {}
local npc_list = {}
local AI_TARGET_DISTANCE = 2500


function ai_state.getCharacterList()
    return character_list
end

function ai_state.getNpcList()
    return npc_list
end

function ai_state.isAlive(id)
    return character_list[id] ~= nil and character_list[id].isAlive == true
end

function ai_state.getWaynetObject()
    return ai_waynet_object
end

function ai_state.OnGamemodeInit()
	ai_waynet_object.loadFreePoints("ai_scripts/newworld.fp", "NEWWORLD\\NEWWORLD.ZEN")
	ai_waynet_object.loadWaynet("ai_scripts/newworld.wp", "NEWWORLD\\NEWWORLD.ZEN")
end

local function calculate_area_index(ai_id)
    local x,y,z = GetPlayerPos(ai_id)
 return 
   math.floor(x / AI_TARGET_DISTANCE) + 1000 
 * math.floor(y / AI_TARGET_DISTANCE) + 1000 
 * math.floor(z / AI_TARGET_DISTANCE) * 1000
end

local function getFirstOtherCharacterInArea(ai_id, characters_in_area)
    for k,v in pairs(characters_in_area) do
        if v ~= ai_id and IsNPC(v) == 0 then
            return v
        end
    end
    return -1
end

function ai_state.getFirstCharacterInArea(ai_id)
    local nearest_character = -1
    local world = GetPlayerWorld(ai_id)
    local characters_in_area = area_positions[world][calculate_area_index(ai_id)]

    if characters_in_area ~= nil then
        nearest_character = getFirstOtherCharacterInArea(ai_id, characters_in_area)
    end
    return nearest_character
end

function ai_state.updateAreaPosition()
    area_positions = {}

    for k,_ in pairs(ai_state.getCharacterList()) do
        local area_index = calculate_area_index(k)
        local world = GetPlayerWorld(k)
        if area_positions[world] == nil then
            area_positions[world] = {}
        end

        if area_positions[world][area_index] == nil then
            area_positions[world][area_index] = {}
        end
        table.insert(area_positions[world][area_index], k)
    end
end

return ai_state