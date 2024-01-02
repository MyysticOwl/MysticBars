-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine";
import "MysticBars.Utils.Class";
import "MysticBars.Menus.Core.UI.MenuUtils";
import "MysticBars.Menus.Controls.ExtensionPanel"
import "MysticBars.Menus.Controls.PredefinedExtensionPanel"

ExtensionBarMenuPanel = class();

ExtensionBarMenuPanel.utils = MysticBars.Menus.Core.UI.MenuUtils();

function ExtensionBarMenuPanel:Draw(parentNode, barId, barValue)

	-- -----------------------   SLOTS	  0000000000000000000000000000
	parentNode:GetChildNodes():Add(MysticBars.Menus.Controls.SlotsPanel(barId, barValue, true));

	-----------------------   SLOTS	  0000000000000000000000000000
	parentNode:GetChildNodes():Add(MysticBars.Menus.Controls.ExtensionPanel(barId, barValue));

	-----------------------   SLOTS	  0000000000000000000000000000
	parentNode:GetChildNodes():Add(MysticBars.Menus.Controls.PredefinedExtensionPanel(barId, barValue));

	-- -----------------------   COLOR  0000000000000000000000000000
	parentNode:GetChildNodes():Add(MysticBars.Menus.Controls.ColorPanel(barId, barValue));
end