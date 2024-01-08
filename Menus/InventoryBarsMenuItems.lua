-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

InventoryBarsMenuItems = class();

InventoryBarsMenuItems.panel = MysticBars.Menus.InventoryMenuPanel();
InventoryBarsMenuItems.menuItems = MysticBars.Menus.MainMenuItems();
InventoryBarsMenuItems.utils = MysticBars.Menus.Core.UI.MenuUtils();

function InventoryBarsMenuItems:Constructor(mainMenu, parent)
	self:Refresh(mainMenu, parent)
end

function InventoryBarsMenuItems:Refresh(mainMenu, parent)
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

	local tab_bars = settingsService:GetBars( TABBED_INV_BAR );
	for key, value in pairs (tab_bars) do
		local node = MysticBars.Menus.Core.BarsTitleTreeNode(self.menuItems:GetBarName(key, value), 1, key, value);
		parent:GetChildNodes():Add(node);
		self.panel:Draw(node, key, value);
	end
end