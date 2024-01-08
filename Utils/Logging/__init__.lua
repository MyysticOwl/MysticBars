
import "MysticBars.Utils.Logging.Logger";
import "MysticBars.Utils.Logging.LogLevel";
import "MysticBars.Utils.Logging.LogManager";
import "MysticBars.Utils.Logging.DumpLoggingCommand";
import "MysticBars.Utils.Logging.LoadLoggingCommand";

dumpLoggingCommand = MysticBars.Utils.Logging.DumpLoggingCommand();
loadLoggingCommand = MysticBars.Utils.Logging.LoadLoggingCommand();


Turbine.Shell.AddCommand( "mysticbars_dump_loggers", dumpLoggingCommand );
Turbine.Shell.AddCommand( "mysticbars_load_loggers", loadLoggingCommand );