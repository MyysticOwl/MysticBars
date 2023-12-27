-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine";
import "MyysticUI.Utils.Class";
import "MyysticUI.Core.UI.MenuUtils";

EasyBarMenuPanel = class();

function EasyBarMenuPanel:Draw()
	menu.contentBox:ClearItems();

	local title = MyysticUI.Core.UI.AutoListBox();
	local utils = MyysticUI.Core.UI.MenuUtils();

	utils:AddCategoryBox(title, "Create Bars Quickly");
	utils:AddLabelBox( title, "This menu is used to create complicated bars, very easily. Often getting everything setup on your bar takes a lot of time. Hopefully this helps you get where you want to go easier.", selectionWidth + 250, selectionHeight + 20 );

	menu.contentBox:AddItem( title );
end