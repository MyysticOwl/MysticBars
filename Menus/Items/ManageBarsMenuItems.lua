-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "MyysticUI.Menus.Panels.Bars.BarMenuPanel";
import "MyysticUI.Menus.Panels.Bars.ExtensionBarMenuPanel";
import "MyysticUI.Menus.Panels.Menus.ExtensionsMenuPanel"

ManageBarsMenuItems = class();

ManageBarsMenuItems.panel = MyysticUI.Menus.Panels.Bars.BarMenuPanel();
ManageBarsMenuItems.menuItems = MyysticUI.Menus.Items.MainMenuItems();
ManageBarsMenuItems.extensionsPanel = MyysticUI.Menus.Panels.Menus.ExtensionsMenuPanel();
ManageBarsMenuItems.extensionsBarPanel = MyysticUI.Menus.Panels.Bars.ExtensionBarMenuPanel();
ManageBarsMenuItems.utils = MyysticUI.Core.UI.MenuUtils();

function ManageBarsMenuItems:Constructor(mainMenu, parent)
	self:Refresh(mainMenu, parent)
end

function ManageBarsMenuItems:Refresh(mainMenu, parent)
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);

	menu = mainMenu;

	local bars = settingsService:GetBars( QUICKSLOTBAR );
	local extensions = settingsService:GetBars( EXTENSIONBAR );
	for key, value in pairs (bars) do
		local context = self.menuItems:CreateIfExistsBarNode(parent, mainMenu, self.panel, key, value);

		for extKey, extValue in pairs (extensions) do
			if (extValue.barType == EXTENSIONBAR and extValue.connectionBarID == key) then
				self.menuItems:CreateBarNode(context["node"], mainMenu, self.extensionsBarPanel, extKey, extValue);
			end
		end
	end

	self.menuItems:CreateNewBarItem(parent, mainMenu);
	self.menuItems:CreateNewExtensionItem(parent, self.extensionsPanel);
end