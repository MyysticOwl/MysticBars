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

	local language = Turbine.Engine.GetLanguage();
	local locale = (language == Turbine.Language.English and "en" or (language == Turbine.Language.French and "fr" or (language == Turbine.Language.Russian and "ru" or "de" )));
	if ( locale == "de" or locale == "fr" ) then
		self.settings = { };
		DeepcopyLoadConvertInts( playerSettings, self.settings );
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
		self.settings.nextBarId = 1;
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
			DeepcopySaveConvertInts( self.settings, temp );
			self.profiles[ playerService.player:GetName() ] = temp;
		else
			DeepcopySaveConvertInts( profile, temp );
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
		DeepcopyLoadConvertInts( playerBuffs, self.buffs );
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
		DeepcopySaveConvertInts( self.buffProfiles, temp );
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
				Deepcopy( self.settings.bars[key], self.tempBars[key] );
				i = i + 1;
			end
		end
		return self.tempBars;
	end
end

function SettingsService:GetBarSettings( barid )
	self.Log:Debug("GetBarSettings");

	local bar = self.settings.bars[barid]
	if ( bar == nil ) then
		bar = { };
	end

	if ( bar.quickslots == nil ) then
		bar.quickslots = { };
	end

	if ( bar.x == nil )then
		bar.x = 103;
	end

	if ( bar.y == nil )then	
		bar.y = 161;
	end

	if ( bar.barType == nil )then	
		bar.barType = 1;
	end

	if ( bar.quickslotCount == nil )then	
		bar.quickslotCount = 5;
	end

	if ( bar.quickslotColumns == nil )then
		bar.quickslotColumns = 1;
	end

	if ( bar.quickslotRows == nil ) then
		bar.quickslotRows = bar.quickslotCount / bar.quickslotColumns;
	end

	if ( bar.visible == nil )then
		bar.visible = true;
	end

	if ( bar.locked == nil )then
		bar.locked = false;
	end

	if ( bar.onMouseOver == nil ) then
		bar.onMouseOver = SHOW_EXTENSIONS;
	end

	if ( bar.opacity == nil )then
		bar.opacity = 1.0;
	end

	if ( bar.quickslotSpacing == nil )then
		bar.quickslotSpacing = 1;
	end

	if ( bar.quickslotSize == nil )then
		bar.quickslotSize = 36;
	end

	if ( bar.useBackgroundColor == nil )then
		bar.useBackgroundColor = false;
	end	
	if ( bar.backgroundColorRed == nil )then
		bar.backgroundColorRed = 0;
	end
	if ( bar.backgroundColorGreen == nil )then
		bar.backgroundColorGreen = 0;
	end
	if ( bar.backgroundColorBlue == nil )then
		bar.backgroundColorBlue = 0;
	end
	if ( bar.useFading == nil )then
		bar.useFading = false;
	end	
	if ( bar.fadeOpacity == nil )then
		bar.fadeOpacity = 1;
	end
	if ( bar.events == nil ) then
		bar.events = { };
	end
	if ( bar.events.triggered == nil ) then
		bar.events.triggered = { };
	end
	if ( bar.events.triggered.healthTrigger == nil )then
		bar.events.triggered.healthTrigger = 0.25;
	end
	if ( bar.events.triggered.powerTrigger == nil )then
		bar.events.triggered.powerTrigger = 0.25;
	end
	if ( bar.events.triggered.triggerOnClassBuffActive == nil ) then
		bar.events.triggered.triggerOnClassBuffActive = true;
	end
	if ( bar.events.inventory == nil )then
		bar.events.inventory = { };
	end
	if ( bar.events.inventory.quantity == nil )then
		bar.events.inventory.quantity = 50;
	end

	self:MigrateTriggerParam(bar.events, bar.events.triggered, "displayInCombat");
	self:MigrateTriggerParam(bar.events, bar.events.triggered, "displayNotInCombat");
	self:MigrateTriggerParam(bar.events, bar.events.triggered, "displayWhileMounted");
	self:MigrateTriggerParam(bar.events, bar.events.triggered, "displayWhileNotMounted");
	self:MigrateTriggerParam(bar.events, bar.events.triggered, "displayWhileCombatMounted");
	self:MigrateTriggerParam(bar.events, bar.events.triggered, "displayWhileNotCombatMounted");
	self:MigrateTriggerParam(bar.events, bar.events.triggered, "isControl");
	self:MigrateTriggerParam(bar.events, bar.events.triggered, "isAlt");
	self:MigrateTriggerParam(bar.events, bar.events.triggered, "isShift");
	self:MigrateTriggerParam(bar.events, bar.events.triggered, "categories");
	self:MigrateTriggerParam(bar.events, bar.events.triggered, "displayOnHealth");
	self:MigrateTriggerParam(bar.events, bar.events.triggered, "healthTrigger");
	self:MigrateTriggerParam(bar.events, bar.events.triggered, "displayOnPower");
	self:MigrateTriggerParam(bar.events, bar.events.triggered, "powerTrigger");
	self:MigrateTriggerParam(bar.events, bar.events.triggered, "triggerOnClassBuffActive");
	self:MigrateTriggerParam(bar.events, bar.events.triggered, "triggerBuffType");

	return bar
end

function SettingsService:MigrateTriggerParam(path, newpath, parameter)
	self.Log:Debug("MigrateTriggerParam");

	if (path[parameter] ~= nil) then
		if (newpath[parameter] == nil) then
			newpath[parameter] = {};
		end
		newpath[parameter] = path[parameter];
		path[parameter] = nil;
	end
end

function SettingsService:SetBarSettings(barid, bar, doNotRefresh, force)
	self.Log:Debug("SetBarSettings");

	local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);

	if ( barid ~= nil and barService  ~= nil and (barService:Alive( barid ) or force)) then
		self.settings.bars[barid] = bar;
		
		self:SaveSettings();
		if ( doNotRefresh == nil and barService ~= nil ) then
			barService:RefreshBars();
		end
	end
end

function SettingsService:UpdateBarSettings(barid, updateCallback, completeCallback, force, doNotRefresh)
	self.Log:Debug("UpdateBarSettings");

	local barSettings = self:GetBarSettings( barid );

	if (self.working == false) then
		self.working = true;

		local updatedSettings = updateCallback(barSettings);

		self:SetBarSettings( barid, updatedSettings, doNotRefresh, force );
		self.working = false;

		if (completeCallback ~= nil) then
			completeCallback(updatedSettings);
		end
	else
		Turbine.Shell.WriteLine("Too many requests too fast");
	end
end

function SettingsService:SaveQuickslots( bar, qSlots, save )
	self.Log:Debug("SaveQuickslots");

	if ( self.loading ) then
		return;
	end

	bar.quickslots = nil;
	bar.quickslots = { };

	for key, value in pairs (qSlots) do
		local shortcut = value:GetShortcut();
		if( shortcut:GetType() ~= 0 and shortcut:GetData() ~= "" ) then
			if ( bar.quickslots[key] == nil ) then
				bar.quickslots[key] = { };
			end
			bar.quickslots[key].Type = shortcut:GetType();
			bar.quickslots[key].Data = shortcut:GetData();
		end
	end
	if ( save == nil or save == false ) then
		self:SaveSettings();
	end
end

function SettingsService:LoadQuickslots( bar, qSlots )
	self.Log:Debug("LoadQuickslots");

	self.loading = true;
	for key, value in pairs (bar.quickslots) do
		if( value.Type ~= 0 and value.Data ~= "" ) then
			local shortcut = Turbine.UI.Lotro.Shortcut( value.Type, value.Data );
			if ( pcall( SetShortcut, shortcut, qSlots, key ) == false ) then
				value = nil;
				dirty = true;
			end
		end
	end
	self.loading = false;

	if (dirty == true) then
		self:SaveQuickslots( bar, qSlots )
	end
end

function SetShortcut( shortcut, qSlots, key )
	qSlots[key]:SetShortcut( shortcut );
end

function SettingsService:IncrementNextId()
	self.Log:Debug("IncrementNextId");

	self.settings.nextBarId = self.settings.nextBarId + 1;
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
	barService:LoadQuickslots();
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
	for key, value in opairs (barService:GetBars()) do
		barService:Remove( key, false );
	end
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

	Deepcopy( realProfile.bars[barid], copyProfile.bars[ copyProfile.nextBarId ] );
	
	if ( copyType == self.PARTIAL ) then
		copyProfile.bars[ copyProfile.nextBarId ].quickslots = nil;
	end

	local newQuickslotBar = copyProfile.nextBarId;
	copyProfile.nextBarId = copyProfile.nextBarId + 1;

	if ( realProfile.bars[barid].barType == QUICKSLOTBAR ) then
		for key, value in opairs ( realProfile.bars ) do
			if ( value.barType == EXTENSIONBAR and value.connectionBarID == barid ) then
				self:CreatePath( copyProfile );
				Deepcopy( realProfile.bars[key], copyProfile.bars[ copyProfile.nextBarId ] );
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