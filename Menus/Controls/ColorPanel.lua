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

ColorPanel = class();

function ColorPanel:Constructor( panel )
	self.utils = MyysticUI.Menus.Core.UI.MenuUtils();

	self.utils:AddCategoryBox(panel, "Background Colors");

	self.useBackgroundCheckBox  = self.utils:AddCheckBox( panel, "Use Background Color on Bar", selectionWidth + 150, selectionHeight );
	self.utils:CreateCheckBoxCallback( self.useBackgroundCheckBox, { "useBackgroundColor" } );

	self.bgRSB = self.utils:AddScrollBar( panel, 0, 0, 100, 200, selectionHeight + 20, nil, "Red:" );
	self.utils:CreateScrollBarCallback( self.bgRSB, { "backgroundColorRed" }, nil, 100);
	self.bgGSB = self.utils:AddScrollBar( panel, 0, 0, 100, 200, selectionHeight + 20, nil, "Green:" );
	self.utils:CreateScrollBarCallback( self.bgGSB, { "backgroundColorGreen" }, nil, 100);
	self.bgBSB = self.utils:AddScrollBar( panel, 0, 0, 100, 200, selectionHeight + 20, nil, "Blue:" );
	self.utils:CreateScrollBarCallback( self.bgBSB, { "backgroundColorBlue" }, nil, 100);
	self.bgASB = self.utils:AddScrollBar( panel, 0, 0, 100, 200, selectionHeight + 20, nil, "Opacity:" );
	self.utils:CreateScrollBarCallback( self.bgASB, { "opacity" }, nil, 100);

	self.utils:AddCategoryBox(panel, "Fade Options");

	self.fadeOpacitySelection = self.utils:AddScrollBar( panel, 0, 0, 100, 200, selectionHeight + 20, nil, "Shortcut Opacity:" );
	self.utils:CreateScrollBarCallback( self.fadeOpacitySelection, { "fadeOpacity" }, nil, 100 );

	self.useFadingCheckBox  = self.utils:AddCheckBox( panel, "Remove opacity when moused over?", selectionWidth + 200, selectionHeight );
	self.utils:CreateCheckBoxCallback( self.useFadingCheckBox, { "useFading" } );
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
