-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

TriggersPanel = class(MysticBars.Menus.Controls.BasePanel);

function TriggersPanel:Constructor( parent, barId, barValue )
	MysticBars.Menus.Controls.BasePanel.Constructor(self, barId, barValue);

	self.parentNode = parent;

	self:SetHeight(140);

	self.utils:AddLabelBox( self.panelBackground, L["Triggered When:"], 120, selectionHeight, nil, 5, 5 );
	self.triggerList = self.utils:AddCheckedComboBox(self.panelBackground, 5, 300, 20, 120, 5);
	self.triggerList:AddItem( L["In Combat"], { "events", "triggered", "displayInCombat" } );
	self.triggerList:AddItem( L["Out of Combat"], { "events", "triggered", "displayNotInCombat" } );

	self.triggerList:AddItem( L["Mounted"], { "events", "triggered", "displayWhileMounted" } );
	self.triggerList:AddItem( L["Not Mounted"], { "events", "triggered", "displayWhileNotMounted" } );
	self.triggerList:AddItem( L["Combat Mounted"], { "events", "triggered", "displayWhileCombatMounted" } );
	self.triggerList:AddItem( L["Not Combat Mounted"], { "events", "triggered", "displayWhileNotCombatMounted" } );

	self.triggerList:AddItem( L["Ctrl Pressed"], { "events", "triggered", "isControl" } );
	self.triggerList:AddItem( L["Alt Pressed"], { "events", "triggered", "isAlt" } );
	self.triggerList:AddItem( L["Shift Pressed"], { "events", "triggered", "isShift" } );

	local eventService = SERVICE_CONTAINER:GetService(MysticBars.Services.EventService);
	local events = eventService:GetRegisteredEvents();
	for key, value in pairs (events.categories) do
		self.triggerList:AddItem( value.description, { "events", "triggered", "categories", key} );
	end

	self.healthTriggerCheckBox = self.utils:AddCheckBox( self.panelBackground, L["Health Drops Below %:"], selectionWidth + 100, selectionHeight, nil, 5, 20 );
	self.utils:CreateCheckBoxCallback( self.healthTriggerCheckBox, barId, { "events", "triggered", "displayOnHealth" } );
	self.healthSB = self.utils:AddScrollBar( self.panelBackground, 0, 0, 100, 200, selectionHeight + 20, nil, nil, 200, 25, -30 );
	self.utils:CreateScrollBarCallback( self.healthSB, barId, { "events", "triggered", "healthTrigger" }, nil, 100 );

	self.powerTriggerCheckBox = self.utils:AddCheckBox( self.panelBackground, L["Power Drops Below %:"], selectionWidth + 100, 16, nil, 5, 60 );
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
				barSettings.visible = false;
				if (self.parentNode.visible ~= nil) then
					self.parentNode.visible:Hide(barSettings);
				end
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

	self.healthTriggerCheckBox:SetChecked( localBarSettings.events.triggered.displayOnHealth );
	self.powerTriggerCheckBox:SetChecked( localBarSettings.events.triggered.displayOnPower );
	if (localBarSettings.events.triggered.healthTrigger == nil) then
		localBarSettings.events.triggered.healthTrigger = 0;
		localBarSettings.events.triggered.powerTrigger = 0;
	end
	self.healthSB:SetValue( localBarSettings.events.triggered.healthTrigger * 100 );
	self.powerSB:SetValue( localBarSettings.events.triggered.powerTrigger * 100 );
end

function TriggersPanel:EnableTriggers( enabled )	
	self.healthTriggerCheckBox:SetDisabled( not enabled );
	self.powerTriggerCheckBox:SetDisabled( not enabled );
end