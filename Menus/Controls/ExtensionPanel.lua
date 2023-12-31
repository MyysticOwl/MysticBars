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

ExtensionPanel = class(MyysticUI.Menus.Controls.BasePanel);

function ExtensionPanel:Constructor( barId, barValue )
	MyysticUI.Menus.Controls.BasePanel.Constructor(self, barId, barValue);

	self:SetHeight(140);

	self.utils:AddLabelBox( self.panelBackground, "Orientation:", selectionWidth + 100, selectionHeight + 5, nil, 5, 5 );
	self.orientationList = self.utils:AddComboBox(self.panelBackground, 10, 200, 20, 120, 5);
	self.orientationList:AddItem( "Left",  "Left" );
	self.orientationList:AddItem( "Right", "Right" );
	self.orientationList:AddItem( "Up",    "Up" );
	self.orientationList:AddItem( "Down",  "Down" );

	self.utils:AddLabelBox( self.panelBackground, "Attached quickslot Moused Over:", selectionWidth + 200, selectionHeight + 5, nil, 5, 30 );
	self.mousedOverList = self.utils:AddComboBox(self.panelBackground, 10, 200, 20, 240, 30);
	self.mousedOverList:AddItem( "Show Extension(s)", SHOW_EXTENSIONS );
	self.mousedOverList:AddItem( "Show & Rollup Selection", ROLL_UP_SELECTION );
	self.mousedOverList:AddItem( "Select Random Shortcut", SELECT_RANDOM_SHORTCUT );
	self.mousedOverList:AddItem( "Cycle Shortcuts", CYCLE_EXTENSIONS );

	self.utils:AddLabelBox( self.panelBackground, "Stop displaying when:", selectionWidth + 200, selectionHeight + 5, nil, 5, 60 );
	self.removalList = self.utils:AddComboBox(self.panelBackground, 10, 200, 20, 150, 60);
	self.removalList:AddItem( "Mouse Leaves Bar", 1 );
	self.removalList:AddItem( "Combat has ended", 2 );

	self:DisplaySettings();
end

function ExtensionPanel:DisplaySettings()
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
	local localBarSettings = settingsService:GetBarSettings( self.barId );

	self.orientationList:SetSelection( localBarSettings.orientation );
    self.orientationList.SelectedIndexChanged = function(sender, args)
		SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService):UpdateBarSettings(self.barId,
		function(barSettings)
			barSettings.orientation = self.orientationList:GetSelection();
			return barSettings;
		end);
	end

    self.mousedOverList.SelectedIndexChanged = function(sender, args)
		SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService):UpdateBarSettings(self.barId,
		function(barSettings)
			barSettings.onMouseOver = self.mousedOverList:GetSelection();
			return barSettings;
		end);
	end
	self.mousedOverList:SetSelection( localBarSettings.onMouseOver or SHOW_EXTENSIONS );

    self.removalList.SelectedIndexChanged = function(sender, args)
		SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService):UpdateBarSettings(self.barId,
		function(barSettings)
			barSettings.barTermination = self.removalList:GetSelection();
			return barSettings;
		end);
	end
	self.removalList:SetSelection( localBarSettings.barTermination or 1 );
end

function ExtensionPanel:EnableTriggers( enabled )
end
