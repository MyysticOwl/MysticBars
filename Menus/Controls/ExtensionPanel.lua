-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

ExtensionPanel = class(MysticBars.Menus.Controls.BasePanel);

function ExtensionPanel:Constructor( barId, barValue )
	MysticBars.Menus.Controls.BasePanel.Constructor(self, barId, barValue);

	self:SetHeight(140);

	self.utils:AddLabelBox( self.panelBackground, L["Orientation:"], selectionWidth + 100, selectionHeight + 5, nil, 5, 5 );
	self.orientationList = self.utils:AddComboBox(self.panelBackground, 10, 200, 20, 120, 5);
	self.orientationList:AddItem( L["Left"],  "Left" );
	self.orientationList:AddItem( L["Right"], "Right" );
	self.orientationList:AddItem( L["Up"],    "Up" );
	self.orientationList:AddItem( L["Down"],  "Down" );

	self.utils:AddLabelBox( self.panelBackground, L["On Mouseover:"], selectionWidth + 200, selectionHeight + 5, nil, 5, 30 );
	self.mousedOverList = self.utils:AddComboBox(self.panelBackground, 10, 200, 20, 240, 30);
	self.mousedOverList:AddItem( L["Show Extension(s)"], SHOW_EXTENSIONS );
	self.mousedOverList:AddItem( L["Show & Rollup Selection"], ROLL_UP_SELECTION );
	self.mousedOverList:AddItem( L["Select Random Shortcut"], SELECT_RANDOM_SHORTCUT );
	self.mousedOverList:AddItem( L["Cycle Shortcuts"], CYCLE_EXTENSIONS );

	self.utils:AddLabelBox( self.panelBackground, L["Stop displaying when:"], selectionWidth + 200, selectionHeight + 5, nil, 5, 60 );
	self.removalList = self.utils:AddComboBox(self.panelBackground, 10, 200, 20, 150, 60);
	self.removalList:AddItem( L["Mouse Leaves Bar"], 1 );
	self.removalList:AddItem( L["Combat has ended"], 2 );

	self:DisplaySettings();
end

function ExtensionPanel:DisplaySettings()
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local localBarSettings = settingsService:GetBarSettings( self.barId );

	self.orientationList:SetSelection( localBarSettings.orientation );
    self.orientationList.SelectedIndexChanged = function(sender, args)
		SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barId,
		function(barSettings)
			barSettings.orientation = self.orientationList:GetSelection();
			return barSettings;
		end);
	end

    self.mousedOverList.SelectedIndexChanged = function(sender, args)
		SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barId,
		function(barSettings)
			barSettings.onMouseOver = self.mousedOverList:GetSelection();
			return barSettings;
		end);
	end
	self.mousedOverList:SetSelection( localBarSettings.onMouseOver or SHOW_EXTENSIONS );

    self.removalList.SelectedIndexChanged = function(sender, args)
		SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barId,
		function(barSettings)
			barSettings.barTermination = self.removalList:GetSelection();
			return barSettings;
		end);
	end
	self.removalList:SetSelection( localBarSettings.barTermination or 1 );
end

function ExtensionPanel:EnableTriggers( enabled )
end
