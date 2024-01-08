-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

MenuService = class( MysticBars.Utils.Service );

MenuService.Log = MysticBars.Utils.Logging.LogManager.GetLogger( "MenuService" );

function MenuService:Constructor()
	self.Log:Debug("Constructor");

	self.menu = MysticBars.Menus.MainMenu();
end

function MenuService:SetSelection(selection)
	self.Log:Debug("SetSelection");

	self.selected = selection;
end

function MenuService:GetSelection()
	self.Log:Debug("GetSelection");

	return self.selected;
end

function MenuService:GetMenu()
	self.Log:Debug("GetMenu");

	return self.menu;
end
