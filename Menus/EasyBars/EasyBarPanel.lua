-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "MyysticUI.Menus.Core.UI.AutoListBox";
import "MyysticUI.Menus.Core.UI.MenuUtils";
import "MyysticUI.Menus.Controls.BasePanel";

import "MyysticUI.Menus.EasyBars.ShortcutLooksupData"

EasyBarPanel = class(MyysticUI.Menus.Controls.BasePanel);

EasyBarPanel.menuItems = MyysticUI.Menus.MainMenuItems();

function EasyBarPanel:Constructor()
	MyysticUI.Menus.Controls.BasePanel.Constructor(self, nil, nil);

	self.templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);
	local easyBars = self.templateService:GetEasyBars();
	local column = 0;
	local row = 0;
	local leftPad = 200;
	local topPad = 40;

	local skillsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SkillsService);
	local playerService = SERVICE_CONTAINER:GetService(MyysticUI.Services.PlayerService);
	skillsService:BuildSkillLists();
	local trainedSkills = playerService.player:GetTrainedSkills();

	for i = 1, trainedSkills:GetCount() do
		local skill = trainedSkills:GetItem(i);
		local skillInfo = skill:GetSkillInfo();
		local possibleHex = "0x" .. dec2hex(skillInfo:GetIconImageID());

		if (possibleHex ~= nil and ShortcutLookup[possibleHex] == nil) then
			local left = 5 + (leftPad * column);
			local top = 5 + (topPad * row);
			column = column + 1;

			if (column == 3) then
				column = 0;
				row = row + 1;
			end

			self.add = Turbine.UI.Control();
			self.add:SetParent(TestWindow);
			self.add:SetSize(30, 30);
			self.add:SetVisible(true);
			self.add:SetPosition(left, top);
			self.add:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
			self.add:SetMouseVisible(true);
			self.add:SetBackground(skillInfo:GetIconImageID());

			self.add3 = Turbine.UI.Lotro.Quickslot();
			self.add3:SetParent(TestWindow);
			self.add3:SetSize(30, 30);
			self.add3:SetVisible(true);
			self.add3:SetPosition(left + 30, top);
			--self.add3:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
			self.add3:SetBackColor(Turbine.UI.Color(0.5, 0, 1, 0));
		end
	end

	self:SetHeight(row * 50);

	self:DisplaySettings();
end

function EasyBarPanel:DisplaySettings()

end

function EasyBarPanel:EnableTriggers(enabled)
end

function EasyBarPanel:GetBarMatch(barName)
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);

	for key, value in opairs (settingsService:GetBars()) do
		if (value.barName == barName and value.barName ~= nil) then
			return key, value;
		end
	end
end

function dec2hex( num )
	if (type( num ) ~= "number") then
		num = tonumber( num )
	end
	if num == 0 or num == nil then return '0' end

   local neg = false
   if num < 0 then
	   neg = true
	   num = num * -1
   end

   local hexstr    = '0123456789ABCDEF'
   local result    = ''

   while num > 0 do
	   local n = math.mod( num, 16 )
	   result      = string.sub( hexstr, n + 1, n + 1 ) .. result
	   num         = math.floor( num / 16 )
   end

   if neg then
	   result = '-' .. result
   end

   return result
end