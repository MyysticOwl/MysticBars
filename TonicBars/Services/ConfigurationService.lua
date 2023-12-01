-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

ConfigurationService = class( MyysticBars.Utils.Service );
ConfigurationService.HEALTH = 1;
ConfigurationService.POWER = 11;

ConfigurationService.CTRL = 3;
ConfigurationService.ALT = 4;
ConfigurationService.SHIFT = 5;

function ConfigurationService:Constructor()
	local playerService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.PlayerService);
	local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);

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
	local barService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.BarService);
	local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);

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
			self.barSettings = settingsService:GetBarSettings( self.barid );
			if ( theSettings.autoCreatedBars == nil ) then
				theSettings.autoCreatedBars = { };
			end
			if ( theSettings.autoCreatedBars[self.barid] == nil ) then
				theSettings.autoCreatedBars[self.barid] = { };
			end
			theSettings.autoCreatedBars[self.barid].barName = name;

			self.barSettings.barName = name;
			if ( rows ~= nil ) then
				self.barSettings.quickslotRows = rows;
			end
			if ( columns ~= nil ) then
				self.barSettings.quickslotColumns = columns;
			end
			if ( rows ~= nil and columns ~= nil ) then
				self.barSettings.quickslotCount = rows * columns;
			end
			self.barSettings.x = x;
			self.barSettings.y = y;
		else
			self.barid = foundbar;
			self.barSettings = settingsService:GetBarSettings( self.barid );
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
	local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);

	if ( barid ~= nil ) then
		self.barid = barid;
		self.barSettings = settingsService:GetBarSettings( barid );
		return self.barSettings;
	end
end

-- Set it to trigger on health                Bar ID - When to trigger
function ConfigurationService:SetTrigger( statType, percent )
	if ( self.barid ~= nil ) then
		if ( self.barSettings.events == nil ) then
			self.barSettings.events = { };
		end
		if ( self.barSettings.events.categories == nil ) then
			self.barSettings.events.categories = { };
		end

		self.barSettings.visible = false;

		if ( statType == ConfigurationService.HEALTH ) then
			self.barSettings.events.displayOnHealth = true;
			self.barSettings.events.healthTrigger = (percent / 100);
		elseif ( statType == ConfigurationService.POWER ) then
			self.barSettings.events.displayOnPower = true;
			self.barSettings.events.powerTrigger = (percent / 100);

		elseif ( statType == Turbine.Gameplay.EffectCategory.Disease ) then
			self.barSettings.events.categories[statType] = true;
		elseif ( statType == Turbine.Gameplay.EffectCategory.Fear ) then
			self.barSettings.events.categories[statType] = true;
		elseif ( statType == Turbine.Gameplay.EffectCategory.Poison ) then
			self.barSettings.events.categories[statType] = true;
		elseif ( statType == Turbine.Gameplay.EffectCategory.Wound ) then
			self.barSettings.events.categories[statType] = true;

		elseif ( statType == ConfigurationService.CTRL ) then
			self.barSettings.events.isControl = true;
		elseif ( statType == ConfigurationService.ALT ) then
			self.barSettings.events.isAlt = true;
		elseif ( statType == ConfigurationService.SHIFT ) then
			self.barSettings.events.isShift = true;
		end
	end
end

-- Set it to trigger on Buff                 
function ConfigurationService:SetBuffTriggerOptions( whenActive, Anding )
	if ( self.barid ~= nil ) then
		if ( self.barSettings.events == nil ) then
			self.barSettings.events = { };
		end
		self.barSettings.visible = false;
		self.barSettings.events.triggerOnClassBuffActive = whenActive;
		if ( Anding ) then
			self.barSettings.events.triggerBuffType = "and";
		else
			self.barSettings.events.triggerBuffType = "or";
		end
	end
end

-- Set it to trigger on Buff                Bar ID - When to trigger
function ConfigurationService:SetBuffTrigger( buff )
	local eventService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.EventService);
	local localizationService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.LocalizationService);
	local playerService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.PlayerService);
	playerClass = playerService.playerClass;

	if ( self.barid ~= nil ) then
		if ( self.barSettings.events == nil ) then
			self.barSettings.events = { };
		end
		if ( self.barSettings.events.effects == nil ) then
			self.barSettings.events.effects = { };
		end
		if ( localizationService:GetLanguage() ~= "en" ) then
			local events = eventService:GetRegisteredEvents();
			for key, value in pairs (events.classes[ playerClass ].effects) do
				if ( value.englishSkillName == buff and self.barSettings.events.effects[buff] == nil) then
					self.barSettings.events.effects[key] = true;	
				end
			end
		else
			if ( self.barSettings.events.effects[buff] == nil ) then
				self.barSettings.events.effects[buff] = true;
			end
		end
	end
end

-- Set it to trigger on name                Bar ID - When to trigger
function ConfigurationService:SetClassRangeTrigger( name, theMin, theMax )
	if ( self.barid ~= nil ) then
		if ( self.barSettings.events == nil ) then
			self.barSettings.events = { };
		end
		if ( self.barSettings.events.classRange == nil ) then
			self.barSettings.events.classRange = { };
		end
		if ( self.barSettings.events.classRange[name] == nil ) then
			self.barSettings.events.classRange[name] = { };
			self.barSettings.events.classRange[name].minValue = theMin;
			self.barSettings.events.classRange[name].maxValue = theMax;
		end
	end
end

--                                       Bar ID  a  r  g  b
function ConfigurationService:SetBGColor( a, r, g, b )
	if ( self.barid ~= nil ) then
		self.barSettings.useBackgroundColor = true;
		self.barSettings.opacity = a;
		self.barSettings.backgroundColorRed = r;
		self.barSettings.backgroundColorGreen = g;
		self.barSettings.backgroundColorBlue = b;
	end
end

--                               Bar ID - Location - Hex for Shortcut
function ConfigurationService:AddShortcut( location, sData, sType, level )
	if ( self.barid ~= nil and (level == nil or self.level >= level) ) then
		if ( self.barSettings.quickslots == nil ) then
			self.barSettings.quickslots = { };
		end
		if ( self.barSettings.quickslots[location] == nil ) then
			self.barSettings.quickslots[location] = { };
		end
		if ( self.barSettings.quickslots[location].Data == nil ) then
			self.barSettings.quickslots[location].Data = sData;
			self.barSettings.quickslots[location].Type = sType;
		end
	end
end

--                               Bar ID - Location - Hex for Shortcut
function ConfigurationService:SetInventoryFilter( filter )
	if ( self.barid ~= nil ) then
		if ( self.barSettings.events == nil ) then
			self.barSettings.events = { };
		end
		if ( self.barSettings.events.inventory == nil ) then
			self.barSettings.events.inventory = { };
		end
		if ( self.barSettings.events.inventory.nameFilters == nil ) then
			self.barSettings.events.inventory.nameFilters = { };
		end
		self.barSettings.events.inventory.nameFilters[ filter ] = true;
	end
end

function ConfigurationService:Save()
	local barService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.BarService);
	local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);

	if ( self.barid ~= nil and barService  ~= nil and barService:Alive( self.barid )) then
		settingsService:SetBarSettings( self.barid, self.barSettings );
	end
end