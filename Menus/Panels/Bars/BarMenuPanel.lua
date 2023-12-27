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

BarMenuPanel = class();

BarMenuPanel.utils = MyysticUI.UI.MenuUtils();

function BarMenuPanel:Draw(context)
	menu.contentBox:ClearItems();

	self.utils:AddCategoryBox(menu.contentBox, context.barName);

	-----------------------   GENERAL  0000000000000000000000000000
	self.generalPanel = MyysticUI.Menus.Panels.Controls.GeneralPanel( menu.contentBox );

	-----------------------   SLOTS	  0000000000000000000000000000
	self.slotsPanel = MyysticUI.Menus.Panels.Controls.SlotsPanel( menu.contentBox, true );

	-----------------------   COLOR  0000000000000000000000000000
	self.colorPanel = MyysticUI.Menus.Panels.Controls.ColorPanel( menu.contentBox );

	-----------------------   TRIGGERS  0000000000000000000000000000
	self.tp = MyysticUI.Menus.Panels.Controls.TriggersPanel( menu.contentBox );

	-----------------------   CLASS BUFF TRIGGERS  0000000000000000000000000000
	self.classBuffPanel = MyysticUI.Menus.Panels.Controls.ClassBuffPanel( menu.contentBox );

	self:DisplaySettings();
end

function BarMenuPanel:DisplaySettings()
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
	local localBarSettings = settingsService:GetBarSettings( menu:GetSelection() );
	if ( localBarSettings.events == nil ) then
		localBarSettings.events = { };
	end

	self.tp:DisplaySettings();
	self.classBuffPanel:DisplaySettings();
	self.slotsPanel:DisplaySettings();
	self.generalPanel:DisplaySettings();
	self.colorPanel:DisplaySettings();
end