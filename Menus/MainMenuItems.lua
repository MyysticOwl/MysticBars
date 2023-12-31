-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "MyysticUI.Utils.Class";
import "MyysticUI.Menus.Core.UI.ComboBox";
import "MyysticUI.Menus.Core.UI.AutoListBox";
import "MyysticUI.Menus.Core.UI.MenuUtils";

MainMenuItems = class();

MainMenuItems.utils = MyysticUI.Menus.Core.UI.MenuUtils();

function MainMenuItems:NewContext(parent, barId, barName, width)
	return {
		["parent"] = parent,
		["id"] = tonumber(barId),
		["barName"] = barName,
		["width"] = width
	};
end

function MainMenuItems:GetBarName(barId, bar)
	if (bar == nil) then
		return ""
	end

	local text = bar.barName;
	if (text == nil) then
		if (bar.barname ~= nil) then
			text = bar.barname;
		elseif (bar.barType ~= nil and bar.barType == 1 or bar.barType == 3) then
			text = "Bar: " .. barId;
		else
			text = "Ext Bar: " .. barId;
		end
	end
	return text;
end

function MainMenuItems:GetBarMatch(context)
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);

	for key, value in opairs (settingsService:GetBars()) do
		if (value.barName == context["barName"] and value.barName ~=nil) then
			return key, value;
		end
		if (key == context["id"]) then
			return key, value;
		end
	end
end