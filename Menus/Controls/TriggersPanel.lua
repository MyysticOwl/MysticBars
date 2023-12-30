-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "MyysticUI.Menus.Core.UI.AutoListBox";
import "MyysticUI.Menus.Core.UI.MenuUtils";

TriggersPanel = class(MyysticUI.Menus.Controls.BasePanel);

function TriggersPanel:Constructor( barId, barValue )
	MyysticUI.Menus.Controls.BasePanel.Constructor(self, barId, barValue);

	self:SetHeight(140);

	self.utils:AddLabelBox( self.panelBackground, "Bar Visibility?", 120, selectionHeight, nil, 5, 5 );
	self.visibilityList = self.utils:AddComboBox(self.panelBackground, 10, 200, 20, 98, 5);
	self.visibilityList:AddItem( "Always", 1 );
	self.visibilityList:AddItem( "Triggered", 2 );

	self.utils:AddLabelBox( self.panelBackground, "When?", 120, selectionHeight, nil, 5, 30 );
	self.triggerList = self.utils:AddCheckedComboBox(self.panelBackground, 5, 300, 20, 55, 30);
	self.triggerList:AddItem( "In Combat", "displayInCombat" );
	self.triggerList:AddItem( "Out of Combat", "displayNotInCombat" );

	self.triggerList:AddItem( "Mounted", "displayWhileMounted" );
	self.triggerList:AddItem( "Not Mounted", "displayWhileNotMounted" );
	self.triggerList:AddItem( "Combat Mounted", "displayWhileCombatMounted" );
	self.triggerList:AddItem( "Not Combat Mounted", "displayWhileNotCombatMounted" );

	self.triggerList:AddItem( "Ctrl Pressed", "isControl" );
	self.triggerList:AddItem( "Alt Pressed", "isAlt" );
	self.triggerList:AddItem( "Shift Pressed", "isShift" );

	local eventService = SERVICE_CONTAINER:GetService(MyysticUI.Services.EventService);
	local events = eventService:GetRegisteredEvents();
	for key, value in pairs (events.categories) do
		self.triggerList:AddItem( value.description, "categories", key );
	end

	self.healthTriggerCheckBox = self.utils:AddCheckBox( self.panelBackground, "Health Drops Below %:", selectionWidth + 100, selectionHeight, nil, 5, 50 );
	self.utils:CreateCheckBoxCallback( self.healthTriggerCheckBox, barId, "displayOnHealth" );
	self.healthSB = self.utils:AddScrollBar( self.panelBackground, 0, 0, 100, 200, selectionHeight + 20, nil, nil, 200, 55, -30 );
	self.utils:CreateScrollBarCallback( self.healthSB, barId, "healthTrigger", nil, 100 );

	self.powerTriggerCheckBox = self.utils:AddCheckBox( self.panelBackground, "Power Drops Below %:", selectionWidth + 100, 16, nil, 5, 90 );
	self.utils:CreateCheckBoxCallback( self.powerTriggerCheckBox, barId, "displayOnPower" );

	self.powerSB = self.utils:AddScrollBar( self.panelBackground, 0, 0, 100, 200, selectionHeight + 20, nil, nil, 200, 95, -30 );
	self.utils:CreateScrollBarCallback( self.powerSB, barId, "powerTrigger", nil, 100 );

	self:DisplaySettings();
end

function TriggersPanel:DisplaySettings()
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
	local localBarSettings = settingsService:GetBarSettings( self.barId );
	if ( localBarSettings.events == nil ) then
		localBarSettings.events = { };
	end

	self.triggerList.SelectedIndexChanged = function(sender, args)
		local selections = self.triggerList:GetSelections();
		if ( selections ~= nil ) then
			SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService):UpdateBarSettings(self.barId, function(barSettings)
				-- ALWAYS RESET THE CATEGORIES
				barSettings.events = { };
				for key, value in pairs( selections ) do
					self.utils:BuildItemFromCommandTable( barSettings, value, true );
				end
				return barSettings;
			end, function()
				SERVICE_CONTAINER:GetService(MyysticUI.Services.InventoryService):NotifyClients();
			end);
		end
	end
	self.triggerList:ClearChecks();
	self.triggerList:SetSelections( localBarSettings.events, true );
	self.triggerList:SetSelections( localBarSettings.events.categories, true );

	self.healthTriggerCheckBox:SetChecked( localBarSettings.events.displayOnHealth );
	self.powerTriggerCheckBox:SetChecked( localBarSettings.events.displayOnPower );
	self.healthSB:SetValue( localBarSettings.events.healthTrigger * 100 );
	self.powerSB:SetValue( localBarSettings.events.powerTrigger * 100 );
end

function TriggersPanel:EnableTriggers( enabled )	
	self.healthTriggerCheckBox:SetDisabled( not enabled );
	self.powerTriggerCheckBox:SetDisabled( not enabled );
end