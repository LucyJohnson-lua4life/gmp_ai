local ai_state = require "ai_scripts/ai_state"
local ai_action = require "ai_scripts/ai_actions"
local script_time = require "helper/script_time"
local ai_state_funcs = require "ai_scripts/ai_state_funcs"
local robber = require "ai_scripts/npc_data/robber"
local ai_init = require "ai_scripts/ai_init"
local security_module = require "feature_modules/security_module/security_module"


function OnGamemodeInit()
	print("--------------------");
	print("Gamemode inited");
	print("--------------------");
	ai_init.OnGamemodeInit()
end

local function setPlayerStartPos(playerid)
		local waynet = ai_state.getWaynetObject()
        local position_name = "FP_STAND_NW_TAVERNE"
		local pos = waynet.getPositionObject(position_name, "NEWWORLD\\NEWWORLD.ZEN")
		SetPlayerPos(playerid, pos.x, pos.y, pos.z)
end

local function equipPlayer(playerid)
	SetPlayerStrength(playerid, 100)
	SetPlayerHealth(playerid, 1100)
	SetPlayerMaxHealth(playerid, 1100)
	SetPlayerSkillWeapon(playerid, SKILL_1H, 100);
	EquipArmor(playerid, "ITAR_THORUS_ADDON");
	EquipMeleeWeapon(playerid,"ITMW_1H_FERROSSWORD_MIS");


end

function OnPlayerConnect(playerid)
	SpawnPlayer(playerid)
	ai_init.OnPlayerConnect(playerid)
end

function OnPlayerDisconnect(playerid, reason)
	ai_init.OnPlayerDisconnect(playerid, reason)
end

function OnPlayerSpawn(playerid)
	if IsNPC(playerid) == 0 then
		equipPlayer(playerid)
		setPlayerStartPos(playerid)
	end
end

function OnPlayerHit(playerid, killerid)
	--security_module.OnPlayerHit(playerid, killerid)
	ai_init.OnPlayerHit(playerid, killerid)
end

function OnPlayerUnconscious(playerid, p_classid, killerid, k_classid)
	SendPlayerMessage(playerid, 255, 0, 0, "You were knocked out by " .. GetPlayerName(killerid) .. "");
end

function OnPlayerDeath(playerid, p_classid, killerid, k_classid)
	ai_init.OnPlayerDeath(playerid, p_classid, killerid, k_classid)
end

function OnPlayerEnterWorld(playerid, world)
	SendPlayerMessage(playerid, 0, 255, 0, "Welcome to " .. world .. "!");
end

-- DEBUG commands!!
function OnPlayerCommandText(playerid, cmdtext)
     local cmd, params = GetCommand(cmdtext);
    if cmdtext == "/start" then
        SetPlayerPos(playerid, 0,0,0)
    elseif cmdtext == "/heal" then
        CompleteHeal(playerid)
    elseif cmdtext == "/spawn" then
		ai_state_funcs.spawnNpc(robber, "HAFEN", "NEWWORLD\\NEWWORLD.ZEN")
    elseif cmd == "/tpto" then
        local target_id = tonumber(params);
		local x,y,z = GetPlayerPos(target_id)
		local world = GetPlayerWorld(target_id)
		--SetPlayerWorld(playerid, world)
		SetPlayerPos(playerid, x,y,z)
    elseif cmd == "/wolf" then
		SetPlayerInstance(playerid, "Wolf")
    elseif cmd == "/instancetest" then
		local instance = ai_action.createWaitAction()
		instance.func()
    elseif cmd == "/time" then
		print(script_time.getNowInSeconds())
    elseif cmd == "/anim" then
		print(GetPlayerAnimationName(playerid))
    elseif cmd == "/towp" then
        local target_id = tonumber(params);
        local ai_data = ai_state.getCharacterList()[target_id]
		ai_data.next_action = ai_action.gotoPosition(target_id, "TAVERNE")
		--ai_data.next_action = ai_action.gotoPosition(target_id, "CITY1")
	elseif cmd == "/eat" then
        local target_id = tonumber(params);
        --local ai_data = ai_state.getCharacterList()[target_id]
        PlayAnimation(target_id, "S_EAT")
	elseif cmd == "/world" then
		print(GetPlayerWorld(playerid))
	elseif cmd == "/goto" then
		local waynet = ai_state.getWaynetObject()
        local position_name = string.upper(params);
		local world = GetPlayerWorld(playerid)
		local position = nil
		if waynet.getWaynet()[world][position_name] ~= nil then
			position = waynet.getWaynet()[world][position_name]
		elseif waynet.getFreePoints()[world][position_name] ~= nil then
			position = waynet.getFreePoints()[world][position_name]
		else
			position = {}
			position.x = 0
			position.y = 0
			position.z = 0
		end
		SetPlayerPos(playerid, position.x, position.y, position.z)
	end
end

function OnPlayerChangeHealth(playerid, new_value, old_value)
	--security_module.OnPlayerChangeHealth(playerid, new_value, old_value)
end