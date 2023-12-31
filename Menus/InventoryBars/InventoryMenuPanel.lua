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

function InventoryMenuPanel:Draw(parentNode, barId, barValue)

	-- -----------------------   TRIGGERS  0000000000000000000000000000
	parentNode:GetChildNodes():Add(MyysticUI.Menus.Controls.InventoryPanel(barId, barValue));

	-- -----------------------   TRIGGERS  0000000000000000000000000000
	parentNode:GetChildNodes():Add(MyysticUI.Menus.Controls.TriggersPanel(barId, barValue));

	-- -----------------------   SLOTS	  0000000000000000000000000000
	parentNode:GetChildNodes():Add(MyysticUI.Menus.Controls.SlotsPanel(barId, barValue));

	-- -----------------------   COLOR  0000000000000000000000000000
	parentNode:GetChildNodes():Add(MyysticUI.Menus.Controls.ColorPanel(barId, barValue));
end