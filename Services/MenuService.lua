-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine.Gameplay";
import "Turbine.UI";
import "MysticBars.Utils.Class";
import "MysticBars.Utils.Service";
import "MysticBars.Utils.Table";
import "MysticBars.Bars.Events.BuffEvents";
import "MysticBars.Bars.Events.KeyEvents";
import "MysticBars.Bars.Events.StatEvents";
import "MysticBars.Bars.Events.ClassSpecificEvents";
import "MysticBars.Bars.Events.MiscEvents";
import "MysticBars.Services.SettingsService"

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
