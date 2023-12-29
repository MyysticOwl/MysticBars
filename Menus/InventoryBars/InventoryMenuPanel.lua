-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine";
import "MyysticUI.Utils.Class";
import "MyysticUI.Menus.Core.UI.MenuUtils";
import "MyysticUI.Menus.Controls.BasePanel"
import "MyysticUI.Menus.Controls.SlotsPanel"
import "MyysticUI.Menus.Controls.ClassBuffPanel"
import "MyysticUI.Menus.Controls.InventoryPanel"
import "MyysticUI.Menus.Controls.TriggersPanel"
import "MyysticUI.Menus.Controls.ColorPanel"

InventoryMenuPanel = class();

InventoryMenuPanel.utils = MyysticUI.Menus.Core.UI.MenuUtils();

function InventoryMenuPanel:Draw(context)
	menu.contentBox:ClearItems();

	self.utils:AddCategoryBox(menu.contentBox, context.barName);

	-----------------------   INVENTORY  0000000000000000000000000000
	self.inventoryPanel = MyysticUI.Menus.Controls.InventoryPanel( menu.contentBox );

	-----------------------   TRIGGERS  0000000000000000000000000000
	self.tp = MyysticUI.Menus.Controls.TriggersPanel( menu.contentBox );

	-----------------------   CLASS BUFF TRIGGERS  0000000000000000000000000000
	self.slotsPanel = MyysticUI.Menus.Controls.SlotsPanel( menu.contentBox, true );

	-----------------------   COLOR TRIGGERS  0000000000000000000000000000
	self.colorPanel = MyysticUI.Menus.Controls.ColorPanel( menu.contentBox );

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
	self.colorPanel:DisplaySettings();
end