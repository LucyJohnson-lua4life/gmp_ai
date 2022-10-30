local ai_helper = {}

function ai_helper.getAnimationName(prefix, weaponmode, ani)
    local animation = prefix.."_WALK"..ani
    if weaponmode == WEAPON_NONE or weaponmode == WEAPON_FIST then
        animation = prefix.."_FIST"..ani
    elseif weaponmode == WEAPON_1H then
        animation = prefix.."_1H"..ani
    elseif weaponmode == WEAPON_2H then
        animation = prefix.."_2H"..ani
    elseif weaponmode == WEAPON_BOW then
        animation = prefix.."_BOW"..ani
    elseif weaponmode == WEAPON_CBOW then
        animation = prefix.."_CBOW"..ani
    end
    return animation
end

function ai_helper.isTargetInFrontOfAi(ai_id, target_id)
    local dangle = GetPlayerAngle(ai_id) - GetAngleToPlayer(ai_id, target_id); -- Angle vom Monster - Angle vom Monster zum Spieler
    return dangle > -20 and dangle < 20
end

function ai_helper.watchTarget(ai_id, target_id)
    local angle_to_enemy = GetAngleToPlayer(ai_id, target_id)
    SetPlayerAngle(ai_id, angle_to_enemy);
end

function ai_helper.stopAnimation(character_data)
    if character_data.weapon_mode ~= nil then
        PlayAnimation(character_data.id, ai_helper.getAnimationName("S", character_data.weapon_mode, "RUN"))
    else
        PlayAnimation(character_data.id, ai_helper.getAnimationName("S", 0, "RUN"))
    end
end

function ai_helper.runsNoAnimation(ai_id)
    local anim_name = GetPlayerAnimationName(ai_id)
    return anim_name == "S_RUN" or anim_name == nil
end

function ai_helper.getDistance(x1, y1, z1, x2, y2, z2)
    if (x1 == nil or x2 == nil or y1 == nil or y2 == nil or z1 == nil or z2 == nil) then
        return 99999;
    end
    local x, y, z = x1 - x2, y1 - y2, z1 - z2;
    return math.sqrt(x * x + y * y + z * z);
end

function ai_helper.getRadiansAngle(x1, y1, x2, y2)
    if(x1 == x2 and y1 == y2) then
        return 0;
    end
    local x, y = x2-x1, y2- y1;
    local angle =  math.atan(x / y) * 180.0 / 3.14;
    if(y < 0) then
        if(angle >= 180.0) then
            angle = angle- 180.0;
        else
            angle = angle + 180.0;
        end
        
    end
    return tonumber(angle);
end

local function getUnitCircleAngle(x1, y1, x2, y2)

    if(x1 == x2 and y1 == y2) then
        return 0;
    end
    local x, y = x2-x1, y2- y1;

	local angle =  math.atan(math.abs(y) / math.abs(x)) * 180.0 / 3.14;
	
	if(x < 0 and y > 0) then
		angle = 180-angle
	elseif (x<0 and y<0) then
		angle = angle +180
	elseif (x>0 and y<0) then
		angle = 360 - angle
	end
    
	return tonumber(angle);

end

function ai_helper.alignToDirection(playerid, dir_x, dir_z)
    local px, py, pz = GetPlayerPos(playerid);
    local angle = getUnitCircleAngle(px, pz, px + dir_x, pz + dir_z);
    SetPlayerAngle(playerid, angle)
end


return ai_helper