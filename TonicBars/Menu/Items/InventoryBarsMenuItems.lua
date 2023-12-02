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
import "MyysticBars.TonicBars.Menu.Panels.Bars.InventoryMenuPanel";

InventoryBarsMenuItems = class();

InventoryBarsMenuItems.panel = MyysticBars.TonicBars.Menu.Panels.Bars.InventoryMenuPanel();
InventoryBarsMenuItems.menuItems = MyysticBars.TonicBars.Menu.Items.MainMenuItems();
InventoryBarsMenuItems.utils = MyysticBars.UI.MenuUtils();

function InventoryBarsMenuItems:Constructor(mainMenu, parent)
	self:Refresh(mainMenu, parent)
end

function InventoryBarsMenuItems:Refresh(mainMenu, parent)
	local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);

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
	-- self.menuItems:CreateNewWindowInventoryBarItem(parent, mainMenu);
end