-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

ConfigurationService = class( MyysticUI.Utils.Service );
ConfigurationService.HEALTH = 1;
ConfigurationService.POWER = 11;

ConfigurationService.CTRL = 3;
ConfigurationService.ALT = 4;
ConfigurationService.SHIFT = 5;

function ConfigurationService:Constructor()
	local playerService = SERVICE_CONTAINER:GetService(MyysticUI.Services.PlayerService);
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);

	self.level = playerService.player:GetLevel();
	self.registeredBars = 1;
end

function ConfigurationService:RegisterBarCreator( description, barname, callback, disable )
	if ( self.RegisteredEasyBars == nil ) then
		self.RegisteredEasyBars = { };
	end
	if ( self.RegisteredEasyBars[description] == nil ) then
		self.RegisteredEasyBars[description] = { };
	end
	if ( self.RegisteredEasyBars[description].sortindex == nil ) then
		self.RegisteredEasyBars[description].barname = barname;
		self.RegisteredEasyBars[description].callback = callback;
		self.RegisteredEasyBars[description].sortindex = self.registeredBars;
		self.RegisteredEasyBars[description].disableAutoCreate = disable;
		self.registeredBars = self.registeredBars + 1;
	end
end

function ConfigurationService:ConstructBars()
	for key, value in pairs (self.RegisteredEasyBars) do
		if ( value.disableAutoCreate == nil ) then
			value.callback();
		end
	end
end

function ConfigurationService:GetEasyBars()
	return self.RegisteredEasyBars;
end

function ConfigurationService:SetPlayerLevel( newLevel )
	self.level = newLevel;
end

-- Create Quickslot Bar                           Name -      Rows - Columns - X coord - Y coord
function ConfigurationService:CreateBar( override, name, level, rows, columns, x, y, barType )
	local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);

	if ( barType == nil ) then
		barType = QUICKSLOTBAR;
	end
	if ( level == nil or self.level >= level or override ~= nil ) then
		local foundbar = nil;
		for key, value in pairs (settingsService:GetBars()) do
			if ( value.barName == name ) then
				foundbar = key;
			end
		end
		local theSettings = settingsService:GetSettings();
		local autoBarID, autoBarSettings;
		if ( theSettings.autoCreatedBars ~= nil ) then
			for key, value in pairs (theSettings.autoCreatedBars) do
				if ( value.barName == name ) then
					autoBarID = key;
					autoBarSettings = value;
				end
			end
		end
		if ( override == true and foundbar ~= nil ) then
			if ( theSettings.autoCreatedBars ~= nil and theSettings.autoCreatedBars[ foundbar ] ~= nil ) then
				barService:Remove( foundbar );
				foundbar = nil;
			end
		end
		if ( override ~= nil or ( autoBarID == nil and foundbar == nil ) ) then
			self.barid = barService:Add( barType, autoBarID );
			local localBarSettings = settingsService:GetBarSettings( self.barid );
			if ( theSettings.autoCreatedBars == nil ) then
				theSettings.autoCreatedBars = { };
			end
			if ( theSettings.autoCreatedBars[self.barid] == nil ) then
				theSettings.autoCreatedBars[self.barid] = { };
			end
			theSettings.autoCreatedBars[self.barid].barName = name;

			localBarSettings.barName = name;
			if ( rows ~= nil ) then
				localBarSettings.quickslotRows = rows;
			end
			if ( columns ~= nil ) then
				localBarSettings.quickslotColumns = columns;
			end
			if ( rows ~= nil and columns ~= nil ) then
				localBarSettings.quickslotCount = rows * columns;
			end
			localBarSettings.x = x;
			localBarSettings.y = y;
		else
			self.barid = foundbar;
			-- localBarSettings = settingsService:GetBarSettings( self.barid );
		end
		if ( menu ~= nil ) then
			theSettings = settingsService:GetSettings();
			local mode = theSettings.barMode;
		
			menu:Refresh();
		
			theSettings = settingsService:GetSettings();
			theSettings.barMode = mode;
		end
	else
		self.barid = nil;
	end
end

function ConfigurationService:SetBar( barid )
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);

	if ( barid ~= nil ) then
		self.barid = barid;
		return settingsService:GetBarSettings( barid );
	end
end

-- Set it to trigger on health                Bar ID - When to trigger
function ConfigurationService:SetTrigger( statType, percent )
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
	local localBarSettings = settingsService:GetBarSettings( self.barid );

	if ( self.barid ~= nil ) then
		if ( localBarSettings.events == nil ) then
			localBarSettings.events = { };
		end
		if ( localBarSettings.events.categories == nil ) then
			localBarSettings.events.categories = { };
		end

		localBarSettings.visible = false;

		if ( statType == ConfigurationService.HEALTH ) then
			localBarSettings.events.displayOnHealth = true;
			localBarSettings.events.healthTrigger = (percent / 100);
		elseif ( statType == ConfigurationService.POWER ) then
			localBarSettings.events.displayOnPower = true;
			localBarSettings.events.powerTrigger = (percent / 100);

		elseif ( statType == Turbine.Gameplay.EffectCategory.Disease ) then
			localBarSettings.events.categories[statType] = true;
		elseif ( statType == Turbine.Gameplay.EffectCategory.Fear ) then
			localBarSettings.events.categories[statType] = true;
		elseif ( statType == Turbine.Gameplay.EffectCategory.Poison ) then
			localBarSettings.events.categories[statType] = true;
		elseif ( statType == Turbine.Gameplay.EffectCategory.Wound ) then
			localBarSettings.events.categories[statType] = true;

		elseif ( statType == ConfigurationService.CTRL ) then
			localBarSettings.events.isControl = true;
		elseif ( statType == ConfigurationService.ALT ) then
			localBarSettings.events.isAlt = true;
		elseif ( statType == ConfigurationService.SHIFT ) then
			localBarSettings.events.isShift = true;
		end
	end
end

-- Set it to trigger on Buff                 
function ConfigurationService:SetBuffTriggerOptions( whenActive, Anding )
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
	local localBarSettings = settingsService:GetBarSettings( self.barid );

	if ( self.barid ~= nil ) then
		if ( localBarSettings.events == nil ) then
			localBarSettings.events = { };
		end
		localBarSettings.visible = false;
		localBarSettings.events.triggerOnClassBuffActive = whenActive;
		if ( Anding ) then
			localBarSettings.events.triggerBuffType = "and";
		else
			localBarSettings.events.triggerBuffType = "or";
		end
	end
end

-- Set it to trigger on Buff                Bar ID - When to trigger
function ConfigurationService:SetBuffTrigger( buff )
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
	local localBarSettings = settingsService:GetBarSettings( self.barid );

	if ( self.barid ~= nil ) then
		if ( localBarSettings.events == nil ) then
			localBarSettings.events = { };
		end
		if ( localBarSettings.events.effects == nil ) then
			localBarSettings.events.effects = { };
		end
		if ( localBarSettings.events.effects[buff] == nil ) then
			localBarSettings.events.effects[buff] = true;
		end
	end
end

-- Set it to trigger on name                Bar ID - When to trigger
function ConfigurationService:SetClassRangeTrigger( name, theMin, theMax )
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
	local localBarSettings = settingsService:GetBarSettings( self.barid );

	if ( self.barid ~= nil ) then
		if ( localBarSettings.events == nil ) then
			localBarSettings.events = { };
		end
		if ( localBarSettings.events.classRange == nil ) then
			localBarSettings.events.classRange = { };
		end
		if ( localBarSettings.events.classRange[name] == nil ) then
			localBarSettings.events.classRange[name] = { };
			localBarSettings.events.classRange[name].active = true;
			localBarSettings.events.classRange[name].minValue = theMin;
			localBarSettings.events.classRange[name].maxValue = theMax;
		end
	end
end

--                                       Bar ID  a  r  g  b
function ConfigurationService:SetBGColor( a, r, g, b )
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
	local localBarSettings = settingsService:GetBarSettings( self.barid );
	
	if ( self.barid ~= nil ) then
		localBarSettings.useBackgroundColor = true;
		localBarSettings.opacity = a;
		localBarSettings.backgroundColorRed = r;
		localBarSettings.backgroundColorGreen = g;
		localBarSettings.backgroundColorBlue = b;
	end
end

--                               Bar ID - Location - Hex for Shortcut
function ConfigurationService:AddShortcut( location, sData, sType, level )
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
	local localBarSettings = settingsService:GetBarSettings( self.barid );

	if ( self.barid ~= nil and (level == nil or self.level >= level) ) then
		if ( localBarSettings.quickslots == nil ) then
			localBarSettings.quickslots = { };
		end
		if ( localBarSettings.quickslots[location] == nil ) then
			localBarSettings.quickslots[location] = { };
		end
		if ( localBarSettings.quickslots[location].Data == nil ) then
			localBarSettings.quickslots[location].Data = sData;
			localBarSettings.quickslots[location].Type = sType;
		end
	end
end

--                               Bar ID - Location - Hex for Shortcut
function ConfigurationService:SetInventoryFilter( filter )
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
	local localBarSettings = settingsService:GetBarSettings( self.barid );

	if ( self.barid ~= nil ) then
		if ( localBarSettings.events == nil ) then
			localBarSettings.events = { };
		end
		if ( localBarSettings.events.inventory == nil ) then
			localBarSettings.events.inventory = { };
		end
		if ( localBarSettings.events.inventory.nameFilters == nil ) then
			localBarSettings.events.inventory.nameFilters = { };
		end
		localBarSettings.events.inventory.nameFilters[ filter ] = true;
	end
end