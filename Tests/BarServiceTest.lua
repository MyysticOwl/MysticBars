
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

function BarServiceTest:TestAddQuickbar()
    self.barService:Add(QUICKSLOTBAR);
    local bars = self.barService:GetBars();
    Assert.IsTrue(bars[1] ~= nil, "Bar service can't be constructed");

    self.barService:Add(QUICKSLOTBAR);
    local bars = self.barService:GetBars();
    Assert.IsTrue(bars[2] ~= nil, "Bar service can't be constructed");

    self.barService:Add(QUICKSLOTBAR);
    local bars = self.barService:GetBars();
    Assert.IsTrue(bars[3] ~= nil, "Bar service can't be constructed");

    self.barService:Add(QUICKSLOTBAR);
    local bars = self.barService:GetBars();
    Assert.IsTrue(bars[4] ~= nil, "Bar service can't be constructed");

    self.barService:Remove(1);
    self.barService:Remove(2);
    self.barService:Remove(3);
    self.barService:Remove(4);
end

function BarServiceTest:TestAddExtensionbar()
    self.barService:Add(QUICKSLOTBAR);
   -- self.settingsService:GetBarSettings(1);

    -- self.barService:Add(EXTENSIONBAR, 1, 1);
    -- local bars = self.barService:GetBars();
    -- bars[1].extensionBars[1].bar:SetOrientation("Right");
    -- Assert.IsTrue(bars[1] ~= nil, "Bar service can't be constructed");
    -- Assert.IsTrue(bars[1].extensionBars[1].bar ~= nil, "Bar service can't be constructed");

    -- self.barService:Add(EXTENSIONBAR, 1, 2);
    -- local bars = self.barService:GetBars();
    -- bars[1].extensionBars[2].bar:SetOrientation("Left");
    -- Assert.IsTrue(bars[1] ~= nil, "Bar service can't be constructed");
    -- Assert.IsTrue(bars[1].extensionBars[2].bar ~= nil, "Bar service can't be constructed");

    -- self.barService:Add(QUICKSLOTBAR);
    -- self.barService:Add(EXTENSIONBAR, 2, 1);
    -- local bars = self.barService:GetBars();
    -- bars[2].extensionBars[1].bar:SetOrientation("Right");
    -- Assert.IsTrue(bars[2] ~= nil, "Bar service can't be constructed");
    -- Assert.IsTrue(bars[2].extensionBars[1].bar ~= nil, "Bar service can't be constructed");

   -- self.barService:Remove(1);
    -- self.barService:Remove(2);
    -- self.barService:Remove(3);
    -- self.barService:Remove(4);
end

function BarServiceTest:TestRemoveQuickslot()
    self.barService:Add(QUICKSLOTBAR);
    self.settingsService:GetBarSettings(1);
    local bars = self.barService:GetBars();
    Assert.IsTrue(bars[1] ~= nil, "Bar service can't be constructed");

    self.barService:Remove(1);
    Assert.IsTrue(bars[1] == nil, "Quickbars are removed successfully");
end

function BarServiceTest:TestRemoveQuickslotAndExtensions()
    self.barService:Add(QUICKSLOTBAR);
    self.settingsService:GetBarSettings(1);
    local bars = self.barService:GetBars();
    Assert.IsTrue(bars[1] ~= nil, "Bar service can't be constructed");

    self.barService:Add(EXTENSIONBAR, 1, 1);
    local bars = self.barService:GetBars();
    bars[1].extensionBars[1].bar:SetOrientation("Right");
    Assert.IsTrue(bars[1] ~= nil, "Bar service can't be constructed");
    Assert.IsTrue(bars[1].extensionBars[1].bar ~= nil, "Bar service can't be constructed");

    self.barService:Remove(1);
    Assert.IsTrue(bars[1] == nil, "Bar service can't be constructed");
    -- Assert.IsTrue(bars[1].extensionBars[1].bar == nil, "Extensions should be removed on Delete");
end

-- TODO:SE with barService and actual SettingsService.
-- function BarServiceTest:TestRemoveQuickslotAndMultiExtensions()
--     self.barService:Add(QUICKSLOTBAR);
--     self.settingsService:GetBarSettings(1);
--     local bars = self.barService:GetBars();
--     Assert.IsTrue(bars[1] ~= nil, "Bar service can't be constructed");

--     self.barService:Add(EXTENSIONBAR, 1, 1);
--     local bars = self.barService:GetBars();
--     bars[1].extensionBars[1].bar:SetOrientation("Right");
--     Assert.IsTrue(bars[1] ~= nil, "Bar service can't be constructed");
--     Assert.IsTrue(bars[1].extensionBars[1].bar ~= nil, "Bar service can't be constructed");

--     self.barService:Add(EXTENSIONBAR, 1, 2);
--     local bars = self.barService:GetBars();
--     bars[1].extensionBars[1].bar:SetOrientation("Right");
--     Assert.IsTrue(bars[1] ~= nil, "Bar service can't be constructed");
--     Assert.IsTrue(bars[1].extensionBars[2].bar ~= nil, "Bar service can't be constructed");

--     self.barService:Remove(1);
--     Assert.IsTrue(bars[1] == nil, "Bar service can't be constructed");
--     Assert.IsTrue(bars[1].extensionBars[1].bar == nil, "Extensions should be removed on Delete");
--     Assert.IsTrue(bars[1].extensionBars[2].bar == nil, "Extensions should be removed on Delete");
-- end

function BarServiceTest:TestAddInventorybar()
    self.barService:Add(TABBED_INV_BAR, 2);
    local bars = self.barService:GetBars();
    Assert.IsTrue(bars[2] ~= nil, "Bar service can't be constructed");

    self.barService:Add(TABBED_INV_BAR);
    local bars = self.barService:GetBars();
    Assert.IsTrue(bars[1] ~= nil, "Bar service can't be constructed");
end