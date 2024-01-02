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

TriggersPanel = class(MysticBars.Menus.Controls.BasePanel);

function TriggersPanel:Constructor( barId, barValue )
	MysticBars.Menus.Controls.BasePanel.Constructor(self, barId, barValue);

	self:SetHeight(140);

	self.utils:AddLabelBox( self.panelBackground, "Triggered When?", 120, selectionHeight, nil, 5, 5 );
	self.triggerList = self.utils:AddCheckedComboBox(self.panelBackground, 5, 300, 20, 120, 5);
	self.triggerList:AddItem( "In Combat", { "events", "triggered", "displayInCombat" } );
	self.triggerList:AddItem( "Out of Combat", { "events", "triggered", "displayNotInCombat" } );

	self.triggerList:AddItem( "Mounted", { "events", "triggered", "displayWhileMounted" } );
	self.triggerList:AddItem( "Not Mounted", { "events", "triggered", "displayWhileNotMounted" } );
	self.triggerList:AddItem( "Combat Mounted", { "events", "triggered", "displayWhileCombatMounted" } );
	self.triggerList:AddItem( "Not Combat Mounted", { "events", "triggered", "displayWhileNotCombatMounted" } );

	self.triggerList:AddItem( "Ctrl Pressed", { "events", "triggered", "isControl" } );
	self.triggerList:AddItem( "Alt Pressed", { "events", "triggered", "isAlt" } );
	self.triggerList:AddItem( "Shift Pressed", { "events", "triggered", "isShift" } );

	local eventService = SERVICE_CONTAINER:GetService(MysticBars.Services.EventService);
	local events = eventService:GetRegisteredEvents();
	for key, value in pairs (events.categories) do
		self.triggerList:AddItem( value.description, { "events", "triggered", "categories", key} );
	end

	self.healthTriggerCheckBox = self.utils:AddCheckBox( self.panelBackground, "Health Drops Below %:", selectionWidth + 100, selectionHeight, nil, 5, 20 );
	self.utils:CreateCheckBoxCallback( self.healthTriggerCheckBox, barId, { "events", "triggered", "displayOnHealth" } );
	self.healthSB = self.utils:AddScrollBar( self.panelBackground, 0, 0, 100, 200, selectionHeight + 20, nil, nil, 200, 25, -30 );
	self.utils:CreateScrollBarCallback( self.healthSB, barId, { "events", "triggered", "healthTrigger" }, nil, 100 );

	self.powerTriggerCheckBox = self.utils:AddCheckBox( self.panelBackground, "Power Drops Below %:", selectionWidth + 100, 16, nil, 5, 60 );
	self.utils:CreateCheckBoxCallback( self.powerTriggerCheckBox, barId, { "events", "triggered", "displayOnPower" } );

	self.powerSB = self.utils:AddScrollBar( self.panelBackground, 0, 0, 100, 200, selectionHeight + 20, nil, nil, 200, 65, -30 );
	self.utils:CreateScrollBarCallback( self.powerSB, barId, { "events", "triggered", "powerTrigger" }, nil, 100 );

	self:DisplaySettings();
end

function TriggersPanel:DisplaySettings()
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local localBarSettings = settingsService:GetBarSettings( self.barId );
	if ( localBarSettings.events == nil ) then
		localBarSettings.events = { };
	end
	if ( localBarSettings.events.triggered == nil ) then
		localBarSettings.events.triggered = { };
	end

	self.triggerList.SelectedIndexChanged = function(sender, args)
		local selections = self.triggerList:GetSelections();
		if ( selections ~= nil ) then
						SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barId, function(barSettings)
				-- ALWAYS RESET THE CATEGORIES
				barSettings.events.triggered = { };
				for key, value in pairs( selections ) do
					self.utils:BuildItemFromCommandTable( barSettings, value, true );
				end
				return barSettings;
			end, function()
				SERVICE_CONTAINER:GetService(MysticBars.Services.InventoryService):NotifyClients();
			end);
		end
	end
	self.triggerList:ClearChecks();
	self.triggerList:SetSelections( localBarSettings.events.triggered, true );
	self.triggerList:SetSelections( localBarSettings.events.triggered.categories, true );

	self.healthTriggerCheckBox:SetChecked( localBarSettings.events.displayOnHealth );
	self.powerTriggerCheckBox:SetChecked( localBarSettings.events.displayOnPower );
	self.healthSB:SetValue( localBarSettings.events.healthTrigger * 100 );
	self.powerSB:SetValue( localBarSettings.events.powerTrigger * 100 );
end

function TriggersPanel:EnableTriggers( enabled )	
	self.healthTriggerCheckBox:SetDisabled( not enabled );
	self.powerTriggerCheckBox:SetDisabled( not enabled );
end