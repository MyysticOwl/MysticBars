-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "Tonic.Utils.Class";
import "Tonic.UI.CheckBox";
import "Tonic.UI.ComboBox";
import "Tonic.UI.AutoListBox";
import "Tonic.UI.MenuUtils";
import "Tonic.TonicBars.Menu.Items.MainMenuItems";
import "Tonic.TonicBars.Menu.Panels.Bars.BarMenuPanel";

EasyBarMenuItems = class();

EasyBarMenuItems.panel = Tonic.TonicBars.Menu.Panels.Bars.BarMenuPanel();
EasyBarMenuItems.menuItems = Tonic.TonicBars.Menu.Items.MainMenuItems();
EasyBarMenuItems.utils = Tonic.UI.MenuUtils();

function EasyBarMenuItems:Constructor(mainMenu, parent)
	self.configurationService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.ConfigurationService);

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

					self.menuItems:CreateCheckedBarItem(parent, mainMenu, self.panel, barId, value2);
				end
			end
		end
	end
end
