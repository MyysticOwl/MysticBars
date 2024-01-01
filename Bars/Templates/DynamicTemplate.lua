-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

DynamicTemplate = class();

function DynamicTemplate:Constructor()
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	--TOtemplateService:RegisterBarCreator( "Mounts", "Mounts", self.Mounts );
	templateService:ConstructBars();
end

function DynamicTemplate:Mounts()
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);
	local skillsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SkillsService);
	skillsService:BuildSkillLists();

	--	override, name, level, rows, columns, x, y, barType, createdCallback )
	templateService:CreateBar( false, "Mounts", 1, 5, 5, 200, 200, QUICKSLOTBAR, function(localBarSettings)
		for key, skill in pairs ( skillsService.travel ) do
			local skillInfo = skill:GetSkillInfo();
			local possibleHex = "0x" .. dec2hex(skillInfo:GetIconImageID());

			if (ShortcutLookup[possibleHex]) then
				templateService:AddShortcut( key, ShortcutLookup[possibleHex].shortcut, 6, 1, localBarSettings );
			else
--				Turbine.Shell.WriteLine("Missing: " .. possibleHex .. " desc: " .. skillInfo:GetDescription());
			end
		end
	end);
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