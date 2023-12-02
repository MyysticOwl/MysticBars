-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

import "Turbine";
import "MyysticBars.Utils.Class";
import "MyysticBars.UI.MenuUtils";

InventoryBarMenuPanel = class();

function InventoryBarMenuPanel:Draw()
	menu.contentBox:ClearItems();

	local title = MyysticBars.UI.AutoListBox();
	local utils = MyysticBars.UI.MenuUtils();

	utils:AddCategoryBox(title, LOCALESTRINGS.InventoryMenu["Inventory Bars"]);
	utils:AddLabelBox( title, LOCALESTRINGS.InventoryMenu["Click Add Bar to start using tonic bars or select an Windowed Bar to edit."], selectionWidth + 250, selectionHeight + 20 );

	menu.contentBox:AddItem( title );
end