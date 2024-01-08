LoadLoggingCommand = class( Turbine.ShellCommand );

function LoadLoggingCommand:Execute( command, arguments )
	local logManager = LogManager.GetInstance();
	logManager:LoadLoggers();
end

function LoadLoggingCommand:GetHelp()
	return "Executes a unit test.";
end

function LoadLoggingCommand:GetShortHelp()
	return "Executes a unit test.";
end
