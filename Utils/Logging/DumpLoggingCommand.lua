DumpLoggingCommand = class( Turbine.ShellCommand );

function DumpLoggingCommand:Execute( command, arguments )
	local logManager = LogManager.GetInstance();
	logManager:DumpLoggers();
end

function DumpLoggingCommand:GetHelp()
	return "Executes a unit test.";
end

function DumpLoggingCommand:GetShortHelp()
	return "Executes a unit test.";
end
