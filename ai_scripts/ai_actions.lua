local ai_state = require "ai_scripts/ai_state"
local ai_state_funcs = require "ai_scripts/ai_state_funcs"
local ai_helper = require "ai_scripts/ai_helper"
local ai_defaults = require "ai_scripts/ai_defaults"
local script_time = require "helper/script_time"
local ai_actions = {}

local function executeHit(ai_data)
    local is_target_in_front_of_ai = ai_helper.isTargetInFrontOfAi(ai_data.id, ai_data.enemy_id)
    local attack_range = ai_data.attack_range
    if attack_range == nil then
        attack_range = ai_defaults.ATTACK_RANGE
    end
    
    if (IsNPC(ai_data.id) == 1 and IsNPC(ai_data.enemy_id) == 1) then
        local hp = GetPlayerHealth(ai_data.enemy_id) - GetPlayerStrength(ai_data.id);
        if (hp < 0) then
            hp = 0;
        end
        SetPlayerHealth(ai_data.enemy_id, hp);
        OnPlayerHit(ai_data.enemy_id, ai_data.id);
    
    elseif is_target_in_front_of_ai == true and GetDistancePlayers(ai_data.id, ai_data.enemy_id) < attack_range then
        HitPlayer(ai_data.id, ai_data.enemy_id);
    end
end

function ai_actions.createRunToTargetAction(ai_id, target_id)
    local action = {}
    
    action.executeAction = function()
        if IsPlayerConnected(target_id) == 1 and GetPlayerHealth(target_id) > 0 then
            local ai_data = ai_state.getCharacterList()[ai_id]
            ai_helper.watchTarget(ai_id, target_id)
            local ani = ai_helper.getAnimationName("S", ai_data.weapon_mode, "RUNL")
            PlayAnimation(ai_id, ani);
        end
    end
    
    return action
end

function ai_actions.createForwardAttackWithPauseAction(ai_id, pause_time)
    local action = {}
    action.is_looping = true
    
    action.executeAction = function()
        local ai_data = ai_state.getNpcList()[ai_id]
        
        if action.start_time == nil then
            action.start_time = script_time.getNowInMs()
            PlayAnimation(ai_data.id, ai_helper.getAnimationName("S", ai_data.weapon_mode, "ATTACK"))
            executeHit(ai_data)
        end
        
        if script_time.getNowInMs() > action.start_time + pause_time then
            action.is_looping = false
        end
    
    end
    
    return action
end


function ai_actions.createStrafeRightWithPauseAction(ai_id, pause_time)
    local action = {}
    action.is_looping = true
    
    action.executeAction = function()
        local ai_data = ai_state.getNpcList()[ai_id]
        
        if action.start_time == nil then
            action.start_time = script_time.getNowInMs()
            PlayAnimation(ai_data.id, ai_helper.getAnimationName("T", ai_data.weapon_mode, "RUNSTRAFER"))
        end
        
        if script_time.getNowInMs() > action.start_time + pause_time then
            action.is_looping = false
        end
    
    end
    
    return action
end


function ai_actions.createStrafeLeftWithPauseAction(ai_id, pause_time)
    local action = {}
    action.is_looping = true
    
    action.executeAction = function()
        local ai_data = ai_state.getNpcList()[ai_id]
        if action.start_time == nil then
            action.start_time = script_time.getNowInMs()
            PlayAnimation(ai_data.id, ai_helper.getAnimationName("T", ai_data.weapon_mode, "RUNSTRAFEL"))
        end
        
        if script_time.getNowInMs() > action.start_time + pause_time then
            action.is_looping = false
        end
    
    end
    
    return action
end

function ai_actions.createParadeAction(ai_id, pause_time)
    local action = {}
    action.is_looping = true
    
    action.executeAction = function()
        local ai_data = ai_state.getNpcList()[ai_id]
        
        if action.start_time == nil then
            action.start_time = script_time.getNowInMs()
            PlayAnimation(ai_data.id, ai_helper.getAnimationName("T", ai_data.weapon_mode, "PARADEJUMPB"))
        end
        
        if script_time.getNowInMs() > action.start_time + pause_time then
            action.is_looping = false
        end
    end
    
    return action
end

function ai_actions.createWarnAction(ai_id, target_id, warn_time, warn_distance)
    local action = {}
    action.is_looping = true
    
    action.executeAction = function()
        local ai_data = ai_state.getNpcList()[ai_id]
        
        if action.start_time == nil then
            action.start_time = script_time.getNowInMs()
        end
        
        if GetPlayerHealth(target_id) > 0 and IsPlayerConnected(target_id) then
            ai_helper.watchTarget(ai_data.id, target_id)
            local current_distance = GetDistancePlayers(ai_data.id, target_id)
            local atttack_distance = ai_data.fight_range
            
            if atttack_distance == nil then
                atttack_distance = ai_defaults.ATTACK_RANGE
            end
            
            if script_time.getNowInMs() > action.start_time + warn_time and current_distance < warn_distance then
                ai_state.getNpcList()[ai_data.id].enemy_id = target_id
                action.is_looping = false
            end
            
            if current_distance < atttack_distance then
                ai_state.getNpcList()[ai_data.id].enemy_id = target_id
                action.is_looping = false
            elseif current_distance < warn_distance then
                PlayAnimation(ai_data.id, "T_WARN")
            
            else
                action.is_looping = false
            end
        else
            action.is_looping = false
        end
    
    end
    
    return action
end

function ai_actions.createTurnToTargetAction(ai_id)
    local action = {}
    
    action.executeAction = function()
        local ai_data = ai_state.getNpcList()[ai_id]
        ai_helper.watchTarget(ai_data.id, ai_data.enemy_id)
    end
    
    return action
end

function ai_actions.createStopAction(ai_id)
    local action = {}
    
    action.executeAction = function()
        local ai_data = ai_state.getCharacterList()[ai_id]
        ai_helper.stopAnimation(ai_data)
    end
    return action
end


-- TODO: GOTOPOSITION implementieren
function ai_actions.gotoPosition(ai_id, target_position_name, world)
    local waynet = ai_state.getWaynetObject()
    local x, y, z = GetPlayerPos(ai_id)
    local closest_start_wp_name = waynet.getNearestWaypointNameByCoordinates(x, y, z, world)
    local target_wp_name = nil
    local action = {}
    action.is_looping = true
    if waynet.getWaynet()[world][target_position_name] ~= nil then
        target_wp_name = target_position_name
    else
        target_wp_name = waynet.getNearestWaypointNameByFp(target_position_name, world)
    end
    action.way_route = waynet.getWayRoute(closest_start_wp_name, target_wp_name, world)
    action.route_index = 1
    --waynet.printWayPath(closest_start_wp_name, target_wp_name)
    action.executeAction = function()
        local next_wp_name = action.way_route[action.route_index]
        local target_wp = waynet.getWaynet()[world][next_wp_name]
        --print("next: " .. next_wp_name .. ", " .. target_wp.x .. ", " .. target_wp.y .. ", " .. target_wp.z)
        ai_state_funcs.gotoPosition(ai_id, target_wp.x, target_wp.y, target_wp.z)
        local current_x, current_y, current_z = GetPlayerPos(ai_id)
        
        if ai_state.getNpcList()[ai_id].hit_by ~= nil then
            action.is_looping = false
            PlayAnimation(ai_id, ai_state_funcs.getCombatStateBasedAni(ai_id, "S_", "RUN"))
        end
        
        if action.way_route ~= nil and action.route_index < #action.way_route then
            if ai_helper.getDistance(target_wp.x, target_wp.y, target_wp.z, current_x, current_y, current_z) < 100 then
                action.route_index = action.route_index + 1
            else
                local angle_to_next_wp = ai_helper.getRadiansAngle(current_x, current_z, target_wp.x, target_wp.z)
                SetPlayerAngle(ai_id, angle_to_next_wp)
                PlayAnimation(ai_id, ai_state_funcs.getCombatStateBasedAni(ai_id, "S_", "WALKL"))
            end
        --PlayAnimation(ai_id, "S_FISTWALKL")
        else
            action.is_looping = false
            PlayAnimation(ai_id, ai_state_funcs.getCombatStateBasedAni(ai_id, "S_", "RUN"))
        end
    end
    
    return action
end


function ai_actions.createEatAction(ai_id)
    local action = {}
    action.is_looping = false
    
    action.executeAction = function()
        if GetPlayerAnimationName(ai_id) ~= "S_EAT" then
            PlayAnimation(ai_id, "S_EAT")
        end
    end
    return action
end


function ai_actions.createPlayAnimationAction(ai_id, anim)
    local action = {}
    action.is_looping = false
    
    action.executeAction = function()
        if GetPlayerAnimationName(ai_id) ~= anim then
            PlayAnimation(ai_id, anim)
        end
    end
    return action
end


function ai_actions.createThreatenAction(ai_id, target_id, wait_time_ms)
    local action = {}
    
    action.times_warned = 1
    action.wait_time_ms = wait_time_ms
    action.start_wait_time = nil
    action.dialogue = {"Hey idiot! Whats with that stupid look of yours?", "EY I'm talking to you!", "I've had enough. Lets teach you a lesson!"}
    action.chase_distance = 300
    action.is_looping = true
    
    action.executeAction = function()
            
            if ai_state.getNpcList()[ai_id].hit_by ~= nil then
                action.is_looping = false
                ai_state.getNpcList()[ai_id].enemy_id = target_id
            end
            
            if IsPlayerConnected(target_id) == 1 and IsDead(target_id) == 0 and IsUnconscious(target_id) == 0 then
                local ai_data = ai_state.getCharacterList()[ai_id]
                ai_helper.watchTarget(ai_id, target_id)
                local distance = GetDistancePlayers(ai_id, target_id)
                
                if action.start_wait_time == nil then
                    SendPlayerMessage(target_id, 255, 255, 255, GetPlayerName(ai_id) .. " says: " .. action.dialogue[action.times_warned])
                    action.start_wait_time = script_time.getNowInMs()
                end
                
                if distance < action.chase_distance then
                    PlayAnimation(ai_id, ai_state_funcs.getCombatStateBasedAni(ai_id, "S_", "RUN"))
                else
                    PlayAnimation(ai_id, ai_helper.getAnimationName("S", ai_data.weapon_mode, "RUNL"));
                end
                
                if script_time.getNowInMs() > action.start_wait_time + action.wait_time_ms then
                    action.start_wait_time = script_time.getNowInMs()
                    action.times_warned = action.times_warned + 1
                    SendPlayerMessage(target_id, 255, 255, 255, GetPlayerName(ai_id) .. " says: " .. action.dialogue[action.times_warned])
                end
                
                if action.times_warned >= #action.dialogue then
                    action.is_looping = false
                    ai_data.enemy_id = target_id
                end
            end
    end
    
    return action
end


function ai_actions.createTripleQuickAttackAction(ai_id)
    local action = {}
    action.is_looping = true
    action.start_time = nil
    action.attack_counter = 0
    
    action.executeAction = function()
        local ai_data = ai_state.getNpcList()[ai_id]
        if action.start_time == nil and action.attack_counter == 0 then
            action.start_time = script_time.getNowInMs()
            PlayAnimation(ai_data.id, ai_helper.getAnimationName("T", ai_data.weapon_mode, "ATTACKL"))
            executeHit(ai_data)
            action.attack_counter = action.attack_counter + 1
        elseif script_time.getNowInMs() > action.start_time + 350 and action.attack_counter == 1 then
            PlayAnimation(ai_data.id, ai_helper.getAnimationName("T", ai_data.weapon_mode, "ATTACKR"))
            executeHit(ai_data)
            action.attack_counter = action.attack_counter + 1
        elseif script_time.getNowInMs() > action.start_time + 700 and action.attack_counter == 2 then
            PlayAnimation(ai_data.id, ai_helper.getAnimationName("T", ai_data.weapon_mode, "ATTACKL"))
            executeHit(ai_data)
            action.attack_counter = action.attack_counter + 1
        elseif script_time.getNowInMs() > action.start_time + 1100 and action.attack_counter >= 3 then
            action.is_looping = false
        end
    end
    
    return action
end



return ai_actions
