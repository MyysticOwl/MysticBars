-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "MyysticBars.Utils.Class";
import "MyysticBars.Utils.TableDump";
import "MyysticBars.UI.CheckBox";
import "MyysticBars.UI.ComboBox";
import "MyysticBars.UI.AutoListBox";
import "MyysticBars.UI.MenuUtils";
import "MyysticBars.TonicBars.Menu.Panels.Bars.BarMenuPanel";
import "MyysticBars.TonicBars.Menu.Panels.Bars.ExtensionBarMenuPanel";
import "MyysticBars.TonicBars.Menu.Panels.Menus.ExtensionsMenuPanel"

ManageBarsMenuItems = class();

ManageBarsMenuItems.panel = MyysticBars.TonicBars.Menu.Panels.Bars.BarMenuPanel();
ManageBarsMenuItems.menuItems = MyysticBars.TonicBars.Menu.Items.MainMenuItems();
ManageBarsMenuItems.extensionsPanel = MyysticBars.TonicBars.Menu.Panels.Menus.ExtensionsMenuPanel();
ManageBarsMenuItems.extensionsBarPanel = MyysticBars.TonicBars.Menu.Panels.Bars.ExtensionBarMenuPanel();
ManageBarsMenuItems.utils = MyysticBars.UI.MenuUtils();

function ManageBarsMenuItems:Constructor(mainMenu, parent)
	self:Refresh(mainMenu, parent)
end

function ManageBarsMenuItems:Refresh(mainMenu, parent)
	local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);

	menu = mainMenu;

	local bars = settingsService:GetBars( QUICKSLOTBAR );
	local extensions = settingsService:GetBars( EXTENSIONBAR );
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