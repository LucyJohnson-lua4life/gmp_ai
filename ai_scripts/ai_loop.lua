local ai_state = require "ai_scripts/ai_state"
local script_time = require "helper/script_time"
local ai_state_funcs = require "ai_scripts/ai_state_funcs"

local ai_loop = {}

local function respawnNpc(ai_data)
    local world = GetPlayerWorld(ai_data.id);
    local position_name = ai_data.position_name
    DestroyNPC(ai_data.id);
    ai_state.getNpcList()[ai_data.id] = nil

    ai_data.last_pos_update = nil
    ai_data.last_pos_x = nil
    ai_data.last_pos_y = nil
    ai_data.last_pos_z = nil
    ai_data.death_time = nil
    ai_data.next_acttion = nil

    ai_state_funcs.spawnNpc(ai_data, position_name, world)
end

local function respawnDeadNpc(ai_data)
    if ai_data.death_time ~= nil
    and IsNPC(ai_data.id) == 1
    and script_time.getNowInMs() > ai_data.death_time + ai_data.respawn_time_ms
    then
        respawnNpc(ai_data)
    end
end

function ai_loop.runAiLoop()
    ai_state.updateAreaPosition()
    for k, _ in pairs(ai_state.getNpcList()) do
        local ai_data = ai_state.getNpcList()[k]
        respawnDeadNpc(ai_data)

        if IsDead(ai_data.id) == 1 then
            ai_data.next_action = nil
        end

        if ai_data.next_action == nil and IsDead(ai_data.id) == 0 and IsUnconscious(ai_data.id) == 0 then
            ai_data.next_action = ai_data.behavior.getNextAction(ai_data.id)
        end
        
        if ai_data.next_action ~= nil then
                ai_data.next_action.executeAction()
            if ai_data.next_action.is_looping ~= true then
                ai_data.next_action = nil
            end
        end

    end
end

return ai_loop
