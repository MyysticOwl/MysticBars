-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine.Gameplay";
import "Turbine.UI";
import "MyysticUI.Utils.Class";
import "MyysticUI.Utils.Service";
import "MyysticUI.Utils.Table";
import "MyysticUI.Bars.Events.BuffEvents";
import "MyysticUI.Bars.Events.KeyEvents";
import "MyysticUI.Bars.Events.StatEvents";
import "MyysticUI.Bars.Events.ClassSpecificEvents";
import "MyysticUI.Bars.Events.MiscEvents";
import "MyysticUI.Services.SettingsService"

PlayerService = class( MyysticUI.Utils.Service );

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
		local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);

		local settings = settingsService:GetSettings();
		if ( settings.playerClass == nil ) then
			settings.playerClass = 162;
		end
		self.playerClass = settings.playerClass;
	end
end