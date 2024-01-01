-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "MyysticUI.Bars.Templates.Classes.BeorningTemplate"
import "MyysticUI.Bars.Templates.Classes.BrawlerTemplate"
import "MyysticUI.Bars.Templates.Classes.BurglarTemplate"
import "MyysticUI.Bars.Templates.Classes.CaptainTemplate"
import "MyysticUI.Bars.Templates.Classes.ChampionTemplate"
import "MyysticUI.Bars.Templates.Classes.GuardianTemplate"
import "MyysticUI.Bars.Templates.Classes.HunterTemplate"
import "MyysticUI.Bars.Templates.Classes.LoreMasterTemplate"
import "MyysticUI.Bars.Templates.Classes.MarinerTemplate"
import "MyysticUI.Bars.Templates.Classes.MinstrelTemplate"
import "MyysticUI.Bars.Templates.Classes.RuneKeeperTemplate"
import "MyysticUI.Bars.Templates.Classes.WardenTemplate"
import "MyysticUI.Bars.Templates.SkirmishTemplate"
import "MyysticUI.Bars.Templates.MonsterPlayTemplate"
import "MyysticUI.Bars.Templates.PotionsTemplate"
import "MyysticUI.Bars.Templates.DynamicTemplate"
import "MyysticUI.Tools.ShortcutLooksupData"

BarTemplates = class();

BarTemplates.Brawler = 215;
BarTemplates.Mariner = 216;

function BarTemplates:Constructor()
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

function BarTemplates:CheckTemplates()
	local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
	local playerService = SERVICE_CONTAINER:GetService(MyysticUI.Services.PlayerService);
	local playerClass = playerService.playerClass;

	templateService:SetPlayerLevel( playerService.player:GetLevel() );

	MyysticUI.Bars.Templates.DynamicTemplate();

	if ( playerClass == Turbine.Gameplay.Class.Beorning ) then
		MyysticUI.Bars.Templates.Classes.BeorningTemplate();
	elseif ( playerClass == self.Brawler ) then
		MyysticUI.Bars.Templates.Classes.BrawlerTemplate();
	elseif ( playerClass == Turbine.Gameplay.Class.Burglar ) then
		MyysticUI.Bars.Templates.Classes.BurglarTemplate();
	elseif ( playerClass == Turbine.Gameplay.Class.Captain ) then
		MyysticUI.Bars.Templates.Classes.CaptainTemplate();
	elseif ( playerClass == Turbine.Gameplay.Class.Champion ) then
		MyysticUI.Bars.Templates.Classes.ChampionTemplate();
	elseif ( playerClass == Turbine.Gameplay.Class.Guardian ) then
		MyysticUI.Bars.Templates.Classes.GuardianTemplate();
	elseif ( playerClass == Turbine.Gameplay.Class.Hunter ) then
		MyysticUI.Bars.Templates.Classes.HunterTemplate();
	elseif ( playerClass == Turbine.Gameplay.Class.LoreMaster ) then
		MyysticUI.Bars.Templates.Classes.LoreMasterTemplate();
	elseif ( playerClass == self.Mariner ) then
		MyysticUI.Bars.Templates.Classes.MarinerTemplate();
	elseif ( playerClass == Turbine.Gameplay.Class.Minstrel ) then
		MyysticUI.Bars.Templates.Classes.MinstrelTemplate();
	elseif ( playerClass == Turbine.Gameplay.Class.RuneKeeper ) then
		MyysticUI.Bars.Templates.Classes.RuneKeeperTemplate();
	elseif ( playerClass == Turbine.Gameplay.Class.Warden ) then
		MyysticUI.Bars.Templates.Classes.WardenTemplate();
	end

	MyysticUI.Bars.Templates.SkirmishTemplate();
	MyysticUI.Bars.Templates.PotionsTemplate();

	settingsService:SaveSettings();

	barService:LoadQuickslots();
	barService:RefreshBars();
end