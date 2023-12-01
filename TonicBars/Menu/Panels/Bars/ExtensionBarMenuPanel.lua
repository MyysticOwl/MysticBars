-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

import "Turbine";
import "MyysticBars.Utils.Class";
import "MyysticBars.UI.MenuUtils";
import "MyysticBars.TonicBars.Menu.Panels.Controls.ExtensionGeneralPanel"
import "MyysticBars.TonicBars.Menu.Panels.Controls.PredefinedExtensionPanel"

ExtensionBarMenuPanel = class();

ExtensionBarMenuPanel.utils = MyysticBars.UI.MenuUtils();

function ExtensionBarMenuPanel:Draw(context)
	menu.contentBox:ClearItems();

	self.utils:AddCategoryBox(menu.contentBox, context.barName);

	-----------------------   GENERAL  0000000000000000000000000000
	self.generalPanel = MyysticBars.TonicBars.Menu.Panels.Controls.ExtensionGeneralPanel( menu.contentBox, menu );
	-----------------------   SLOTS	  0000000000000000000000000000
	self.slotsPanel = MyysticBars.TonicBars.Menu.Panels.Controls.SlotsPanel( menu.contentBox, false, nil, menu );
	-----------------------   SLOTS	  0000000000000000000000000000
	self.predefinedPanel = MyysticBars.TonicBars.Menu.Panels.Controls.PredefinedExtensionPanel( menu.contentBox, menu );
	-----------------------   COLOR  0000000000000000000000000000
	self.colorPanel = MyysticBars.TonicBars.Menu.Panels.Controls.ColorPanel( menu.contentBox, menu );

	self:DisplaySettings();
end

function ExtensionBarMenuPanel:DisplaySettings()
	self.generalPanel:DisplaySettings();
	self.slotsPanel:DisplaySettings();
	self.predefinedPanel:DisplaySettings();
end