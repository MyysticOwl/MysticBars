-- CreaquickslotRowsted by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

SettingsService = class( MysticBars.Utils.Service );

SettingsService.Log = MysticBars.Utils.Logging.LogManager.GetLogger( "SettingsService" );

SettingsService.buffProfiles = {};

function SettingsService:Constructor()
	self.Log:Debug("Constructor");

	self.PARTIAL = 1;
	self.ALL = 2;
	self.BAR = 3;
	self.working = false;

	self:LoadSettings();

	local DISPLAYWIDTH = Turbine.UI.Display.GetWidth();
   	local DISPLAYHEIGHT = Turbine.UI.Display.GetHeight();

	if ( self.settings.bars ~= nil ) then
		for bKey, bValue in pairs (self.settings.bars) do
			if ( bValue.relationalX == nil or bValue.relationalY == nil ) then				
				bValue.relationalX = bValue.x / DISPLAYWIDTH;
				bValue.relationalY = bValue.y / DISPLAYHEIGHT;
			end

			bValue.x = math.floor(bValue.relationalX * DISPLAYWIDTH);
			bValue.y = math.floor(bValue.relationalY * DISPLAYHEIGHT);
		end
	end
	if ( self.settings.barMode ~= NORMAL_MODE ) then
		self.settings.barMode = NORMAL_MODE;
	end

end

function SettingsService:GetSettings()
	self.Log:Debug("GetSettings");

	return self.settings;
end

function SettingsService:LoadSettings( profile )
	self.Log:Debug("LoadSettings");

	local playerService = SERVICE_CONTAINER:GetService(MysticBars.Services.PlayerService);

	if ( profile == nil ) then
		self.profiles = Turbine.PluginData.Load( Turbine.DataScope.Server, "TonicBarSettings", function(args) end);
	else
		self.profiles = profile;
	end
	if ( self.profiles == nil ) then
		self.profiles = { };
	end

	local playersName = playerService.player:GetName();
	local playerSettings = self.profiles[ playersName ];
	if ( playerSettings == nil ) then
		self.profiles[ playersName ] = { };
		playerSettings = self.profiles[ playersName ];
	end

	local usData = true;
	for key, value in pairs(playerSettings) do
		if (type( key ) ~= "number" ) then
			usData = false;
			break;
		end
	end

	local language = Turbine.Engine.GetLanguage();
	local locale = (language == Turbine.Language.English and "en" or (language == Turbine.Language.French and "fr" or (language == Turbine.Language.Russian and "ru" or "de" )));
	if ( locale == "de" or locale == "fr" or not usData ) then
		self.settings = { };
		MysticBars.Utils.DeepcopyLoadConvertInts( playerSettings, self.settings );
	else
		self.settings = playerSettings;
	end

	self.settings.version = THEVERSION;

	if ( self.settings.bars == nil ) then
		self.settings.bars = { };
	end
	if ( self.settings.menuLanguage == nil ) then
		self.settings.menuLanguage = locale;
	end
	if ( self.settings.nextBarId == nil ) then
		self.settings.nextBarId = 0;
	end
	if ( self.settings.mainMenuVisible ~= nil ) then
		self.settings.mainMenuVisible = nil;
	end
	if ( self.settings.selectedBar == nil )then
		self.settings.selectedBar = 0;
	end

	return self.settings;
end

function SettingsService:SaveSettings( profile )
	self.Log:Debug("SaveSettings");

	local playerService = SERVICE_CONTAINER:GetService(MysticBars.Services.PlayerService);

	local language = Turbine.Engine.GetLanguage();
	local locale = (language == Turbine.Language.English and "en" or (language == Turbine.Language.French and "fr" or (language == Turbine.Language.Russian and "ru" or "de" )));

	if ( locale == "de" or locale == "fr" or locale == "ru" ) then
		local temp = { };
		if ( profile == nil ) then
			MysticBars.Utils.DeepcopySaveConvertInts( self.settings, temp );
			self.profiles[ playerService.player:GetName() ] = temp;
		else
			MysticBars.Utils.DeepcopySaveConvertInts( profile, temp );
			Turbine.PluginData.Save( Turbine.DataScope.Server, "TonicBarSettings", temp, function (success, error)
				if (not success) then
					Turbine.Shell.WriteLine("Error Saving... " .. error);
				end
			end);
		end
	else
		if ( profile == nil ) then
			self.profiles[ playerService.player:GetName() ] = self.settings;
		else
			Turbine.PluginData.Save( Turbine.DataScope.Server, "TonicBarSettings", profile, function (success, error)
				if (not success) then
					Turbine.Shell.WriteLine("Error Saving... " .. error);
				end
			end);
		end
	end
	if ( profile == nil ) then
		Turbine.PluginData.Save( Turbine.DataScope.Server, "TonicBarSettings", self.profiles, function (success, error)
			if (not success) then
				Turbine.Shell.WriteLine("Error Saving... " .. error);
			end
		end);
	end
end

function SettingsService:LoadBuffs()
	self.Log:Debug("LoadBuffs");

	local playerService = SERVICE_CONTAINER:GetService(MysticBars.Services.PlayerService);

	self.buffProfiles = Turbine.PluginData.Load( Turbine.DataScope.Server, "MysticBarsBuffs", function(args) end);
	if ( self.buffProfiles == nil ) then
		self.buffProfiles = { };
	end

	local playersName = playerService.player:GetName();
	local playerBuffs = self.buffProfiles[ playersName ];
	if ( playerBuffs == nil ) then
		self.buffProfiles[ playersName ] = { };
		playerBuffs = self.buffProfiles[ playersName ];
	end

	local language = Turbine.Engine.GetLanguage();
	local locale = (language == Turbine.Language.English and "en" or (language == Turbine.Language.French and "fr" or (language == Turbine.Language.Russian and "ru" or "de" )));
	if ( locale == "de" or locale == "fr" ) then
		self.buffs = { };
		MysticBars.Utils.DeepcopyLoadConvertInts( playerBuffs, self.buffs );
	else
		self.buffs = playerBuffs;
	end

	return self.buffs;
end

function SettingsService:SaveBuffs(buffs)
	self.Log:Debug("SaveBuffs");

	local playerService = SERVICE_CONTAINER:GetService(MysticBars.Services.PlayerService);
	local playersName = playerService.player:GetName();

	self.buffProfiles[ playersName ] = buffs;

	local language = Turbine.Engine.GetLanguage();
	local locale = (language == Turbine.Language.English and "en" or (language == Turbine.Language.French and "fr" or (language == Turbine.Language.Russian and "ru" or "de" )));

	if ( locale == "de" or locale == "fr" or locale == "ru" ) then
		local temp = { };
		MysticBars.Utils.DeepcopySaveConvertInts( self.buffProfiles, temp );
		Turbine.PluginData.Save( Turbine.DataScope.Server, "MysticBarsBuffs", temp, function (success, error)
			if (not success) then
				Turbine.Shell.WriteLine("Error Saving... " .. error);
			end
		end);
		return self.buffProfiles;
	end
	Turbine.PluginData.Save( Turbine.DataScope.Server, "MysticBarsBuffs", self.buffProfiles, function (success, error)
		if (not success) then
			Turbine.Shell.WriteLine("Error Saving... " .. error);
		end
	end);
	return self.buffProfiles;
end

function SettingsService:GetBars( localBarType )
	self.Log:Debug("GetBars");

	if ( localBarType == nil ) then
		return self.settings.bars
	else
		self.tempBars = { };
		local i = 1;
		for key, value in pairs (self.settings.bars) do
			if ( value.barType == localBarType and value ~= nil ) then
				self.tempBars[key] = {};
				MysticBars.Utils.Deepcopy( self.settings.bars[key], self.tempBars[key] );
				i = i + 1;
			end
		end
		return self.tempBars;
	end
end

function SettingsService:FindBar( name )
	if ( self.settings.autoCreatedBars ~= nil ) then
		for key, value in pairs (self.settings.autoCreatedBars) do
			if ( value.barName == name ) then
				return value;
			end
		end
	end
	for key, value in pairs (self.settings.bars) do
		if ( value.barName == name ) then
			return value;
		end
	end
	return nil;
end

function SettingsService:NewBar()
	local bar = { };
	bar.id = self:IncrementNextId();
	bar.quickslots = { };
	bar.x = 103;
	bar.y = 161;
	bar.decorator = TAB_BAR_DECORATOR;
	bar.barType = 1;
	bar.quickslotCount = 5;
	bar.quickslotColumns = 1;
	bar.quickslotRows = bar.quickslotCount / bar.quickslotColumns;
	bar.visible = true;
	bar.locked = false;
	bar.onMouseOver = SHOW_EXTENSIONS;
	bar.opacity = 1.0;
	bar.quickslotSpacing = 1;
	bar.quickslotSize = 36;
	bar.useBackgroundColor = false;
	bar.backgroundColorRed = 0;
	bar.backgroundColorGreen = 0;
	bar.backgroundColorBlue = 0;
	bar.useFading = false;
	bar.fadeOpacity = 1;
	bar.events = { };
	bar.events.triggered = { };
	bar.events.triggered.healthTrigger = 0.25;
	bar.events.triggered.powerTrigger = 0.25;
	bar.events.triggered.triggerOnClassBuffActive = true;
	bar.events.inventory = { };
	bar.events.inventory.quantity = 50;
	bar.decorators = {};
	bar.decorators.window = {titleColor=false, titleColorA=1, titleColorR=1, titleColorG=1, titleColorB=1,backColor=false, backColorA=1, backColorR=1, backColorG=1, backColorB=1};
	bar.decorators.tab = {titleColor=false, titleColorA=1, titleColorR=1, titleColorG=1, titleColorB=1,backColor=false, backColorA=1, backColorR=1, backColorG=1, backColorB=1};

	return bar;
end

function SettingsService:GetBarSettings( barid )
	self.Log:Debug("GetBarSettings");

	if (barid == nil or self.settings.bars == nil or self.settings.bars[barid] == nil) then
		self.Log:Debug("Attempting to get Bar that is nil or unregistered.");
		return nil;
	end

	local barSettings = self.settings.bars[barid];
	if (barSettings.decorator == nil) then
		barSettings.decorator = TAB_BAR_DECORATOR;
		barSettings.decorators = {};
		barSettings.decorators.window = {titleColor=false, titleColorA=1, titleColorR=0, titleColorG=0, titleColorB=0,backColor=false, backColorA=1, backColorR=0, backColorG=0, backColorB=0};
		barSettings.decorators.tab = {titleColor=true, titleColorA=0, titleColorR=0, titleColorG=0, titleColorB=0,backColor=false, backColorA=1, backColorR=0, backColorG=0, backColorB=0};
	end

	if (barSettings.events == nil) then
		barSettings.events = {};
	end
	if (barSettings.events.triggered == nil) then
		barSettings.events.triggered = {};
	end

	self:MigrateTriggerParam(barSettings.events, barSettings.events.triggered, "displayInCombat");
	self:MigrateTriggerParam(barSettings.events, barSettings.events.triggered, "displayNotInCombat");
	self:MigrateTriggerParam(barSettings.events, barSettings.events.triggered, "displayWhileMounted");
	self:MigrateTriggerParam(barSettings.events, barSettings.events.triggered, "displayWhileNotMounted");
	self:MigrateTriggerParam(barSettings.events, barSettings.events.triggered, "displayWhileCombatMounted");
	self:MigrateTriggerParam(barSettings.events, barSettings.events.triggered, "displayWhileNotCombatMounted");
	self:MigrateTriggerParam(barSettings.events, barSettings.events.triggered, "isControl");
	self:MigrateTriggerParam(barSettings.events, barSettings.events.triggered, "isAlt");
	self:MigrateTriggerParam(barSettings.events, barSettings.events.triggered, "isShift");
	self:MigrateTriggerParam(barSettings.events, barSettings.events.triggered, "categories");
	self:MigrateTriggerParam(barSettings.events, barSettings.events.triggered, "displayOnHealth");
	self:MigrateTriggerParam(barSettings.events, barSettings.events.triggered, "healthTrigger");
	self:MigrateTriggerParam(barSettings.events, barSettings.events.triggered, "displayOnPower");
	self:MigrateTriggerParam(barSettings.events, barSettings.events.triggered, "powerTrigger");
	self:MigrateTriggerParam(barSettings.events, barSettings.events.triggered, "triggerOnClassBuffActive");
	self:MigrateTriggerParam(barSettings.events, barSettings.events.triggered, "triggerBuffType");

	return barSettings;
end

function SettingsService:MigrateTriggerParam(path, newpath, parameter)
	self.Log:Debug("MigrateTriggerParam");

	if (path[parameter] ~= nil) then
		if (newpath == nil) then
			newpath = {};
		end
		if (newpath[parameter] == nil) then
			newpath[parameter] = {};
		end
		newpath[parameter] = path[parameter];
		path[parameter] = nil;
	end
end

function SettingsService:SetBarSettings( updatedSettings )
	self.Log:Debug("SetBarSettings " .. updatedSettings.id);

	self.settings.bars[ updatedSettings.id ] = updatedSettings;
	self:SaveSettings();

	local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
	if (barService ~= nil) then
		local bar = barService:GetBar(updatedSettings.id);
		if (bar ~= nil) then
			bar:Refresh();
		end
	end
end

function SettingsService:ClearBarSettings( barId )
	self.Log:Debug("ClearBarSettings");

	self.settings.bars[ barId ] = nil;
	self:SaveSettings();
end

function SettingsService:UpdateBarSettings(barid, updateCallback, completeCallback)
	self.Log:Debug("UpdateBarSettings");

	local barSettings = self:GetBarSettings( barid );

	local updatedSettings = updateCallback(barSettings);

	self:SetBarSettings( updatedSettings );

	if (completeCallback ~= nil) then
		completeCallback(updatedSettings);
	end
end

function SettingsService:IncrementNextId()
	self.Log:Debug("IncrementNextId");

	self.settings.nextBarId = self.settings.nextBarId + 1;
	return self.settings.nextBarId;
end

function SettingsService:LoadHelper()
end

function SettingsService:SetWrapperSettings( theWrapperSettings )
	self.Log:Debug("SetWrapperSettings");

	self.settings.wrapperSettings = theWrapperSettings;
	self:SaveSettings();
end

function SettingsService:GetProfiles()
	self.Log:Debug("GetProfiles");

	return self.profiles;
end

function SettingsService:GetProfileBars( profile )
	self.Log:Debug("GetProfileBars");

	return self.profiles[ profile ].bars;
end

function SettingsService:ResetAllBars()
	self.Log:Debug("ResetAllBars");

	local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);

	self:SaveSettings();
	if ( self.settings.bars == nil ) then
		self.settings.bars = { };
	end
	barService:Construct( self.settings.bars, true );

	barService:RefreshBars();
	SERVICE_CONTAINER:GetService(MysticBars.Services.InventoryService):NotifyClients();
end


function SettingsService:CopyProfile( profileToCopy, copyType, barid, myBar )
	self.Log:Debug("CopyProfile");

	local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
	local playerService = SERVICE_CONTAINER:GetService(MysticBars.Services.PlayerService);

	if ( barid == nil ) then
		return;
	end

	self.profiles[ playerService.player:GetName() ] = self.settings;
	-- for key, value in opairs (barService:GetBars()) do
	-- 	barService:Remove( key, false );
	-- end
	self:CopyBars(profileToCopy, copyType, barid, myBar);

	self.settings = self.profiles[ playerService.player:GetName() ];
	self:ResetAllBars();
end

function SettingsService:CopyBars(profileToCopy, copyType, barid, myBar)
	self.Log:Debug("CopyBars");
	
	local playerService = SERVICE_CONTAINER:GetService(MysticBars.Services.PlayerService);

	local realProfile = nil;
	local copyProfile = nil;
	if ( myBar == true ) then
		realProfile = self.profiles[ playerService.player:GetName() ];
		copyProfile = self.profiles[ profileToCopy ];
	else
		realProfile = self.profiles[ profileToCopy ]; 
		copyProfile = self.profiles[ playerService.player:GetName() ];
	end

	self:CreatePath( copyProfile );

	MysticBars.Utils.Deepcopy( realProfile.bars[barid], copyProfile.bars[ copyProfile.nextBarId ] );

	copyProfile.bars[ copyProfile.nextBarId ].id = copyProfile.nextBarId;

	if ( copyType == self.PARTIAL ) then
		copyProfile.bars[ copyProfile.nextBarId ].quickslots = nil;
	end

	local newQuickslotBar = copyProfile.nextBarId;
	copyProfile.nextBarId = copyProfile.nextBarId + 1;

	if ( realProfile.bars[barid].barType == QUICKSLOTBAR ) then
		for key, value in opairs ( realProfile.bars ) do
			if ( value.barType == EXTENSIONBAR and value.connectionBarID == barid ) then
				self:CreatePath( copyProfile );
				MysticBars.Utils.Deepcopy( realProfile.bars[key], copyProfile.bars[ copyProfile.nextBarId ] );
				copyProfile.bars[ copyProfile.nextBarId ].id = copyProfile.nextBarId;

				copyProfile.bars[ copyProfile.nextBarId ].connectionBarID = newQuickslotBar;
				copyProfile.nextBarId = copyProfile.nextBarId + 1;	
			end
		end
	end
end

function SettingsService:CreatePath( copyProfile )
	self.Log:Debug("CreatePath");

	if (  copyProfile == nil ) then
		 copyProfile = { };
	end
	if (  copyProfile.bars == nil ) then
		 copyProfile.bars = { };
	end
	if ( copyProfile.bars[ copyProfile.nextBarId ] == nil ) then
		copyProfile.bars[ copyProfile.nextBarId ] = { };
	end
end