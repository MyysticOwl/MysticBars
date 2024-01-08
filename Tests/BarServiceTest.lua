
BarServiceTest = _G.unittest();

function BarServiceTest:Setup()
    SERVICE_CONTAINER:RemoveService(MysticBars.Services.SettingsService);
    SERVICE_CONTAINER:AddService(MysticBars.Tests.Services.TestSettingsService(), MysticBars.Services.SettingsService);
    SERVICE_CONTAINER:RemoveService(MysticBars.Services.BarService);
    SERVICE_CONTAINER:AddService(MysticBars.Services.BarService(), MysticBars.Services.BarService);
    self.barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
end

function BarServiceTest:TearDown()
    self.barService = nil;
    -- SERVICE_CONTAINER:AddService(MysticBars.Services.SettingsService(), MysticBars.Services.SettingsService);
    -- SERVICE_CONTAINER:AddService(MysticBars.Services.SettingsService(), MysticBars.Services.BarService);
end

function BarServiceTest:TestConstruction()
    Assert.IsTrue(self.barService ~= nil, "Bar service can't be constructed");
end

function BarServiceTest:TestAddQuickbar()
    self.barService:Add(QUICKSLOTBAR, 1);
    local bars = self.barService:GetBars();
    Assert.IsTrue(bars[1] ~= nil, "Bar service can't be constructed");

    self.barService:Add(QUICKSLOTBAR);
    local bars = self.barService:GetBars();
    Assert.IsTrue(bars[2] ~= nil, "Bar service can't be constructed");

    self.barService:Add(QUICKSLOTBAR, 3);
    local bars = self.barService:GetBars();
    Assert.IsTrue(bars[3] ~= nil, "Bar service can't be constructed");

    self.barService:Add(QUICKSLOTBAR);
    local bars = self.barService:GetBars();
    Assert.IsTrue(bars[4] ~= nil, "Bar service can't be constructed");
end

function BarServiceTest:TestAddExtensionbar()
    self.barService:Add(QUICKSLOTBAR, 1);
    self.barService:Add(EXTENSIONBAR, 1, 1);
    local bars = self.barService:GetBars();
    Assert.IsTrue(bars[1] ~= nil, "Bar service can't be constructed");
    Assert.IsTrue(bars[1].extensionBars[1].bar ~= nil, "Bar service can't be constructed");

    self.barService:Add(EXTENSIONBAR, 1, 2);
    local bars = self.barService:GetBars();
    Assert.IsTrue(bars[1] ~= nil, "Bar service can't be constructed");
    Assert.IsTrue(bars[1].extensionBars[2].bar ~= nil, "Bar service can't be constructed");

    self.barService:Add(QUICKSLOTBAR, 2);
    self.barService:Add(EXTENSIONBAR, 2, 1);
    local bars = self.barService:GetBars();
    Assert.IsTrue(bars[2] ~= nil, "Bar service can't be constructed");
    Assert.IsTrue(bars[2].extensionBars[1].bar ~= nil, "Bar service can't be constructed");
end

function BarServiceTest:TestAddInventorybar()
    self.barService:Add(TABBED_INV_BAR, 2);
    local bars = self.barService:GetBars();
    Assert.IsTrue(bars[2] ~= nil, "Bar service can't be constructed");

    self.barService:Add(TABBED_INV_BAR);
    local bars = self.barService:GetBars();
    Assert.IsTrue(bars[1] ~= nil, "Bar service can't be constructed");
end