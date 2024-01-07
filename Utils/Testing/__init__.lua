
import "MysticBars.Utils.Testing.Assert";
import "MysticBars.Utils.Testing.ShellTestRunner";
import "MysticBars.Utils.Testing.TestResults";
import "MysticBars.Utils.Testing.TestRunner";
import "MysticBars.Utils.Testing.UnitTest";
import "MysticBars.Utils.Testing.UnitTestCommand";

unitTestCommand = MysticBars.Utils.Testing.UnitTestCommand();

Turbine.Shell.AddCommand( "mysticbars_unittest", unitTestCommand );