-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "MyysticUI.Core.DefaultConfiguration.Classes.Brawler"
import "MyysticUI.Core.DefaultConfiguration.Classes.Burglar"
import "MyysticUI.Core.DefaultConfiguration.Classes.Captain"
import "MyysticUI.Core.DefaultConfiguration.Classes.Champion"
import "MyysticUI.Core.DefaultConfiguration.Classes.Guardian"
import "MyysticUI.Core.DefaultConfiguration.Classes.Hunter"
import "MyysticUI.Core.DefaultConfiguration.Classes.LoreMaster"
import "MyysticUI.Core.DefaultConfiguration.Classes.Mariner"
import "MyysticUI.Core.DefaultConfiguration.Classes.Minstrel"
import "MyysticUI.Core.DefaultConfiguration.Classes.RuneKeeper"
import "MyysticUI.Core.DefaultConfiguration.Classes.Warden"
import "MyysticUI.Core.DefaultConfiguration.Skirmish"
import "MyysticUI.Core.DefaultConfiguration.Potions"

MainConfig = class();

MainConfig.Brawler = 215;
MainConfig.Mariner = 216;

function MainConfig:Constructor()
	local eventService = SERVICE_CONTAINER:GetService(MyysticUI.Services.EventService);
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);

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
	local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);
	local eventService = SERVICE_CONTAINER:GetService(MyysticUI.Services.EventService);
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
	local playerService = SERVICE_CONTAINER:GetService(MyysticUI.Services.PlayerService);
	local playerClass = playerService.playerClass;

	configurationService:SetPlayerLevel( playerService.player:GetLevel() );

	-- Create Quickslot Bar        Name - Rows - Columns
	-- configHelper:CreateBar( "Health", nil, 5, 1, 200, 200 );
	-- configHelper:SetTrigger( ConfigurationHelper.HEALTH, 95 );
	-- configHelper:AddShortcut( 4, "0x70003E7F", 6 );

	if ( playerClass == Turbine.Gameplay.Class.Burglar ) then
		MyysticUI.Core.DefaultConfiguration.Classes.BurglarClass();
	elseif ( playerClass == Turbine.Gameplay.Class.Captain ) then
		MyysticUI.Core.DefaultConfiguration.Classes.CaptainClass();
	elseif ( playerClass == Turbine.Gameplay.Class.Champion ) then
		MyysticUI.Core.DefaultConfiguration.Classes.ChampionClass();
	elseif ( playerClass == Turbine.Gameplay.Class.Guardian ) then
		MyysticUI.Core.DefaultConfiguration.Classes.GuardianClass();
	elseif ( playerClass == Turbine.Gameplay.Class.Hunter ) then
		MyysticUI.Core.DefaultConfiguration.Classes.HunterClass();
	elseif ( playerClass == Turbine.Gameplay.Class.LoreMaster ) then
		MyysticUI.Core.DefaultConfiguration.Classes.LoreMasterClass();
	elseif ( playerClass == Turbine.Gameplay.Class.Minstrel ) then
		MyysticUI.Core.DefaultConfiguration.Classes.MinstrelClass();
	elseif ( playerClass == Turbine.Gameplay.Class.RuneKeeper ) then
		MyysticUI.Core.DefaultConfiguration.Classes.RuneKeeperClass();
	elseif ( playerClass == Turbine.Gameplay.Class.Warden ) then
		MyysticUI.Core.DefaultConfiguration.Classes.WardenClass();
	elseif ( playerClass == Turbine.Gameplay.Class.Beorning ) then
		-- MyysticUI.Core.DefaultConfiguration.Classes.WardenClass();
	elseif ( playerClass == self.Brawler ) then
		MyysticUI.Core.DefaultConfiguration.Classes.BrawlerClass();
	elseif ( playerClass == self.Mariner ) then
		MyysticUI.Core.DefaultConfiguration.Classes.MarinerClass();
	end

	--MyysticUI.Core.DefaultConfiguration.Skirmish();
	MyysticUI.Core.DefaultConfiguration.Potions();

	settingsService:SaveSettings();

	barService:LoadQuickslots();
	barService:RefreshBars();
end