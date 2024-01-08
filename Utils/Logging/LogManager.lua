-- This is just a static class with static methods only. Not using
-- the class function since I don't want this to be instantiatable.
LogManager = class();

-- Initialize static constants for log colors.
function LogManager:Constructor()
	self.loggers = { };
end

function LogManager.GetInstance()
	if ( LogManager.Instance == nil ) then
		LogManager.Instance = LogManager();
	end
	
	return LogManager.Instance;
end

function LogManager.GetLogger( name, active )
	local instance = LogManager:GetInstance();

	local logger = instance.loggers[name];

	if ( logger == nil ) then
		logger = instance:CreateLogger( name );
		if (active == false) then
			logger.active = false;
		end
		instance.loggers[name] = logger;
	end

	return logger;
end

function LogManager:CreateLogger( name )
	return Logger( name );
end

function LogManager:LoadLoggers()
	local logs = Turbine.PluginData.Load( Turbine.DataScope.Account, "MysticBarsLogging", function(logs)
		self:Load(logs);
	end);

	self:Load(logs);
	return logs;
end

function LogManager:Load(logs)
	local instance = LogManager:GetInstance();
	if (logs ~= nil) then
		for key, value in pairs(logs) do
			instance.loggers[key].active = value.active;
			instance.loggers[key].level = value.level;
		end
	end
end

function LogManager:DumpLoggers()
	local instance = LogManager:GetInstance();

	local loggers = {};
	for key, value in pairs(instance.loggers) do
		Turbine.Shell.WriteLine("Found Log ".. key);
		loggers[key] = {active = value.active, level = value.level};
	end

	Turbine.PluginData.Save( Turbine.DataScope.Account, "MysticBarsLogging", loggers, function (success, error)
		Turbine.Shell.WriteLine("Logging dump complete!");
	end);
end