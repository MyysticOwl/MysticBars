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

-- import "MyysticUI.Tools.SkillMapper"