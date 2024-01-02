-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine.Gameplay";
import "Turbine.UI";
import "MysticBars.Utils.Class";
import "MysticBars.Utils.Service";
import "MysticBars.Utils.Table";
import "MysticBars.Bars.Events.BuffEvents";
import "MysticBars.Bars.Events.KeyEvents";
import "MysticBars.Bars.Events.StatEvents";
import "MysticBars.Bars.Events.ClassSpecificEvents";
import "MysticBars.Bars.Events.MiscEvents";
import "MysticBars.Services.SettingsService"

PlayerService = class( MysticBars.Utils.Service );

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
		self.player = Turbine.Gameplay.LocalPlayer.GetInstance();
		self.playerClass = self.player:GetClass();
		self.playerClassAttributes = self.player:GetClassAttributes();
	end
end

function PlayerService:Build()
	if ( self.playerClass == nil ) then
		local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

		local settings = settingsService:GetSettings();
		if ( settings.playerClass == nil ) then
			settings.playerClass = 162;
		end
		self.playerClass = settings.playerClass;
	end
end