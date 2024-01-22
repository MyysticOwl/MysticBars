-- CreaquickslotRowsted by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

Migration326to330 = class( MysticBars.Utils.Service );

Migration326to330.Log = MysticBars.Utils.Logging.LogManager.GetLogger( "Migration326to330" );

Migration326to330.buffProfiles = {};

function Migration326to330:Constructor()
	self.Log:Debug("Constructor");
end

function Migration326to330:MigrateSettings()
	self.Log:Debug("MigrateSettings");

	local profiles = Turbine.PluginData.Load( Turbine.DataScope.Server, "TonicBarSettings", function(args) end);
	local buffProfiles = Turbine.PluginData.Load( Turbine.DataScope.Server, "MysticBarsBuffs", function(args) end);

	if ( profiles == nil ) then
		self.Log:Debug("TonicBarSettings Empy");
		return;
	end
	if ( buffProfiles == nil ) then
		buffProfiles = {};
	end

    Turbine.PluginData.Save( Turbine.DataScope.Server, "MysticBarsSettings_Backup", profiles, function (success, error)end);
    Turbine.PluginData.Save( Turbine.DataScope.Server, "MysticBarsBuffs_Backup", buffProfiles, function (success, error)end);

	local currentSettings = nil;
	local characters = {};

	self.Log:Debug("MigrateSettings starting");
	for characterName, settings in pairs(profiles) do
		self.Log:Debug("MigrateSettings starting " .. characterName);
		if (buffProfiles[characterName] ~= nil) then
			self.Log:Debug("MigrateSettings starting buffs " .. characterName);
			settings.buffs = buffProfiles[characterName];
		end

		characters[characterName] = true;

		local playerService = SERVICE_CONTAINER:GetService(MysticBars.Services.PlayerService);
		if (characterName == playerService.player:GetName()) then
			currentSettings = settings;
		end

		Turbine.PluginData.Save( Turbine.DataScope.Server, "MysticBars_" .. characterName, settings, function (success, error)end);
	end
	self.Log:Debug("MigrateSettings complete");
	Turbine.PluginData.Save( Turbine.DataScope.Server, "TonicBarSettings", nil, function (success, error)end);
	Turbine.PluginData.Save( Turbine.DataScope.Server, "MysticBarsBuffs", nil, function (success, error)end);

	Turbine.PluginData.Save( Turbine.DataScope.Server, "MysticBars_Characters", characters, function (success, error)end);

	return currentSettings;
end