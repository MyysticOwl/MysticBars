-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine.Gameplay";
import "Turbine.UI";
import "MyysticUI.Utils.Class";
import "MyysticUI.Utils.Service";
import "MyysticUI.Utils.Table";
import "MyysticUI.Bars.Events.BuffEvents";
import "MyysticUI.Bars.Events.KeyEvents";
import "MyysticUI.Bars.Events.StatEvents";
import "MyysticUI.Bars.Events.ClassSpecificEvents";
import "MyysticUI.Bars.Events.MiscEvents";
import "MyysticUI.Services.SettingsService"

SkillsService = class( MyysticUI.Utils.Service );

SkillsService.mounts = {}
SkillsService.mountedCombat = {}
SkillsService.pets = {}
SkillsService.travel = {}
SkillsService.skills = {}
SkillsService.crafting = {}
SkillsService.class = {}
SkillsService.skirmish = {}
SkillsService.corruption = {}

function SkillsService:Constructor()
end

function SkillsService:BuildSkillLists()
	local playerService = SERVICE_CONTAINER:GetService(MyysticUI.Services.PlayerService);

	local mountCount = 0;
	local mountedCombatCount = 0;
	local petsCount = 0;
	local travelCount = 0;
	local skillsCount = 0;
	local craftingCount = 0;
	local classCount = 0;
	local skirmishCount = 0;
	local corruptionCount = 0;

	local trainedSkills = playerService.player:GetTrainedSkills();
	local untrainedSkills = playerService.player:GetUntrainedSkills();

	Turbine.Shell.WriteLine( "untrainedSkills: " .. untrainedSkills:GetCount());

	for i = 1, trainedSkills:GetCount() do
		local skill = trainedSkills:GetItem(i);
		local info = skill:GetSkillInfo();
		local name = string.lower(info:GetName());
		local description = string.lower(info:GetDescription());

		local found = false;

		if ((string.find(description, "gambits quickly") ~= nil) and found == false) then

			if (self.class[classCount] == nil) then
				self.class[classCount] = {};
			end
			self.class[classCount]["masteries"] = skill;
			classCount = classCount + 1;
			found = true;
		end

		if ((string.find(description, "stance") ~= nil) and found == false) then

			if (self.class[classCount] == nil) then
				self.class[classCount] = {};
			end
			self.class[classCount]["stances"] = skill;
			classCount = classCount + 1;
			found = true;
		end

		if ((string.find(name, "friend of") ~= nil or 
			string.find(name, "-speach") ~= nil or 
			string.find(name, "commune with") ~= nil or 
			(string.find(description, "summons a") ~= nil and string.find(description, "companion") ~= nil)) and found == false) then

			if (self.class[classCount] == nil) then
				self.class[classCount] = {};
			end
			self.class[classCount]["pet"] = skill;
			classCount = classCount + 1;
			found = true;
		end

		if ((string.find(name, "travel to") ~= nil or
			string.find(name, "journey to") ~= nil or
			string.find(name, "return to") ~= nil or
			string.find(name, "return home") ~= nil or
			string.find(name, "muster at") ~= nil or
			string.find(name, "muster in") ~= nil) and found == false) then

			self.travel[travelCount] = skill;
			travelCount = travelCount + 1;
			found = true;
		end
	
		if ((string.find(description, "summons") ~= nil or
			string.find(description, "companion") ~= nil or
			string.find(description, "bill the pony") ~= nil or
			string.find(description, "company") ~= nil or
			string.find(description, "with you") ~= nil or
			string.find(description, "brings out") ~= nil) and found == false) then

			self.pets[petsCount] = skill;
			petsCount = petsCount + 1;
			found = true;
		end

		if (((	string.find(description, "mounted combat ") ~= nil and 
				string.find(description, "mounted combat enemies") == nil) or
			string.find(description, "your war") ~= nil or
			string.find(description, "your steed") ~= nil or
			string.find(description, "to ride") ~= nil) and found == false) then

			self.mountedCombat[mountedCombatCount] = skill;
			mountedCombatCount = mountedCombatCount + 1;
			found = true;
		end

		if ((string.find(name, "pony") ~= nil or
			string.find(name, "goat") ~= nil or
			string.find(name, "horse") ~= nil or
			string.find(name, "elk") ~= nil or
			string.find(name, "boar") ~= nil or
			string.find(name, "steed") ~= nil) and found == false) then

			self.mounts[mountCount] = skill;
			mountCount = mountCount + 1;
			found = true;
		end

		if ((string.find(name, "track") ~= nil) and found == false) then
			self.crafting[craftingCount] = skill;
			craftingCount = craftingCount + 1;
			found = true;
		end

		if ((string.find(description, "your soldier") ~= nil) and found == false) then
			self.skirmish[skirmishCount] = skill;
			skirmishCount = skirmishCount + 1;
			found = true;
		end

		if ((string.find(description, "remove a corruption") ~= nil) and found == false) then
			self.corruption[corruptionCount] = skill;
			corruptionCount = corruptionCount + 1;
			--found = true; NOT FOR THIS ONE!
		end

		if (found == false) then
			self.skills[skillsCount] = skill;
			skillsCount = skillsCount + 1;
		end
	end
end