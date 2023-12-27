-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine";
import "MyysticUI.Utils.Class";
import "MyysticUI.UI.MenuUtils";

ManageBarsMenuPanel = class();

function ManageBarsMenuPanel:Draw()
	menu.contentBox:ClearItems();

	local title = MyysticUI.UI.AutoListBox();
	local utils = MyysticUI.UI.MenuUtils();

	utils:AddCategoryBox(title, "Manage Bars");
	utils:AddLabelBox( title, "This menu is used to create complicated bars, very easily. Often getting everything setup on your bar takes a lot of time. Hopefully this helps you get where you want to go easier.", selectionWidth + 250, selectionHeight + 20 );

	menu.contentBox:AddItem( title );
end