local script_time = require "helper/script_time"

local anti_cheat = {}

local last_hit_time = {}
local last_player_health = {}

local DAMAGE_THRESHOLD = 200
local MAX_DAMAGE_SPEED = 2000

local function handleAttackSpeedAntiCheat(playerid, killerid)
    local now = script_time.getNowInMs()
    local latest_hit_time = last_hit_time[killerid]

    if latest_hit_time == nil then
        latest_hit_time = 0
    end

    if now - latest_hit_time < MAX_DAMAGE_SPEED then
        SetPlayerHealth(playerid, GetPlayerMaxHealth(playerid))
        SetPlayerHealth(killerid, 0)
	    SendPlayerMessage(killerid, 255, 0, 0, "Attack speed cheat detected! Attacker got killed.");
    end
    last_hit_time[killerid] = now
end

local function handleAttackDamageAntiCheat(playerid, killerid)
    local latest_health = last_player_health[playerid]
    if latest_health == nil then
        latest_health = GetPlayerMaxHealth(playerid)
    end

    local health_diff = latest_health - GetPlayerHealth(playerid)

    if playerid ~= killerid then
        if health_diff > DAMAGE_THRESHOLD then
            SetPlayerHealth(playerid, GetPlayerMaxHealth(playerid))
            SetPlayerHealth(killerid, 0)
	        SendPlayerMessage(killerid, 255, 0, 0, "Attack damage cheat detected! Attacker got killed.");
        end
    end

    last_player_health[playerid] = GetPlayerHealth(playerid)
end

function anti_cheat.OnPlayerHit(playerid, killerid)
    if IsNPC(killerid) == 0 then
        handleAttackDamageAntiCheat(playerid, killerid)
        handleAttackSpeedAntiCheat(playerid, killerid)
    end
end

function anti_cheat.OnPlayerChangeHealth(playerid, new_value, old_value)
    if new_value == 0 then
        last_player_health[playerid] = nil
    end
end

function anti_cheat.OnPlayerDisconnect(playerid, reason)
    last_player_health[playerid] = nil
    last_hit_time[playerid] = nil
end

return anti_cheat