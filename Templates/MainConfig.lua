-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "MyysticUI.Templates.Classes.BeorningTemplate"
import "MyysticUI.Templates.Classes.BrawlerTemplate"
import "MyysticUI.Templates.Classes.BurglarTemplate"
import "MyysticUI.Templates.Classes.CaptainTemplate"
import "MyysticUI.Templates.Classes.ChampionTemplate"
import "MyysticUI.Templates.Classes.GuardianTemplate"
import "MyysticUI.Templates.Classes.HunterTemplate"
import "MyysticUI.Templates.Classes.LoreMasterTemplate"
import "MyysticUI.Templates.Classes.MarinerTemplate"
import "MyysticUI.Templates.Classes.MinstrelTemplate"
import "MyysticUI.Templates.Classes.RuneKeeperTemplate"
import "MyysticUI.Templates.Classes.WardenTemplate"
import "MyysticUI.Templates.SkirmishTemplate"
import "MyysticUI.Templates.MonsterPlayTemplate"
import "MyysticUI.Templates.PotionsTemplate"

MainConfig = class();

MainConfig.Brawler = 215;
MainConfig.Mariner = 216;

function MainConfig:Constructor()
	local eventService = SERVICE_CONTAINER:GetService(MyysticUI.Services.EventService);
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);

	eventService:AddCallback( Turbine.Gameplay.LocalPlayer.GetInstance(), "LevelChanged", function( sender, args )
		self:CheckTemplates();
	end);

	local configSettings = settingsService:GetSettings();
	if ( configSettings.defaultsCreated == nil and settingsService:GetBars() == 0) then
		configSettings.defaultsCreated = true;
		self:CheckTemplates();
	end
end

function MainConfig:CheckTemplates()
	local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
	local playerService = SERVICE_CONTAINER:GetService(MyysticUI.Services.PlayerService);
	local playerClass = playerService.playerClass;

	templateService:SetPlayerLevel( playerService.player:GetLevel() );

	if ( playerClass == Turbine.Gameplay.Class.Beorning ) then
		MyysticUI.Templates.Classes.BeorningTemplate();
	elseif ( playerClass == self.Brawler ) then
		MyysticUI.Templates.Classes.BrawlerTemplate();
	elseif ( playerClass == Turbine.Gameplay.Class.Burglar ) then
		MyysticUI.Templates.Classes.BurglarTemplate();
	elseif ( playerClass == Turbine.Gameplay.Class.Captain ) then
		MyysticUI.Templates.Classes.CaptainTemplate();
	elseif ( playerClass == Turbine.Gameplay.Class.Champion ) then
		MyysticUI.Templates.Classes.ChampionTemplate();
	elseif ( playerClass == Turbine.Gameplay.Class.Guardian ) then
		MyysticUI.Templates.Classes.GuardianTemplate();
	elseif ( playerClass == Turbine.Gameplay.Class.Hunter ) then
		MyysticUI.Templates.Classes.HunterTemplate();
	elseif ( playerClass == Turbine.Gameplay.Class.LoreMaster ) then
		MyysticUI.Templates.Classes.LoreMasterTemplate();
	elseif ( playerClass == self.Mariner ) then
		MyysticUI.Templates.Classes.MarinerTemplate();
	elseif ( playerClass == Turbine.Gameplay.Class.Minstrel ) then
		MyysticUI.Templates.Classes.MinstrelTemplate();
	elseif ( playerClass == Turbine.Gameplay.Class.RuneKeeper ) then
		MyysticUI.Templates.Classes.RuneKeeperTemplate();
	elseif ( playerClass == Turbine.Gameplay.Class.Warden ) then
		MyysticUI.Templates.Classes.WardenTemplate();
	end

	MyysticUI.Templates.SkirmishTemplate();
	MyysticUI.Templates.PotionsTemplate();

	settingsService:SaveSettings();

	barService:LoadQuickslots();
	barService:RefreshBars();
end