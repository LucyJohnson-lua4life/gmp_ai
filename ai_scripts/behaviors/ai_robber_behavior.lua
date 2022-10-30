local ai_state = require "ai_scripts/ai_state"
local ai_actions = require "ai_scripts/ai_actions"
local ai_helper = require "ai_scripts/ai_helper"
local ai_defaults = require "ai_scripts/ai_defaults"
local script_time = require "helper/script_time"
local ai_robber_behavior = {}
local TIME_TO_WAIT_MS = 3000
local WARN_DISTANCE = 500
local WANDER_FREQUENCY = 1200000

local robber_wps = {
    "NW_CITY_TO_LIGHTHOUSE_16",
    "NW_TO_PASS_01",
    "NW_FARM2_TO_TAVERN_RANGERBANDITS_01",
    "NW_BIGMILL_FARM3_RANGERBANDITS_02",
    "NW_FLEEDMT_KAP3",
    "NW_FARM4_WOOD_RANGERBANDITS_02",
    "NW_FARM4_WOOD_MONSTER_N_5",
    "NW_FARM3_PATH_14",
    "NW_TROLLAREA_PATH_57",
    "NW_TROLLAREA_PATH_32",
    "NW_TROLLAREA_RUINS_37",
    "NW_TROLLAREA_RUINS_33",
    "NW_TROLLAREA_PLANE_02",
    "NW_TROLLAREA_PATH_01_01",
    "NW_TROLLAREA_PATH_71_MONSTER2",
    "NW_TAVERNE_06"
}

local function getEvasiveAction(ai_data)
    local random = math.random(1, 10)
    if ai_helper.isTargetInFrontOfAi(ai_data.id, ai_data.enemy_id) and random <= 2 then
        return ai_actions.createParadeAction(ai_data.id, 200)
    elseif ai_helper.isTargetInFrontOfAi(ai_data.id, ai_data.enemy_id) and random <= 7 then
        local strafe_random = math.random(1, 10)
        if strafe_random <= 5 then
            return ai_actions.createStrafeRightWithPauseAction(ai_data.id, 400)
        else
            return ai_actions.createStrafeLeftWithPauseAction(ai_data.id, 400)
        end
    elseif ai_helper.isTargetInFrontOfAi(ai_data.id, ai_data.enemy_id) and random <= 9 then
        return ai_actions.createParadeAction(ai_data.id, 900)
    else
        return ai_actions.createTurnToTargetAction(ai_data.id)
    end
end

local function getRandomAttackAction(ai_data)
    local random = math.random(1, 10)
    
    if random >= 3 then
        return ai_actions.createTripleQuickAttackAction(ai_data.id)
    else
        return ai_actions.createForwardAttackWithPauseAction(ai_data.id, 200)
    end
end

local function getFightAction(ai_data)
    local last_attack_time = ai_data.last_attack_time
    local distance = GetDistancePlayers(ai_data.id, ai_data.enemy_id)
    local attack_range = ai_data.attack_range
    
    if GetPlayerWeaponMode(ai_data.id) ~= ai_data.weapon_mode then
        SetPlayerWeaponMode(ai_data.id, ai_data.weapon_mode)
    end
    
    if last_attack_time == nil then
        last_attack_time = 0
    end
    
    if attack_range == nil then
        attack_range = ai_defaults.ATTACK_RANGE
    end
    
    local time_diff = math.abs(script_time.getNowInMs() - last_attack_time)
    
    if ai_helper.isTargetInFrontOfAi(ai_data.id, ai_data.enemy_id) and time_diff > TIME_TO_WAIT_MS then
        ai_data.last_attack_time = script_time.getNowInMs()
        return getRandomAttackAction(ai_data)
    elseif distance <= attack_range - 150 then
        return ai_actions.createParadeAction(ai_data.id, 200)
    else
        return getEvasiveAction(ai_data)
    end
end

local function isAiFarAwayFromStartPosition(ai_data, world)
    local start_position = ai_state.getWaynetObject().getPositionObject(ai_data.position_name, world)
    local current_x, current_y, current_z = GetPlayerPos(ai_data.id)
    local distance_to_start_pos = ai_helper.getDistance(start_position.x, start_position.y, start_position.z, current_x, current_y, current_z)
    return distance_to_start_pos > 1500
end

function ai_robber_behavior.getNextAction(ai_id)
    local ai_data = ai_state.getNpcList()[ai_id]
    local attack_range = ai_data.attack_range
    local close_by_char_id = ai_state.getFirstCharacterInArea(ai_id)
    local world = GetPlayerWorld(ai_id)
    
    if attack_range == nil then
        attack_range = ai_defaults.ATTACK_RANGE
    end
    
    if ai_data.hit_by ~= nil then
        ai_data.enemy_id = ai_data.hit_by
        ai_data.hit_by = nil
    end
    
    if ai_data.enemy_id ~= nil then
        if IsDead(ai_data.enemy_id) == 1 or IsPlayerConnected(ai_data.enemy_id) == 0 or IsUnconscious(ai_data.enemy_id) == 1 then
            ai_data.enemy_id = nil
        end
    end
    
    if ai_data.last_wander_time == nil then
        ai_data.last_wander_time = script_time.getNowInMs()
    end
    
    if ai_data.enemy_id ~= nil then
        local distance = GetDistancePlayers(ai_data.id, ai_data.enemy_id)
        if distance > attack_range and distance < attack_range + WARN_DISTANCE then
            return ai_actions.createRunToTargetAction(ai_data.id, ai_data.enemy_id)
        elseif distance > attack_range + WARN_DISTANCE then
            ai_data.enemy_id = nil
        elseif distance <= attack_range then
            return getFightAction(ai_data)
        end
    elseif close_by_char_id ~= -1 and GetDistancePlayers(ai_id, close_by_char_id) < ai_defaults.WARN_RANGE and IsDead(close_by_char_id) == 0 and IsUnconscious(close_by_char_id) == 0 then
        return ai_actions.createThreatenAction(ai_id, close_by_char_id, 5000)
    elseif isAiFarAwayFromStartPosition(ai_data, world) == true then
        return ai_actions.gotoPosition(ai_id, ai_data.position_name, world)
    elseif script_time.getNowInMs() > ai_data.last_wander_time + WANDER_FREQUENCY then
        ai_data.position_name = robber_wps[math.random(1, #robber_wps)]
        return ai_actions.gotoPosition(ai_id, ai_data.position_name, world)
    else
        return ai_actions.createPlayAnimationAction(ai_id, "S_LGUARD")
    end
end


return ai_robber_behavior
