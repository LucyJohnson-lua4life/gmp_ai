local ai_default_monster_behavior = require "ai_scripts/behaviors/ai_default_monster_behavior"
local npc_data = {}
npc_data.name = "Troll"
npc_data.instance = "Troll"
npc_data.strength = 300
npc_data.dexterity = 80
npc_data.level = 55
npc_data.max_health = 1500
npc_data.health = 1500
npc_data.behavior = ai_default_monster_behavior
npc_data.weapon_mode = 0
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