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

ColorPanel = class(MyysticUI.Menus.Controls.BasePanel);

function ColorPanel:Constructor( barId, barValue )
	MyysticUI.Menus.Controls.BasePanel.Constructor(self, barId, barValue);

	self:SetHeight(190);

	self.useBackgroundCheckBox  = self.utils:AddCheckBox( self.panelBackground, "Use Background Color on Bar", selectionWidth + 150, selectionHeight, nil, 5, 5 );
	self.utils:CreateCheckBoxCallback( self.useBackgroundCheckBox, { "useBackgroundColor" } );

	self.bgRSB = self.utils:AddScrollBar( self.panelBackground, 0, 0, 100, 200, selectionHeight + 20, nil, "Red:", 30, 40, -5 );
	self.utils:CreateScrollBarCallback( self.bgRSB, { "backgroundColorRed" }, nil, 100);
	self.bgGSB = self.utils:AddScrollBar( self.panelBackground, 0, 0, 100, 200, selectionHeight + 20, nil, "Green:", 230, 40, 10 );
	self.utils:CreateScrollBarCallback( self.bgGSB, { "backgroundColorGreen" }, nil, 100);
	self.bgBSB = self.utils:AddScrollBar( self.panelBackground, 0, 0, 100, 200, selectionHeight + 20, nil, "Blue:", 30, 80 );
	self.utils:CreateScrollBarCallback( self.bgBSB, { "backgroundColorBlue" }, nil, 100);
	self.bgASB = self.utils:AddScrollBar( self.panelBackground, 0, 0, 100, 200, selectionHeight + 20, nil, "Opacity:", 230, 80, 25 );
	self.utils:CreateScrollBarCallback( self.bgASB, { "opacity" }, nil, 100);

	self.fadeOpacitySelection = self.utils:AddScrollBar( self.panelBackground, 0, 0, 100, 200, selectionHeight + 20, nil, "Shortcut Opacity:", 30, 120, 95 );
	self.utils:CreateScrollBarCallback( self.fadeOpacitySelection, { "fadeOpacity" }, nil, 100 );

	self.useFadingCheckBox  = self.utils:AddCheckBox( self.panelBackground, "Remove opacity when moused over?", selectionWidth + 200, selectionHeight, nil, 30, 160 );
	self.utils:CreateCheckBoxCallback( self.useFadingCheckBox, { "useFading" } );

	self:DisplaySettings();
end

function ColorPanel:DisplaySettings()
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
	local menuService = SERVICE_CONTAINER:GetService(MyysticUI.Services.MenuService);
	local localBarSettings = settingsService:GetBarSettings( menuService:GetSelection() );

	-- COLOR SETTINGS
	self.useBackgroundCheckBox:SetChecked( localBarSettings.useBackgroundColor );
	self.bgRSB:SetValue( localBarSettings.backgroundColorRed * 100 );
	self.bgGSB:SetValue( localBarSettings.backgroundColorGreen * 100 );
	self.bgBSB:SetValue( localBarSettings.backgroundColorBlue * 100 );
	self.bgASB:SetValue( localBarSettings.opacity * 100 );
	self.fadeOpacitySelection:SetValue( localBarSettings.fadeOpacity * 100 );
	self.useFadingCheckBox:SetChecked( localBarSettings.useFading );
end

function ColorPanel:EnableTriggers( enabled )
end
