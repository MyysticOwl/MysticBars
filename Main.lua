-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "MyysticUI.Utils.Type";
import "MyysticUI.Utils.ServiceContainer";
import "MyysticUI.Bars.Templates.BarTemplates"
import "MyysticUI.Menus.MainMenu";
import "MyysticUI.Services.TemplateService";
import "MyysticUI.Services.EventService"
import "MyysticUI.Services.InventoryService"
import "MyysticUI.Services.PlayerService"
import "MyysticUI.Services.SkillsService"
import "MyysticUI.Services.SettingsService"
import "MyysticUI.Services.BarService"
import "MyysticUI.Services.MenuService"
import "MyysticUI.Enumerations";

import "MyysticUI.Utils.TableDump";

--local player = Turbine.Gameplay.LocalPlayer.GetInstance();
-- local dump = MyysticUI.Utils.TableDump();
-- dump.Dump(getmetatable(Turbine.UI.Lotro.Quickslot));

DISPLAYWIDTH = Turbine.UI.Display.GetWidth();
DISPLAYHEIGHT = Turbine.UI.Display.GetHeight();

SERVICE_CONTAINER = MyysticUI.Utils.ServiceContainer();
SERVICE_CONTAINER:AddService(MyysticUI.Services.PlayerService(), MyysticUI.Services.PlayerService);
SERVICE_CONTAINER:AddService(MyysticUI.Services.SettingsService(), MyysticUI.Services.SettingsService);

SERVICE_CONTAINER:AddService(MyysticUI.Services.EventService(), MyysticUI.Services.EventService);
SERVICE_CONTAINER:GetService(MyysticUI.Services.EventService):StartManager(); -- Start watching for effects.

SERVICE_CONTAINER:AddService(MyysticUI.Services.InventoryService(), MyysticUI.Services.InventoryService);
SERVICE_CONTAINER:AddService(MyysticUI.Services.TemplateService(), MyysticUI.Services.TemplateService);

SERVICE_CONTAINER:AddService(MyysticUI.Services.SkillsService(), MyysticUI.Services.SkillsService);
SERVICE_CONTAINER:AddService(MyysticUI.Services.BarService(), MyysticUI.Services.BarService);

SERVICE_CONTAINER:GetService(MyysticUI.Services.PlayerService):Build();

SERVICE_CONTAINER:GetService(MyysticUI.Services.InventoryService):NotifyClients();
SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService):UpdateBarExtensions();

MyysticUI.Bars.Templates.BarTemplates():CheckTemplates();

Turbine.Shell.WriteLine( "----------------------------" );
Turbine.Shell.WriteLine( "MysticBars " .. THEVERSION .. " from MyysticOwl" );
Turbine.Shell.WriteLine( "usage: /tb; /TonicBars; /mb; /MysticBars" );
Turbine.Shell.WriteLine( "----------------------------" );

local shellCommand = Turbine.ShellCommand()
function shellCommand:Execute(command, arguments)
	Turbine.PluginManager.ShowOptions(Plugins["TonicBars"]);
end
Turbine.Shell.AddCommand('mb;mysticui;MysticUI;mysticbars;MysticBars;', shellCommand);

SERVICE_CONTAINER:AddService(MyysticUI.Services.MenuService(), MyysticUI.Services.MenuService);

plugin.GetOptionsPanel = function( self )
  	return SERVICE_CONTAINER:GetService(MyysticUI.Services.MenuService):GetMenu();
end

plugin.Unload = function( self )
	SERVICE_CONTAINER:GetService(MyysticUI.Services.MenuService):GetMenu():Destroy();
end

Turbine.Plugin.Unload = function(self, sender, args)
	SERVICE_CONTAINER:GetService(MyysticUI.Services.MenuService):GetMenu():Destroy();
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

import "MyysticUI.ShortcutLooksupData"

local column = 0;
local row = 0;
local leftPad = 200;
local topPad = 40;

local skillsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SkillsService);
local playerService = SERVICE_CONTAINER:GetService(MyysticUI.Services.PlayerService);
skillsService:BuildSkillLists();
local trainedSkills = playerService.player:GetTrainedSkills();

TestWindow = MyysticUI.Menus.Core.UI.Window();
TestWindow:SetSize(700, 500);
TestWindow:SetVisible(true);
TestWindow:SetPosition(200, 200);
TestWindow:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
TestWindow:SetMouseVisible(true);
TestWindow:SetBackColor(Turbine.UI.Color(1, 0, 1, 0));

add = nil;
add3 = nil;

for i = 1, trainedSkills:GetCount() do
	local skill = trainedSkills:GetItem(i);
	local skillInfo = skill:GetSkillInfo();
	local possibleHex = "0x" .. dec2hex(skillInfo:GetIconImageID());

	if (possibleHex ~= nil and ShortcutLookup[possibleHex] == nil) then
		local left = 60 + (leftPad * column);
		local top = 60 + (topPad * row);
		column = column + 1;

		if (column == 3) then
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

		add3 = Turbine.UI.Lotro.Quickslot();
		add3:SetParent(TestWindow);
		add3:SetSize(30, 30);
		add3:SetVisible(true);
		add3:SetPosition(left + 30, top);
		--add3:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
		add3:SetBackColor(Turbine.UI.Color(0.5, 0, 1, 0));

		local lb = Turbine.UI.Label();
		lb:SetParent( TestWindow );
		lb:SetText( skillInfo:GetName() );
		lb:SetBackColor( unselectedColor );
		lb:SetTextAlignment( Turbine.UI.ContentAlignment.UpperLeft );
		lb:SetSize( 120, 40 );
		lb:SetPosition(left + 65, top);
	end
end