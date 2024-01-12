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

function TemplateService:CreateBar( name, rows, columns, x, y, barType, createdCallback )
	self.Log:Debug("CreateBar");

	local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

	local barSettings = settingsService:FindBar(name);
	if ( barSettings == nil ) then

		barSettings = settingsService:NewBar();
		barSettings.barType = barType;
		barSettings.barName = name;
		barSettings.quickslotRows = rows;
		barSettings.quickslotColumns = columns;
		barSettings.quickslotCount = rows * columns;
		barSettings.x = x;
		barSettings.y = y;

		createdCallback(barSettings);

		if (barType == QUICKSLOTBAR) then
			barService:AddQuickslotBar( barSettings );
		elseif (barType == TABBED_INV_BAR) then
			barService:AddTabbedInventoryBar( barSettings );
		end
	end

	local menuService = SERVICE_CONTAINER:GetService(MysticBars.Services.MenuService)
	if (menuService ~= nil) then
		menuService:GetMenu():Refresh();
	end

	return barSettings;
end

-- Set it to trigger on health                Bar ID - When to trigger
function TemplateService:SetTrigger( statType, percent, barSettings )
	self.Log:Debug("SetTrigger");

	if ( barSettings.events == nil ) then
		barSettings.events = { };
	end
	if ( barSettings.events.triggered == nil ) then
		barSettings.events.triggered = { };
	end
	if ( barSettings.events.triggered.categories == nil ) then
		barSettings.events.triggered.categories = { };
	end

	barSettings.visible = false;

	if ( statType == TemplateService.HEALTH ) then
		barSettings.events.triggered.displayOnHealth = true;
		barSettings.events.triggered.healthTrigger = (percent / 100);
	elseif ( statType == TemplateService.POWER ) then
		barSettings.events.triggered.displayOnPower = true;
		barSettings.events.triggered.powerTrigger = (percent / 100);

	elseif ( statType == Turbine.Gameplay.EffectCategory.Disease ) then
		barSettings.events.triggered.categories[statType] = true;
	elseif ( statType == Turbine.Gameplay.EffectCategory.Fear ) then
		barSettings.events.triggered.categories[statType] = true;
	elseif ( statType == Turbine.Gameplay.EffectCategory.Poison ) then
		barSettings.events.triggered.categories[statType] = true;
	elseif ( statType == Turbine.Gameplay.EffectCategory.Wound ) then
		barSettings.events.triggered.categories[statType] = true;

	elseif ( statType == TemplateService.CTRL ) then
		barSettings.events.triggered.isControl = true;
	elseif ( statType == TemplateService.ALT ) then
		barSettings.events.triggered.isAlt = true;
	elseif ( statType == TemplateService.SHIFT ) then
		barSettings.events.triggered.isShift = true;
	end
end

-- Set it to trigger on Buff                 
function TemplateService:SetBuffTriggerOptions( whenActive, Anding, barSettings )
	self.Log:Debug("SetBuffTriggerOptions");

	if ( barSettings.events == nil ) then
		barSettings.events = { };
	end
	if ( barSettings.events.triggered == nil ) then
		barSettings.events.triggered = { };
	end
	barSettings.visible = false;
	barSettings.events.triggered.triggerOnClassBuffActive = whenActive;
	if ( Anding ) then
		barSettings.events.triggered.triggerBuffType = "and";
	else
		barSettings.events.triggered.triggerBuffType = "or";
	end
end

-- Set it to trigger on Buff                Bar ID - When to trigger
function TemplateService:SetBuffTrigger( buff, barSettings )
	self.Log:Debug("SetBuffTrigger");

	if ( barSettings.events == nil ) then
		barSettings.events = { };
	end
	if ( barSettings.events.effects == nil ) then
		barSettings.events.effects = { };
	end
	if ( barSettings.events.effects[buff] == nil ) then
		barSettings.events.effects[buff] = true;
	end
end

-- Set it to trigger on name                Bar ID - When to trigger
function TemplateService:SetClassRangeTrigger( name, theMin, theMax, barSettings )
	self.Log:Debug("SetClassRangeTrigger");

	if ( barSettings.events == nil ) then
		barSettings.events = { };
	end
	if ( barSettings.events.classRange == nil ) then
		barSettings.events.classRange = { };
	end
	if ( barSettings.events.classRange[name] == nil ) then
		barSettings.events.classRange[name] = { };
		barSettings.events.classRange[name].active = true;
		barSettings.events.classRange[name].minValue = theMin;
		barSettings.events.classRange[name].maxValue = theMax;
	end
end

--                                       Bar ID  a  r  g  b
function TemplateService:SetBGColor( a, r, g, b, barSettings )
	self.Log:Debug("SetBGColor");

	barSettings.useBackgroundColor = true;
	barSettings.opacity = a;
	barSettings.backgroundColorRed = r;
	barSettings.backgroundColorGreen = g;
	barSettings.backgroundColorBlue = b;
end

--                               Bar ID - Location - Hex for Shortcut
function TemplateService:AddShortcut( location, sData, sType, level, barSettings )
	self.Log:Debug("AddShortcut");

	if ( level == nil or self.level >= level ) then
		if ( barSettings.quickslots == nil ) then
			barSettings.quickslots = { };
		end
		if ( barSettings.quickslots[location] == nil ) then
			barSettings.quickslots[location] = { };
		end
		if ( barSettings.quickslots[location].Data == nil ) then
			barSettings.quickslots[location].Data = sData;
			barSettings.quickslots[location].Type = sType;
		end
	end
	return barSettings;
end

--                               Bar ID - Location - Hex for Shortcut
function TemplateService:SetInventoryFilter( filter, barSettings )
	self.Log:Debug("SetInventoryFilter");

	if ( barSettings.events == nil ) then
		barSettings.events = { };
	end
	if ( barSettings.events.inventory == nil ) then
		barSettings.events.inventory = { };
	end
	if ( barSettings.events.inventory.nameFilters == nil ) then
		barSettings.events.inventory.nameFilters = { };
	end
	barSettings.events.inventory.nameFilters[ filter ] = true;
end