-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

import "MyysticBars.Utils.Type";
import "MyysticBars.Utils.ServiceContainer";
import "MyysticBars.TonicBars.DefaultConfiguration.MainConfig"
import "MyysticBars.TonicBars.Services.ConfigurationService";
import "MyysticBars.TonicBars.Services.EventService"
import "MyysticBars.TonicBars.Services.InventoryService"
import "MyysticBars.TonicBars.Services.LocalizationService"
import "MyysticBars.TonicBars.Services.PlayerService"
import "MyysticBars.TonicBars.Services.SkillsService"
import "MyysticBars.TonicBars.Services.SettingsService"
import "MyysticBars.TonicBars.Services.BarService"
import "MyysticBars.TonicBars.Localization.Localizer";
import "MyysticBars.TonicBars.Menu.MainMenu";
import "MyysticBars.TonicBars.Enumerations";

import "MyysticBars.Utils.TableDump";

--local player = Turbine.Gameplay.LocalPlayer.GetInstance();
local dump = MyysticBars.Utils.TableDump();
-- dump.Dump(getmetatable());

DISPLAYWIDTH = Turbine.UI.Display.GetWidth();
DISPLAYHEIGHT = Turbine.UI.Display.GetHeight();

SERVICE_CONTAINER = MyysticBars.Utils.ServiceContainer();
SERVICE_CONTAINER:AddService(MyysticBars.TonicBars.Services.PlayerService(), MyysticBars.TonicBars.Services.PlayerService);
SERVICE_CONTAINER:AddService(MyysticBars.TonicBars.Services.SettingsService(), MyysticBars.TonicBars.Services.SettingsService);

SERVICE_CONTAINER:AddService(MyysticBars.TonicBars.Services.SkillsService(), MyysticBars.TonicBars.Services.SkillsService);

SERVICE_CONTAINER:AddService(MyysticBars.TonicBars.Services.EventService(), MyysticBars.TonicBars.Services.EventService);
SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.EventService):StartManager(); -- Start watching for effects.

SERVICE_CONTAINER:AddService(MyysticBars.TonicBars.Services.InventoryService(), MyysticBars.TonicBars.Services.InventoryService);
SERVICE_CONTAINER:AddService(MyysticBars.TonicBars.Services.LocalizationService(), MyysticBars.TonicBars.Services.LocalizationService);
SERVICE_CONTAINER:AddService(MyysticBars.TonicBars.Services.ConfigurationService(), MyysticBars.TonicBars.Services.ConfigurationService);

SERVICE_CONTAINER:AddService(MyysticBars.TonicBars.Services.BarService(), MyysticBars.TonicBars.Services.BarService);

menu = nil;

SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.PlayerService):Build();
local localizer = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.LocalizationService) -- Load Localization Settings.
localizer:LoadLocalizedEvents();
LOCALESTRINGS = localizer:GetStrings();
SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.InventoryService):NotifyClients();
SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.BarService):UpdateBarExtensions();

local mc = MyysticBars.TonicBars.DefaultConfiguration.MainConfig();
mc:CheckConfiguration();

Turbine.Shell.WriteLine( "----------------------------" );
Turbine.Shell.WriteLine( "MysticBars " .. THEVERSION .. " from MyysticOwl" );
Turbine.Shell.WriteLine( "usage: /tb; /TonicBars; /mb; /MysticBars" );
Turbine.Shell.WriteLine( "----------------------------" );

local shellCommand = Turbine.ShellCommand()
function shellCommand:Execute(command, arguments)
	Turbine.PluginManager.ShowOptions(Plugins["TonicBars"]);
end
Turbine.Shell.AddCommand('tb;tonicbars;TonicBars;mb;mysticbars;MysticBars', shellCommand);

menu = MyysticBars.TonicBars.Menu.MainMenu();
plugin.GetOptionsPanel = function( self )
  return menu;
end

Turbine.Plugin.Unload = function(self, sender, args)
	for key, value in pairs (SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.BarService):GetBars()) do
		value:ClearQuickslots();
	end
end