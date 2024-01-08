-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

ManageBarsMenuItems = class();

ManageBarsMenuItems.panel = MysticBars.Menus.ManageBarsMenuPanel();
ManageBarsMenuItems.menuItems = MysticBars.Menus.MainMenuItems();
ManageBarsMenuItems.extensionsBarPanel = MysticBars.Menus.ExtensionBarMenuPanel();
ManageBarsMenuItems.utils = MysticBars.Menus.Core.UI.MenuUtils();

function ManageBarsMenuItems:Constructor(mainMenu, parent)
	self:Refresh(mainMenu, parent)
end

function ManageBarsMenuItems:Refresh(mainMenu, parent)
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local eventService = SERVICE_CONTAINER:GetService(MysticBars.Services.EventService);

	menu = mainMenu;

	local bars = settingsService:GetBars( QUICKSLOTBAR );
	local extensions = settingsService:GetBars( EXTENSIONBAR );
	for key, value in pairs (bars) do
		local node = MysticBars.Menus.Core.BarsTitleTreeNode(self.menuItems:GetBarName(key, value), 1, key, value);
		parent:GetChildNodes():Add(node);
		self.panel:Draw(node, key, value, eventService.buffs);

		for extKey, extValue in pairs (extensions) do
			if (extValue.barType == EXTENSIONBAR and extValue.connectionBarID == key) then
				local node = MysticBars.Menus.Core.BarsTitleTreeNode(self.menuItems:GetBarName(extKey, extValue), 1, extKey);
				parent:GetChildNodes():Add(node);
				self.extensionsBarPanel:Draw(node, extKey, extValue);
			end
		end
	end
end