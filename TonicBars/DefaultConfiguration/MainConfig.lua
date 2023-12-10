-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

import "MyysticBars.TonicBars.DefaultConfiguration.Classes.Brawler"
import "MyysticBars.TonicBars.DefaultConfiguration.Classes.Burglar"
import "MyysticBars.TonicBars.DefaultConfiguration.Classes.Captain"
import "MyysticBars.TonicBars.DefaultConfiguration.Classes.Champion"
import "MyysticBars.TonicBars.DefaultConfiguration.Classes.Guardian"
import "MyysticBars.TonicBars.DefaultConfiguration.Classes.Hunter"
import "MyysticBars.TonicBars.DefaultConfiguration.Classes.LoreMaster"
import "MyysticBars.TonicBars.DefaultConfiguration.Classes.Mariner"
import "MyysticBars.TonicBars.DefaultConfiguration.Classes.Minstrel"
import "MyysticBars.TonicBars.DefaultConfiguration.Classes.RuneKeeper"
import "MyysticBars.TonicBars.DefaultConfiguration.Classes.Warden"
import "MyysticBars.TonicBars.DefaultConfiguration.Skirmish"
import "MyysticBars.TonicBars.DefaultConfiguration.Potions"

MainConfig = class();

MainConfig.Brawler = 215;
MainConfig.Mariner = 216;

function MainConfig:Constructor()
	local eventService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.EventService);
	local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);

	eventService:AddCallback( Turbine.Gameplay.LocalPlayer.GetInstance(), "LevelChanged", function( sender, args )
		self:CheckConfiguration();
	end);
	
	local configSettings = settingsService:GetSettings();
	if ( configSettings.defaultsCreated == nil and #settingsService:GetBars() == 0) then
		configSettings.defaultsCreated = true;
		self:CheckConfiguration();
	end
end

function MainConfig:CheckConfiguration()
	local barService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.BarService);
	local configurationService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.ConfigurationService);
	local eventService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.EventService);
	local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);
	local playerService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.PlayerService);
	local playerClass = playerService.playerClass;

	configurationService:SetPlayerLevel( playerService.player:GetLevel() );

	-- Create Quickslot Bar        Name - Rows - Columns
	-- configHelper:CreateBar( "Health", nil, 5, 1, 200, 200 );
	-- configHelper:SetTrigger( ConfigurationHelper.HEALTH, 95 );
	-- configHelper:AddShortcut( 4, "0x70003E7F", 6 );

	if ( playerClass == Turbine.Gameplay.Class.Burglar ) then
		MyysticBars.TonicBars.DefaultConfiguration.Classes.BurglarClass();
	elseif ( playerClass == Turbine.Gameplay.Class.Captain ) then
		MyysticBars.TonicBars.DefaultConfiguration.Classes.CaptainClass();
	elseif ( playerClass == Turbine.Gameplay.Class.Champion ) then
		MyysticBars.TonicBars.DefaultConfiguration.Classes.ChampionClass();
	elseif ( playerClass == Turbine.Gameplay.Class.Guardian ) then
		MyysticBars.TonicBars.DefaultConfiguration.Classes.GuardianClass();
	elseif ( playerClass == Turbine.Gameplay.Class.Hunter ) then
		MyysticBars.TonicBars.DefaultConfiguration.Classes.HunterClass();
	elseif ( playerClass == Turbine.Gameplay.Class.LoreMaster ) then
		MyysticBars.TonicBars.DefaultConfiguration.Classes.LoreMasterClass();
	elseif ( playerClass == Turbine.Gameplay.Class.Minstrel ) then
		MyysticBars.TonicBars.DefaultConfiguration.Classes.MinstrelClass();
	elseif ( playerClass == Turbine.Gameplay.Class.RuneKeeper ) then
		MyysticBars.TonicBars.DefaultConfiguration.Classes.RuneKeeperClass();
	elseif ( playerClass == Turbine.Gameplay.Class.Warden ) then
		MyysticBars.TonicBars.DefaultConfiguration.Classes.WardenClass();
	elseif ( playerClass == Turbine.Gameplay.Class.Beorning ) then
		-- MyysticBars.TonicBars.DefaultConfiguration.Classes.WardenClass();
	elseif ( playerClass == self.Brawler ) then
		MyysticBars.TonicBars.DefaultConfiguration.Classes.BrawlerClass();
	elseif ( playerClass == self.Mariner ) then
		MyysticBars.TonicBars.DefaultConfiguration.Classes.MarinerClass();
	end

	--MyysticBars.TonicBars.DefaultConfiguration.Skirmish();
	MyysticBars.TonicBars.DefaultConfiguration.Potions();

	settingsService:SaveSettings();

	barService:LoadQuickslots();
	barService:RefreshBars();
end