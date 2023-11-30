-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

import "Tonic.TonicBars.DefaultConfiguration.Classes.Brawler"
import "Tonic.TonicBars.DefaultConfiguration.Classes.Burglar"
import "Tonic.TonicBars.DefaultConfiguration.Classes.Captain"
import "Tonic.TonicBars.DefaultConfiguration.Classes.Champion"
import "Tonic.TonicBars.DefaultConfiguration.Classes.Guardian"
import "Tonic.TonicBars.DefaultConfiguration.Classes.Hunter"
import "Tonic.TonicBars.DefaultConfiguration.Classes.LoreMaster"
import "Tonic.TonicBars.DefaultConfiguration.Classes.Mariner"
import "Tonic.TonicBars.DefaultConfiguration.Classes.Minstrel"
import "Tonic.TonicBars.DefaultConfiguration.Classes.RuneKeeper"
import "Tonic.TonicBars.DefaultConfiguration.Classes.Warden"
import "Tonic.TonicBars.DefaultConfiguration.Skirmish"
import "Tonic.TonicBars.DefaultConfiguration.Potions"

MainConfig = class();

MainConfig.Brawler = 215;
MainConfig.Mariner = 216;

function MainConfig:Constructor()
	self.barService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.BarService);
	self.configurationService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.ConfigurationService);
	self.eventService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.EventService);
	self.settingsService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.SettingsService);
	self.playerService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.PlayerService);
	self.playerClass = self.playerService.playerClass;

	self.eventService:AddCallback( Turbine.Gameplay.LocalPlayer.GetInstance(), "LevelChanged", function( sender, args )
		self:CheckConfiguration();
	end);
	
	local configSettings = self.settingsService:GetSettings();
	if ( configSettings.defaultsCreated == nil and #self.settingsService:GetBars() == 0) then
		configSettings.defaultsCreated = true;
		self:CheckConfiguration();
	end
end

function MainConfig:CheckConfiguration()
	self.configurationService:SetPlayerLevel( self.playerService.player:GetLevel() );

	-- Create Quickslot Bar        Name - Rows - Columns
	-- configHelper:CreateBar( "Health", nil, 5, 1, 200, 200 );
	-- configHelper:SetTrigger( ConfigurationHelper.HEALTH, 95 );
	-- configHelper:AddShortcut( 4, "0x70003E7F", 6 );

	if ( self.playerClass == Turbine.Gameplay.Class.Burglar ) then
		Tonic.TonicBars.DefaultConfiguration.Classes.BurglarClass();
	elseif ( self.playerClass == Turbine.Gameplay.Class.Captain ) then
		Tonic.TonicBars.DefaultConfiguration.Classes.CaptainClass();
	elseif ( self.playerClass == Turbine.Gameplay.Class.Champion ) then
		Tonic.TonicBars.DefaultConfiguration.Classes.ChampionClass();
	elseif ( self.playerClass == Turbine.Gameplay.Class.Guardian ) then
		Tonic.TonicBars.DefaultConfiguration.Classes.GuardianClass();
	elseif ( self.playerClass == Turbine.Gameplay.Class.Hunter ) then
		Tonic.TonicBars.DefaultConfiguration.Classes.HunterClass();
	elseif ( self.playerClass == Turbine.Gameplay.Class.LoreMaster ) then
		Tonic.TonicBars.DefaultConfiguration.Classes.LoreMasterClass();
	elseif ( self.playerClass == Turbine.Gameplay.Class.Minstrel ) then
		Tonic.TonicBars.DefaultConfiguration.Classes.MinstrelClass();
	elseif ( self.playerClass == Turbine.Gameplay.Class.RuneKeeper ) then
		Tonic.TonicBars.DefaultConfiguration.Classes.RuneKeeperClass();
	elseif ( self.playerClass == Turbine.Gameplay.Class.Beorning ) then
		-- Tonic.TonicBars.DefaultConfiguration.Classes.WardenClass();
	elseif ( self.playerClass == self.Brawler ) then
		Tonic.TonicBars.DefaultConfiguration.Classes.BrawlerClass();
	elseif ( self.playerClass == self.Mariner ) then
		Tonic.TonicBars.DefaultConfiguration.Classes.MarinerClass();
	end

	--Tonic.TonicBars.DefaultConfiguration.Skirmish();
	Tonic.TonicBars.DefaultConfiguration.Potions();

	self.settingsService:SaveSettings();
	self.barService:LoadQuickslots();
	self.barService:RefreshBars();
end