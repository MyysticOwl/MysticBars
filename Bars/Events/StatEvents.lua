-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine.Gameplay";
import "Turbine.UI";
import "MyysticUI.Utils.Class";
import "MyysticUI.Utils.Table";

StatEvents = class( Turbine.Object  );

function StatEvents:Constructor( regEvents )
	local eventService = SERVICE_CONTAINER:GetService(MyysticUI.Services.EventService);
	local playerService = SERVICE_CONTAINER:GetService(MyysticUI.Services.PlayerService);
	self.registeredEvents = regEvents;
	
	eventService:AddCallback( playerService.player, "MoraleChanged", function( sender, args )
		local eventService = SERVICE_CONTAINER:GetService(MyysticUI.Services.EventService);
		local playerService = SERVICE_CONTAINER:GetService(MyysticUI.Services.PlayerService);

		local value = playerService.player:GetMorale() / playerService.player:GetMaxMorale();
		if ( value ~= 1 ) then
			self.registeredEvents.healthTriggerActive = value;
		else
			self.registeredEvents.healthTriggerActive = nil;
		end
		eventService:NotifyClients();
	end);
	eventService:AddCallback( playerService.player, "PowerChanged", function( sender, args )
		local eventService = SERVICE_CONTAINER:GetService(MyysticUI.Services.EventService);
		local playerService = SERVICE_CONTAINER:GetService(MyysticUI.Services.PlayerService);

		local value = playerService.player:GetPower() / playerService.player:GetMaxPower();
		if ( value ~= 1 ) then
			self.registeredEvents.powerTriggerActive = value;
		else
			self.registeredEvents.powerTriggerActive = nil;
		end
		eventService:NotifyClients();
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