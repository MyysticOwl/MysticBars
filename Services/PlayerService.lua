-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

PlayerService = class( MysticBars.Utils.Service );

PlayerService.Log = MysticBars.Utils.Logging.LogManager.GetLogger( "PlayerService" );

PlayerService.player = nil
PlayerService.playerClass = nil
PlayerService.playerClassAttributes = nil
PlayerService.realClassSet = nil

function PlayerService:Constructor()
	self.Log:Debug("Constructor");

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
	self.Log:Debug("Build");

	if ( self.playerClass == nil ) then
		local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

		local settings = settingsService:GetSettings();
		if ( settings.playerClass == nil ) then
			settings.playerClass = 162;
		end
		self.playerClass = settings.playerClass;
	end
end