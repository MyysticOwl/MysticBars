-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

import "Tonic.Utils.Type";
import "Tonic.Utils.ServiceContainer";
import "Tonic.TonicBars.DefaultConfiguration.MainConfig"
import "Tonic.TonicBars.Services.ConfigurationService";
import "Tonic.TonicBars.Services.EventService"
import "Tonic.TonicBars.Services.InventoryService"
import "Tonic.TonicBars.Services.LocalizationService"
import "Tonic.TonicBars.Services.PlayerService"
import "Tonic.TonicBars.Services.SettingsService"
import "Tonic.TonicBars.Services.BarService"
import "Tonic.TonicBars.Localization.Localizer";
import "Tonic.TonicBars.Menu.MainMenu";
import "Tonic.TonicBars.Enumerations";

import "Tonic.Utils.Table";

DISPLAYWIDTH = Turbine.UI.Display.GetWidth();
DISPLAYHEIGHT = Turbine.UI.Display.GetHeight();

SERVICE_CONTAINER = Tonic.Utils.ServiceContainer();
SERVICE_CONTAINER:AddService(Tonic.TonicBars.Services.PlayerService(), Tonic.TonicBars.Services.PlayerService);
SERVICE_CONTAINER:AddService(Tonic.TonicBars.Services.SettingsService(), Tonic.TonicBars.Services.SettingsService);

SERVICE_CONTAINER:AddService(Tonic.TonicBars.Services.EventService(), Tonic.TonicBars.Services.EventService);
SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.EventService):StartManager(); -- Start watching for effects.

SERVICE_CONTAINER:AddService(Tonic.TonicBars.Services.BarService(), Tonic.TonicBars.Services.BarService);
SERVICE_CONTAINER:AddService(Tonic.TonicBars.Services.InventoryService(), Tonic.TonicBars.Services.InventoryService);
SERVICE_CONTAINER:AddService(Tonic.TonicBars.Services.LocalizationService(), Tonic.TonicBars.Services.LocalizationService);
SERVICE_CONTAINER:AddService(Tonic.TonicBars.Services.ConfigurationService(), Tonic.TonicBars.Services.ConfigurationService);

menu = nil;

SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.PlayerService):Build();
local localizer = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.LocalizationService) -- Load Localization Settings.
localizer:LoadLocalizedEvents();
LOCALESTRINGS = localizer:GetStrings();
SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.InventoryService):NotifyClients();
SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.BarService):UpdateBarExtensions();

local mc = Tonic.TonicBars.DefaultConfiguration.MainConfig();
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

menu = Tonic.TonicBars.Menu.MainMenu();
plugin.GetOptionsPanel = function( self )
  return menu;
end

Turbine.Plugin.Unload = function(self, sender, args)
	for key, value in pairs (SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.BarService):GetBars()) do
		value:ClearQuickslots();
	end
end