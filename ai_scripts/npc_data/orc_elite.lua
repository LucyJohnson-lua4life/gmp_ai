local ai_orc_behavior = require "ai_scripts/behaviors/ai_orc_behavior"
local npc_data = {}
npc_data.name = "Orc Elite"
npc_data.instance = "OrcElite_Roam"
npc_data.strength = 125
npc_data.dexterity = 100
npc_data.level = 55 
npc_data.max_health = 300
npc_data.health = 300
npc_data.skill_1h = 100
npc_data.skill_2h = 100
npc_data.melee_weapon = "ItMw_2H_OrcSword_02"
npc_data.armor = "ItMw_2H_OrcSword_02"
npc_data.behavior = ai_orc_behavior
npc_data.weapon_mode = 4
npc_data.fight_range = 300 
npc_data.respawn_time_ms = 120000
npc_data.last_pos_update = nil
npc_data.last_pos_x = nil
npc_data.last_pos_y = nil
npc_data.last_pos_z = nil
npc_data.current_pos_x = nil
npc_data.current_pos_y = nil
npc_data.current_pos_z = nil

return npc_data