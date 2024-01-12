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

import "MysticBars.ShortcutLooksupData"

local column = 0;
local row = 0;
local leftPad = 200;
local topPad = 40;

local skillsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SkillsService);
local playerService = SERVICE_CONTAINER:GetService(MysticBars.Services.PlayerService);
skillsService:BuildSkillLists();
local trainedSkills = playerService.player:GetTrainedSkills();

TestWindow = MysticBars.Bars.UI.Window();
TestWindow:SetSize(700, 500);
TestWindow:SetVisible(true);
TestWindow:SetText("Skill Mapper");
TestWindow:SetPosition(200, 200);
TestWindow:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
TestWindow:SetMouseVisible(true);
TestWindow:SetBackColor(Turbine.UI.Color(1, 0, 1, 0));

add = nil;
add3 = nil;
missing = 0;
mapped = 0;
data = Turbine.PluginData.Load( Turbine.DataScope.Account, "ShortcutLookupData", function(args) end);
if (data == nil) then
	data = {}
end

for i = 1, trainedSkills:GetCount() do
	local skill = trainedSkills:GetItem(i);
	local skillInfo = skill:GetSkillInfo();
	local possibleHex = "0x" .. dec2hex(skillInfo:GetIconImageID());

	if (ShortcutLookup[possibleHex] == nil) then
		if (data[possibleHex] == nil) then
			missing = missing + 1;
			local left = 60 + (leftPad * column);
			local top = 60 + (topPad * row);
			column = column + 1;

			if (column == 7) then
				column = 0;
				row = row + 1;
			end

			add = Turbine.UI.Control();
			add:SetParent(TestWindow);
			add:SetSize(30, 30);
			add:SetVisible(true);
			add:SetPosition(left, top);
			add:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
			add:SetMouseVisible(true);
			add:SetBackground(skillInfo:GetIconImageID());

			local quickslot = Turbine.UI.Lotro.Quickslot();
			quickslot:SetParent(TestWindow);
			quickslot:SetSize(30, 30);
			quickslot:SetVisible(true);
			quickslot:SetPosition(left + 30, top);
			quickslot:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
			quickslot:SetBackColor(Turbine.UI.Color(1, 0, 1, 0));
			if (data[possibleHex] ~= nil and data[possibleHex].shortcut ~= nil and data[possibleHex].shortcut ~= "") then
				local shortcut = Turbine.UI.Lotro.Shortcut(Turbine.UI.Lotro.ShortcutType.Skill, data[possibleHex].shortcut);
				quickslot:SetShortcut(shortcut);
			end

			local lb = Turbine.UI.Label();
			lb:SetParent( TestWindow );
			lb:SetText( skillInfo:GetName() );
			lb:SetBackColor( unselectedColor );
			lb:SetTextAlignment( Turbine.UI.ContentAlignment.UpperLeft );
			lb:SetSize( 120, 40 );
			lb:SetPosition(left + 65, top);
			data[possibleHex] = {qs = quickslot, name=skillInfo:GetName()}
		end
	else
		mapped = mapped + 1;
	end
end

output = {}

local noShortcutButton = Turbine.UI.Lotro.Button();
noShortcutButton:SetParent( TestWindow );
noShortcutButton:SetText( "Save Mapping Mapped:" .. mapped .. " Missing:" .. missing  );
noShortcutButton:SetSize( 300, 20 );
noShortcutButton:SetPosition( 5, 30 );
noShortcutButton.MouseClick = function( sender, args )
	for key, value in pairs(data) do
		if (value.qs ~= nil) then
			local shortcut = value.qs:GetShortcut();
			if (shortcut ~= nil and shortcut:GetData() ~= nil and shortcut:GetData() ~= "") then
				output[key] = {shortcut = shortcut:GetData(), type = shortcut:GetType(), name = value.name}
			end
		else
			output[key] = value
		end
	end
	Turbine.PluginData.Save( Turbine.DataScope.Account, "ShortcutLookupData", output, function (success, error) end);
end
