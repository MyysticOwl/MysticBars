-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine";
import "MyysticUI.Utils.Class";
import "MyysticUI.Menus.Core.UI.MenuUtils";
import "MyysticUI.Menus.Controls.ExtensionGeneralPanel"
import "MyysticUI.Menus.Controls.PredefinedExtensionPanel"

ExtensionBarMenuPanel = class();

ExtensionBarMenuPanel.utils = MyysticUI.Menus.Core.UI.MenuUtils();

function ExtensionBarMenuPanel:Draw(parentNode, barId, barValue)

	-- -----------------------   SLOTS	  0000000000000000000000000000
	parentNode:GetChildNodes():Add(MyysticUI.Menus.Controls.SlotsPanel(barId, barValue, true));

	-----------------------   SLOTS	  0000000000000000000000000000
	parentNode:GetChildNodes():Add(MyysticUI.Menus.Controls.PredefinedExtensionPanel(barId, barValue));

	-- -----------------------   COLOR  0000000000000000000000000000
	parentNode:GetChildNodes():Add(MyysticUI.Menus.Controls.ColorPanel(barId, barValue));
end