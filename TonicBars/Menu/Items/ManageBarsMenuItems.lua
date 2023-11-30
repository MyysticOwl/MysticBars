-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "Tonic.Utils.Class";
import "Tonic.Utils.TableDump";
import "Tonic.UI.CheckBox";
import "Tonic.UI.ComboBox";
import "Tonic.UI.AutoListBox";
import "Tonic.UI.MenuUtils";
import "Tonic.TonicBars.Menu.Panels.Bars.BarMenuPanel";
import "Tonic.TonicBars.Menu.Panels.Bars.ExtensionBarMenuPanel";
import "Tonic.TonicBars.Menu.Panels.Menus.ExtensionsMenuPanel"

ManageBarsMenuItems = class();

ManageBarsMenuItems.panel = Tonic.TonicBars.Menu.Panels.Bars.BarMenuPanel();
ManageBarsMenuItems.menuItems = Tonic.TonicBars.Menu.Items.MainMenuItems();
ManageBarsMenuItems.extensionsPanel = Tonic.TonicBars.Menu.Panels.Menus.ExtensionsMenuPanel();
ManageBarsMenuItems.extensionsBarPanel = Tonic.TonicBars.Menu.Panels.Bars.ExtensionBarMenuPanel();
ManageBarsMenuItems.utils = Tonic.UI.MenuUtils();

function ManageBarsMenuItems:Constructor(mainMenu, parent)
	self.settingsService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.SettingsService);

	self:Refresh(mainMenu, parent)
end

function ManageBarsMenuItems:Refresh(mainMenu, parent)
	menu = mainMenu;

	local bars = self.settingsService:GetBars( QUICKSLOTBAR );
	local extensions = self.settingsService:GetBars( EXTENSIONBAR );
	for key, value in pairs (bars) do
		local context = self.menuItems:CreateIfExistsCheckedBarItem(parent, mainMenu, self.panel, key, value);

		for extKey, extValue in pairs (extensions) do
			if (extValue.barType == EXTENSIONBAR and extValue.connectionBarID == key) then
				self.menuItems:CreateCheckedBarItem(context["node"], mainMenu, self.extensionsBarPanel, extKey, extValue);
			end
		end
	end

	self.menuItems:CreateNewBarItem(parent, mainMenu);
	self.menuItems:CreateNewExtensionItem(parent, self.extensionsPanel);
end