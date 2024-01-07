-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

PredefinedExtensionPanel = class(MysticBars.Menus.Controls.BasePanel);

function PredefinedExtensionPanel:Constructor( barId, barValue )
	MysticBars.Menus.Controls.BasePanel.Constructor(self, barId, barValue);

	self:SetHeight(120);

	self.utils:AddLabelBox( self.panelBackground, L["This will change shortcuts on the current bar perminately!!!!"], selectionWidth + 150, selectionHeight + 10, 5, 5 );

	self.typeList = self.utils:AddComboBox(self.panelBackground, 3, 200, 20, 5, 30);

	local skillsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SkillsService);
	skillsService:BuildSkillLists();
	for key, skillSet in pairs ( skillsService:GetSkillSets() ) do
		self.typeList:AddItem( skillSet.title, 	key );
	end

	self:DisplaySettings();
end

function PredefinedExtensionPanel:DisplaySettings()
    self.typeList.SelectedIndexChanged = function(sender, args)
		local skillsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SkillsService);
		local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);

		local skillSets = skillsService:GetSkillSets();
		local skillSet = skillSets[self.typeList:GetSelection()];

		-- This is a bit of a hack... have to change the size and give it TIME before
		-- we attempt to add the new slots.
		SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barId, function(barSettings)
			if (barSettings.orientation == "Right" or barSettings.orientation == "Left") then
				barSettings.quickslotColumns = skillSet.skillCount;
				barSettings.quickslotRows = 1;
			else
				barSettings.quickslotRows = skillSet.skillCount;
				barSettings.quickslotColumns = 1;
			end
			barSettings.quickslotCount = skillSet.skillCount;
			return barSettings;
		end, nil, true, true);

		local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
		barService:LoadQuickslots();
		barService:RefreshBars();

		local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
		local barSettings = settingsService:GetBarSettings( self.barId );

		SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barId, function(barSettings)
			local count = 0;
			barSettings.quickslots = {};
			for key, skill in pairs ( skillSet.skills ) do
				local possibleHex = MysticBars.Utils.Decimal2Hex(skill);
				local shortcutMapping = ShortcutLookup[possibleHex];
				if (shortcutMapping ~= nil) then
					count = count + 1;

					barSettings.quickslots[count] = {};
					barSettings.quickslots[count].Type = 6;
					barSettings.quickslots[count].Data = shortcutMapping.shortcut;
				end
			end
			return barSettings;
		end, nil, true, true);

		local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
		barService:LoadQuickslots();
		barService:RefreshBars();
	end
end

function ExtensionPanel:EnableTriggers( enabled )
end
