local script_time = require "helper/script_time"
require "helper/lua_helper"
local ai_state = require "ai_scripts/ai_state"
local ai_helper = require "ai_scripts/ai_helper"
local ai_state_funcs = {}


function ai_state_funcs.getCombatStateBasedAni(ai_id, ani_prefix, ani_suffix) 
    local ai_data = ai_state.getNpcList()[ai_id]
    local weapon_mode = ai_data.weapon_mode;

    if weapon_mode == 0 then
        return ani_prefix .. "FIST" .. ani_suffix
    elseif weapon_mode == 1 then
        return ani_prefix .. "1H" .. ani_suffix
    elseif weapon_mode == 1 then
        return ani_prefix .. "2H" .. ani_suffix
    elseif weapon_mode == 1 then
        return ani_prefix .. "BOW" .. ani_suffix
    elseif weapon_mode == 1 then
        return ani_prefix .. "CBOW" .. ani_suffix
    end
    return ani_prefix .. ani_suffix
end


local function refreshPosition(ai_data)
        ai_data.last_pos_update = script_time.getNowInMs()
        ai_data.last_pos_x = ai_data.current_pos_x
        ai_data.last_pos_y = ai_data.current_pos_y
        ai_data.last_pos_z = ai_data.current_pos_z
end

function ai_state_funcs.gotoPosition(ai_id, target_x, target_y, target_z)
    local ai_data = ai_state.getNpcList()[ai_id]
    if ai_data.last_pos_update == nil or ai_data.last_pos_update == 0 then
        refreshPosition(ai_data)
    elseif ai_data.last_pos_update + 500 < script_time.getNowInMs() then
        local x,y,z = GetPlayerPos(ai_id)
        if ai_data.current_pos_x ~= x or ai_data.current_pos_y ~= y or ai_data.current_pos_z ~= z then
            ai_data.current_pos_x = x
            ai_data.current_pos_y = y
            ai_data.current_pos_z = z
        
        elseif ai_helper.getDistance(ai_data.current_pos_x, ai_data.current_pos_y, ai_data.current_pos_z, ai_data.last_pos_x, ai_data.last_pos_y, ai_data.last_pos_z) < 2 then
            local time_diff = script_time.getNowInMs() - ai_data.last_pos_update
            local speed = (5*100)*(time_diff/1000.0);-- meter per seconds!
            local distance = ai_helper.getDistance(ai_data.current_pos_x, ai_data.current_pos_y, ai_data.current_pos_z, target_x, target_y, target_z)
            if speed > distance then
                ai_data.current_pos_x = target_x
                ai_data.current_pos_y = target_y
                ai_data.current_pos_z = target_z
                SetPlayerPos(ai_id, target_x, target_y, target_z);
            else
                local dir_x = target_x - ai_data.current_pos_x
                local dir_y = target_y - ai_data.current_pos_y
                local dir_z = target_z - ai_data.current_pos_z

                local dir_norm = math.sqrt(dir_x*dir_x+dir_y*dir_y+dir_z*dir_z);
                dir_x = dir_x / dir_norm
                dir_y = dir_y / dir_norm
                dir_z = dir_z / dir_norm

                ai_data.current_pos_x = ai_data.current_pos_x + (dir_x * speed)
                ai_data.current_pos_y = ai_data.current_pos_y + (dir_y * speed)
                ai_data.current_pos_z = ai_data.current_pos_z + (dir_z * speed)

                SetPlayerPos(ai_id, ai_data.current_pos_x, ai_data.current_pos_y, ai_data.current_pos_z)
            end
        end
        refreshPosition(ai_data)
    end
end




function ai_state_funcs.spawnNpc(npc_data, position_name, world)
    local npc_id = CreateNPC(npc_data.name);
    SetPlayerInstance(npc_id, npc_data.instance);
    SetPlayerStrength(npc_id, npc_data.strength);
    SetPlayerDexterity(npc_id, npc_data.dexterity);
    SetPlayerLevel(npc_id, npc_data.level);
    SetPlayerMaxHealth(npc_id, npc_data.max_health);
    SetPlayerHealth(npc_id, npc_data.health);
    SetPlayerWorld(npc_id, string.upper(trim(world)));


    if npc_data.body_model ~= nil and npc_data.body_texture ~= nil and npc_data.head_model ~= nil and npc_data.head_texture ~= nil then
        SetPlayerAdditionalVisual(npc_id, npc_data.body_model, npc_data.body_texture, npc_data.head_model, npc_data.head_texture);
    end

    if npc_data.skill_1h ~= nil then
        SetPlayerSkillWeapon(npc_id, SKILL_1H, npc_data.skill_1h);
    end

    if npc_data.skill_2h ~= nil then
        SetPlayerSkillWeapon(npc_id, SKILL_2H, npc_data.skill_2h);
    end

    if npc_data.melee_weapon ~= nil then
        EquipMeleeWeapon(npc_id, npc_data.melee_weapon);
    end

    if npc_data.armor ~= nil then
        EquipArmor(npc_id, npc_data.armor);
    end

    SpawnPlayer(npc_id);

    local waynet = ai_state.getWaynetObject()

    local position_object = nil

    if waynet.getWaynet()[string.upper(trim(world))][position_name] ~= nil then
        position_object = waynet.getWaynet()[string.upper(trim(world))][position_name]
    elseif waynet.getFreePoints()[string.upper(trim(world))][position_name] ~= nil then
        position_object = waynet.getFreePoints()[string.upper(trim(world))][position_name]
    else
        position_object = {}
        position_object.x = 0
        position_object.y = 0
        position_object.z = 0
        position_object.dir_x = 0
        position_object.dir_z = 0
    end

    SetPlayerPos(npc_id, position_object.x, position_object.y, position_object.z);
    ai_helper.alignToDirection(npc_id, position_object.dir_x, position_object.dir_z)

    local ai_data = table.copy(npc_data)
    ai_data.id = npc_id
    ai_data.position_name = position_name
    ai_data.current_pos_x = position_object.x
    ai_data.current_pos_y = position_object.y
    ai_data.current_pos_z = position_object.z

    ai_state.getNpcList()[npc_id] = ai_data
    ai_state.getCharacterList()[npc_id] = ai_data
end

return ai_state_funcs