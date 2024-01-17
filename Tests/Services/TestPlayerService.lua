-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

TestPlayerService = class( MysticBars.Utils.Service );

TestPlayerService.Log = MysticBars.Utils.Logging.LogManager.GetLogger( "TestPlayerService" );

TestPlayerService.player = nil
TestPlayerService.playerClass = nil
TestPlayerService.playerClassAttributes = nil
TestPlayerService.realClassSet = nil

function TestPlayerService:Constructor()
	self.Log:Debug("Constructor");
end

function TestPlayerService:Build()
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