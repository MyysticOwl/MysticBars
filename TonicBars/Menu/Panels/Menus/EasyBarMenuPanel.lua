-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

import "Turbine";
import "Tonic.Utils.Class";
import "Tonic.UI.MenuUtils";

EasyBarMenuPanel = class();

function EasyBarMenuPanel:Draw()
	menu.contentBox:ClearItems();

	local title = Tonic.UI.AutoListBox();
	local utils = Tonic.UI.MenuUtils();

	utils:AddCategoryBox(title, LOCALESTRINGS.EasyBarMenu["Create Bars Quickly"]);
	utils:AddLabelBox( title, LOCALESTRINGS.EasyBarMenu["This menu is used to create complicated bars, very easily. Often getting everything setup on your bar takes a lot of time. Hopefully this helps you get where you want to go easier."], selectionWidth + 250, selectionHeight + 20 );

	menu.contentBox:AddItem( title );
end