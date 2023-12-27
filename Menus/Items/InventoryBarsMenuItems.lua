-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "MyysticUI.Utils.Class";
import "MyysticUI.Utils.TableDump";
import "MyysticUI.UI.ComboBox";
import "MyysticUI.UI.AutoListBox";
import "MyysticUI.UI.MenuUtils";
import "MyysticUI.Menus.Panels.Bars.InventoryMenuPanel";

InventoryBarsMenuItems = class();

InventoryBarsMenuItems.panel = MyysticUI.Menus.Panels.Bars.InventoryMenuPanel();
InventoryBarsMenuItems.menuItems = MyysticUI.Menus.Items.MainMenuItems();
InventoryBarsMenuItems.utils = MyysticUI.UI.MenuUtils();

function InventoryBarsMenuItems:Constructor(mainMenu, parent)
	self:Refresh(mainMenu, parent)
end

function InventoryBarsMenuItems:Refresh(mainMenu, parent)
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);

	menu = mainMenu;

	local tab_bars = settingsService:GetBars( TABBED_INV_BAR );
	for key, value in pairs (tab_bars) do
		self.menuItems:CreateIfExistsCheckedBarItem(parent, mainMenu, self.panel, key, value);
	end

	-- local window_bars = settingsService:GetBars( WINDOW_INV_BAR );
	-- for key, value in pairs (window_bars) do
	-- 	self.menuItems:CreateIfExistsCheckedBarItem(parent, mainMenu, self.panel, key, value);
	-- end

	self.menuItems:CreateNewTabInventoryBarItem(parent, mainMenu);
	--self.menuItems:CreateNewWindowInventoryBarItem(parent, mainMenu);
end