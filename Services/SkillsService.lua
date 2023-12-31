-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

SkillsService = class( MysticBars.Utils.Service );

SkillsService.Log = MysticBars.Utils.Logging.LogManager.GetLogger( "SkillsService" );

SkillsService.mounts = {}
SkillsService.mountedCombat = {}
SkillsService.pets = {}
SkillsService.travel = {}
SkillsService.skills = {}
SkillsService.crafting = {}
SkillsService.class = {}
SkillsService.skirmish = {}
SkillsService.corruption = {}

SkillsService.mountsCount = 0;
SkillsService.mountedCombatCount = 0;
SkillsService.petsCount = 0;
SkillsService.travelCount = 0;
SkillsService.skillsCount = 0;
SkillsService.craftingCount = 0;
SkillsService.classCount = 0;
SkillsService.skirmishCount = 0;
SkillsService.corruptionCount = 0;

function SkillsService:Constructor()
	self.Log:Debug("Constructor");

	self.built = false;
end

function SkillsService:BuildSkillLists()
	self.Log:Debug("BuildSkillLists");

	if (not self.built) then
		local playerService = SERVICE_CONTAINER:GetService(MysticBars.Services.PlayerService);

		local trainedSkills = playerService.player:GetTrainedSkills();

		for i = 1, trainedSkills:GetCount() do
			local skill = trainedSkills:GetItem(i);
			local info = skill:GetSkillInfo();
			local name = string.lower(info:GetName());
			local description = string.lower(info:GetDescription());
			local image = info:GetIconImageID()

			-- Turbine.Shell.WriteLine( "t: " .. info:GetType());
			-- Turbine.Shell.WriteLine( "i: " .. info:GetIconImageID());
			-- Turbine.Shell.WriteLine( "n: " .. name);
			-- Turbine.Shell.WriteLine( "d: " .. description);

			local found = false;

			if ((string.find(description, "gambits quickly") ~= nil) and found == false) then

				if (self.class[self.classCount] == nil) then
					self.class[self.classCount] = {};
				end
				self.class[self.classCount]["masteries"] = image;
				self.classCount = self.classCount + 1;
				found = true;
			end

			if ((string.find(description, "stance") ~= nil) and found == false) then

				if (self.class[self.classCount] == nil) then
					self.class[self.classCount] = {};
				end
				self.class[self.classCount]["stances"] = image;
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
				self.class[self.classCount]["pet"] = image;
				self.classCount = self.classCount + 1;
				found = true;
			end

			if ((string.find(name, "travel to") ~= nil or
				string.find(name, "journey to") ~= nil or
				string.find(name, "return to") ~= nil or
				string.find(name, "return home") ~= nil or
				string.find(name, "muster at") ~= nil or
				string.find(name, "muster in") ~= nil) and found == false) then

				self.travel[self.travelCount] = image;
				self.travelCount = self.travelCount + 1;
				found = true;
			end
		
			if ((string.find(description, "summons") ~= nil or
				string.find(description, "companion") ~= nil or
				string.find(description, "bill the pony") ~= nil or
				string.find(description, "company") ~= nil or
				string.find(description, "with you") ~= nil or
				string.find(description, "brings out") ~= nil) and found == false) then

				self.pets[self.petsCount] = image;
				self.petsCount = self.petsCount + 1;
				found = true;
			end

			if (((	string.find(description, "mounted combat ") ~= nil and 
					string.find(description, "mounted combat enemies") == nil) or
				string.find(description, "your war") ~= nil or
				string.find(description, "your steed") ~= nil or
				string.find(description, "to ride") ~= nil) and found == false) then

				self.mountedCombat[self.mountedCombatCount] = image;
				self.mountedCombatCount = self.mountedCombatCount + 1;
				found = true;
			end

			if ((string.find(name, "pony") ~= nil or
				string.find(name, "goat") ~= nil or
				string.find(name, "horse") ~= nil or
				string.find(name, "elk") ~= nil or
				string.find(name, "boar") ~= nil or
				string.find(name, "steed") ~= nil) and found == false) then

				self.mounts[self.mountsCount] = image;
				self.mountsCount = self.mountsCount + 1;
				found = true;
			end

			if ((string.find(name, "track") ~= nil) and found == false) then
				self.crafting[self.craftingCount] = image;
				self.craftingCount = self.craftingCount + 1;
				found = true;
			end

			if ((string.find(description, "your soldier") ~= nil) and found == false) then
				self.skirmish[self.skirmishCount] = image;
				self.skirmishCount = self.skirmishCount + 1;
				found = true;
			end

			if ((string.find(description, "remove a corruption") ~= nil) and found == false) then
				self.corruption[self.corruptionCount] = image;
				self.corruptionCount = self.corruptionCount + 1;
				--found = true; NOT FOR THIS ONE!
			end

			if (found == false) then
				self.skills[self.skillsCount] = image;
				self.skillsCount = self.skillsCount + 1;
			end
		end
		self.built = true;
	end
end

function SkillsService:GetSkillSets()
	self.Log:Debug("GetSkillSets");

	return {
		mounts = {
			skills = self.mounts,
			skillCount = self.mountsCount,
			title = "Mounts",
			autoCreate = true
		},
		mountedCombat = {
			skills = self.mountedCombat,
			skillCount = self.mountedCombatCount,
			title = "Mounted Combat",
			autoCreate = true
		},
		pets = {
			skills = self.pets,
			skillCount = self.petsCount,
			title = "Pets",
			autoCreate = true
		},
		travel = {
			skills = self.travel,
			skillCount = self.travelCount,
			title = "Travel",
			autoCreate = true
		},
		skills = {
			skills = self.skills,
			skillCount = self.skillsCount,
			title = "Skills",
			autoCreate = true
		},
		crafting = {
			skills = self.crafting,
			skillCount = self.craftingCount,
			title = "Crafting",
			autoCreate = true
		},
		-- class = {
		-- 	skills = self.class,
		-- 	skillCount = self.classCount,
		-- 	title = "Class",
		-- 	autoCreate = true
		-- },
		skirmish = {
			skills = self.skirmish,
			skillCount = self.skirmishCount,
			title = "Skirmish",
			autoCreate = true
		},
		corruption = {
			skills = self.corruption,
			skillCount = self.corruptionCount,
			title = "Corruption",
			autoCreate = true
		}
	};
end