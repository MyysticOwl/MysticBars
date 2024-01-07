-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

MenuService = class( MysticBars.Utils.Service );

function MenuService:Constructor()
	self.menu = MysticBars.Menus.MainMenu();
end

function MenuService:SetSelection(selection)
	self.selected = selection;
end

function MenuService:GetSelection()
	return self.selected;
end

function MenuService:GetMenu()
	return self.menu;
end
