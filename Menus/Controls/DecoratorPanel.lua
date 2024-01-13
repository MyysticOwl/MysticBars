-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

DecoratorPanel = class(MysticBars.Menus.Controls.BasePanel);

function DecoratorPanel:Constructor(barId, barSettings)
	MysticBars.Menus.Controls.BasePanel.Constructor(self, barSettings.id, barSettings);

	self:SetHeight(40);
	self.barSettings = barSettings;

	self.tabbed  = self.utils:AddCheckBox( self.panelBackground, L["Tabbed Bar"], selectionWidth + 150, selectionHeight, nil, 5, 5 );
	self.tabbed:SetChecked(self.barSettings.decorator == TAB_BAR_DECORATOR);
	self.window  = self.utils:AddCheckBox( self.panelBackground, L["Window Bar"], selectionWidth + 150, selectionHeight, nil, 150, 5 );
	self.window:SetChecked(self.barSettings.decorator == WINDOW_BAR_DECORATOR);

	self:DisplaySettings();
end

function DecoratorPanel:DisplaySettings()
	self.tabbed.CheckedChanged = function( sender, args )
		SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barSettings.id, function(barSettings)
			if ( self.tabbed:IsChecked() == true ) then
				barSettings.decorator = TAB_BAR_DECORATOR;
				self.window:SetChecked(false);
			else
				barSettings.decorator = WINDOW_BAR_DECORATOR;
				self.window:SetChecked(true);
			end
			return barSettings;
		end);
	end
	self.window.CheckedChanged = function( sender, args )
		SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barSettings.id, function(barSettings)
			if ( self.window:IsChecked() == true ) then
				barSettings.decorator = WINDOW_BAR_DECORATOR;
				self.tabbed:SetChecked(false);
			else
				barSettings.decorator = TAB_BAR_DECORATOR;
				self.tabbed:SetChecked(true);
			end
			return barSettings;
		end);
	end
end

function DecoratorPanel:EnableTriggers(enabled)
end
