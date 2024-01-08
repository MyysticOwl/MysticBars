
LoggingDisabledTest = _G.unittest();

function LoggingDisabledTest:TestAllLoggersDisabled()
    local logManager = MysticBars.Utils.Logging.LogManager:GetInstance();
    for key, value in pairs(logManager.loggers) do
        if (value.active) then
            Assert.IsTrue(value.level == LogLevel.Warn, "Expect all loggers to be Info or below. " .. key .. " was " .. value.level);
        end
    end
end