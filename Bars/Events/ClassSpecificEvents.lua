-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine.Gameplay";
import "Turbine.UI";
import "MyysticUI.Utils.Class";
import "MyysticUI.Utils.Table";
import "MyysticUI.Utils.TableDump"

ClassSpecificEvents = class( Turbine.Object  );

function ClassSpecificEvents:Constructor( regEvents )
	local eventService = SERVICE_CONTAINER:GetService(MyysticUI.Services.EventService);
	local playerService = SERVICE_CONTAINER:GetService(MyysticUI.Services.PlayerService);

	self.test = {1,2,3,4,5};
	self.registeredEvents = regEvents;
	local att = playerService.playerClassAttributes;
	if ( self.registeredEvents.classRange == nil ) then
		self.registeredEvents.classRange = { };
	end

	-- local dump = MyysticUI.Utils.TableDump()
	-- dump.Dump(getmetatable(Turbine.UI.Lotro.LotroUIElement));

	if ( playerService.player:GetClass() == Turbine.Gameplay.Class.Burglar ) then
		-- eventService.AddCallback( self, att, "StanceChanged", function( sender, args )
		-- 	Turbine.Shell.WriteLine( "BURG STANCE!!" );
		-- 	eventService:NotifyClients();
		-- end);
--		eventService.AddCallback( self, att, "IsCriticalTier1Changed", function( sender, args )
--			Turbine.Shell.WriteLine( "Tier1" );
----			self.registeredEvents.classRange[ "Crit Tier1" ] = att:IsCriticalTier1Available();
--			eventService:NotifyClients();
--		end);
--		eventService.AddCallback( self, att, "IsCriticalTier2Changed", function( sender, args )
--			Turbine.Shell.WriteLine( "Tier2" );
----			self.registeredEvents.classRange[ "Crit Tier2" ] = att:IsCriticalTier2Available();
--			eventService:NotifyClients();
--		end);
--		eventService.AddCallback( self, att, "IsCriticalTier3Changed", function( sender, args )
--			Turbine.Shell.WriteLine( "Tier3" );
----			self.registeredEvents.classRange[ "Crit Tier3" ] = att:IsCriticalTier3Available();
--			eventService:NotifyClients();
--		end);
	elseif ( playerService.player:GetClass() == Turbine.Gameplay.Class.Champion ) then
		self.registeredEvents.classRange[ CHAMPION_FERVOR ] = att:GetFervor();
		eventService:AddCallback( att, "FervorChanged", function( sender, args )
			self.registeredEvents.classRange[ CHAMPION_FERVOR ] = att:GetFervor();
			eventService:NotifyClients();
		end);
	elseif ( playerService.player:GetClass() == Turbine.Gameplay.Class.RuneKeeper ) then
		if (self.registeredEvents.classRange[ RK_ATTUNEMENT ] ~= nil) then
			self.registeredEvents.classRange[ RK_ATTUNEMENT ] = att:GetAttunement();
			eventService:AddCallback( att, "AttunementChanged", function( sender, args )
				self.registeredEvents.classRange[ RK_ATTUNEMENT ] = att:GetAttunement();
				eventService:NotifyClients();
			end);
		end
		-- eventService.AddCallback( self, att, "IsChargedChanged", function( sender, args )
			-- self.registeredEvents.classRange[ "Charged" ] = att:IsCharged();
			-- eventService:NotifyClients();
		-- end);
	elseif ( playerService.player:GetClass() == Turbine.Gameplay.Class.Hunter ) then
		self.registeredEvents.classRange[ HUNTER_FOCUS ] = att:GetFocus();
		eventService:AddCallback( att, "FocusChanged", function( sender, args )
			self.registeredEvents.classRange[ HUNTER_FOCUS ] = att:GetFocus();
			eventService:NotifyClients();
		end);
	elseif ( playerService.player:GetClass() == Turbine.Gameplay.Class.Minstrel ) then
		eventService:AddCallback( att, "StanceChanged", function( sender, args )
--			Turbine.Shell.WriteLine( "MINSTREL STANCE!!" );
			eventService:NotifyClients();
		end);
	end
	eventService:NotifyClients();
end

function ClassSpecificEvents:CheckVisibility( barSettings )
	local playerService = SERVICE_CONTAINER:GetService(MyysticUI.Services.PlayerService);

	local visible = false;
	if ( playerService.player:GetClass() == Turbine.Gameplay.Class.Minstrel ) then
		local att = playerService.player:GetClassAttributes();
		if ( barSettings.events ~= nil and barSettings.events.effects ~= nil ) then
			if ( (att:IsSerenadeTier1Available() and barSettings.events.effects[ "Ballad Tier 1" ] ~= nil) or
				 (att:IsSerenadeTier2Available() and barSettings.events.effects[ "Ballad Tier 2" ] ~= nil) or
				 (att:IsSerenadeTier3Available() and barSettings.events.effects[ "Ballad Tier 3" ] ~= nil)	 ) then
				visible = true;
			end
		end
	end

	-- Send all Class Specific events to all clients
	if (barSettings.events.classRange ~= nil ) then
		for key2, value2 in pairs (self.registeredEvents.classRange) do
			if ( value2 ~= nil and barSettings.events ~= nil and barSettings.events.classRange[ key2 ] ~= nil and 
																 barSettings.events.classRange[ key2 ].minValue ~= nil and
																 barSettings.events.classRange[ key2 ].maxValue ~= nil ) then
				if ( type( value2 ) == "number" and value2 >= barSettings.events.classRange[ key2 ].minValue and value2 <= barSettings.events.classRange[ key2 ].maxValue ) then
					visible = true;
				end
			end
		end
	end
	return visible;
end