-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine";
import "MyysticUI.Utils.Class";
import "MyysticUI.Menus.Core.UI.MenuUtils";

InventoryBarMenuPanel = class();

function InventoryBarMenuPanel:Draw()
	menu.contentBox:ClearItems();

	local title = MyysticUI.Menus.Core.UI.AutoListBox();
	local utils = MyysticUI.Menus.Core.UI.MenuUtils();

	utils:AddCategoryBox(title, "Inventory Bars");
	utils:AddLabelBox( title, "Click Add Bar to start using tonic bars or select an Windowed Bar to edit.", selectionWidth + 250, selectionHeight + 20 );

	menu.contentBox:AddItem( title );
end