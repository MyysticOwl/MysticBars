-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

GeneralMenuItems = class();

GeneralMenuItems.menuItems = MysticBars.Menus.MainMenuItems();

function GeneralMenuItems:Constructor(mainMenu, parent)
	self.templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	parent:GetChildNodes():Add(MysticBars.Menus.Controls.GeneralMenuPanel());
end