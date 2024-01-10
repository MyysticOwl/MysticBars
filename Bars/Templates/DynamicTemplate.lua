-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

DynamicTemplate = class();

function DynamicTemplate:Constructor()
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	local skillsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SkillsService);
	skillsService:BuildSkillLists();
	for key, skillSet in pairs ( skillsService:GetSkillSets() ) do
		local callback = function()
			local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);
			local skillsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SkillsService);
			skillsService:BuildSkillLists();

			local rows = 1;
			local cols = skillSet.skillCount;
			if (skillSet.skillCount >= 5) then
				rows = math.ceil(skillSet.skillCount / 5);
				cols = 5;
			end
			templateService:CreateBar( skillSet.title, rows, cols, 200, 200, QUICKSLOTBAR, function(localBarSettings)
				MysticBars.Bars.Templates.DynamicTemplate.PopulateShortcuts(self, skillSet.skills, localBarSettings);
			end);
		end

		templateService:RegisterBarCreator( skillSet.title, skillSet.title, callback, skillSet.title, autoCreate );
	end

	templateService:ConstructBars();
end

function DynamicTemplate:PopulateShortcuts(list, localBarSettings)
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	local count = 0;
	for key, skill in pairs ( list ) do
		local possibleHex = MysticBars.Utils.Decimal2Hex(skill);

		if (ShortcutLookup[possibleHex]) then
			count = count + 1;
			templateService:AddShortcut( count, ShortcutLookup[possibleHex].shortcut, 6, 1, localBarSettings );
		-- else
		-- 	Turbine.Shell.WriteLine("Missing: " .. possibleHex .. " desc: " .. skillInfo:GetDescription());
		end
	end
end