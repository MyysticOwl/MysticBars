-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "MyysticUI.Menus.MainMenuItems";

EasyBarMenuItems = class();

EasyBarMenuItems.menuItems = MyysticUI.Menus.MainMenuItems();

function EasyBarMenuItems:Constructor(mainMenu, parent)
	self.configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	parent:GetChildNodes():Add(MyysticUI.Menus.EasyBars.EasyBarPanel());
end