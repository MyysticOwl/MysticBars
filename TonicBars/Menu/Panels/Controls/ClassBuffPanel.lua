-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "MyysticBars.UI.AutoListBox";
import "MyysticBars.UI.MenuUtils";

ClassBuffPanel = class();

function ClassBuffPanel:Constructor( panel )
	local eventService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.EventService);
	local playerService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.PlayerService);
	local playerClass = playerService.playerClass;

	self.utils = MyysticBars.UI.MenuUtils();

	self.utils:AddCategoryBox(panel, LOCALESTRINGS.QuickslotsMenu["Class Triggers"]);

	self.utils:AddLabelBox( panel, LOCALESTRINGS.ClassTriggerType["Triggered When:"], 120, selectionHeight );
	self.triggerList = MyysticBars.UI.ComboBox();
	self.triggerList:SetSize( 200, 20 );
	self.triggerList:SetParent( panel );
	self.triggerList:AddItem( LOCALESTRINGS.ClassTriggerType["Buffs Active"], 1 );
	self.triggerList:AddItem( LOCALESTRINGS.ClassTriggerType["Buffs Not Active"], 2 );
	panel:AddItem( self.triggerList );

	self.fadeOpacityNum1 = self.utils:AddLabelBox( panel, "", 50, selectionHeight );

	local events = eventService:GetRegisteredEvents();
	self.eventCheckboxes = { };
	local count = 0;
	local box = nil;

	self.utils:AddLabelBox( panel, LOCALESTRINGS.QuickslotsMenu["Buffs"], 120, selectionHeight );
	self.buffList = MyysticBars.UI.CheckedComboBox();
	self.buffList:SetSize( 300, 20 );
	self.buffList:SetParent( panel );
	panel:AddItem( self.buffList );

	local box13 = self.utils:AddAutoListBox( panel, Turbine.UI.Orientation.Vertical, 0, 0, 0, 0 );
	if ( playerClass == Turbine.Gameplay.Class.Burglar ) then
	elseif ( playerClass == Turbine.Gameplay.Class.Champion ) then
		self.eventCheckboxes[CHAMPION_FERVOR] = self.utils:AddCheckBox( box13, LOCALESTRINGS.ClassTriggers["Fervor between:"], selectionWidth + 15, selectionHeight );
		self.eventCheckboxes[CHAMPION_FERVOR].CheckedCallback = function( sender, args )
			local barService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.BarService);
			local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);
			local barSettings = settingsService:GetBarSettings( menu:GetSelection() );

			if ( self.eventCheckboxes[CHAMPION_FERVOR].IsChecked ) then
				if ( barSettings.events == nil ) then
					barSettings.events = { }; 
				end
				if ( barSettings.events.classRange == nil ) then
					barSettings.events.classRange = { };
				end
				barSettings.events.classRange[CHAMPION_FERVOR] = { };
				barSettings.events.classRange[CHAMPION_FERVOR].minValue = 1;
				barSettings.events.classRange[CHAMPION_FERVOR].maxValue = 1;
				self.championSbMin:SetValue( 1 );
				self.championSbMax:SetValue( 5 );
			elseif ( barSettings.events ~= nil and barSettings.events.classRange ~= nil and barSettings.events.classRange[CHAMPION_FERVOR] ~= nil) then
				self.championSbMin:SetValue( 0 );
				self.championSbMax:SetValue( 0 );
				barSettings.events.classRange[CHAMPION_FERVOR].maxValue = nil;
				barSettings.events.classRange[CHAMPION_FERVOR].minValue = nil;
				barSettings.events.classRange[CHAMPION_FERVOR] = nil;
			end
			if ( barService  ~= nil and barService:Alive( menu:GetSelection() ) ) then
				settingsService:SetBarSettings( menu:GetSelection(), barSettings );
			end
		end
		box = self.utils:AddAutoListBox( box13, Turbine.UI.Orientation.Horizontal, 0, 0, 0, 0 );
		boxSet1 = self.utils:AddAutoListBox( box, Turbine.UI.Orientation.Vertical, 0, 0, 0, 0 );
		boxSet2 = self.utils:AddAutoListBox( box, Turbine.UI.Orientation.Vertical, 0, 0, 0, 0 );

		self.championSbMin = self.utils:AddScrollBar( boxSet1, 1, 1, 5, 100, selectionHeight + 15, nil, LOCALESTRINGS.QuickslotsMenu["Min:"] );
		self.utils:CreateScrollBarCallback( self.championSbMin, { "events", "classRange", CHAMPION_FERVOR, "minValue" } );

		self.championSbMax = self.utils:AddScrollBar( boxSet2, 1, 1, 5, 100, selectionHeight + 15, nil, LOCALESTRINGS.QuickslotsMenu["Max:"] );
		self.utils:CreateScrollBarCallback( self.championSbMax, { "events", "classRange", CHAMPION_FERVOR, "maxValue" } );
		self.championSbMin:SetValue( 0 );
		self.championSbMax:SetValue( 0 );
		box:AddItem( boxSet1 );
		box:AddItem( boxSet2 );
		box13:AddItem( box );
	elseif ( playerClass == Turbine.Gameplay.Class.RuneKeeper ) then
		self.eventCheckboxes[RK_ATTUNEMENT] = self.utils:AddCheckBox( box13, LOCALESTRINGS.ClassTriggers["Attunement between:"], selectionWidth + 15, selectionHeight );
		self.eventCheckboxes[RK_ATTUNEMENT].CheckedCallback = function( sender, args )
			local barService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.BarService);
			local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);
			local barSettings = settingsService:GetBarSettings( menu:GetSelection() );

			if ( self.eventCheckboxes[RK_ATTUNEMENT].IsChecked ) then
				if ( barSettings.events == nil ) then
					barSettings.events = { }; 
				end
				if ( barSettings.events.classRange == nil ) then
					barSettings.events.classRange = { };
				end
				barSettings.events.classRange[RK_ATTUNEMENT] = { };
				barSettings.events.classRange[RK_ATTUNEMENT].minValue = 1;
				barSettings.events.classRange[RK_ATTUNEMENT].maxValue = 1;
				self.rkSbMin:SetValue( 1 );
				self.rkSbMax:SetValue( 19 );
			elseif ( barSettings.events ~= nil and barSettings.events.classRange ~= nil and barSettings.events.classRange[RK_ATTUNEMENT] ~= nil) then
				self.rkSbMin:SetValue( 0 );
				self.rkSbMax:SetValue( 0 );
				barSettings.events.classRange[RK_ATTUNEMENT].maxValue = nil;
				barSettings.events.classRange[RK_ATTUNEMENT].minValue = nil;
				barSettings.events.classRange[RK_ATTUNEMENT] = nil;
			end
			if ( barService  ~= nil and barService:Alive( menu:GetSelection() ) ) then
				settingsService:SetBarSettings( menu:GetSelection(), barSettings );
			end
		end
		self.utils:AddLabelBox( box13, LOCALESTRINGS.QuickslotsMenu["Attunement is set with: 10 is Balanced, Lower numbers are Battle and Higher numbers are Healing"], 50, selectionHeight );
		box = self.utils:AddAutoListBox( box13, Turbine.UI.Orientation.Horizontal, 0, 0, 0, 0 );
		boxSet1 = self.utils:AddAutoListBox( box, Turbine.UI.Orientation.Vertical, 0, 0, 0, 0 );
		boxSet2 = self.utils:AddAutoListBox( box, Turbine.UI.Orientation.Vertical, 0, 0, 0, 0 );

		self.rkSbMin = self.utils:AddScrollBar( boxSet1, 1, 1, 19, 100, selectionHeight + 20, nil, LOCALESTRINGS.QuickslotsMenu["Min:"] );
		self.utils:CreateScrollBarCallback( self.rkSbMin, { "events", "classRange", RK_ATTUNEMENT, "minValue" } );

		self.rkSbMax = self.utils:AddScrollBar( boxSet2, 1, 1, 19, 100, selectionHeight + 20, nil, LOCALESTRINGS.QuickslotsMenu["Max:"] );
		self.utils:CreateScrollBarCallback( self.rkSbMax, { "events", "classRange", RK_ATTUNEMENT, "maxValue" } );

		self.rkSbMin:SetValue( 0 );
		self.rkSbMax:SetValue( 0 );
		box:AddItem( boxSet1 );
		box:AddItem( boxSet2 );
		box13:AddItem( box );
	elseif ( playerClass == Turbine.Gameplay.Class.Hunter ) then
		self.eventCheckboxes[HUNTER_FOCUS] = self.utils:AddCheckBox( box13, LOCALESTRINGS.ClassTriggers["Focus between:"], selectionWidth + 15, selectionHeight );
		self.eventCheckboxes[HUNTER_FOCUS].CheckedCallback = function( sender, args )
			local barService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.BarService);
			local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);
			local barSettings = settingsService:GetBarSettings( menu:GetSelection() );

			if ( self.eventCheckboxes[HUNTER_FOCUS].IsChecked ) then
				if ( barSettings.events == nil ) then
					barSettings.events = { }; 
				end
				if ( barSettings.events.classRange == nil ) then
					barSettings.events.classRange = { };
				end
				barSettings.events.classRange[HUNTER_FOCUS] = { };
				barSettings.events.classRange[HUNTER_FOCUS].minValue = 1;
				barSettings.events.classRange[HUNTER_FOCUS].maxValue = 1;
				self.hunterSbMin:SetValue( 1 );
				self.hunterSbMax:SetValue( 9 );
			elseif ( barSettings.events ~= nil and barSettings.events.classRange ~= nil and barSettings.events.classRange[HUNTER_FOCUS] ~= nil) then
				self.hunterSbMin:SetValue( 0 );
				self.hunterSbMax:SetValue( 0 );
				barSettings.events.classRange[HUNTER_FOCUS].maxValue = nil;
				barSettings.events.classRange[HUNTER_FOCUS].minValue = nil;
				barSettings.events.classRange[HUNTER_FOCUS] = nil;

			end
			if ( barService  ~= nil and barService:Alive( menu:GetSelection() ) ) then
				settingsService:SetBarSettings( menu:GetSelection(), barSettings );
			end
		end
		box = self.utils:AddAutoListBox( box13, Turbine.UI.Orientation.Horizontal, 0, 0, 0, 0 );
		boxSet1 = self.utils:AddAutoListBox( box, Turbine.UI.Orientation.Vertical, 0, 0, 0, 0 );
		boxSet2 = self.utils:AddAutoListBox( box, Turbine.UI.Orientation.Vertical, 0, 0, 0, 0 );

		self.hunterSbMin = self.utils:AddScrollBar( boxSet1, 1, 1, 9, 100, selectionHeight + 20, nil, LOCALESTRINGS.QuickslotsMenu["Min:"] );
		self.utils:CreateScrollBarCallback( self.hunterSbMin, { "events", "classRange", HUNTER_FOCUS, "minValue" } );

		self.hunterSbMax = self.utils:AddScrollBar( boxSet2, 1, 1, 9, 100, selectionHeight + 20, nil, LOCALESTRINGS.QuickslotsMenu["Max:"] );
		self.utils:CreateScrollBarCallback( self.hunterSbMax, { "events", "classRange", HUNTER_FOCUS, "maxValue" } );

		self.hunterSbMin:SetValue( 0 );
		self.hunterSbMax:SetValue( 0 );
		box:AddItem( boxSet1 );
		box:AddItem( boxSet2 );
		box13:AddItem( box );
	end
	panel:AddItem( box13 );
end

function ClassBuffPanel:DisplaySettings()
	local eventService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.EventService);
	local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);
	local localBarSettings = settingsService:GetBarSettings( menu:GetSelection() );
	local playerService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.PlayerService);
	local playerClass = playerService.playerClass;

	if ( localBarSettings.events == nil ) then
		localBarSettings.events = { };
	end

    self.buffList.SelectedIndexChanged = function(sender, args)
		local barService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.BarService);
		local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);
		local barSettings = settingsService:GetBarSettings( menu:GetSelection() );

		local selections = self.buffList:GetSelections();
		if ( selections ~= nil ) then
			-- ALWAYS RESET THE CATEGORIES
			barSettings.events.effects = { };
			for key, value in pairs( selections ) do
				if ( barSettings.events.effects[value] == nil ) then
					barSettings.events.effects[value] = true;
				end
			end
			if ( barService  ~= nil and barService:Alive( menu:GetSelection() ) ) then
				settingsService:SetBarSettings( menu:GetSelection(), barSettings );
			end
			-- local inventoryService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.InventoryService);
			--inventoryManager:NotifyClients();
		end
	end
	self.buffList:Clear();

	local events = eventService:GetRegisteredEvents();
	if ( events.classes ~= nil and events.classes[ playerClass ] ~= nil and events.classes[ playerClass ].effects ~= nil ) then
		for key, value in opairs( events.classes[ playerClass ].effects ) do
			self.buffList:AddItem( value.description, value );
		end
	end
	self.buffList:SetSelections( localBarSettings.events.effects );

    self.triggerList.SelectedIndexChanged = function(sender, args)
		local barService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.BarService);
		local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);
		local barSettings = settingsService:GetBarSettings( menu:GetSelection() );

		if ( self.triggerList:GetSelection() == 1 ) then
			barSettings.events.triggerOnClassBuffActive = true;
		else
			barSettings.events.triggerOnClassBuffActive = false;
		end
		if ( barService  ~= nil and barService:Alive( menu:GetSelection() ) ) then
			settingsService:SetBarSettings( menu:GetSelection(), barSettings );
		end
	end
	if ( localBarSettings.events.triggerOnClassBuffActive ) then
		self.triggerList:SetSelection( 1 );
	else
		self.triggerList:SetSelection( 2 );
	end

	if ( self.championSbMin ~= nil and localBarSettings.events ~= nil and localBarSettings.events.classRange ~= nil and localBarSettings.events.classRange[CHAMPION_FERVOR] ~= nil ) then
		if ( localBarSettings.events.classRange[CHAMPION_FERVOR] ~= nil ) then
			self.championSbMin:SetValue( localBarSettings.events.classRange[CHAMPION_FERVOR].minValue );
			self.championSbMax:SetValue( localBarSettings.events.classRange[CHAMPION_FERVOR].maxValue );
		else
			self.championSbMin:SetValue( 0 );
			self.championSbMax:SetValue( 0 );
		end
	end
	if ( self.hunterSbMin ~= nil ) then
		if ( localBarSettings.events ~= nil and localBarSettings.events.classRange ~= nil and localBarSettings.events.classRange[HUNTER_FOCUS] ~= nil ) then
			if ( localBarSettings.events.classRange[HUNTER_FOCUS] ~= nil ) then
				self.hunterSbMin:SetValue( localBarSettings.events.classRange[HUNTER_FOCUS].minValue );
				self.hunterSbMax:SetValue( localBarSettings.events.classRange[HUNTER_FOCUS].maxValue );
			else
				self.hunterSbMin:SetValue( 0 );
				self.hunterSbMax:SetValue( 0 );
			end
		end
	end
	if ( self.rkSbMin ~= nil ) then
		if ( localBarSettings.events ~= nil and localBarSettings.events.classRange ~= nil and localBarSettings.events.classRange[RK_ATTUNEMENT] ~= nil ) then
			if ( localBarSettings.events.classRange[RK_ATTUNEMENT] ~= nil ) then
				self.rkSbMin:SetValue( localBarSettings.events.classRange[RK_ATTUNEMENT].minValue );
				self.rkSbMax:SetValue( localBarSettings.events.classRange[RK_ATTUNEMENT].maxValue );
			else
				self.rkSbMin:SetValue( 0 );
				self.rkSbMax:SetValue( 0 );
			end
		end
	end
	
	if ( self.eventCheckboxes ~= nil ) then
		for key, value in pairs (self.eventCheckboxes) do
			local checked = false;
			if ( localBarSettings.events.classRange ~= nil and localBarSettings.events.classRange[key] ~= nil ) then
				checked = true;
			end
			value:SetChecked( checked );
		end
	end
end

function ClassBuffPanel:EnableTriggers( enabled )
	for key, value in pairs (self.eventCheckboxes) do
		value:SetDisabled( not enabled );
	end
end
