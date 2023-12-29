-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine";
import "MyysticUI.Utils.Class";
import "MyysticUI.Menus.Core.UI.MenuUtils";

ManageBarsMenuPanel = class();

ManageBarsMenuPanel.utils = MyysticUI.Menus.Core.UI.MenuUtils();

function ManageBarsMenuPanel:Draw(parentNode, barId, barValue)

	-- -----------------------   SLOTS	  0000000000000000000000000000
	parentNode:GetChildNodes():Add(MyysticUI.Menus.Controls.SlotsPanel(barId, barValue));

	-- -----------------------   COLOR  0000000000000000000000000000
	parentNode:GetChildNodes():Add(MyysticUI.Menus.Controls.ColorPanel(barId, barValue));

	-- -----------------------   TRIGGERS  0000000000000000000000000000
	parentNode:GetChildNodes():Add(MyysticUI.Menus.Controls.TriggersPanel(barId, barValue));

	-- -----------------------   CLASS BUFF TRIGGERS  0000000000000000000000000000
	parentNode:GetChildNodes():Add(MyysticUI.Menus.Controls.ClassBuffPanel(barId, barValue));

	self:DisplaySettings();
end

function ManageBarsMenuPanel:DisplaySettings()
	-- local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
	-- local localBarSettings = settingsService:GetBarSettings( menu:GetSelection() );
	-- if ( localBarSettings.events == nil ) then
	-- 	localBarSettings.events = { };
	-- end

	-- self.tp:DisplaySettings();
	-- self.classBuffPanel:DisplaySettings();
	-- self.slotsPanel:DisplaySettings();
	-- self.generalPanel:DisplaySettings();
	-- self.colorPanel:DisplaySettings();
end