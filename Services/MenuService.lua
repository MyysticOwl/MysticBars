-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine.Gameplay";
import "Turbine.UI";
import "MyysticUI.Utils.Class";
import "MyysticUI.Utils.Service";
import "MyysticUI.Utils.Table";
import "MyysticUI.Bars.Events.BuffEvents";
import "MyysticUI.Bars.Events.KeyEvents";
import "MyysticUI.Bars.Events.StatEvents";
import "MyysticUI.Bars.Events.ClassSpecificEvents";
import "MyysticUI.Bars.Events.MiscEvents";
import "MyysticUI.Services.SettingsService"

MenuService = class( MyysticUI.Utils.Service );

function MenuService:Constructor()
	self.menu = MyysticUI.Menus.MainMenu();
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
