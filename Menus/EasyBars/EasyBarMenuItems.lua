-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "MyysticUI.Menus.MainMenuItems";
--import "MyysticUI.Menus.Core.UI.MenuUtils";

EasyBarMenuItems = class();

EasyBarMenuItems.menuItems = MyysticUI.Menus.MainMenuItems();
--EasyBarMenuItems.utils = MyysticUI.Menus.Core.UI.MenuUtils();

function EasyBarMenuItems:Constructor(mainMenu, parent)
	self.configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	self:Refresh(mainMenu, parent);
end

function EasyBarMenuItems:Refresh(mainMenu, parent)
	local easyBars = self.configurationService:GetEasyBars();
	local processingID = 0;
	if ( easyBars ~= nil ) then
		for key, value in pairs (easyBars) do
			processingID = processingID + 1;
			for key2, value2 in pairs (easyBars) do
				if ( value2.sortindex == processingID ) then
					local barId, bar = self.menuItems:GetBarMatch({["barName"] = key2 });
					if (bar == nil) then
						bar = { };
						bar.barName = key2;
					end

					self.menuItems:CreateBarNode(parent, barId);
				end
			end
		end
	end
end
