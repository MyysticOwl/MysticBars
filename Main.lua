-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "MysticBars";

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

MysticBars.Bars.Templates.BarTemplates():CheckTemplates();

local bag = MysticBars.Bag.ManagedBagBar();

Turbine.Shell.WriteLine( "----------------------------" );
Turbine.Shell.WriteLine( "MysticBars " .. THEVERSION .. " from MyysticOwl" );
Turbine.Shell.WriteLine( "usage: /mb; /MysticBars" );
Turbine.Shell.WriteLine( "----------------------------" );

ShellCommand = Turbine.ShellCommand()
Turbine.Shell.AddCommand('mb', ShellCommand);
Turbine.Shell.AddCommand('mysticbars', ShellCommand);

function ShellCommand:Execute(command, arguments)
	Turbine.PluginManager.ShowOptions(Plugins["MysticBars"]);
end


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

MysticBars.Utils.Logging.LogManager.GetInstance():LoadLoggers();

-- import "MysticBars.Tools.EasyBarMapper"
-- import "MysticBars.Tools.SkillMapper"