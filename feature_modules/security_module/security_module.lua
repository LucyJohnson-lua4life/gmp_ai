
local anti_cheat = require "feature_modules/security_module/anti_cheat"
local security_module = {}


function security_module.OnPlayerHit(playerid, killerid)
    anti_cheat.OnPlayerHit(playerid, killerid)
end

function security_module.OnPlayerChangeHealth(playerid, new_value, old_value)
    anti_cheat.OnPlayerChangeHealth(playerid, new_value, old_value)
end

function security_module.OnPlayerDisconnect(playerid, reason)
    anti_cheat.OnPlayerDisconnect(playerid, reason)
end

return security_module