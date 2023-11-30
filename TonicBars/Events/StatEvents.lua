-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

import "Turbine.Gameplay";
import "Turbine.UI";
import "Tonic.Utils.Class";
import "Tonic.Utils.Table";

StatEvents = class( Turbine.Object  );

function StatEvents:Constructor( regEvents )
	self.eventService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.EventService);
	self.playerService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.PlayerService);
	self.registeredEvents = regEvents;
	
	self.eventService:AddCallback( self.playerService.player, "MoraleChanged", function( sender, args )
		local value = self.playerService.player:GetMorale() / self.playerService.player:GetMaxMorale();
		if ( value ~= 1 ) then
			self.registeredEvents.healthTriggerActive = value;
		else
			self.registeredEvents.healthTriggerActive = nil;
		end
		self.eventService:NotifyClients();
	end);
	self.eventService:AddCallback( self.playerService.player, "PowerChanged", function( sender, args )
		local value = self.playerService.player:GetPower() / self.playerService.player:GetMaxPower();
		if ( value ~= 1 ) then
			self.registeredEvents.powerTriggerActive = value;
		else
			self.registeredEvents.powerTriggerActive = nil;
		end
		self.eventService:NotifyClients();
	end);
end

function StatEvents:CheckVisibility( barSettings )
	local visible = false;
	if ( (self.registeredEvents.healthTriggerActive ~= nil and barSettings.events.healthTrigger ~= nil and
		  self.registeredEvents.healthTriggerActive <= barSettings.events.healthTrigger and 
		  barSettings.events.displayOnHealth) or 
		 (self.registeredEvents.powerTriggerActive ~= nil and barSettings.events.powerTrigger ~= nil and
		  self.registeredEvents.powerTriggerActive <= barSettings.events.powerTrigger and 
		  barSettings.events.displayOnPower) ) then
		visible = true;
	end
	return visible;
end