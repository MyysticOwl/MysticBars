-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "MyysticUI.Utils.Type";
import "MyysticUI.Utils.ServiceContainer";
import "MyysticUI.Core.DefaultConfiguration.MainConfig"
import "MyysticUI.Services.ConfigurationService";
import "MyysticUI.Services.EventService"
import "MyysticUI.Services.InventoryService"
import "MyysticUI.Services.PlayerService"
import "MyysticUI.Services.SkillsService"
import "MyysticUI.Services.SettingsService"
import "MyysticUI.Services.BarService"
import "MyysticUI.Menus.MainMenu";
import "MyysticUI.Core.Enumerations";

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
SERVICE_CONTAINER:AddService(MyysticUI.Services.ConfigurationService(), MyysticUI.Services.ConfigurationService);

SERVICE_CONTAINER:AddService(MyysticUI.Services.SkillsService(), MyysticUI.Services.SkillsService);
SERVICE_CONTAINER:GetService(MyysticUI.Services.SkillsService):BuildSkillLists();

SERVICE_CONTAINER:AddService(MyysticUI.Services.BarService(), MyysticUI.Services.BarService);

menu = nil;

SERVICE_CONTAINER:GetService(MyysticUI.Services.PlayerService):Build();

SERVICE_CONTAINER:GetService(MyysticUI.Services.InventoryService):NotifyClients();
SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService):UpdateBarExtensions();

local mc = MyysticUI.Core.DefaultConfiguration.MainConfig();
mc:CheckConfiguration();

Turbine.Shell.WriteLine( "----------------------------" );
Turbine.Shell.WriteLine( "MysticBars " .. THEVERSION .. " from MyysticOwl" );
Turbine.Shell.WriteLine( "usage: /tb; /TonicBars; /mb; /MysticBars" );
Turbine.Shell.WriteLine( "----------------------------" );


local shellCommand = Turbine.ShellCommand()
function shellCommand:Execute(command, arguments)
	Turbine.PluginManager.ShowOptions(Plugins["TonicBars"]);
end
Turbine.Shell.AddCommand('mb;mysticui;MysticUI;mysticbars;MysticBars;', shellCommand);

menu = MyysticUI.Menus.MainMenu();
plugin.GetOptionsPanel = function( self )
  return menu;
end

Turbine.Plugin.Unload = function(self, sender, args)
	for key, value in pairs (SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService):GetBars()) do
		value:ClearQuickslots();
	end
end