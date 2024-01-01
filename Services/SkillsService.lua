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

SkillsService.mountCount = 0;
SkillsService.mountedCombatCount = 0;
SkillsService.petsCount = 0;
SkillsService.travelCount = 0;
SkillsService.skillsCount = 0;
SkillsService.craftingCount = 0;
SkillsService.classCount = 0;
SkillsService.skirmishCount = 0;
SkillsService.corruptionCount = 0;

function SkillsService:Constructor()
	self.built = false;
end

function SkillsService:BuildSkillLists()
	if (not self.built) then
		local playerService = SERVICE_CONTAINER:GetService(MyysticUI.Services.PlayerService);

		local trainedSkills = playerService.player:GetTrainedSkills();

		for i = 1, trainedSkills:GetCount() do
			local skill = trainedSkills:GetItem(i);
			local info = skill:GetSkillInfo();
			local name = string.lower(info:GetName());
			local description = string.lower(info:GetDescription());

			-- Turbine.Shell.WriteLine( "t: " .. info:GetType());
			-- Turbine.Shell.WriteLine( "i: " .. info:GetIconImageID());
			-- Turbine.Shell.WriteLine( "n: " .. name);
			-- Turbine.Shell.WriteLine( "d: " .. description);

			local found = false;

			if ((string.find(description, "gambits quickly") ~= nil) and found == false) then

				if (self.class[self.classCount] == nil) then
					self.class[self.classCount] = {};
				end
				self.class[self.classCount]["masteries"] = skill;
				self.classCount = self.classCount + 1;
				found = true;
			end

			if ((string.find(description, "stance") ~= nil) and found == false) then

				if (self.class[self.classCount] == nil) then
					self.class[self.classCount] = {};
				end
				self.class[self.classCount]["stances"] = skill;
				self.classCount = self.classCount + 1;
				found = true;
			end

			if ((string.find(name, "friend of") ~= nil or 
				string.find(name, "-speach") ~= nil or 
				string.find(name, "commune with") ~= nil or 
				(string.find(description, "summons a") ~= nil and string.find(description, "companion") ~= nil)) and found == false) then

				if (self.class[self.classCount] == nil) then
					self.class[self.classCount] = {};
				end
				self.class[self.classCount]["pet"] = skill;
				self.classCount = self.classCount + 1;
				found = true;
			end

			if ((string.find(name, "travel to") ~= nil or
				string.find(name, "journey to") ~= nil or
				string.find(name, "return to") ~= nil or
				string.find(name, "return home") ~= nil or
				string.find(name, "muster at") ~= nil or
				string.find(name, "muster in") ~= nil) and found == false) then

				self.travel[self.travelCount] = skill;
				self.travelCount = self.travelCount + 1;
				found = true;
			end
		
			if ((string.find(description, "summons") ~= nil or
				string.find(description, "companion") ~= nil or
				string.find(description, "bill the pony") ~= nil or
				string.find(description, "company") ~= nil or
				string.find(description, "with you") ~= nil or
				string.find(description, "brings out") ~= nil) and found == false) then

				self.pets[self.petsCount] = skill;
				self.petsCount = self.petsCount + 1;
				found = true;
			end

			if (((	string.find(description, "mounted combat ") ~= nil and 
					string.find(description, "mounted combat enemies") == nil) or
				string.find(description, "your war") ~= nil or
				string.find(description, "your steed") ~= nil or
				string.find(description, "to ride") ~= nil) and found == false) then

				self.mountedCombat[self.mountedCombatCount] = skill;
				self.mountedCombatCount = self.mountedCombatCount + 1;
				found = true;
			end

			if ((string.find(name, "pony") ~= nil or
				string.find(name, "goat") ~= nil or
				string.find(name, "horse") ~= nil or
				string.find(name, "elk") ~= nil or
				string.find(name, "boar") ~= nil or
				string.find(name, "steed") ~= nil) and found == false) then

				self.mounts[self.mountCount] = skill;
				self.mountCount = self.mountCount + 1;
				found = true;
			end

			if ((string.find(name, "track") ~= nil) and found == false) then
				self.crafting[self.craftingCount] = skill;
				self.craftingCount = self.craftingCount + 1;
				found = true;
			end

			if ((string.find(description, "your soldier") ~= nil) and found == false) then
				self.skirmish[self.skirmishCount] = skill;
				self.skirmishCount = self.skirmishCount + 1;
				found = true;
			end

			if ((string.find(description, "remove a corruption") ~= nil) and found == false) then
				self.corruption[self.corruptionCount] = skill;
				self.corruptionCount = self.corruptionCount + 1;
				--found = true; NOT FOR THIS ONE!
			end

			if (found == false) then
				self.skills[self.skillsCount] = skill;
				self.skillsCount = self.skillsCount + 1;
			end
		end
		self.built = true;
	end
end