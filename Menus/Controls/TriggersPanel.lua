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

TriggersPanel = class(Turbine.UI.TreeNode);

TriggersPanel.utils = MyysticUI.Menus.Core.UI.MenuUtils();

function TriggersPanel:Constructor( barId, barValue )
	Turbine.UI.TreeNode.Constructor(self);

	self.barId = barId;
	self.barValues = barValue;

	self:SetHeight(160);

	self.panel = Turbine.UI.Control();
	self.panel:SetParent(self);
	self.panel:SetPosition(0, 0);
	self.panel:SetSize(self:GetWidth()-2,self:GetHeight()-2);
	self.panel:SetBackColor(Turbine.UI.Color(0.42,0.3,0.3));
	self.panel:SetMouseVisible(false);

	self.panelBackground = Turbine.UI.Control();
	self.panelBackground:SetParent(self.panel);
	self.panelBackground:SetPosition(1,1);
	self.panelBackground:SetSize(self:GetWidth()-4,self:GetHeight()-4);
	self.panelBackground:SetBackColor(Turbine.UI.Color(0.925,0,0,0));
	self.panelBackground:SetMouseVisible(false);

	self.utils:AddLabelBox( self.panelBackground, "Bar Visibility?", 120, selectionHeight, nil, 5, 5 );
	self.visibilityList = self.utils:AddComboBox(self.panelBackground, 200, 20, 98, 5);
	self.visibilityList:AddItem( "Always", 1 );
	self.visibilityList:AddItem( "Triggered", 2 );

	self.utils:AddLabelBox( self.panelBackground, "When?", 120, selectionHeight, nil, 5, 30 );
	self.triggerList = self.utils:AddCheckedComboBox(self.panelBackground, 5, 300, 20, 55, 30);
	self.triggerList:AddItem( "In Combat", { "events", "displayInCombat" } );
	self.triggerList:AddItem( "Out of Combat", { "events", "displayNotInCombat" } );

	self.triggerList:AddItem( "Mounted", { "events", "displayWhileMounted" } );
	self.triggerList:AddItem( "Not Mounted", { "events", "displayWhileNotMounted" } );
	self.triggerList:AddItem( "Combat Mounted", { "events", "displayWhileCombatMounted" } );
	self.triggerList:AddItem( "Not Combat Mounted", { "events", "displayWhileNotCombatMounted" } );

	self.triggerList:AddItem( "Ctrl Pressed", { "events", "isControl" } );
	self.triggerList:AddItem( "Alt Pressed", { "events", "isAlt" } );
	self.triggerList:AddItem( "Shift Pressed", { "events", "isShift" } );

	local eventService = SERVICE_CONTAINER:GetService(MyysticUI.Services.EventService);
	local events = eventService:GetRegisteredEvents();
	for key, value in pairs (events.categories) do
		self.triggerList:AddItem( value.description, { "events", "categories", key } );
	end

	self.healthTriggerCheckBox = self.utils:AddCheckBox( self.panelBackground, "Health Drops Below %:", selectionWidth + 100, selectionHeight, nil, 5, 50 );
	self.utils:CreateCheckBoxCallback( self.healthTriggerCheckBox, { "events", "displayOnHealth" } );
	self.healthSB = self.utils:AddScrollBar( self.panelBackground, 0, 0, 100, 200, selectionHeight + 20, nil, nil, 200, 55 );
	self.utils:CreateScrollBarCallback( self.healthSB, { "events", "healthTrigger" }, nil, 100 );

	self.powerTriggerCheckBox = self.utils:AddCheckBox( self.panelBackground, "Power Drops Below %:", selectionWidth + 100, 16, nil, 5, 90 );
	self.utils:CreateCheckBoxCallback( self.powerTriggerCheckBox, { "events", "displayOnPower" } );

	self.powerSB = self.utils:AddScrollBar( self.panelBackground, 0, 0, 100, 200, selectionHeight + 20, nil, nil, 200, 95 );
	self.utils:CreateScrollBarCallback( self.powerSB, { "events", "powerTrigger" }, nil, 100 );

	self:DisplaySettings();
end

function TriggersPanel:DisplaySettings()
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
	local localBarSettings = settingsService:GetBarSettings( self.barId );
	if ( localBarSettings.events == nil ) then
		localBarSettings.events = { };
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

function TriggersPanel:Refresh(width)
	local w = width or self:GetWidth();

	self:SetWidth(w);
	self.panel:SetSize(self:GetWidth()-2,self:GetHeight()-2);
	self.panelBackground:SetSize(self:GetWidth()-4,self:GetHeight()-4);
  end