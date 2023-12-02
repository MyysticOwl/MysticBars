-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

import "Turbine";
import "MyysticBars.Utils.Class";
import "MyysticBars.UI.MenuUtils";
import "MyysticBars.TonicBars.Menu.Panels.Controls.GeneralPanel"
import "MyysticBars.TonicBars.Menu.Panels.Controls.SlotsPanel"
import "MyysticBars.TonicBars.Menu.Panels.Controls.ClassBuffPanel"
import "MyysticBars.TonicBars.Menu.Panels.Controls.InventoryPanel"
import "MyysticBars.TonicBars.Menu.Panels.Controls.TriggersPanel"
import "MyysticBars.TonicBars.Menu.Panels.Controls.ColorPanel"

InventoryMenuPanel = class();

InventoryMenuPanel.utils = MyysticBars.UI.MenuUtils();

function InventoryMenuPanel:Draw(context)
	menu.contentBox:ClearItems();

	self.utils:AddCategoryBox(menu.contentBox, context.barName);

	-----------------------   GENERAL  0000000000000000000000000000
	self.generalPanel = MyysticBars.TonicBars.Menu.Panels.Controls.GeneralPanel( menu.contentBox );

	-----------------------   INVENTORY  0000000000000000000000000000
	self.inventoryPanel = MyysticBars.TonicBars.Menu.Panels.Controls.InventoryPanel( menu.contentBox );

	-----------------------   TRIGGERS  0000000000000000000000000000
	self.tp = MyysticBars.TonicBars.Menu.Panels.Controls.TriggersPanel( menu.contentBox );

	-----------------------   CLASS BUFF TRIGGERS  0000000000000000000000000000
	self.slotsPanel = MyysticBars.TonicBars.Menu.Panels.Controls.SlotsPanel( menu.contentBox, true );

	-----------------------   COLOR TRIGGERS  0000000000000000000000000000
	self.colorPanel = MyysticBars.TonicBars.Menu.Panels.Controls.ColorPanel( menu.contentBox );

	self:DisplaySettings();
end

function InventoryMenuPanel:DisplaySettings()
	local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);
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