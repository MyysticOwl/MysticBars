-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

import "Turbine.Gameplay";
import "Turbine.UI";
import "Tonic.Utils.Class";
import "Tonic.Utils.Service";
import "Tonic.Utils.Table";
import "Tonic.TonicBars.Events.BuffEvents";
import "Tonic.TonicBars.Events.KeyEvents";
import "Tonic.TonicBars.Events.StatEvents";
import "Tonic.TonicBars.Events.ClassSpecificEvents";
import "Tonic.TonicBars.Events.MiscEvents";
import "Tonic.TonicBars.Services.SettingsService"

PlayerService = class( Tonic.Utils.Service );

PlayerService.player = nil
PlayerService.playerClass = nil
PlayerService.playerClassAttributes = nil
PlayerService.realClassSet = nil

function PlayerService:Constructor()
	function GetPlayer()
		self.player = Turbine.Gameplay.LocalPlayer.GetInstance();
		self.playerClass = self.player:GetClass();
		self.playerClassAttributes = self.player:GetClassAttributes();
		self.realClassSet = true;
	end
	if ( pcall( GetPlayer ) == false ) then
		self.player = Turbine.Gameplay.LocalPlayer();
		self.playerClass = self.player:GetClass();
		self.playerClassAttributes = self.player:GetClassAttributes();
	end
end

function PlayerService:Build()
	if ( self.playerClass == nil ) then
		local settingsService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.SettingsService);

		local settings = settingsService:GetSettings();
		if ( settings.playerClass == nil ) then
			settings.playerClass = 162;
		end
		self.playerClass = settings.playerClass;
	end
	Turbine.Shell.WriteLine("Player is: " .. self.playerClass)
end