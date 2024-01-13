-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

ColorPanel = class(MysticBars.Menus.Controls.BasePanel);

function ColorPanel:Constructor( barId, barValue )
	MysticBars.Menus.Controls.BasePanel.Constructor(self, barId, barValue);

	self:SetHeight(190);

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings( self.barId );

	local checkbox, picker, colorPreview, opacity = self.utils:AddColorPicker(self.panelBackground, L["Bar Back Color:"],
	barSettings.backgroundColorRed, barSettings.backgroundColorGreen, barSettings.backgroundColorBlue, 145, 5);
	self.useBackgroundCheckBox = checkbox;
	self.bgASB = opacity;
	self.utils:CreateCheckBoxCallback( checkbox, barId, { "useBackgroundColor" } );

	picker.LeftClick = function ()
		colorPreview:SetBackColor(picker:GetTurbineColor());

		local red, green, blue = picker:GetRGBColor();
		SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barId, function(barSettings)
			self.utils:BuildItemFromCommandTable( barSettings, { "backgroundColorRed" }, red / 255 );
			self.utils:BuildItemFromCommandTable( barSettings, { "backgroundColorGreen" }, green / 255 );
			self.utils:BuildItemFromCommandTable( barSettings, { "backgroundColorBlue" }, blue / 255 );
			return barSettings;
		end);
	end
	self.utils:CreateScrollBarCallback( opacity, barId, { "opacity" }, nil, 150);

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
	-- self.bgRSB:SetValue( localBarSettings.backgroundColorRed * 100 );
	-- self.bgGSB:SetValue( localBarSettings.backgroundColorGreen * 100 );
	-- self.bgBSB:SetValue( localBarSettings.backgroundColorBlue * 100 );
	self.bgASB:SetValue( localBarSettings.opacity * 100 );
	self.fadeOpacitySelection:SetValue( localBarSettings.fadeOpacity * 100 );
	self.useFadingCheckBox:SetChecked( localBarSettings.useFading );
end

function ColorPanel:EnableTriggers( enabled )
end
