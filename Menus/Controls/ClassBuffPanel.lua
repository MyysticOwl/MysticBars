-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "MysticBars.Menus.Core.UI.AutoListBox";
import "MysticBars.Menus.Core.UI.MenuUtils";

ClassBuffPanel = class(MysticBars.Menus.Controls.BasePanel);

function ClassBuffPanel:Constructor( barId, barValue )
	MysticBars.Menus.Controls.BasePanel.Constructor(self, barId, barValue);

	self:SetHeight(140);

	local playerService = SERVICE_CONTAINER:GetService(MysticBars.Services.PlayerService);
	local playerClass = playerService.playerClass;

	self.eventCheckboxes = { };

	self.utils:AddLabelBox( self.panelBackground, L["Triggered When:"], 120, selectionHeight, nil, 5, 5 );

	self.triggerList = self.utils:AddComboBox(self.panelBackground, 10, 200, 20, 120, 5);
	self.triggerList:AddItem( L["Buffs Active"], 1 );
	self.triggerList:AddItem( L["Buffs Not Active"], 2 );

	self.utils:AddLabelBox( self.panelBackground, "Buffs:", 120, selectionHeight, nil, 5, 30 );
	self.buffList = self.utils:AddCheckedComboBox(self.panelBackground, 5, 300, 20, 50, 30);

	if ( playerClass == Turbine.Gameplay.Class.Burglar ) then
	elseif ( playerClass == Turbine.Gameplay.Class.Champion ) then
		self.eventCheckboxes[CHAMPION_FERVOR] = self.utils:AddCheckBox( self.panelBackground, L["Fervor between:"], selectionWidth + 15, selectionHeight, nil, 5, 50 );
		self.eventCheckboxes[CHAMPION_FERVOR].CheckedChanged = function( sender, args )
			SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barId, function(barSettings)
				if ( barSettings.events == nil ) then
					barSettings.events = { };
				end
				if ( barSettings.events.classRange == nil ) then
					barSettings.events.classRange = { };
				end
				if ( self.eventCheckboxes[CHAMPION_FERVOR]:IsChecked() == true) then
					barSettings.events.classRange[CHAMPION_FERVOR].active = true;
				else
					barSettings.events.classRange[CHAMPION_FERVOR].active = false;
				end
				return barSettings;
			end);
		end

		self.championSbMin = self.utils:AddScrollBar( self.panelBackground, 1, 1, 5, 100, selectionHeight + 15, nil, L["Min:"], 30, 80, 15 );
		self.utils:CreateScrollBarCallback( self.championSbMin, barId, { "events", "classRange", CHAMPION_FERVOR, "minValue" } );

		self.championSbMax = self.utils:AddScrollBar( self.panelBackground, 1, 1, 5, 100, selectionHeight + 15, nil, L["Max:"], 130, 80, 15 );
		self.utils:CreateScrollBarCallback( self.championSbMax, barId, { "events", "classRange", CHAMPION_FERVOR, "maxValue" } );
	elseif ( playerClass == Turbine.Gameplay.Class.RuneKeeper ) then
		self.eventCheckboxes[RK_ATTUNEMENT] = self.utils:AddCheckBox( self.panelBackground, L["Attunement between:"], selectionWidth + 15, selectionHeight, nil, 5, 50 );
		self.eventCheckboxes[RK_ATTUNEMENT].CheckedChanged = function( sender, args )
			SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barId, function(barSettings)
				if ( barSettings.events == nil ) then
					barSettings.events = { }; 
				end
				if ( barSettings.events.classRange == nil ) then
					barSettings.events.classRange = { };
				end
				if ( self.eventCheckboxes[RK_ATTUNEMENT]:IsChecked() == true) then
					barSettings.events.classRange[RK_ATTUNEMENT].active = true;
				else
					barSettings.events.classRange[RK_ATTUNEMENT].active = false;
				end
				return barSettings;
			end);
			
		end
		self.utils:AddLabelBox( self.panelBackground, L["10 = Balanced;Lower numbers = Damage;Higher numbers Healing:"], 500, selectionHeight, nil, 30, 80 );

		self.rkSbMin = self.utils:AddScrollBar( self.panelBackground, 1, 1, 19, 100, selectionHeight + 20, nil, L["Min:"], 30, 100, 15 );
		self.utils:CreateScrollBarCallback( self.rkSbMin, barId, { "events", "classRange", RK_ATTUNEMENT, "minValue" } );

		self.rkSbMax = self.utils:AddScrollBar( self.panelBackground, 1, 1, 19, 100, selectionHeight + 20, nil, L["Max:"], 130, 100, 20 );
		self.utils:CreateScrollBarCallback( self.rkSbMax, barId, { "events", "classRange", RK_ATTUNEMENT, "maxValue" } );
	elseif ( playerClass == Mariner ) then
		self.eventCheckboxes[MARINER_BALANCE] = self.utils:AddCheckBox( self.panelBackground, L["Balance between:"], selectionWidth + 15, selectionHeight, nil, 5, 50 );
		self.eventCheckboxes[MARINER_BALANCE].CheckedChanged = function( sender, args )
			SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barId, function(barSettings)
				if ( barSettings.events == nil ) then
					barSettings.events = { }; 
				end
				if ( barSettings.events.classRange == nil ) then
					barSettings.events.classRange = { };
				end
				if ( self.eventCheckboxes[MARINER_BALANCE]:IsChecked() == true) then
					barSettings.events.classRange[MARINER_BALANCE].active = true;
				else
					barSettings.events.classRange[MARINER_BALANCE].active = false;
				end
				return barSettings;
			end);
			
		end
		self.utils:AddLabelBox( self.panelBackground, L["25 = Balanced;Lower numbers = Aft;Higher numbers Fore:"], 500, selectionHeight, nil, 30, 80 );

		self.marinerSbMin = self.utils:AddScrollBar( self.panelBackground, 1, 25, 50, 100, selectionHeight + 20, nil, L["Min:"], 30, 100, 15 );
		self.utils:CreateScrollBarCallback( self.marinerSbMin, barId, { "events", "classRange", MARINER_BALANCE, "minValue" } );

		self.marinerSbMax = self.utils:AddScrollBar( self.panelBackground, 1, 25, 50, 100, selectionHeight + 20, nil, L["Max:"], 130, 100, 20 );
		self.utils:CreateScrollBarCallback( self.marinerSbMax, barId, { "events", "classRange", MARINER_BALANCE, "maxValue" } );
	elseif ( playerClass == Turbine.Gameplay.Class.Hunter ) then
		self.eventCheckboxes[HUNTER_FOCUS] = self.utils:AddCheckBox( self.panelBackground, L["Focus between:"], selectionWidth + 15, selectionHeight, nil, 5, 50 );
		self.eventCheckboxes[HUNTER_FOCUS].CheckedChanged = function( sender, args )
			SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barId, function(barSettings)
				if ( self.eventCheckboxes[HUNTER_FOCUS]:IsChecked() == true ) then
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
				return barSettings;
			end);
		end

		self.hunterSbMin = self.utils:AddScrollBar( self.panelBackground, 1, 1, 9, 100, selectionHeight + 20, nil, L["Min:"], 30, 80, 15 );
		self.utils:CreateScrollBarCallback( self.hunterSbMin, barId, { "events", "classRange", HUNTER_FOCUS, "minValue" } );

		self.hunterSbMax = self.utils:AddScrollBar( self.panelBackground, 1, 1, 9, 100, selectionHeight + 20, nil, L["Max:"], 130, 80, 15 );
		self.utils:CreateScrollBarCallback( self.hunterSbMax, barId, { "events", "classRange", HUNTER_FOCUS, "maxValue" } );

		self.hunterSbMin:SetValue( 0 );
		self.hunterSbMax:SetValue( 0 );
	end

	self:DisplaySettings();
end

function ClassBuffPanel:DisplaySettings()
	local eventService = SERVICE_CONTAINER:GetService(MysticBars.Services.EventService);
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local localBarSettings = settingsService:GetBarSettings( self.barId );
	local playerService = SERVICE_CONTAINER:GetService(MysticBars.Services.PlayerService);
	local playerClass = playerService.playerClass;

	if ( localBarSettings.events == nil ) then
		localBarSettings.events = { };
	end

    self.buffList.SelectedIndexChanged = function(sender, args)
		local selections = self.buffList:GetSelections();
		if ( selections ~= nil ) then
			SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barId, function(barSettings)
				-- ALWAYS RESET THE CATEGORIES
				barSettings.events.effects = { };
				for key, value in pairs( selections ) do
					if ( barSettings.events.effects[value] == nil ) then
						barSettings.events.effects[value] = true;
					end
				end
				return barSettings;
			end, function()
				SERVICE_CONTAINER:GetService(MysticBars.Services.InventoryService):NotifyClients();
			end);
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
		SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barId, function(barSettings)
			if ( self.triggerList:GetSelection() == 1 ) then
				barSettings.events.triggered.triggerOnClassBuffActive = true;
			else
				barSettings.events.triggered.triggerOnClassBuffActive = false;
			end
			return barSettings;
		end, function()
			SERVICE_CONTAINER:GetService(MysticBars.Services.InventoryService):NotifyClients();
		end);
	end
	if ( localBarSettings.events.triggered.triggerOnClassBuffActive ) then
		self.triggerList:SetSelection( 1 );
	else
		self.triggerList:SetSelection( 2 );
	end

	if ( self.championSbMin ~= nil and localBarSettings.events ~= nil and localBarSettings.events.classRange ~= nil and localBarSettings.events.classRange[CHAMPION_FERVOR] ~= nil ) then
		self.eventCheckboxes[CHAMPION_FERVOR]:SetChecked(localBarSettings.events.classRange[CHAMPION_FERVOR].active);
		self.championSbMin:SetValue( localBarSettings.events.classRange[CHAMPION_FERVOR].minValue );
		self.championSbMax:SetValue( localBarSettings.events.classRange[CHAMPION_FERVOR].maxValue );
	elseif (self.eventCheckboxes[CHAMPION_FERVOR] ~= nil) then
		self.eventCheckboxes[CHAMPION_FERVOR]:SetChecked(false);
		self.championSbMin:SetValue( 0 );
		self.championSbMax:SetValue( 0 );
	end
	if ( self.hunterSbMin ~= nil and localBarSettings.events ~= nil and localBarSettings.events.classRange ~= nil and localBarSettings.events.classRange[HUNTER_FOCUS] ~= nil ) then
		self.eventCheckboxes[HUNTER_FOCUS]:SetChecked(localBarSettings.events.classRange[HUNTER_FOCUS].active);
		self.hunterSbMin:SetValue( localBarSettings.events.classRange[HUNTER_FOCUS].minValue );
		self.hunterSbMax:SetValue( localBarSettings.events.classRange[HUNTER_FOCUS].maxValue );
	elseif (self.eventCheckboxes[HUNTER_FOCUS] ~= nil) then
		self.eventCheckboxes[HUNTER_FOCUS]:SetChecked(false);
		self.hunterSbMin:SetValue( 0 );
		self.hunterSbMax:SetValue( 0 );
	end
	if ( self.rkSbMin ~= nil and localBarSettings.events ~= nil and localBarSettings.events.classRange ~= nil and localBarSettings.events.classRange[RK_ATTUNEMENT] ~= nil ) then
		self.eventCheckboxes[RK_ATTUNEMENT]:SetChecked(localBarSettings.events.classRange[RK_ATTUNEMENT].active);
		self.rkSbMin:SetValue( localBarSettings.events.classRange[RK_ATTUNEMENT].minValue );
		self.rkSbMax:SetValue( localBarSettings.events.classRange[RK_ATTUNEMENT].maxValue );
	elseif (self.eventCheckboxes[RK_ATTUNEMENT] ~= nil) then
		self.eventCheckboxes[RK_ATTUNEMENT]:SetChecked(false);
		self.rkSbMin:SetValue( 0 );
		self.rkSbMax:SetValue( 0 );
	end
	if ( self.marinerSbMin ~= nil and localBarSettings.events ~= nil and localBarSettings.events.classRange ~= nil and localBarSettings.events.classRange[MARINER_BALANCE] ~= nil ) then
		self.eventCheckboxes[MARINER_BALANCE]:SetChecked(localBarSettings.events.classRange[MARINER_BALANCE].active);
		self.marinerSbMin:SetValue( localBarSettings.events.classRange[MARINER_BALANCE].minValue );
		self.marinerSbMax:SetValue( localBarSettings.events.classRange[MARINER_BALANCE].maxValue );
	elseif (self.eventCheckboxes[MARINER_BALANCE] ~= nil) then
		self.eventCheckboxes[MARINER_BALANCE]:SetChecked(false);
		self.marinerSbMin:SetValue( 25 );
		self.marinerSbMax:SetValue( 25 );
	end
end

function ClassBuffPanel:EnableTriggers( enabled )
	for key, value in pairs (self.eventCheckboxes) do
		value:SetDisabled( not enabled );
	end
end
