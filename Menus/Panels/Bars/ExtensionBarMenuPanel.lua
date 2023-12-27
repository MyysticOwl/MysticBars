-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine";
import "MyysticUI.Utils.Class";
import "MyysticUI.Core.UI.MenuUtils";
import "MyysticUI.Menus.Panels.Controls.ExtensionGeneralPanel"
import "MyysticUI.Menus.Panels.Controls.PredefinedExtensionPanel"

ExtensionBarMenuPanel = class();

ExtensionBarMenuPanel.utils = MyysticUI.Core.UI.MenuUtils();

function ExtensionBarMenuPanel:Draw(context)
	menu.contentBox:ClearItems();

	self.utils:AddCategoryBox(menu.contentBox, context.barName);

	-----------------------   GENERAL  0000000000000000000000000000
	self.generalPanel = MyysticUI.Menus.Panels.Controls.ExtensionGeneralPanel( menu.contentBox, menu );
	-----------------------   SLOTS	  0000000000000000000000000000
	self.slotsPanel = MyysticUI.Menus.Panels.Controls.SlotsPanel( menu.contentBox, false, nil, menu );
	-----------------------   SLOTS	  0000000000000000000000000000
	self.predefinedPanel = MyysticUI.Menus.Panels.Controls.PredefinedExtensionPanel( menu.contentBox, menu );
	-----------------------   COLOR  0000000000000000000000000000
	self.colorPanel = MyysticUI.Menus.Panels.Controls.ColorPanel( menu.contentBox, menu );

	self:DisplaySettings();
end

function ExtensionBarMenuPanel:DisplaySettings()
	self.generalPanel:DisplaySettings();
	self.slotsPanel:DisplaySettings();
	self.predefinedPanel:DisplaySettings();
end