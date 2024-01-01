-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

DynamicTemplate = class();

function DynamicTemplate:Constructor()
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:RegisterBarCreator( "Mounts", "Mounts", self.Mounts, true );
	templateService:ConstructBars();
end

function DynamicTemplate:Mounts()
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);
	local skillsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SkillsService);
	skillsService:BuildSkillLists();

	--	override, name, level, rows, columns, x, y, barType, createdCallback )
	templateService:CreateBar( false, "Mounts", 1, 5, 5, 200, 200, QUICKSLOTBAR, function(localBarSettings)
		local dump = MyysticUI.Utils.TableDump();
		templateService:SetTrigger( templateService.ALT, nil, localBarSettings );

		for key, skill in pairs ( skillsService.travel ) do
			local skillInfo = skill:GetSkillInfo();
			-- local shortcut = skillInfo:GetShortcut();
--			dump.Dump(getmetatable(skillInfo:GetShortcutData()));
			-- dump.Dump(shortcut);
			local possibleHex = "0x" .. dec2hex(skillInfo:GetIconImageID());
--			Turbine.Shell.WriteLine(possibleHex);

			if (shortcutLookup[possibleHex]) then
				Turbine.Shell.WriteLine("Found: " .. shortcutLookup[possibleHex].shortcut .. " desc: " .. skillInfo:GetDescription());
				templateService:AddShortcut( key, shortcutLookup[possibleHex].shortcut, 6, 1, localBarSettings );
			end

			-- local shortcut = Turbine.UI.Lotro.Shortcut( skillInfo:GetType(), skillInfo:GetIconImageID() );
			-- if (shortcut:GetData() == "0x7001CEA9" or shortcut:GetData() == "0x7001B4D8") then
			-- 	Turbine.Shell.WriteLine("Found it!");
			-- end

			--templateService:AddShortcut( key, "0x" .. dec2hex(skillInfo:GetIconImageID()), skillInfo:GetType(), 1, localBarSettings );
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