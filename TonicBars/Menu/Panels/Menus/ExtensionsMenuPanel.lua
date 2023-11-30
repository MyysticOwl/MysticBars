-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

import "Turbine";
import "Tonic.Utils.Class";
import "Tonic.UI.MenuUtils";

ExtensionsMenuPanel = class();

function ExtensionsMenuPanel:Draw()
	menu.contentBox:ClearItems();

	local title = Tonic.UI.AutoListBox();
	local utils = Tonic.UI.MenuUtils();

	utils:AddCategoryBox(title, LOCALESTRINGS.ExtensionsMenu["Extensions"]);
	utils:AddLabelBox( title, LOCALESTRINGS.ExtensionsMenu["Extensions work different than QuickBars. To add an Extension, just right click on the quickslot to extend. Then select the orientation."], selectionWidth + 250, selectionHeight + 20 );

	menu.contentBox:AddItem( title );
end
