-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

SlotsPanel = class(MysticBars.Menus.Controls.BasePanel);

function SlotsPanel:Constructor(barId, barValue, isExtension)
	MysticBars.Menus.Controls.BasePanel.Constructor(self, barId, barValue);

	self:SetHeight(80);

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local localBarSettings = settingsService:GetBarSettings(self.barId);

	if (isExtension == nil) then
		isExtension = false;
	end

	self.isExtension = isExtension;

	if (self.isExtension == false and localBarSettings.barType ~= INVENTORY_BAR) then
		self.sb = self.utils:AddScrollBar(self.panelBackground, 1, 1, 100, 200, selectionHeight + 20, nil, L["Rows:"], 5, 5,
			5);
		self.sb2 = self.utils:AddScrollBar(self.panelBackground, 1, 1, 50, 200, selectionHeight + 20, nil, L["Columns:"],
			200, 5, 30);
	else
		self.extSb = self.utils:AddScrollBar(self.panelBackground, 1, 1, 50, 200, selectionHeight + 20, nil, L["Count:"], 5,
			5, 20);
	end
	self.spacingSB = self.utils:AddScrollBar(self.panelBackground, 1, 0, 50, 200, selectionHeight + 20, nil, L["Spacing:"],
		5, 40, 20);
	self.utils:CreateScrollBarCallback(self.spacingSB, barId, { "quickslotSpacing" });

	self.sizeSB = self.utils:AddScrollBar(self.panelBackground, 36, 0, 99, 200, selectionHeight + 20, nil, L["Size:"], 200,
		40, 5);
	self.utils:CreateScrollBarCallback(self.sizeSB, barId, { "quickslotSize" }, nil, nil);

	self:DisplaySettings();
end

function SlotsPanel:DisplaySettings()
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local localBarSettings = settingsService:GetBarSettings(self.barId);

	if (self.isExtension == false and localBarSettings.barType ~= INVENTORY_BAR) then
		self.sb:SetValue(localBarSettings.quickslotRows);
		self.sb.ValueChanged = function(sender, args)
			SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barId,
				function(barSettings)
					barSettings.quickslotRows = self.sb:GetValue();
					barSettings.quickslotCount = barSettings.quickslotRows * barSettings.quickslotColumns;
					return barSettings;
				end, function()
					SERVICE_CONTAINER:GetService(MysticBars.Services.InventoryService):NotifyClients();
				end);
		end
		self.sb2:SetValue(localBarSettings.quickslotColumns);
		self.sb2.ValueChanged = function(sender, args)
			SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barId,
				function(barSettings)
					barSettings.quickslotColumns = self.sb2:GetValue();
					barSettings.quickslotCount = barSettings.quickslotRows * barSettings.quickslotColumns;
					return barSettings;
				end, function()
					SERVICE_CONTAINER:GetService(MysticBars.Services.InventoryService):NotifyClients();
				end);
		end
	else
		self.extSb:SetValue(localBarSettings.quickslotCount);
		self.extSb.ValueChanged = function(sender, args)
			SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barId,
				function(barSettings)
					barSettings.quickslotColumns = self.extSb:GetValue();
					barSettings.quickslotCount = self.extSb:GetValue();
					return barSettings;
				end);
		end
	end
	self.spacingSB:SetValue(localBarSettings.quickslotSpacing);
	self.sizeSB:SetValue(localBarSettings.quickslotSize);
end

function SlotsPanel:EnableTriggers(enabled)
end
