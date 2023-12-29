-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "MyysticUI.Configuration.Classes.Brawler"
import "MyysticUI.Configuration.Classes.Burglar"
import "MyysticUI.Configuration.Classes.Captain"
import "MyysticUI.Configuration.Classes.Champion"
import "MyysticUI.Configuration.Classes.Guardian"
import "MyysticUI.Configuration.Classes.Hunter"
import "MyysticUI.Configuration.Classes.LoreMaster"
import "MyysticUI.Configuration.Classes.Mariner"
import "MyysticUI.Configuration.Classes.Minstrel"
import "MyysticUI.Configuration.Classes.RuneKeeper"
import "MyysticUI.Configuration.Classes.Warden"
import "MyysticUI.Configuration.Skirmish"
import "MyysticUI.Configuration.Potions"

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
	if ( configSettings.defaultsCreated == nil and settingsService:GetBars() == 0) then
		configSettings.defaultsCreated = true;
		self:CheckConfiguration();
	end
end

function MainConfig:CheckConfiguration()
	local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
	local playerService = SERVICE_CONTAINER:GetService(MyysticUI.Services.PlayerService);
	local playerClass = playerService.playerClass;

	configurationService:SetPlayerLevel( playerService.player:GetLevel() );

	-- Create Quickslot Bar        Name - Rows - Columns
	-- configHelper:CreateBar( "Health", nil, 5, 1, 200, 200 );
	-- configHelper:SetTrigger( ConfigurationHelper.HEALTH, 95 );
	-- configHelper:AddShortcut( 4, "0x70003E7F", 6 );

	if ( playerClass == Turbine.Gameplay.Class.Burglar ) then
		MyysticUI.Configuration.Classes.BurglarClass();
	elseif ( playerClass == Turbine.Gameplay.Class.Captain ) then
		MyysticUI.Configuration.Classes.CaptainClass();
	elseif ( playerClass == Turbine.Gameplay.Class.Champion ) then
		MyysticUI.Configuration.Classes.ChampionClass();
	elseif ( playerClass == Turbine.Gameplay.Class.Guardian ) then
		MyysticUI.Configuration.Classes.GuardianClass();
	elseif ( playerClass == Turbine.Gameplay.Class.Hunter ) then
		MyysticUI.Configuration.Classes.HunterClass();
	elseif ( playerClass == Turbine.Gameplay.Class.LoreMaster ) then
		MyysticUI.Configuration.Classes.LoreMasterClass();
	elseif ( playerClass == Turbine.Gameplay.Class.Minstrel ) then
		MyysticUI.Configuration.Classes.MinstrelClass();
	elseif ( playerClass == Turbine.Gameplay.Class.RuneKeeper ) then
		MyysticUI.Configuration.Classes.RuneKeeperClass();
	elseif ( playerClass == Turbine.Gameplay.Class.Warden ) then
		MyysticUI.Configuration.Classes.WardenClass();
	elseif ( playerClass == Turbine.Gameplay.Class.Beorning ) then
		-- MyysticUI.Configuration.Classes.WardenClass();
	elseif ( playerClass == self.Brawler ) then
		MyysticUI.Configuration.Classes.BrawlerClass();
	elseif ( playerClass == self.Mariner ) then
		MyysticUI.Configuration.Classes.MarinerClass();
	end

	--MyysticUI.Configuration.Skirmish();
	MyysticUI.Configuration.Potions();

	settingsService:SaveSettings();

	barService:LoadQuickslots();
	barService:RefreshBars();
end