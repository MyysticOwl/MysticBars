-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine.Gameplay";
import "Turbine.UI";
import "MysticBars.Utils.Class";

MiscEvents = class( Turbine.Object  );

function MiscEvents:Constructor( regEvents )
	local eventService = SERVICE_CONTAINER:GetService(MysticBars.Services.EventService);
	local playerService = SERVICE_CONTAINER:GetService(MysticBars.Services.PlayerService);
	self.registeredEvents = regEvents;

	eventService:AddCallback( playerService.player, "InCombatChanged", function( sender, args )
		if ( playerService.player:IsInCombat() ) then
			self.registeredEvents.playerInCombat = true;
		else
			self.registeredEvents.playerInCombat = false;
		end
		eventService:NotifyClients();
	end);
	
-- 1: __index
--    1: GetAgility
--    2: GetArmor
--    3: GetBaseAgility
--    4: GetBaseArmor
--    5: GetBaseMaxMorale
--    6: GetBaseMaxPower
--    7: GetBaseStrength
--    8: GetEvasion
--    9: GetFury
--    10: GetMaxFury
--    11: GetMaxMorale
--    12: GetMaxPower
--    13: GetMaxTemporaryMorale
--    14: GetMaxTemporaryPower
--    15: GetMorale
--    16: GetPower
--    17: GetStrength
--    18: GetTemporaryMorale
--    19: GetTemporaryPower
--    20: GetTurnRate
--  2: __metatable
	
	eventService:AddCallback( playerService.player, "MountChanged", function( sender, args )
		local eventService = SERVICE_CONTAINER:GetService(MysticBars.Services.EventService);
		local playerService = SERVICE_CONTAINER:GetService(MysticBars.Services.PlayerService);
		
		local mount = playerService.player:GetMount();
		if ( mount == nil ) then
			self.registeredEvents.playerMounted = false;
			self.registeredEvents.playerCombatMounted = false;
		else
			self.registeredEvents.playerMounted = true;
			if ( mount.GetFury ~= nil) then
				self.registeredEvents.playerCombatMounted = true;
		    end
		end
		eventService:NotifyClients();
	end);
end

function MiscEvents:CheckVisibility( barSettings )
	local visible = false;
	-- Send all Keypress based events to all clients
	if ( (self.registeredEvents.playerInCombat == true and barSettings.events.triggered ~= nil and barSettings.events.triggered.displayInCombat == true) or
		 (self.registeredEvents.playerInCombat == false and barSettings.events.triggered ~= nil and barSettings.events.triggered.displayNotInCombat == true)
		) then
		visible = true;
	end
	-- ToDo -- More here.
	if (
     (self.registeredEvents.playerMounted == true and barSettings.events.triggered.displayWhileMounted == true) or
	 (self.registeredEvents.playerMounted == false and barSettings.events.triggered.displayWhileNotMounted == true) or
	 (self.registeredEvents.playerCombatMounted == true and barSettings.events.triggered.displayWhileCombatMounted == true) or
	 (self.registeredEvents.playerCombatMounted == false and barSettings.events.triggered.displayWhileNotCombatMounted == true)
	) then
		visible = true;
	end
	return visible;
end