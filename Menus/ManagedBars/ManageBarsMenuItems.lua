-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "MyysticUI.Menus.ManagedBars.ManageBarsMenuPanel";

ManageBarsMenuItems = class();

ManageBarsMenuItems.panel = MyysticUI.Menus.ManagedBars.ManageBarsMenuPanel();
ManageBarsMenuItems.menuItems = MyysticUI.Menus.MainMenuItems();
ManageBarsMenuItems.extensionsBarPanel = MyysticUI.Menus.ManagedBars.ExtensionBarMenuPanel();
ManageBarsMenuItems.utils = MyysticUI.Menus.Core.UI.MenuUtils();

function ManageBarsMenuItems:Constructor(mainMenu, parent)
	self:Refresh(mainMenu, parent)
end

function ManageBarsMenuItems:Refresh(mainMenu, parent)
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);

	menu = mainMenu;

	local bars = settingsService:GetBars( QUICKSLOTBAR );
	local extensions = settingsService:GetBars( EXTENSIONBAR );
	for key, value in pairs (bars) do
		local node = MyysticUI.Menus.Core.BarsTitleTreeNode(self.menuItems:GetBarName(key, value), 1, key, value);
		parent:GetChildNodes():Add(node);
		self.panel:Draw(node, key, value);

		for extKey, extValue in pairs (extensions) do
			if (extValue.barType == EXTENSIONBAR and extValue.connectionBarID == key) then
				local node = MyysticUI.Menus.Core.BarsTitleTreeNode(self.menuItems:GetBarName(extKey, extValue), 1);
				parent:GetChildNodes():Add(node);
				self.extensionsBarPanel:Draw(node, extKey, extValue);
			end
		end
	end
end