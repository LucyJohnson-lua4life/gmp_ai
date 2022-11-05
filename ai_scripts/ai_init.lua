local script_time = require "helper/script_time"
local ai_state = require "ai_scripts/ai_state"
local ai_loop = require "ai_scripts/ai_loop"
local ai_state_funcs = require "ai_scripts/ai_state_funcs"
local keiler = require "ai_scripts/npc_data/keiler"
local lurker = require "ai_scripts/npc_data/lurker"
local orc_elite = require "ai_scripts/npc_data/orc_elite"
local scavenger = require "ai_scripts/npc_data/scavenger"
local shadowbeast = require "ai_scripts/npc_data/shadowbeast"
local snapper = require "ai_scripts/npc_data/snapper"
local troll = require "ai_scripts/npc_data/troll"
local warg = require "ai_scripts/npc_data/warg"
local wolf = require "ai_scripts/npc_data/wolf"
local robber = require "ai_scripts/npc_data/robber"

local ai_init = {}



function ai_init.spawnNewWorldNpcs()
  local world = "NEWWORLD\\NEWWORLD.ZEN"

  ai_state_funcs.spawnNpc(wolf, "NW_FARM1_PATH_CITY_05_B", world)
  ai_state_funcs.spawnNpc(scavenger, "NW_FARM1_OUT_13", world)
  -- stone hedge
  ai_state_funcs.spawnNpc(orc_elite, "NW_FARM1_OUT_15", world)
  -- waldgraben
  ai_state_funcs.spawnNpc(wolf, "NW_FARM1_CITYWALL_02_B", world)
  ai_state_funcs.spawnNpc(snapper, "NW_FARM1_CITYWALL_05", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FARM1_CITYWALL_FOREST_03", world)
  ai_state_funcs.spawnNpc(shadowbeast, "NW_FARM1_CITYWALL_FOREST_04_B", world)
  ai_state_funcs.spawnNpc(scavenger, "NW_FARM1_CITYWALL_FOREST_06", world)
  ai_state_funcs.spawnNpc(orc_elite, "NW_FARM1_CITYWALL_FOREST_08_B", world)
  ai_state_funcs.spawnNpc(snapper, "NW_FARM1_CITYWALL_FOREST_14", world)
  ai_state_funcs.spawnNpc(snapper, "NW_FARM1_CITYWALL_FOREST_15", world)
  ai_state_funcs.spawnNpc(snapper, "NW_FARM1_CITYWALL_FOREST_16", world)

  ai_state_funcs.spawnNpc(orc_elite, "NW_XARDAS_TOWER_04", world)
  ai_state_funcs.spawnNpc(orc_elite, "NW_XARDAS_PATH_FARM1_11", world)

  ai_state_funcs.spawnNpc(orc_elite, "NW_XARDAS_GOBBO_02", world)

  ai_state_funcs.spawnNpc(scavenger, "FP_ROAM_XARDAS_SECRET_15", world)
  ai_state_funcs.spawnNpc(scavenger, "FP_ROAM_XARDAS_SECRET_04", world)
  ai_state_funcs.spawnNpc(scavenger, "FP_ROAM_XARDAS_SECRET_27", world)


  ai_state_funcs.spawnNpc(wolf, "NW_XARDAS_VALLEY_03", world)
  ai_state_funcs.spawnNpc(wolf, "NW_XARDAS_VALLEY_04", world)
  ai_state_funcs.spawnNpc(orc_elite, "NW_XARDAS_VALLEY_06", world)

  ai_state_funcs.spawnNpc(wolf, "NW_XARDAS_TOWER_VALLEY_WOLF", world)
  ai_state_funcs.spawnNpc(wolf, "NW_XARDAS_TOWER_VALLEY_08", world)
  -- hoehle im tal
  ai_state_funcs.spawnNpc(orc_elite, "NW_XARDAS_TOWER_SECRET_CAVE_01", world)

  ai_state_funcs.spawnNpc(scavenger, "NW_PATH_TO_MONASTER_AREA_11", world)
  ai_state_funcs.spawnNpc(scavenger, "NW_PATH_TO_MONASTER_MONSTER22", world)
  ai_state_funcs.spawnNpc(scavenger, "NW_PATH_TO_MONASTER_AREA_01", world)
  ai_state_funcs.spawnNpc(scavenger, "NW_PATH_TO_MONASTER_AREA_02", world)
  ai_state_funcs.spawnNpc(scavenger, "NW_PATH_TO_MONASTER_AREA_10", world)
  ai_state_funcs.spawnNpc(scavenger, "NW_PATH_TO_MONASTER_AREA_08", world)
  ai_state_funcs.spawnNpc(scavenger, "NW_SHRINE_MONSTER", world)
  ai_state_funcs.spawnNpc(scavenger, "NW_FOREST_CONNECT_MONSTER2", world)
  -- feldraeuber hoehle
  ai_state_funcs.spawnNpc(wolf, "NW_BIGFARM_FELDREUBER", world)
  ai_state_funcs.spawnNpc(wolf, "NW_BIGFARM_FELDREUBER2", world)
  ai_state_funcs.spawnNpc(wolf, "NW_BIGFARM_FELDREUBER4", world)
  ai_state_funcs.spawnNpc(wolf, "FP_ROAM_MONSTERMILL_11", world)
  ai_state_funcs.spawnNpc(wolf, "FP_ROAM_MONSTERMILL_13", world)
  ai_state_funcs.spawnNpc(wolf, "FP_ROAM_MONSTERMILL_04", world)
  ai_state_funcs.spawnNpc(wolf, "FP_ROAM_MONSTERMILL_03", world)

  -- bigmill felder
  ai_state_funcs.spawnNpc(lurker, "NW_BIGMILL_FIELD_MONSTER_03", world)
  ai_state_funcs.spawnNpc(wolf, "NW_BIGMILL_FIELD_MONSTER_01", world)
  ai_state_funcs.spawnNpc(wolf, "NW_BIGMILL_FIELD_MONSTER_02", world)



  -- farm 4
  ai_state_funcs.spawnNpc(scavenger, "NW_TAVERNE_TROLLAREA_MONSTER_01_01", world)
  ai_state_funcs.spawnNpc(wolf, "NW_TAVERNE_TROLLAREA_MONSTER_04_01", world)
  ai_state_funcs.spawnNpc(wolf, "NW_BIGFARM_LAKE_MONSTER_01_01", world)
  ai_state_funcs.spawnNpc(lurker, "NW_BIGFARM_LAKE_MONSTER_02_01", world)
  ai_state_funcs.spawnNpc(wolf, "NW_BIGFARM_LAKE_MONSTER_03_01", world)

  ai_state_funcs.spawnNpc(orc_elite, "NW_FARM4_WOOD_MONSTER_01", world)
  ai_state_funcs.spawnNpc(warg, "NW_FARM4_WOOD_MONSTER_01", world)
  ai_state_funcs.spawnNpc(warg, "NW_FARM4_WOOD_MONSTER_02", world)
  ai_state_funcs.spawnNpc(warg, "NW_FARM4_WOOD_MONSTER_03", world)

  ai_state_funcs.spawnNpc(warg, "NW_FARM4_WOOD_MONSTER_05", world)
  ai_state_funcs.spawnNpc(warg, "NW_FARM4_WOOD_MONSTER_06", world)
  ai_state_funcs.spawnNpc(warg, "NW_FARM4_WOOD_MONSTER_06", world)
  ai_state_funcs.spawnNpc(warg, "NW_FARM4_WOOD_MONSTER_07", world)
  ai_state_funcs.spawnNpc(shadowbeast, "NW_FARM4_WOOD_MONSTER_08", world)
  ai_state_funcs.spawnNpc(warg, "NW_FARM4_WOOD_MONSTER_09", world)
  ai_state_funcs.spawnNpc(warg, "NW_FARM4_WOOD_MONSTER_10", world)


  ai_state_funcs.spawnNpc(troll, "NW_CASTLEMINE_TROLL_08", world)
  ai_state_funcs.spawnNpc(troll, "NW_CASTLEMINE_TROLL_07", world)

  ai_state_funcs.spawnNpc(wolf, "NW_BIGFARM_LAKE_MONSTER_BLOODFLY", world)
  ai_state_funcs.spawnNpc(wolf, "NW_TAVERNE_TROLLAREA_MONSTER_03_01M1", world)
  ai_state_funcs.spawnNpc(wolf, "NW_SAGITTA_MOREMONSTER_01", world)
  ai_state_funcs.spawnNpc(wolf, "NW_SAGITTA_MOREMONSTER_03", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FARM4_WOOD_NEARPEASANT7", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FARM4_WOOD_NEARPEASANT2_14", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FARM4_WOOD_NEARPEASANT2_10", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FARM4_WOOD_NEARPEASANT2_8", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FARM4_WOOD_NEARPEASANT2_7", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FARM4_WOOD_NEARPEASANT2_12", world)

  ai_state_funcs.spawnNpc(wolf, "NW_FARM4_WOOD_MONSTER_MORE_01", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FARM4_WOOD_MONSTER_N_3", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FARM4_WOOD_MONSTER_N_2", world)
  ai_state_funcs.spawnNpc(wolf, "NW_BIGFARM_FOREST_02", world)

  ai_state_funcs.spawnNpc(keiler, "NW_BIGFARM_FOREST_03_NAVIGATION", world)
  ai_state_funcs.spawnNpc(keiler, "NW_FARM4_WOOD_NAVIGATION_09", world)
  ai_state_funcs.spawnNpc(wolf, "NW_CASTLEMINE_TROLL_05", world)
  ai_state_funcs.spawnNpc(wolf, "NW_BIGFARM_ALLEE_08_N", world)
  ai_state_funcs.spawnNpc(wolf, "NW_BIGFARM_ALLEE_08_N_2", world)
  ai_state_funcs.spawnNpc(wolf, "NW_BIGFARM_ALLEE_08_N_5", world)

  ai_state_funcs.spawnNpc(scavenger, "NW_BIGMILL_05", world)
  ai_state_funcs.spawnNpc(scavenger, "NW_BIGMILL_FARM3_03", world)
  ai_state_funcs.spawnNpc(scavenger, "NW_FARM3_BIGWOOD_02", world)

  ai_state_funcs.spawnNpc(keiler, "NW_FARM3_BIGWOOD_03", world)
  ai_state_funcs.spawnNpc(lurker, "NW_FARM3_PATH_11_SMALLRIVER_02", world)
  ai_state_funcs.spawnNpc(lurker, "NW_FARM3_PATH_11_SMALLRIVER_04", world)
  ai_state_funcs.spawnNpc(scavenger, "NW_FARM3_PATH_11_SMALLRIVER_08", world)
  ai_state_funcs.spawnNpc(scavenger, "NW_FARM3_PATH_11_SMALLRIVER_10", world)
  ai_state_funcs.spawnNpc(lurker, "NW_FARM3_PATH_11_SMALLRIVER_17", world)
  ai_state_funcs.spawnNpc(lurker, "NW_FARM3_PATH_11_SMALLRIVER_20", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FARM3_PATH_11_SMALLRIVER_24", world)
  ai_state_funcs.spawnNpc(lurker, "NW_FARM3_PATH_11_SMALLRIVERMID_03", world)
  ai_state_funcs.spawnNpc(lurker, "NW_FARM3_PATH_11_SMALLRIVERMID_02", world)
  ai_state_funcs.spawnNpc(keiler, "NW_FARM3_PATH_12_MONSTER_01", world)
  ai_state_funcs.spawnNpc(keiler, "NW_FARM3_PATH_12_MONSTER_03", world)
  ai_state_funcs.spawnNpc(lurker, "NW_FARM3_MOUNTAINLAKE_03", world)
  ai_state_funcs.spawnNpc(lurker, "NW_FARM3_MOUNTAINLAKE_MONSTER_01", world)
  ai_state_funcs.spawnNpc(keiler, "NW_BIGFARM_LAKE_03_MOVEMENT", world)
  ai_state_funcs.spawnNpc(wolf, "NW_BIGFARM_LAKE_03_MOVEMENT3", world)


  ai_state_funcs.spawnNpc(wolf, "NW_PASS_06", world)
  ai_state_funcs.spawnNpc(wolf, "NW_PASS_11", world)
  ai_state_funcs.spawnNpc(wolf, "NW_PASS_SECRET_15", world)
  ai_state_funcs.spawnNpc(wolf, "NW_PASS_SECRET_16", world)
  ai_state_funcs.spawnNpc(wolf, "NW_PASS_SECRET_17", world)
  ai_state_funcs.spawnNpc(scavenger, "NW_PASS_SECRET_05", world)
  ai_state_funcs.spawnNpc(scavenger, "NW_PASS_SECRET_06", world)
  ai_state_funcs.spawnNpc(scavenger, "NW_PASS_SECRET_07", world)
  ai_state_funcs.spawnNpc(scavenger, "NW_PASS_SECRET_08", world)
 
  ai_state_funcs.spawnNpc(orc_elite, "NW_PASS_13", world)
  ai_state_funcs.spawnNpc(orc_elite, "NW_PASS_ORKS_01", world)
  ai_state_funcs.spawnNpc(orc_elite, "NW_PASS_ORKS_08", world)
  ai_state_funcs.spawnNpc(orc_elite, "NW_PASS_ORKS_10", world)


  ai_state_funcs.spawnNpc(scavenger, "FP_ROAM_MEDIUMFOREST_KAP2_12", world)
  ai_state_funcs.spawnNpc(scavenger, "FP_ROAM_MEDIUMFOREST_KAP2_10", world)
  ai_state_funcs.spawnNpc(scavenger, "FP_ROAM_MEDIUMFOREST_KAP2_28", world)
  ai_state_funcs.spawnNpc(scavenger, "FP_ROAM_MEDIUMFOREST_KAP2_29", world)
  ai_state_funcs.spawnNpc(scavenger, "FP_ROAM_MEDIUMFOREST_KAP2_17", world)
  ai_state_funcs.spawnNpc(scavenger, "FP_ROAM_MEDIUMFOREST_KAP2_13", world)
  ai_state_funcs.spawnNpc(scavenger, "FP_ROAM_MEDIUMFOREST_KAP2_36", world)
  ai_state_funcs.spawnNpc(scavenger, "FP_ROAM_MEDIUMFOREST_KAP2_34", world)

  ai_state_funcs.spawnNpc(warg, "FP_ROAM_MEDIUMFOREST_KAP3_08", world)
  ai_state_funcs.spawnNpc(warg, "FP_ROAM_MEDIUMFOREST_KAP3_09", world)
  ai_state_funcs.spawnNpc(warg, "FP_ROAM_MEDIUMFOREST_KAP3_11", world)
  ai_state_funcs.spawnNpc(wolf, "FP_ROAM_MEDIUMFOREST_KAP3_15", world)
  ai_state_funcs.spawnNpc(wolf, "FP_ROAM_MEDIUMFOREST_KAP3_17", world)
  ai_state_funcs.spawnNpc(keiler, "FP_ROAM_MEDIUMFOREST_KAP3_21", world)
  ai_state_funcs.spawnNpc(warg, "FP_ROAM_MEDIUMFOREST_KAP3_23", world)
  ai_state_funcs.spawnNpc(warg, "FP_ROAM_MEDIUMFOREST_KAP3_28", world)
  ai_state_funcs.spawnNpc(warg, "FP_ROAM_MEDIUMFOREST_KAP3_29", world)
  ai_state_funcs.spawnNpc(shadowbeast, "FP_ROAM_MEDIUMFOREST_KAP3_20", world)
  ai_state_funcs.spawnNpc(scavenger, "FP_ROAM_MEDIUMFOREST_KAP3_27", world)
  ai_state_funcs.spawnNpc(scavenger, "FP_ROAM_MEDIUMFOREST_KAP3_26", world)
  ai_state_funcs.spawnNpc(orc_elite, "FP_ROAM_MEDIUMFOREST_KAP3_32", world)
  -- osttor leuchtturm
  ai_state_funcs.spawnNpc(wolf, "NW_CITY_TO_LIGHTHOUSE_03", world)
  -- coast
  ai_state_funcs.spawnNpc(orc_elite, "FP_ROAM_SHIPWRECK_04", world)


  ai_state_funcs.spawnNpc(wolf, "NW_CITY_TO_FOREST_05", world)
  ai_state_funcs.spawnNpc(wolf, "NW_CITY_TO_FOREST_07", world)
  ai_state_funcs.spawnNpc(scavenger, "NW_CITY_TO_FOREST_11", world)
  ai_state_funcs.spawnNpc(scavenger, "NW_CITY_TO_FOREST_12", world)
  ai_state_funcs.spawnNpc(wolf, "NW_CITY_TO_FOREST_15", world) 
  ai_state_funcs.spawnNpc(wolf, "FP_ROAM_CITY_TO_FOREST_47", world)
  ai_state_funcs.spawnNpc(scavenger, "FP_ROAM_CITY_TO_FOREST_11", world)
  ai_state_funcs.spawnNpc(scavenger, "FP_ROAM_CITY_TO_FOREST_10", world)
  ai_state_funcs.spawnNpc(scavenger, "FP_ROAM_CITYFOREST_KAP3_22", world)
  ai_state_funcs.spawnNpc(scavenger, "FP_ROAM_CITYFOREST_KAP3_20", world)
  ai_state_funcs.spawnNpc(scavenger, "FP_ROAM_CITYFOREST_KAP3_21", world)
  ai_state_funcs.spawnNpc(wolf, "FP_ROAM_CITYFOREST_KAP3_23", world)
  ai_state_funcs.spawnNpc(wolf, "FP_ROAM_CITYFOREST_KAP3_27", world)
  ai_state_funcs.spawnNpc(wolf, "FP_ROAM_CITYFOREST_KAP3_28", world)
  ai_state_funcs.spawnNpc(wolf, "FP_ROAM_CITYFOREST_KAP3_29", world)
  ai_state_funcs.spawnNpc(wolf, "FP_ROAM_CITYFOREST_KAP3_30", world)
  ai_state_funcs.spawnNpc(wolf, "FP_ROAM_CITYFOREST_KAP3_38", world)
  ai_state_funcs.spawnNpc(warg, "FP_ROAM_CITY_TO_FOREST_32", world)
  ai_state_funcs.spawnNpc(warg, "FP_ROAM_CITY_TO_FOREST_29", world)
  ai_state_funcs.spawnNpc(warg, "FP_ROAM_CITY_TO_FOREST_31", world)
  ai_state_funcs.spawnNpc(wolf, "FP_ROAM_CITY_TO_FOREST_42", world)
  ai_state_funcs.spawnNpc(wolf, "FP_ROAM_CITY_TO_FOREST_41", world)
  ai_state_funcs.spawnNpc(shadowbeast, "FP_ROAM_CITYFOREST_KAP3_04", world)

  ai_state_funcs.spawnNpc(warg, "FP_ROAM_CITYFOREST_KAP3_09", world)
  ai_state_funcs.spawnNpc(warg, "FP_ROAM_CITYFOREST_KAP3_10", world)
  ai_state_funcs.spawnNpc(warg, "FP_ROAM_CITYFOREST_KAP3_11", world)
  ai_state_funcs.spawnNpc(warg, "FP_ROAM_CITYFOREST_KAP3_12", world)
  ai_state_funcs.spawnNpc(warg, "FP_ROAM_CITYFOREST_KAP3_14", world)
  ai_state_funcs.spawnNpc(warg, "FP_ROAM_CITYFOREST_KAP3_15", world)
  ai_state_funcs.spawnNpc(orc_elite, "FP_ROAM_CITYFOREST_KAP3_17", world)
  ai_state_funcs.spawnNpc(scavenger, "NW_FOREST_VINOSKELLEREI_01", world)

  -- SM Forest Cave
  ai_state_funcs.spawnNpc(scavenger, "NW_CITY_SMFOREST_05", world)

  ai_state_funcs.spawnNpc(scavenger, "NW_CITY_SMFOREST_09", world)
  ai_state_funcs.spawnNpc(scavenger, "NW_CITY_SMFOREST_03", world)
  ai_state_funcs.spawnNpc(scavenger, "NW_CITY_SMFOREST_03", world)

  -- coast cave
  ai_state_funcs.spawnNpc(shadowbeast, "NW_FOREST_PATH_35_06", world)
  -- city2 cave

  ai_state_funcs.spawnNpc(wolf, "NW_CITY_TO_FOREST_04_09", world)
  ai_state_funcs.spawnNpc(wolf, "NW_CITY_TO_FOREST_04_05", world)

  -- BridgeCave 
  ai_state_funcs.spawnNpc(wolf, "NW_TAVERN_TO_FOREST_05_05", world)
  ai_state_funcs.spawnNpc(wolf, "NW_TAVERN_TO_FOREST_05_06", world)

  ai_state_funcs.spawnNpc(scavenger, "NW_CITYFOREST_CAVE_04", world)
  ai_state_funcs.spawnNpc(wolf, "NW_CITYFOREST_CAVE_06", world)
  ai_state_funcs.spawnNpc(shadowbeast, "NW_CITYFOREST_CAVE_A06", world)

  ai_state_funcs.spawnNpc(scavenger, "NW_FARM1_CITYWALL_RIGHT_04", world)
  ai_state_funcs.spawnNpc(scavenger, "NW_FOREST_PATH_38_MONSTER", world)
  ai_state_funcs.spawnNpc(keiler, "NW_CITY_TO_LIGHTHOUSE_13_MONSTER", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FOREST_PATH_35_01", world)
  ai_state_funcs.spawnNpc(warg, "NW_FOREST_PATH_31_MONSTER", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FOREST_PATH_21_MONSTER", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FARM2_TO_TAVERN_09_MONSTER", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FARM2_TO_TAVERN_09_MONSTER2", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FARM2_TO_TAVERN_09_MONSTER3", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FARM2_TO_TAVERN_09_MONSTER4", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FARM2_TO_TAVERN_09_MONSTER4", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FARM2_TO_TAVERN_09_MONSTER5", world)
  ai_state_funcs.spawnNpc(wolf, "NW_CITY_TO_FOREST_04", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FOREST_CAVE1_01", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FOREST_PATH_75_2_MONSTER", world)
  ai_state_funcs.spawnNpc(keiler, "NW_FOREST_PATH_79", world)
  ai_state_funcs.spawnNpc(keiler, "NW_FOREST_PATH_80_1", world)
  ai_state_funcs.spawnNpc(warg, "NW_FOREST_PATH_82", world)
  ai_state_funcs.spawnNpc(warg, "NW_FOREST_PATH_82_M", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FOREST_PATH_66_M", world)

  ai_state_funcs.spawnNpc(wolf, "NW_FOREST_PATH_57", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FOREST_PATH_35_01_MONSTER", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FOREST_PATH_80_1_MOVEMENT8_M", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FOREST_PATH_80_1_MOVEMENTF", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FOREST_PATH_31_NAVIGATION3", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FOREST_PATH_31_NAVIGATION10", world)
  ai_state_funcs.spawnNpc(scavenger, "NW_FOREST_PATH_31_NAVIGATION11", world)
  ai_state_funcs.spawnNpc(snapper, "NW_FOREST_PATH_80_1_MOVEMENT6", world)
  ai_state_funcs.spawnNpc(snapper, "NW_FOREST_PATH_80_1_MOVEMENT15", world)
  ai_state_funcs.spawnNpc(snapper, "NW_FOREST_PATH_80_1_MOVEMENT8_M5", world)
  ai_state_funcs.spawnNpc(warg, "NW_FOREST_PATH_31_NAVIGATION16", world)
  ai_state_funcs.spawnNpc(snapper, "NW_FOREST_PATH_80_1_MOVEMENT8_M3", world)
  ai_state_funcs.spawnNpc(warg, "NW_FOREST_PATH_04_16_MONSTER", world)
  ai_state_funcs.spawnNpc(warg, "NW_FOREST_PATH_04_16_MONSTER2", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FOREST_PATH_04_13", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FOREST_PATH_04_3", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FOREST_PATH_04_4", world)
  ai_state_funcs.spawnNpc(warg, "NW_FOREST_PATH_72_MONSTER", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FOREST_PATH_62_06", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FOREST_PATH_56_MONSTER", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FOREST_PATH_27_03", world)
  ai_state_funcs.spawnNpc(warg, "NW_FOREST_PATH_27_02", world)
  ai_state_funcs.spawnNpc(scavenger, "NW_CITY_TO_LIGHTHOUSE_13_MONSTER7", world)
  ai_state_funcs.spawnNpc(wolf, "NW_CITY_TO_LIGHTHOUSE_13_MONSTER8", world)
  ai_state_funcs.spawnNpc(keiler, "NW_FOREST_PATH_35_MONSTER", world)
  ai_state_funcs.spawnNpc(orc_elite, "NW_FOREST_PATH_31_NAVIGATION_M", world)
  ai_state_funcs.spawnNpc(warg, "NW_FOREST_PATH_31_NAVIGATION_M", world)
  ai_state_funcs.spawnNpc(orc_elite, "NW_FOREST_PATH_31_NAVIGATION19", world)
  ai_state_funcs.spawnNpc(orc_elite, "NW_FOREST_PATH_18_MONSTER", world)
  ai_state_funcs.spawnNpc(warg, "NW_FOREST_PATH_18_MONSTER", world)
  ai_state_funcs.spawnNpc(warg, "NW_FOREST_PATH_72_MONSTER23", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FOREST_PATH_76", world)
  ai_state_funcs.spawnNpc(warg, "NW_FOREST_PATH_66_MONSTER", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FOREST_PATH_04_5", world)
  --Egill/Enim-FIX
  ai_state_funcs.spawnNpc(keiler, "NW_FOREST_PATH_04_14_MONSTER", world)
  ai_state_funcs.spawnNpc(wolf, "NW_CITY_SMFOREST_03_M", world)
  ai_state_funcs.spawnNpc(wolf, "NW_FOREST_PATH_25_01_M", world)

  ai_state_funcs.spawnNpc(wolf, "FP_ROAM_TROLLAREA_SEA_01", world)
  ai_state_funcs.spawnNpc(wolf, "FP_ROAM_TROLLAREA_SEA_02", world)
  ai_state_funcs.spawnNpc(wolf, "FP_ROAM_TROLLAREA_SEA_03", world)
  ai_state_funcs.spawnNpc(wolf, "FP_ROAM_TROLLAREA_SEA_04", world)



  ai_state_funcs.spawnNpc(wolf, "NW_TROLLAREA_PATH_66_MONSTER", world)
  ai_state_funcs.spawnNpc(scavenger, "NW_TROLLAREA_PLANE_07", world)
  ai_state_funcs.spawnNpc(wolf, "NW_TROLLAREA_NOVCHASE_01", world)
  ai_state_funcs.spawnNpc(wolf, "NW_TROLLAREA_PATH_38_MONSTER", world)
  ai_state_funcs.spawnNpc(scavenger, "NW_TROLLAREA_PLANE_04", world)
  ai_state_funcs.spawnNpc(scavenger, "NW_TROLLAREA_RUINS_17", world)

  ai_state_funcs.spawnNpc(lurker, "NW_TROLLAREA_PATH_71_MONSTER", world)
  ai_state_funcs.spawnNpc(scavenger, "NW_TROLLAREA_PATH_71_MONSTER2", world)
  ai_state_funcs.spawnNpc(scavenger, "NW_TROLLAREA_PATH_15_MONSTER", world)
  ai_state_funcs.spawnNpc(wolf, "NW_TROLLAREA_RITUALFOREST_04_MONSTER", world)
  ai_state_funcs.spawnNpc(scavenger, "NW_TROLLAREA_RITUALPATH_04", world)

  ai_state_funcs.spawnNpc(wolf, "NW_TROLLAREA_RITUALPATH_032", world)

  ai_state_funcs.spawnNpc(scavenger, "NW_TROLLAREA_PATH_22_MONSTER", world)
  ai_state_funcs.spawnNpc(wolf, "NW_TROLLAREA_RITUALFOREST_06_MONSTER", world)
  ai_state_funcs.spawnNpc(lurker, "NW_TROLLAREA_PATH_08", world)
  ai_state_funcs.spawnNpc(scavenger, "NW_TROLLAREA_BRIGDE_05", world)
  --TROLLROCKCAVE
  --ai_state_funcs.spawnNpc(aiState,Skeleton(), "NW_TROLLAREA_TROLLROCKCAVE_03", world)
  --ai_state_funcs.spawnNpc(aiState,Skeleton(), "NW_TROLLAREA_TROLLROCKCAVE_05", world)
  --ai_state_funcs.spawnNpc(aiState,SkeletonLord(), "NW_TROLLAREA_TROLLROCKCAVE_07", world)
  --ai_state_funcs.spawnNpc(aiState,SkeletonLord(), "NW_TROLLAREA_TROLLROCKCAVE_10", world)
  --TROLLLAKECAVE
  --ai_state_funcs.spawnNpc(aiState,Meatbug(), "NW_TROLLAREA_TROLLLAKECAVE_03A", world)
  --ai_state_funcs.spawnNpc(aiState,scavenger, "NW_TROLLAREA_TROLLLAKECAVE_02", world)
  --ai_state_funcs.spawnNpc(aiState,Gobbo_Black(), "NW_TROLLAREA_TROLLLAKECAVE_08", world)
  --ai_state_funcs.spawnNpc(aiState,Gobbo_Black(), "NW_TROLLAREA_TROLLLAKECAVE_09", world)
  --RIVERSIDECAVE
  ai_state_funcs.spawnNpc(shadowbeast, "NW_TROLLAREA_RIVERSIDECAVE_02", world)
  ai_state_funcs.spawnNpc(shadowbeast, "NW_TROLLAREA_RIVERSIDECAVE_07", world)

  ai_state_funcs.spawnNpc(shadowbeast, "NW_TROLLAREA_RIVERSIDECAVE_07", world)

  ai_state_funcs.spawnNpc(robber, "NW_BYPASS_03_CONNECT", world)
  ai_state_funcs.spawnNpc(robber, "NW_TAVERNE_IN_RANGERMEETING", world)
  ai_state_funcs.spawnNpc(robber, "NW_SHRINE_01", world)
  ai_state_funcs.spawnNpc(robber, "NW_TAVERNE_06", world)


end


function AI_Timer()
	ai_loop.runAiLoop()
end

function ai_init.OnGamemodeInit()
  SetTimer("AI_Timer",50,1);
	ai_state.OnGamemodeInit()
	ai_init.spawnNewWorldNpcs()
end

function ai_init.OnPlayerConnect(playerid)
	local character_data = {}
	character_data.id = playerid
	ai_state.getCharacterList()[playerid] = character_data 
end

function ai_init.OnPlayerDisconnect(playerid, reason)
	ai_state.getCharacterList()[playerid] = nil
end

function ai_init.OnPlayerHit(playerid, killerid)
	if IsNPC(playerid) == 1 then
		ai_state.getNpcList()[playerid].hit_by = killerid
	end
end


function ai_init.OnPlayerDeath(playerid, p_classid, killerid, k_classid)
	if IsNPC(playerid) == 1 then
		ai_state.getNpcList()[playerid].death_time = script_time.getNowInMs()
	end
end


return ai_init