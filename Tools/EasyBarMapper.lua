local column = 0;
local row = 0;
local leftPad = 200;
local topPad = 40;

local skillsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SkillsService);
local playerService = SERVICE_CONTAINER:GetService(MysticBars.Services.PlayerService);
skillsService:BuildSkillLists();
--local trainedSkills = playerService.player:GetTrainedSkills();

TestWindow = MysticBars.Bars.UI.Window();
TestWindow:SetSize(700, 500);
TestWindow:SetVisible(true);
TestWindow:SetText("Skill Mapper");
TestWindow:SetPosition(200, 200);
TestWindow:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
TestWindow:SetMouseVisible(true);
TestWindow:SetBackColor(Turbine.UI.Color(1, 0, 1, 0));

ListBox = Turbine.UI.ListBox();
ListBox:SetParent(TestWindow);
ListBox:SetPosition(20, 40);
ListBox:SetSize(700, 450);

ScrollBar = Turbine.UI.Lotro.ScrollBar();
ScrollBar:SetOrientation(Turbine.UI.Orientation.Vertical);
ScrollBar:SetParent(TestWindow);
ScrollBar:SetPosition(5, 40);
ScrollBar:SetSize(10, 500);

ListBox:SetVerticalScrollBar(ScrollBar);

add = nil;
add3 = nil;
missing = 0;
mapped = 0;
data = Turbine.PluginData.Load( Turbine.DataScope.Account, "ShortcutLookupData", function(args) end);
if (data == nil) then
	data = {}
end

-- SkillsService.mounts = {}
-- SkillsService.mountedCombat = {}
-- SkillsService.pets = {}
-- SkillsService.travel = {}
-- SkillsService.skills = {}
-- SkillsService.crafting = {}
-- SkillsService.class = {}
-- SkillsService.skirmish = {}
-- SkillsService.corruption = {}

EasyBarSkills = {};

for i = 1, skillsService.skillsCount do
	local skill = skillsService.skills[i];
	local skillInfo = skill:GetSkillInfo();

	if (data[possibleHex] == nil) then
		missing = missing + 1;
		local left = 60 + (leftPad * column);
		local top = 60 + (topPad * row);
		column = column + 1;

		if (column == 1) then
			column = 0;
			row = row + 1;
		end

		add = Turbine.UI.Control();
		add:SetParent(ListBox);
		add:SetSize(30, 30);
		add:SetVisible(true);
		add:SetPosition(left, top);
		add:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
		add:SetMouseVisible(true);
		add:SetBackground(skillInfo:GetIconImageID());

		ListBox:AddItem(add);

		local quickslot = Turbine.UI.Lotro.Quickslot();
		quickslot:SetParent(ListBox);
		quickslot:SetSize(30, 30);
		quickslot:SetVisible(true);
		quickslot:SetPosition(left + 30, top);
		quickslot:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
		quickslot:SetBackColor(Turbine.UI.Color(1, 0, 1, 0));

		local lb = Turbine.UI.Label();
		lb:SetParent( ListBox );
		lb:SetText( skillInfo:GetName() );
		lb:SetBackColor( unselectedColor );
		lb:SetTextAlignment( Turbine.UI.ContentAlignment.UpperLeft );
		lb:SetSize( 120, 40 );
		lb:SetPosition(left + 65, top);
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
