-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "MysticBars.Utils.Type";
import "MysticBars.Utils.ServiceContainer";
import "MysticBars.Bars.Templates.BarTemplates"
import "MysticBars.Menus.MainMenu";
import "MysticBars.Services.TemplateService";
import "MysticBars.Services.EventService"
import "MysticBars.Services.InventoryService"
import "MysticBars.Services.PlayerService"
import "MysticBars.Services.SkillsService"
import "MysticBars.Services.SettingsService"
import "MysticBars.Services.BarService"
import "MysticBars.Services.MenuService"
import "MysticBars.Enumerations";

import "MysticBars.Utils.TableDump";

--local player = Turbine.Gameplay.LocalPlayer.GetInstance();
-- local dump = MysticBars.Utils.TableDump();
-- dump.Dump(getmetatable(Turbine.UI.Lotro.Quickslot));

DISPLAYWIDTH = Turbine.UI.Display.GetWidth();
DISPLAYHEIGHT = Turbine.UI.Display.GetHeight();

SERVICE_CONTAINER = MysticBars.Utils.ServiceContainer();
SERVICE_CONTAINER:AddService(MysticBars.Services.PlayerService(), MysticBars.Services.PlayerService);
SERVICE_CONTAINER:AddService(MysticBars.Services.SettingsService(), MysticBars.Services.SettingsService);

SERVICE_CONTAINER:AddService(MysticBars.Services.EventService(), MysticBars.Services.EventService);
SERVICE_CONTAINER:GetService(MysticBars.Services.EventService):StartManager(); -- Start watching for effects.

SERVICE_CONTAINER:AddService(MysticBars.Services.InventoryService(), MysticBars.Services.InventoryService);
SERVICE_CONTAINER:AddService(MysticBars.Services.TemplateService(), MysticBars.Services.TemplateService);

SERVICE_CONTAINER:AddService(MysticBars.Services.SkillsService(), MysticBars.Services.SkillsService);
SERVICE_CONTAINER:AddService(MysticBars.Services.BarService(), MysticBars.Services.BarService);

SERVICE_CONTAINER:GetService(MysticBars.Services.PlayerService):Build();

SERVICE_CONTAINER:GetService(MysticBars.Services.InventoryService):NotifyClients();
SERVICE_CONTAINER:GetService(MysticBars.Services.BarService):UpdateBarExtensions();

MysticBars.Bars.Templates.BarTemplates():CheckTemplates();

Turbine.Shell.WriteLine( "----------------------------" );
Turbine.Shell.WriteLine( "MysticBars " .. THEVERSION .. " from MyysticOwl" );
Turbine.Shell.WriteLine( "usage: /mb; /MysticBars" );
Turbine.Shell.WriteLine( "----------------------------" );

local shellCommand = Turbine.ShellCommand()
function shellCommand:Execute(command, arguments)
	Turbine.PluginManager.ShowOptions(Plugins["MysticBars"]);
end
Turbine.Shell.AddCommand('mb;mysticbars;MysticBars;', shellCommand);

SERVICE_CONTAINER:AddService(MysticBars.Services.MenuService(), MysticBars.Services.MenuService);

plugin.GetOptionsPanel = function( self )
  	return SERVICE_CONTAINER:GetService(MysticBars.Services.MenuService):GetMenu();
end

plugin.Unload = function( self )
	SERVICE_CONTAINER:GetService(MysticBars.Services.MenuService):GetMenu():Destroy();
end

Turbine.Plugin.Unload = function(self, sender, args)
	SERVICE_CONTAINER:GetService(MysticBars.Services.MenuService):GetMenu():Destroy();
end

-- import "MysticBars.Tools.SkillMapper"