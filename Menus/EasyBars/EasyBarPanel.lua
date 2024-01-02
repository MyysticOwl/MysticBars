-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "MysticBars.Menus.Core.UI.AutoListBox";
import "MysticBars.Menus.Core.UI.MenuUtils";
import "MysticBars.Menus.Controls.BasePanel";

EasyBarPanel = class(MysticBars.Menus.Controls.BasePanel);

EasyBarPanel.menuItems = MysticBars.Menus.MainMenuItems();

function EasyBarPanel:Constructor()
	MysticBars.Menus.Controls.BasePanel.Constructor(self, nil, nil);

	self.templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);
	local easyBars = self.templateService:GetEasyBars();
	local column = 0;
	local row = 0;
	local leftPad = 160;
	local topPad = 30;

	if ( easyBars ~= nil ) then
		for key, value in pairs (easyBars) do
			local left = 5 + (leftPad * column);
			local top = 5 + (topPad * row);
			column = column + 1;

			if (column == 3) then
				column = 0;
				row = row + 1;
			end

			local barName = self.menuItems:GetBarName(key, value);
			local easycheck = self.utils:AddCheckBox( self.panelBackground, barName, selectionWidth, selectionHeight, nil, left, top );

			local id, actualBar = self:GetBarMatch(barName);
			if ( actualBar ~= nil ) then
				easycheck:SetChecked(true);
			end

			easycheck.CheckedChanged = function (args)
				local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
				local menuService = SERVICE_CONTAINER:GetService(MysticBars.Services.MenuService);

				local id, actualBar = self:GetBarMatch(barName);
				if ( actualBar ~= nil ) then
					barService:Remove( id );
				else
					local id = value.callback( self, true );
					barService:LoadQuickslots();
					barService:RefreshBars();
					menuService:GetMenu():Refresh(true);
					SERVICE_CONTAINER:GetService(MysticBars.Services.InventoryService):NotifyClients();
				end
			end
		end
	end

	self:SetHeight(row * 40);

	self:DisplaySettings();
end

function EasyBarPanel:DisplaySettings()

end

function EasyBarPanel:EnableTriggers(enabled)
end

function EasyBarPanel:GetBarMatch(barName)
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

	for key, value in opairs (settingsService:GetBars()) do
		if (value.barName == barName and value.barName ~= nil) then
			return key, value;
		end
	end
end