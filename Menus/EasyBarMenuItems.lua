-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

EasyBarMenuItems = class();

EasyBarMenuItems.menuItems = MysticBars.Menus.MainMenuItems();

function EasyBarMenuItems:Constructor(mainMenu, parent)
	self.templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	parent:GetChildNodes():Add(MysticBars.Menus.Controls.EasyBarPanel());
end