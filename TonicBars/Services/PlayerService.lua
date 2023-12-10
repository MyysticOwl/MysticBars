-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

import "Turbine.Gameplay";
import "Turbine.UI";
import "MyysticBars.Utils.Class";
import "MyysticBars.Utils.Service";
import "MyysticBars.Utils.Table";
import "MyysticBars.TonicBars.Events.BuffEvents";
import "MyysticBars.TonicBars.Events.KeyEvents";
import "MyysticBars.TonicBars.Events.StatEvents";
import "MyysticBars.TonicBars.Events.ClassSpecificEvents";
import "MyysticBars.TonicBars.Events.MiscEvents";
import "MyysticBars.TonicBars.Services.SettingsService"

PlayerService = class( MyysticBars.Utils.Service );

PlayerService.player = nil
PlayerService.playerClass = nil
PlayerService.playerClassAttributes = nil
PlayerService.realClassSet = nil

function PlayerService:Constructor()
	function GetPlayer()
		self.player = Turbine.Gameplay.LocalPlayer.GetInstance();
		self.playerClass = self.player:GetClass();
		self.playerClassAttributes = self.player:GetClassAttributes();
		self.realClassSet = true;

		self:BuildSkills();
	end
	if ( pcall( GetPlayer ) == false ) then
		self.player = Turbine.Gameplay.LocalPlayer.GetInstance();
		self.playerClass = self.player:GetClass();
		self.playerClassAttributes = self.player:GetClassAttributes();

		self:BuildSkills();
	end
end

function PlayerService:Build()
	if ( self.playerClass == nil ) then
		local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);

		local settings = settingsService:GetSettings();
		if ( settings.playerClass == nil ) then
			settings.playerClass = 162;
		end
		self.playerClass = settings.playerClass;
	end
	Turbine.Shell.WriteLine("Player is: " .. self.playerClass)
end

function PlayerService:BuildSkills()

	local mounts = {};
	local mountCount = 0;
	local mountedCombat = {};
	local mountedCombatCount = 0;
	local pets = {};
	local petsCount = 0;
	local travel = {};
	local travelCount = 0;
	local skills = {};
	local skillsCount = 0;
	local crafting = {};
	local craftingCount = 0;
	local class = {};
	local classCount = 0;
	local skirmish = {};
	local skirmishCount = 0;
	local corruption = {};
	local corruptionCount = 0;
	
	local trainedSkills = self.player:GetTrainedSkills();
	local untrainedSkills = self.player:GetUntrainedSkills();
	
	Turbine.Shell.WriteLine( "untrainedSkills: " .. untrainedSkills:GetCount());

	for i = 1, trainedSkills:GetCount() do
		local skill = trainedSkills:GetItem(i);
		local info = skill:GetSkillInfo();
		local name = string.lower(info:GetName());
		local description = string.lower(info:GetDescription());

		local found = false;
		
		if ((string.find(description, "gambits quickly") ~= nil) and found == false) then

			if (class[classCount] == nil) then
				class[classCount] = {};
			end
			class[classCount]["masteries"] = skill;
			classCount = classCount + 1;
			found = true;
		end

		if ((string.find(description, "stance") ~= nil) and found == false) then

			if (class[classCount] == nil) then
				class[classCount] = {};
			end
			class[classCount]["stances"] = skill;
			classCount = classCount + 1;
			found = true;
		end

		if ((string.find(description, "attunes") ~= nil) and found == false) then

			if (class[classCount] == nil) then
				class[classCount] = {};
			end
			class[classCount]["attunement"] = skill;
			classCount = classCount + 1;
			found = true;
		end

		if ((string.find(name, "friend of") ~= nil or 
			string.find(name, "-speach") ~= nil or 
			string.find(name, "commune with") ~= nil or 
			(string.find(description, "summons a") ~= nil and string.find(description, "companion") ~= nil)) and found == false) then

			if (class[classCount] == nil) then
				class[classCount] = {};
			end
			class[classCount]["pet"] = skill;
			classCount = classCount + 1;
			found = true;
		end

		if ((string.find(name, "travel to") ~= nil or
			string.find(name, "journey to") ~= nil or
			string.find(name, "return to") ~= nil or
			string.find(name, "return home") ~= nil or
			string.find(name, "muster at") ~= nil or
			string.find(name, "muster in") ~= nil) and found == false) then

			travel[travelCount] = skill;
			travelCount = travelCount + 1;
			found = true;
		end
	
		if ((string.find(description, "summons") ~= nil or
			string.find(description, "companion") ~= nil or
			string.find(description, "bill the pony") ~= nil or
			string.find(description, "company") ~= nil or
			string.find(description, "with you") ~= nil or
			string.find(description, "brings out") ~= nil) and found == false) then

			pets[petsCount] = skill;
			petsCount = petsCount + 1;
			found = true;
		end

		if (((	string.find(description, "mounted combat ") ~= nil and 
				string.find(description, "mounted combat enemies") == nil) or
			string.find(description, "your war") ~= nil or
			string.find(description, "your steed") ~= nil or
			string.find(description, "to ride") ~= nil) and found == false) then

			mountedCombat[mountedCombatCount] = skill;
			mountedCombatCount = mountedCombatCount + 1;
			found = true;
		end

		if ((string.find(name, "pony") ~= nil or
			string.find(name, "goat") ~= nil or
			string.find(name, "horse") ~= nil or
			string.find(name, "elk") ~= nil or
			string.find(name, "boar") ~= nil or
			string.find(name, "steed") ~= nil) and found == false) then

			mounts[mountCount] = skill;
			mountCount = mountCount + 1;
			found = true;
		end

		if ((string.find(name, "track") ~= nil) and found == false) then
			crafting[craftingCount] = skill;
			craftingCount = craftingCount + 1;
			found = true;
		end

		if ((string.find(description, "your soldier") ~= nil) and found == false) then
			skirmish[skirmishCount] = skill;
			skirmishCount = skirmishCount + 1;
			found = true;
		end

		if ((string.find(description, "remove a corruption") ~= nil) and found == false) then
			corruption[corruptionCount] = skill;
			corruptionCount = corruptionCount + 1;
			--found = true; NOT FOR THIS ONE!
		end

		if (found == false) then
			skills[skillsCount] = skill;
			skillsCount = skillsCount + 1;
		end
	end
	
	Turbine.Shell.WriteLine( "Mounts: " .. mountCount);
	-- for i = 0, mountCount - 1 do
	-- 	Turbine.Shell.WriteLine( mounts[i]:GetSkillInfo():GetName());
	-- end

	Turbine.Shell.WriteLine( "Mounted Combat: " .. mountedCombatCount);
	-- for i = 0, mountedCombatCount - 1 do
	-- 	Turbine.Shell.WriteLine( mountedCombat[i]:GetSkillInfo():GetName());
	-- end
	
	Turbine.Shell.WriteLine( "Pets: " .. petsCount);
	-- for i = 0, petsCount - 1 do
	-- 	Turbine.Shell.WriteLine( pets[i]:GetSkillInfo():GetName());
	-- end
	
	Turbine.Shell.WriteLine( "Travel: " .. travelCount);
	-- for i = 0, travelCount - 1 do
	-- 	Turbine.Shell.WriteLine( travel[i]:GetSkillInfo():GetName());
	-- end
	
	Turbine.Shell.WriteLine( "Skills: " .. skillsCount);
	-- for i = 0, skillsCount - 1 do
	-- 	Turbine.Shell.WriteLine( skills[i]:GetSkillInfo():GetName()); -- .. ": " .. skills[i]:GetSkillInfo():GetDescription()
	-- end	

	Turbine.Shell.WriteLine( "Crafting: " .. craftingCount);

	Turbine.Shell.WriteLine( "Class: " ..classCount);
	-- for i = 0, classCount - 1 do
	-- 	Turbine.Shell.WriteLine( class[i]:GetSkillInfo():GetName()); -- .. ": " .. skills[i]:GetSkillInfo():GetDescription()
	-- end	

	Turbine.Shell.WriteLine( "Skirmish: " ..skirmishCount);

	Turbine.Shell.WriteLine( "Corruption Removal: " ..corruptionCount);
end