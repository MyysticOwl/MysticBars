-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

ColorPanel = class(MysticBars.Menus.Controls.BasePanel);

function ColorPanel:Constructor( barId, barValue )
	MysticBars.Menus.Controls.BasePanel.Constructor(self, barId, barValue);

	self:SetHeight(190);

	self.useBackgroundCheckBox  = self.utils:AddCheckBox( self.panelBackground, L["Use Background Color on Bar"], selectionWidth + 150, selectionHeight, nil, 5, 5 );
	self.utils:CreateCheckBoxCallback( self.useBackgroundCheckBox, barId, { "useBackgroundColor" } );

	self.bgRSB = self.utils:AddScrollBar( self.panelBackground, 0, 0, 100, 200, selectionHeight + 20, nil, L["Red:"], 30, 40, -5 );
	self.utils:CreateScrollBarCallback( self.bgRSB, barId, { "backgroundColorRed" }, nil, 100);
	self.bgGSB = self.utils:AddScrollBar( self.panelBackground, 0, 0, 100, 200, selectionHeight + 20, nil, L["Green:"], 230, 40, 10 );
	self.utils:CreateScrollBarCallback( self.bgGSB, barId, { "backgroundColorGreen" }, nil, 100);
	self.bgBSB = self.utils:AddScrollBar( self.panelBackground, 0, 0, 100, 200, selectionHeight + 20, nil, L["Blue:"], 30, 80 );
	self.utils:CreateScrollBarCallback( self.bgBSB, barId, { "backgroundColorBlue" }, nil, 100);
	self.bgASB = self.utils:AddScrollBar( self.panelBackground, 0, 0, 100, 200, selectionHeight + 20, nil, L["Opacity:"], 230, 80, 25 );
	self.utils:CreateScrollBarCallback( self.bgASB, barId, { "opacity" }, nil, 100);

	self.useFadingCheckBox  = self.utils:AddCheckBox( self.panelBackground, L["On Mouseover:"], selectionWidth + 200, selectionHeight, nil, 30, 120 );
	self.utils:CreateCheckBoxCallback( self.useFadingCheckBox, barId, { "useFading" } );

	self.fadeOpacitySelection = self.utils:AddScrollBar( self.panelBackground, 0, 0, 100, 200, selectionHeight + 20, nil, L["Override Opacity:"], 60, 150, 95 );
	self.utils:CreateScrollBarCallback( self.fadeOpacitySelection, barId, { "fadeOpacity" }, nil, 100 );

	self:DisplaySettings();
end

function ColorPanel:DisplaySettings()
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local localBarSettings = settingsService:GetBarSettings( self.barId );

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
