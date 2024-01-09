
BarServiceTest = _G.unittest();

function BarServiceTest:Setup()
    SERVICE_CONTAINER:RemoveService(MysticBars.Services.SettingsService);
    SERVICE_CONTAINER:AddService(MysticBars.Tests.Services.TestSettingsService(), MysticBars.Services.SettingsService);
    SERVICE_CONTAINER:RemoveService(MysticBars.Services.BarService);
    SERVICE_CONTAINER:AddService(MysticBars.Services.BarService(), MysticBars.Services.BarService);
    self.barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
    self.settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
end

function BarServiceTest:TearDown()
    self.barService = nil;
    self.settingsService = nil;
    SERVICE_CONTAINER:RemoveService(MysticBars.Services.SettingsService);
    SERVICE_CONTAINER:AddService(MysticBars.Services.SettingsService(), MysticBars.Services.SettingsService);
    SERVICE_CONTAINER:RemoveService(MysticBars.Services.BarService);
    SERVICE_CONTAINER:AddService(MysticBars.Services.BarService(), MysticBars.Services.BarService);
end

function BarServiceTest:TestConstruction()
    Assert.IsTrue(self.barService ~= nil, "Bar service can't be constructed");
end
