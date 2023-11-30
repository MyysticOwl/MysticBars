-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

import "Turbine.Gameplay";
import "Turbine.UI";
import "Tonic.Utils.Class";

MiscEvents = class( Turbine.Object  );

function MiscEvents:Constructor( regEvents )
	self.eventService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.EventService);
	self.playerService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.PlayerService);
	self.registeredEvents = regEvents;

	self.eventService:AddCallback( self.playerService.player, "InCombatChanged", function( sender, args )
		if ( self.playerService.player:IsInCombat() ) then
			self.registeredEvents.playerInCombat = true;
		else
			self.registeredEvents.playerInCombat = false;
		end
		self.eventService:NotifyClients();
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
	
	self.eventService:AddCallback( self.playerService.player, "MountChanged", function( sender, args )
		local mount = self.playerService.player:GetMount();
		if ( mount == nil ) then
			self.registeredEvents.playerMounted = false;
			self.registeredEvents.playerCombatMounted = false;
		else
			self.registeredEvents.playerMounted = true;
			if ( mount.GetFury ~= nil) then
				self.registeredEvents.playerCombatMounted = true;
		    end
		end
		self.eventService:NotifyClients();
	end);
end

function MiscEvents:CheckVisibility( barSettings )
	local visible = false;
	-- Send all Keypress based events to all clients
	if ( (self.registeredEvents.playerInCombat == true and barSettings.events.displayInCombat == true) or
		 (self.registeredEvents.playerInCombat == false and barSettings.events.displayNotInCombat == true)
		) then
		visible = true;
	end
	-- ToDo -- More here.
	if (
     (self.registeredEvents.playerMounted == true and barSettings.events.displayWhileMounted == true) or
	 (self.registeredEvents.playerMounted == false and barSettings.events.displayWhileNotMounted == true) or
	 (self.registeredEvents.playerCombatMounted == true and barSettings.events.displayWhileCombatMounted == true) or
	 (self.registeredEvents.playerCombatMounted == false and barSettings.events.displayWhileNotCombatMounted == true)
	) then
		visible = true;
	end
	return visible;
end