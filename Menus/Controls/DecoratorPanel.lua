-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

DecoratorPanel = class(MysticBars.Menus.Controls.BasePanel);

function DecoratorPanel:Constructor(barId, barSettings)
	MysticBars.Menus.Controls.BasePanel.Constructor(self, barSettings.id, barSettings);

	self:SetHeight(110);
	self.barSettings = barSettings;

	self.tabbed  = self.utils:AddCheckBox( self.panelBackground, L["Tabbed Bar"], selectionWidth + 150, selectionHeight, nil, 5, 5 );
	self.window  = self.utils:AddCheckBox( self.panelBackground, L["Window Bar"], selectionWidth + 150, selectionHeight, nil, 150, 5 );

	self.decoratorStr = "";
	if (barSettings.decorator == TAB_BAR_DECORATOR) then
		self.decoratorStr = "tab";
	elseif (barSettings.decorator == WINDOW_BAR_DECORATOR) then
		self.decoratorStr = "window";
	end

	self.checkbox, self.picker, self.colorPreview, self.opacity = self.utils:AddColorPicker(self.panelBackground, L["Bar Title Color:"],
	barSettings.decorators[self.decoratorStr].titleColorR, barSettings.decorators[self.decoratorStr].titleColorG, barSettings.decorators[self.decoratorStr].titleColorB, 145, 30);

	self.checkbox2, self.picker2, self.colorPreview2, self.opacity2 = self.utils:AddColorPicker(self.panelBackground, L["Bar Back Color:"],
	barSettings.decorators[self.decoratorStr].backColorR, barSettings.decorators[self.decoratorStr].backColorG, barSettings.decorators[self.decoratorStr].backColorB, 145, 70);

	self:DisplaySettings();
end

function DecoratorPanel:DisplaySettings()
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings( self.barId );

	self.decoratorStr = "tab";
	if (barSettings.decorator == WINDOW_BAR_DECORATOR) then
		self.decoratorStr = "window";
	end

	self.tabbed:SetChecked(self.barSettings.decorator == TAB_BAR_DECORATOR);
	self.window:SetChecked(self.barSettings.decorator == WINDOW_BAR_DECORATOR);

	self.tabbed.CheckedChanged = function( sender, args )
		if ( self.tabbed:IsChecked() == true and barSettings.decorator ~= TAB_BAR_DECORATOR) then
			SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(barSettings.id, function(barSettings)
				barSettings.decorator = TAB_BAR_DECORATOR;
				return barSettings;
			end, function()
				self:DisplaySettings();
			end);
		end
	end
	self.window.CheckedChanged = function( sender, args )
		if ( self.window:IsChecked() == true and barSettings.decorator ~= WINDOW_BAR_DECORATOR) then
			SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(barSettings.id, function(barSettings)
				barSettings.decorator = WINDOW_BAR_DECORATOR;
				return barSettings;
			end, function()
				self:DisplaySettings();
			end);
		end
	end

	self.checkbox:SetChecked(barSettings.decorators[self.decoratorStr].titleColor);

	self.utils:CreateCheckBoxCallback( self.checkbox, self.barId, { "decorators", self.decoratorStr, "titleColor" } );
	self.picker.LeftClick = function ()
		self.colorPreview:SetBackColor(self.picker:GetTurbineColor());

		local red, green, blue = self.picker:GetRGBColor();
		SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barId, function(barSettings)
			self.utils:BuildItemFromCommandTable( barSettings, { "decorators", self.decoratorStr, "titleColorR" }, red / 255 );
			self.utils:BuildItemFromCommandTable( barSettings, { "decorators", self.decoratorStr, "titleColorG" }, green / 255 );
			self.utils:BuildItemFromCommandTable( barSettings, { "decorators", self.decoratorStr, "titleColorB" }, blue / 255 );
			return barSettings;
		end);
	end
	self.utils:CreateScrollBarCallback( self.opacity, self.barId, { "decorators", self.decoratorStr, "titleColorA" }, nil, 150);
	self.opacity:SetValue( barSettings.decorators[self.decoratorStr].titleColorA * 100 );

	self.checkbox2:SetChecked(barSettings.decorators[self.decoratorStr].backColor);

	self.utils:CreateCheckBoxCallback( self.checkbox2, self.barId, { "decorators", self.decoratorStr, "backColor" } );
	self.picker2.LeftClick = function ()
		self.colorPreview2:SetBackColor(self.picker2:GetTurbineColor());

		local red, green, blue = self.picker2:GetRGBColor();
		SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barId, function(barSettings)
			self.utils:BuildItemFromCommandTable( barSettings, { "decorators", self.decoratorStr, "backColorR" }, red / 255 );
			self.utils:BuildItemFromCommandTable( barSettings, { "decorators", self.decoratorStr, "backColorG" }, green / 255 );
			self.utils:BuildItemFromCommandTable( barSettings, { "decorators", self.decoratorStr, "backColorB" }, blue / 255 );
			return barSettings;
		end);
	end
	self.utils:CreateScrollBarCallback( self.opacity2, self.barId, { "decorators", self.decoratorStr, "backColorA" }, nil, 150);
	self.opacity2:SetValue( barSettings.decorators[self.decoratorStr].backColorA * 100 );


end

function DecoratorPanel:EnableTriggers(enabled)
end
