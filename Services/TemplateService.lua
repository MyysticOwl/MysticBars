-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

TemplateService = class( MysticBars.Utils.Service );

TemplateService.Log = MysticBars.Utils.Logging.LogManager.GetLogger( "TemplateService", false );

TemplateService.HEALTH = 1;
TemplateService.POWER = 11;

TemplateService.CTRL = 3;
TemplateService.ALT = 4;
TemplateService.SHIFT = 5;

function TemplateService:Constructor()
	self.Log:Debug("Constructor");

	local playerService = SERVICE_CONTAINER:GetService(MysticBars.Services.PlayerService);
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

	self.level = playerService.player:GetLevel();
	self.registeredBars = 1;
end

function TemplateService:RegisterBarCreator( description, barname, callback, disable )
	self.Log:Debug("RegisterBarCreator");

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

function TemplateService:ConstructBars()
	self.Log:Debug("ConstructBars");

	for key, value in pairs (self.RegisteredEasyBars) do
		if ( value.disableAutoCreate == nil ) then
			value.callback();
		end
	end
end

function TemplateService:GetEasyBars()
	self.Log:Debug("GetEasyBars");

	return self.RegisteredEasyBars;
end

function TemplateService:SetPlayerLevel( newLevel )
	self.Log:Debug("SetPlayerLevel");

	self.level = newLevel;
end

-- Create Quickslot Bar                           Name -      Rows - Columns - X coord - Y coord
function TemplateService:CreateBar( override, name, level, rows, columns, x, y, barType, createdCallback )
	self.Log:Debug("CreateBar");

	local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

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

			if (createdCallback ~= nil) then
				createdCallback(localBarSettings);
				settingsService:SetBarSettings(self.barid, localBarSettings, nil, true);
			end
		else
			self.barid = foundbar;
		end

		local menuService = SERVICE_CONTAINER:GetService(MysticBars.Services.MenuService);
		if (menuService ~= nil) then
			theSettings = settingsService:GetSettings();
			local mode = theSettings.barMode;

			menuService:GetMenu():Refresh();

			theSettings = settingsService:GetSettings();
			theSettings.barMode = mode;
		end
	else
		self.barid = nil;
	end

	return self.barid, settingsService:GetBarSettings( self.barid );
end

function TemplateService:SetBar( barid )
	self.Log:Debug("SetBar");

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

	if ( barid ~= nil ) then
		self.barid = barid;
		return settingsService:GetBarSettings( barid );
	end
end

-- Set it to trigger on health                Bar ID - When to trigger
function TemplateService:SetTrigger( statType, percent, localBarSettings )
	self.Log:Debug("SetTrigger");

	if ( self.barid ~= nil ) then
		if ( localBarSettings.events == nil ) then
			localBarSettings.events = { };
		end
		if ( localBarSettings.events.triggered == nil ) then
			localBarSettings.events.triggered = { };
		end
		if ( localBarSettings.events.triggered.categories == nil ) then
			localBarSettings.events.triggered.categories = { };
		end

		localBarSettings.visible = false;

		if ( statType == TemplateService.HEALTH ) then
			localBarSettings.events.triggered.displayOnHealth = true;
			localBarSettings.events.triggered.healthTrigger = (percent / 100);
		elseif ( statType == TemplateService.POWER ) then
			localBarSettings.events.triggered.displayOnPower = true;
			localBarSettings.events.triggered.powerTrigger = (percent / 100);

		elseif ( statType == Turbine.Gameplay.EffectCategory.Disease ) then
			localBarSettings.events.triggered.categories[statType] = true;
		elseif ( statType == Turbine.Gameplay.EffectCategory.Fear ) then
			localBarSettings.events.triggered.categories[statType] = true;
		elseif ( statType == Turbine.Gameplay.EffectCategory.Poison ) then
			localBarSettings.events.triggered.categories[statType] = true;
		elseif ( statType == Turbine.Gameplay.EffectCategory.Wound ) then
			localBarSettings.events.triggered.categories[statType] = true;

		elseif ( statType == TemplateService.CTRL ) then
			localBarSettings.events.triggered.isControl = true;
		elseif ( statType == TemplateService.ALT ) then
			localBarSettings.events.triggered.isAlt = true;
		elseif ( statType == TemplateService.SHIFT ) then
			localBarSettings.events.triggered.isShift = true;
		end
	end
end

-- Set it to trigger on Buff                 
function TemplateService:SetBuffTriggerOptions( whenActive, Anding, localBarSettings )
	self.Log:Debug("SetBuffTriggerOptions");

	if ( self.barid ~= nil ) then
		if ( localBarSettings.events == nil ) then
			localBarSettings.events = { };
		end
		if ( localBarSettings.events.triggered == nil ) then
			localBarSettings.events.triggered = { };
		end
		localBarSettings.visible = false;
		localBarSettings.events.triggered.triggerOnClassBuffActive = whenActive;
		if ( Anding ) then
			localBarSettings.events.triggered.triggerBuffType = "and";
		else
			localBarSettings.events.triggered.triggerBuffType = "or";
		end
	end
end

-- Set it to trigger on Buff                Bar ID - When to trigger
function TemplateService:SetBuffTrigger( buff, localBarSettings )
	self.Log:Debug("SetBuffTrigger");

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
function TemplateService:SetClassRangeTrigger( name, theMin, theMax, localBarSettings )
	self.Log:Debug("SetClassRangeTrigger");

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
function TemplateService:SetBGColor( a, r, g, b, localBarSettings )
	self.Log:Debug("SetBGColor");

	if ( self.barid ~= nil ) then
		localBarSettings.useBackgroundColor = true;
		localBarSettings.opacity = a;
		localBarSettings.backgroundColorRed = r;
		localBarSettings.backgroundColorGreen = g;
		localBarSettings.backgroundColorBlue = b;
	end
end

--                               Bar ID - Location - Hex for Shortcut
function TemplateService:AddShortcut( location, sData, sType, level, localBarSettings )
	self.Log:Debug("AddShortcut");

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
function TemplateService:SetInventoryFilter( filter, localBarSettings )
	self.Log:Debug("SetInventoryFilter");

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