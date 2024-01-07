-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

InventoryPanel = class(MysticBars.Menus.Controls.BasePanel);

function InventoryPanel:Constructor(barId, barValue)
	MysticBars.Menus.Controls.BasePanel.Constructor(self, barId, barValue);

	self:SetHeight(190);

	self.utils:AddLabelBox(self.panelBackground, L["Category Based:"], 120, selectionHeight, nil, 5, 5);
	self.visibilityList = self.utils:AddCheckedComboBox(self.panelBackground, 8, 300, 20, 115, 5);

	self.utils:AddLabelBox(self.panelBackground, L["Name Based:"], 120, selectionHeight, nil, 5, 30);
	self.nameList = self.utils:AddCheckedComboBox(self.panelBackground, 6, 300, 20, 90, 30);

	self.utils:AddLabelBox(self.panelBackground, L["Add Name Filter:"], 120, selectionHeight, nil, 5, 60);
	self.filterName = self.utils:AddTextBox(self.panelBackground, "", selectionWidth, selectionHeight + 10, nil, 120, 60);

	self.utils:AddButton(self.panelBackground, L["Add"], buttonWidth, selectionHeight, function(sender, args)
		if (self.filterName:GetText() ~= "") then
			SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barId,
				function(barSettings)
					if (barSettings.events.inventory.nameFilters == nil) then
						barSettings.events.inventory.nameFilters = {};
					end
					if (barSettings.events.inventory.nameFilters[self.filterName:GetText()] == nil) then
						self.nameList:AddItem(self.filterName:GetText(), { "events", "inventory", "nameFilters", self.filterName:GetText() });
					end
					barSettings.events.inventory.nameFilters[self.filterName:GetText()] = true;
					self.filterName:SetText("");
					return barSettings;
				end, function()
					self:DisplaySettings();
				end);
		end
	end, 300, 60);

	self.countCheckBox = self.utils:AddCheckBox(self.panelBackground, L["Quantity Based:"], selectionWidth + 100,
		selectionHeight, nil, 5, 90);
	self.utils:CreateCheckBoxCallback(self.countCheckBox, barId, { "events", "inventory", "useCount" },
		function(sender, args)
			SERVICE_CONTAINER:GetService(MysticBars.Services.InventoryService):NotifyClients();
		end);

	self.countSB = self.utils:AddScrollBar(self.panelBackground, 0, 1, 100, 200, selectionHeight + 20, nil, "", 5, 120);
	self.utils:CreateScrollBarCallback(self.countSB, barId, { "events", "inventory", "quantity" }, nil, nil,
		function(sender, args)
			SERVICE_CONTAINER:GetService(MysticBars.Services.InventoryService):NotifyClients();
		end);

	self:DisplaySettings();
end

function InventoryPanel:DisplaySettings()
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local localBarSettings = settingsService:GetBarSettings(self.barId);

	if (localBarSettings.events == nil) then
		localBarSettings.events = {};
	end
	if (localBarSettings.events.inventory == nil) then
		localBarSettings.events.inventory = {};
	end

	self.nameList:Clear();

	if (localBarSettings.events ~= nil and localBarSettings.events.inventory ~= nil and localBarSettings.events.inventory.nameFilters ~= nil) then
		for key, value in opairs(localBarSettings.events.inventory.nameFilters) do
			self.nameList:AddItem(key, { "events", "inventory", "nameFilters", key });
		end
	end
	self.nameList:SetSelections(localBarSettings.events.inventory.nameFilters);
	
	self.nameList.SelectedIndexChanged = function(sender, args)
		local selections = self.nameList:GetSelections();
		if (selections ~= nil) then
			SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barId,
				function(barSettings)
					-- ALWAYS RESET THE nameFilters
					barSettings.events.inventory.nameFilters = {};
					for key, value in pairs(selections) do
						self.utils:BuildItemFromCommandTable(barSettings, value, true);
					end
					return barSettings;
				end, function()
					SERVICE_CONTAINER:GetService(MysticBars.Services.InventoryService):NotifyClients();
				end);
		end
	end

	self.visibilityList:Clear();

	for key, value in opairs(Turbine.Gameplay.ItemCategory) do
		self.visibilityList:AddItem(key, { "events", "inventory", "categories", key });
	end
	self.visibilityList:SetSelections(localBarSettings.events.inventory.categories);

	self.visibilityList.SelectedIndexChanged = function(sender, args)
		local selections = self.visibilityList:GetSelections();
		if (selections ~= nil) then
			SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barId,
				function(barSettings)
					-- ALWAYS RESET THE CATEGORIES
					barSettings.events.inventory.categories = {};
					for key, value in pairs(selections) do
						self.utils:BuildItemFromCommandTable(barSettings, value, true);
					end
					return barSettings;
				end, function()
					SERVICE_CONTAINER:GetService(MysticBars.Services.InventoryService):NotifyClients();
				end);
		end
	end

	self.countCheckBox:SetChecked(localBarSettings.events.inventory.useCount);
	if (localBarSettings.events.inventory.quantity ~= nil) then
		self.countSB:SetValue(localBarSettings.events.inventory.quantity);
	end
end

function InventoryPanel:EnableTriggers(enabled)
end
