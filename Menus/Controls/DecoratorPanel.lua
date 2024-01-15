-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

DecoratorPanel = class(MysticBars.Menus.Controls.BasePanel);

DecoratorPanel.Log = MysticBars.Utils.Logging.LogManager.GetLogger("DecoratorPanel");

function DecoratorPanel:Constructor(barId, barSettings)
	MysticBars.Menus.Controls.BasePanel.Constructor(self, barSettings.id, barSettings);

	self:SetHeight(160);

	if (barSettings.barType ~= EXTENSIONBAR) then

		self.tabbed = self.utils:AddButton(self.panelBackground, L["Tabbed Bar"], buttonWidth, selectionHeight, function(sender, args)
			SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barId, function(barSettings)
				barSettings.decorator = TAB_BAR_DECORATOR;
				self:SetTabVisibility(true);
				self:SetWindowVisibility(false);
				return barSettings;
			end);
		end, 5, 5);
		self.window = self.utils:AddButton(self.panelBackground, L["Window Bar"], buttonWidth, selectionHeight, function(sender, args)
			SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barId, function(barSettings)
				barSettings.decorator = WINDOW_BAR_DECORATOR;
				self:SetTabVisibility(false);
				self:SetWindowVisibility(true);
				return barSettings;
			end);
		end, 100, 5);

		self.tab_checkbox, self.tab_picker, self.tab_colorPreview, self.tab_colorPrevBorder, self.tab_opacity = self.utils:AddColorPicker(self.panelBackground, L["Bar Title Color:"], 145, 30);
		self.tab_checkbox2, self.tab_picker2, self.tab_colorPreview2, self.tab_colorPrevBorder2, self.tab_opacity2 = self.utils:AddColorPicker(self.panelBackground, L["Bar Back Color:"], 145, 70);
	end

	self.window_checkbox, self.window_picker, self.window_colorPreview, self.window_colorPrevBorder, self.window_opacity = self.utils:AddColorPicker(self.panelBackground, L["Bar Title Color:"], 145, 30);
	self.window_checkbox2, self.window_picker2, self.window_colorPreview2, self.window_colorPrevBorder2, self.window_opacity2 = self.utils:AddColorPicker(self.panelBackground, L["Bar Back Color:"], 145, 70);

	if (barSettings.barType ~= EXTENSIONBAR) then
		if (barSettings.decorator == TAB_BAR_DECORATOR) then
			self:SetTabVisibility(true);
			self:SetWindowVisibility(false);
		else
			self:SetTabVisibility(false);
			self:SetWindowVisibility(true);
		end
	end
	self:Reload(barSettings);
end

function DecoratorPanel:SetTabVisibility(visibility)
	self.tabbed:SetEnabled(not visibility);
	self.tab_checkbox:SetVisible(visibility);
	self.tab_picker:SetVisible(visibility);
	self.tab_colorPreview:SetVisible(visibility);
	self.tab_colorPrevBorder:SetVisible(visibility);
	self.tab_opacity:SetVisible(visibility);
	self.tab_checkbox2:SetVisible(visibility);
	self.tab_picker2:SetVisible(visibility);
	self.tab_colorPreview2:SetVisible(visibility);
	self.tab_colorPrevBorder2:SetVisible(visibility);
	self.tab_opacity2:SetVisible(visibility);
end

function DecoratorPanel:SetWindowVisibility(visibility)
	self.window:SetEnabled(not visibility);
	self.tabbed:SetEnabled(visibility);
	self.window_checkbox:SetVisible(visibility);
	self.window_picker:SetVisible(visibility);
	self.window_colorPreview:SetVisible(visibility);
	self.window_colorPrevBorder:SetVisible(visibility);
	self.window_opacity:SetVisible(visibility);
	self.window_checkbox2:SetVisible(visibility);
	self.window_picker2:SetVisible(visibility);
	self.window_colorPreview2:SetVisible(visibility);
	self.window_colorPrevBorder2:SetVisible(visibility);
	self.window_opacity2:SetVisible(visibility);
end

function DecoratorPanel:Reload(barSettings)
	if (barSettings.barType ~= EXTENSIONBAR) then
		self:DisplaySettings("tab", self.tab_checkbox, self.tab_picker, self.tab_colorPreview, self.tab_opacity, 
								self.tab_checkbox2, self.tab_picker2, self.tab_colorPreview2, self.tab_opacity2);
	end
	self:DisplaySettings("window", self.window_checkbox, self.window_picker, self.window_colorPreview, self.window_opacity, 
								self.window_checkbox2, self.window_picker2, self.window_colorPreview2, self.window_opacity2);
end

function DecoratorPanel:DisplaySettings(decoratorStr, checkbox, picker, colorPreview, opacity, checkbox2, picker2, colorPreview2, opacity2)
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings( self.barId );

	checkbox:SetChecked(barSettings.decorators[decoratorStr].titleColor);

	self.utils:CreateCheckBoxCallback( checkbox, self.barId, { "decorators", decoratorStr, "titleColor" } );
	picker:SetColors(barSettings.decorators[decoratorStr].titleColorA, barSettings.decorators[decoratorStr].titleColorR, barSettings.decorators[decoratorStr].titleColorG, barSettings.decorators[decoratorStr].titleColorB);
	colorPreview:SetBackColor(Turbine.UI.Color(barSettings.decorators[decoratorStr].titleColorA, barSettings.decorators[decoratorStr].titleColorR, barSettings.decorators[decoratorStr].titleColorG, barSettings.decorators[decoratorStr].titleColorB));
	picker.LeftClick = function ()
		local red, green, blue = picker:GetRGBColor();
		SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barId, function(barSettings)
			self.utils:BuildItemFromCommandTable( barSettings, { "decorators", decoratorStr, "titleColorR" }, red / 255 );
			self.utils:BuildItemFromCommandTable( barSettings, { "decorators", decoratorStr, "titleColorG" }, green / 255 );
			self.utils:BuildItemFromCommandTable( barSettings, { "decorators", decoratorStr, "titleColorB" }, blue / 255 );
			colorPreview:SetBackColor(Turbine.UI.Color(barSettings.decorators[decoratorStr].titleColorA, red / 255, green / 255, blue / 255));
			return barSettings;
		end);
	end
	opacity:SetValue( barSettings.decorators[decoratorStr].titleColorA * 100 );
	opacity.ValueChanged = function( sender, args )
		SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barId, function(barSettings)
			self.utils:BuildItemFromCommandTable( barSettings, { "decorators", decoratorStr, "titleColorA" }, opacity:GetValue() / 100 );
			return barSettings;
		end, function()
			picker:LeftClick();
		end);
	end

	checkbox2:SetChecked(barSettings.decorators[decoratorStr].backColor);

	self.utils:CreateCheckBoxCallback( checkbox2, self.barId, { "decorators", decoratorStr, "backColor" } );
	picker2:SetColors(barSettings.decorators[decoratorStr].backColorA, barSettings.decorators[decoratorStr].backColorR, barSettings.decorators[decoratorStr].backColorG, barSettings.decorators[decoratorStr].backColorB);
	colorPreview2:SetBackColor(Turbine.UI.Color(barSettings.decorators[decoratorStr].backColorA, barSettings.decorators[decoratorStr].backColorR, barSettings.decorators[decoratorStr].backColorG, barSettings.decorators[decoratorStr].backColorB));
	picker2.LeftClick = function ()
		local red, green, blue = picker2:GetRGBColor();
		SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barId, function(barSettings)
			self.utils:BuildItemFromCommandTable( barSettings, { "decorators", decoratorStr, "backColorR" }, red / 255 );
			self.utils:BuildItemFromCommandTable( barSettings, { "decorators", decoratorStr, "backColorG" }, green / 255 );
			self.utils:BuildItemFromCommandTable( barSettings, { "decorators", decoratorStr, "backColorB" }, blue / 255 );
			colorPreview2:SetBackColor(Turbine.UI.Color(barSettings.decorators[decoratorStr].backColorA, red / 255, green / 255, blue / 255));
			return barSettings;
		end);
	end
	opacity2:SetValue( barSettings.decorators[decoratorStr].backColorA * 100 );
	opacity2.ValueChanged = function( sender, args )
		SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barId, function(barSettings)
			self.utils:BuildItemFromCommandTable( barSettings, { "decorators", decoratorStr, "backColorA" }, opacity2:GetValue() / 100 );
			return barSettings;
		end, function()
			picker2:LeftClick();
		end);
	end
end

function DecoratorPanel:EnableTriggers(enabled)
end
