-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

import "Turbine.Gameplay";
import "Turbine.UI";
import "Tonic.Utils.Class";
import "Tonic.Utils.Table";
import "Tonic.Utils.TableDump"

ClassSpecificEvents = class( Turbine.Object  );

function ClassSpecificEvents:Constructor( regEvents )
	self.eventService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.EventService);
	self.playerService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.PlayerService);

	self.test = {1,2,3,4,5};
	self.registeredEvents = regEvents;
	local att = self.playerService.playerClassAttributes;
	if ( self.registeredEvents.classRange == nil ) then
		self.registeredEvents.classRange = { };
	end

	-- local dump = Tonic.Utils.TableDump()
	-- dump.Dump(getmetatable(Turbine.UI.Lotro.LotroUIElement));

	if ( self.playerService.player:GetClass() == Turbine.Gameplay.Class.Burglar ) then
		-- self.eventService.AddCallback( self, att, "StanceChanged", function( sender, args )
		-- 	Turbine.Shell.WriteLine( "BURG STANCE!!" );
		-- 	self.eventService:NotifyClients();
		-- end);
--		self.eventService.AddCallback( self, att, "IsCriticalTier1Changed", function( sender, args )
--			Turbine.Shell.WriteLine( "Tier1" );
----			self.registeredEvents.classRange[ LOCALESTRINGS.ClassTriggers["Crit Tier1"] ] = att:IsCriticalTier1Available();
--			self.eventService:NotifyClients();
--		end);
--		self.eventService.AddCallback( self, att, "IsCriticalTier2Changed", function( sender, args )
--			Turbine.Shell.WriteLine( "Tier2" );
----			self.registeredEvents.classRange[ LOCALESTRINGS.ClassTriggers["Crit Tier2"] ] = att:IsCriticalTier2Available();
--			self.eventService:NotifyClients();
--		end);
--		self.eventService.AddCallback( self, att, "IsCriticalTier3Changed", function( sender, args )
--			Turbine.Shell.WriteLine( "Tier3" );
----			self.registeredEvents.classRange[ LOCALESTRINGS.ClassTriggers["Crit Tier3"] ] = att:IsCriticalTier3Available();
--			self.eventService:NotifyClients();
--		end);
	elseif ( self.playerService.player:GetClass() == Turbine.Gameplay.Class.Champion ) then
		self.registeredEvents.classRange[ CHAMPION_FERVOR ] = att:GetFervor();
		self.eventService:AddCallback( att, "FervorChanged", function( sender, args )
			self.registeredEvents.classRange[ CHAMPION_FERVOR ] = att:GetFervor();
			self.eventService:NotifyClients();
		end);
	elseif ( self.playerService.player:GetClass() == Turbine.Gameplay.Class.RuneKeeper ) then
		self.registeredEvents.classRange[ RK_ATTUNEMENT ] = att:GetAttunement();
		self.eventService:AddCallback( att, "AttunementChanged", function( sender, args )
			self.registeredEvents.classRange[ RK_ATTUNEMENT ] = att:GetAttunement();
			self.eventService:NotifyClients();
		end);
		-- self.eventService.AddCallback( self, att, "IsChargedChanged", function( sender, args )
			-- self.registeredEvents.classRange[ LOCALESTRINGS.ClassTriggers["Charged"] ] = att:IsCharged();
			-- self.eventService:NotifyClients();
		-- end);
	elseif ( self.playerService.player:GetClass() == Turbine.Gameplay.Class.Hunter ) then
		self.registeredEvents.classRange[ HUNTER_FOCUS ] = att:GetFocus();
		self.eventService:AddCallback( att, "FocusChanged", function( sender, args )
			self.registeredEvents.classRange[ HUNTER_FOCUS ] = att:GetFocus();
			self.eventService:NotifyClients();
		end);
	elseif ( self.playerService.player:GetClass() == Turbine.Gameplay.Class.Minstrel ) then
		self.eventService:AddCallback( att, "StanceChanged", function( sender, args )
--			Turbine.Shell.WriteLine( "MINSTREL STANCE!!" );
			self.eventService:NotifyClients();
		end);
	end
	self.eventService:NotifyClients();
end

function ClassSpecificEvents:CheckVisibility( barSettings )
	local visible = false;
	if ( self.playerService.player:GetClass() == Turbine.Gameplay.Class.Minstrel ) then
		local att = self.playerService.player:GetClassAttributes();
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