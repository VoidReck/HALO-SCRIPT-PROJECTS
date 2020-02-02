--[[
--======================================================================================================--
Script Name: HLN Damage Prevention (v1.0), for SAPP (PC & CE)
	This script will prevent: 
		* Lone-drivers from receiving damage or inflicting damage (unless driving as gunner)
		* Walkers from inflicting damage to anyone
		* Any vehicle occupant from inflicting damage on walkers

Copyright (c) 2020, Jericho Crosby <jericho.crosby227@gmail.com>
* Notice: You can use this document subject to the following conditions:
https://github.com/Chalwk77/Halo-Scripts-Phasor-V2-/blob/master/LICENSE

* Written by Jericho Crosby (Chalwk)
--======================================================================================================--
]]--

api_version = "1.12.0.0"

function OnScriptLoad()
	register_callback(cb["EVENT_DAMAGE_APPLICATION"], "OnDamageApplication")
end

function OnDamageApplication(VictimIndex, CauserIndex, MetaID, Damage, HitString, Backtap)
	if (tonumber(CauserIndex) > 0 and VictimIndex ~= CauserIndex) then

		if not InVehicle(CauserIndex) then
			return false
			
		elseif not InVehicle(CauserIndex) and InVehicle(VictimIndex) then
			return false

		elseif InVehicle(CauserIndex) and not InVehicle(VictimIndex) then
			return false
			
		elseif InVehicle(CauserIndex) and InVehicle(VictimIndex) then
			if GetOccupantCount(VictimIndex) == 1 then
				return false
			end
			
		elseif InVehicle(CauserIndex) and InVehicle(VictimIndex) then
			if GetOccupantCount(VictimIndex) > 1 then
				return false
			end
		end
	end	
end

function InVehicle(PlayerIndex)
	if player_alive(PlayerIndex) then
		local player_object = get_dynamic_player(PlayerIndex)
		if (player_object ~= 0) then
			local VehicleID = read_dword(player_object + 0x11C)
			if (VehicleID == 0xFFFFFFFF) then 
				return false
			else
				return true
			end
		end
	end
	return false
end

function GetOccupantCount(PlayerIndex)
	local count = 1

	local player_object = get_dynamic_player(PlayerIndex)
	local V1ID = read_dword(player_object + 0x11C)
	local v1_object_memory = get_object_memory(V1ID)
	
	for i = 1,16 do
		if player_present(i) and player_alive(i) then
			if (i ~= PlayerIndex) then
				local player_object2 = get_dynamic_player(i)
				local V2ID = read_dword(player_object2 + 0x11C)
				if (V2ID ~= 0xFFFFFFFF) then
					local v2_object_memory = get_object_memory(V2ID)
					if (v1_object_memory == v2_object_memory) then
						count = count + 1
					end
				end
			end
		end
	end
	
	return count
end
