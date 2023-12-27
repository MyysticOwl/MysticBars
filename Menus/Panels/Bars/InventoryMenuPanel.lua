-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine";
import "MyysticUI.Utils.Class";
import "MyysticUI.UI.MenuUtils";
import "MyysticUI.Menus.Panels.Controls.GeneralPanel"
import "MyysticUI.Menus.Panels.Controls.SlotsPanel"
import "MyysticUI.Menus.Panels.Controls.ClassBuffPanel"
import "MyysticUI.Menus.Panels.Controls.InventoryPanel"
import "MyysticUI.Menus.Panels.Controls.TriggersPanel"
import "MyysticUI.Menus.Panels.Controls.ColorPanel"

InventoryMenuPanel = class();

InventoryMenuPanel.utils = MyysticUI.UI.MenuUtils();

function InventoryMenuPanel:Draw(context)
	menu.contentBox:ClearItems();

	self.utils:AddCategoryBox(menu.contentBox, context.barName);

	-----------------------   GENERAL  0000000000000000000000000000
	self.generalPanel = MyysticUI.Menus.Panels.Controls.GeneralPanel( menu.contentBox );

	-----------------------   INVENTORY  0000000000000000000000000000
	self.inventoryPanel = MyysticUI.Menus.Panels.Controls.InventoryPanel( menu.contentBox );

	-----------------------   TRIGGERS  0000000000000000000000000000
	self.tp = MyysticUI.Menus.Panels.Controls.TriggersPanel( menu.contentBox );

	-----------------------   CLASS BUFF TRIGGERS  0000000000000000000000000000
	self.slotsPanel = MyysticUI.Menus.Panels.Controls.SlotsPanel( menu.contentBox, true );

	-----------------------   COLOR TRIGGERS  0000000000000000000000000000
	self.colorPanel = MyysticUI.Menus.Panels.Controls.ColorPanel( menu.contentBox );

	self:DisplaySettings();
end

function InventoryMenuPanel:DisplaySettings()
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
	local localBarSettings = settingsService:GetBarSettings( menu:GetSelection() );

	if ( localBarSettings.events == nil ) then
		localBarSettings.events = { };
	end

	self.tp:DisplaySettings();
	self.inventoryPanel:DisplaySettings();
	self.slotsPanel:DisplaySettings();
	self.generalPanel:DisplaySettings();
	self.colorPanel:DisplaySettings();
end