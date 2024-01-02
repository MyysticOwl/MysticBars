-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "MysticBars.Bars.Templates.Classes.BeorningTemplate"
import "MysticBars.Bars.Templates.Classes.BrawlerTemplate"
import "MysticBars.Bars.Templates.Classes.BurglarTemplate"
import "MysticBars.Bars.Templates.Classes.CaptainTemplate"
import "MysticBars.Bars.Templates.Classes.ChampionTemplate"
import "MysticBars.Bars.Templates.Classes.GuardianTemplate"
import "MysticBars.Bars.Templates.Classes.HunterTemplate"
import "MysticBars.Bars.Templates.Classes.LoreMasterTemplate"
import "MysticBars.Bars.Templates.Classes.MarinerTemplate"
import "MysticBars.Bars.Templates.Classes.MinstrelTemplate"
import "MysticBars.Bars.Templates.Classes.RuneKeeperTemplate"
import "MysticBars.Bars.Templates.Classes.WardenTemplate"
import "MysticBars.Bars.Templates.SkirmishTemplate"
import "MysticBars.Bars.Templates.MonsterPlayTemplate"
import "MysticBars.Bars.Templates.PotionsTemplate"
import "MysticBars.Bars.Templates.DynamicTemplate"
import "MysticBars.ShortcutLooksupData"

BarTemplates = class();

BarTemplates.Brawler = 215;
BarTemplates.Mariner = 216;

function BarTemplates:Constructor()
	local eventService = SERVICE_CONTAINER:GetService(MysticBars.Services.EventService);
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

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
	local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local playerService = SERVICE_CONTAINER:GetService(MysticBars.Services.PlayerService);
	local playerClass = playerService.playerClass;

	templateService:SetPlayerLevel( playerService.player:GetLevel() );

	MysticBars.Bars.Templates.DynamicTemplate();

	if ( playerClass == Turbine.Gameplay.Class.Beorning ) then
		MysticBars.Bars.Templates.Classes.BeorningTemplate();
	elseif ( playerClass == self.Brawler ) then
		MysticBars.Bars.Templates.Classes.BrawlerTemplate();
	elseif ( playerClass == Turbine.Gameplay.Class.Burglar ) then
		MysticBars.Bars.Templates.Classes.BurglarTemplate();
	elseif ( playerClass == Turbine.Gameplay.Class.Captain ) then
		MysticBars.Bars.Templates.Classes.CaptainTemplate();
	elseif ( playerClass == Turbine.Gameplay.Class.Champion ) then
		MysticBars.Bars.Templates.Classes.ChampionTemplate();
	elseif ( playerClass == Turbine.Gameplay.Class.Guardian ) then
		MysticBars.Bars.Templates.Classes.GuardianTemplate();
	elseif ( playerClass == Turbine.Gameplay.Class.Hunter ) then
		MysticBars.Bars.Templates.Classes.HunterTemplate();
	elseif ( playerClass == Turbine.Gameplay.Class.LoreMaster ) then
		MysticBars.Bars.Templates.Classes.LoreMasterTemplate();
	elseif ( playerClass == self.Mariner ) then
		MysticBars.Bars.Templates.Classes.MarinerTemplate();
	elseif ( playerClass == Turbine.Gameplay.Class.Minstrel ) then
		MysticBars.Bars.Templates.Classes.MinstrelTemplate();
	elseif ( playerClass == Turbine.Gameplay.Class.RuneKeeper ) then
		MysticBars.Bars.Templates.Classes.RuneKeeperTemplate();
	elseif ( playerClass == Turbine.Gameplay.Class.Warden ) then
		MysticBars.Bars.Templates.Classes.WardenTemplate();
	end

	MysticBars.Bars.Templates.SkirmishTemplate();
	MysticBars.Bars.Templates.PotionsTemplate();

	settingsService:SaveSettings();

	barService:LoadQuickslots();
	barService:RefreshBars();
end