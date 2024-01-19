
ExtensionbarTest = _G.unittest();

function ExtensionbarTest:Setup()
    SERVICE_CONTAINER:RemoveService(MysticBars.Services.SettingsService);
    SERVICE_CONTAINER:AddService(MysticBars.Tests.Services.TestSettingsService(), MysticBars.Services.SettingsService);
    SERVICE_CONTAINER:RemoveService(MysticBars.Services.BarService);
    SERVICE_CONTAINER:AddService(MysticBars.Services.BarService(), MysticBars.Services.BarService);
    self.barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
    self.settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
end

function ExtensionbarTest:TearDown()
    self.barService = nil;
    self.settingsService = nil;
    SERVICE_CONTAINER:RemoveService(MysticBars.Services.SettingsService);
    SERVICE_CONTAINER:AddService(MysticBars.Services.SettingsService(), MysticBars.Services.SettingsService);
    SERVICE_CONTAINER:RemoveService(MysticBars.Services.BarService);
    SERVICE_CONTAINER:AddService(MysticBars.Services.BarService(), MysticBars.Services.BarService);
end

function ExtensionbarTest:TestConstruction()
    local control = Turbine.UI.Control();
    local quickbarList = MysticBars.Bars.Core.QuickslotList(control, self.settingsService:NewBar());
    Assert.IsTrue(quickbarList ~= nil, "Bar service can't be constructed");
end

function ExtensionbarTest:NewBarSettings(id, name, cols, rows, quickslots, visible, locked, decorator, titleColor, backColor)
    local bar = {
        ["id"] = id,
        ["name"] = name,
        ["quickslotColumns"] = cols,
        ["quickslotRows"] = rows,
        ["quickslotCount"] = cols * rows,
        ["quickslots"] = quickslots,
        ["visible"] = visible,
        ["locked"] = locked,
        ["quickslotSpacing"] = 1.000000,
        ["quickslotSize"] = 36.000000,
        ["y"] = 550.000000,
        ["x"] = 240.000000,
        ["barType"] = 1.000000
    };

    self.settingsService:SetBarSettings(bar);
    local barSettings = self.settingsService:GetBarSettings(bar.id);
    if (decorator) then
        barSettings.decorator = decorator;
    end
    if (titleColor ~= nil) then
        if (decorator == TAB_BAR_DECORATOR) then
            barSettings.decorators.tab.titleColor = true;
            barSettings.decorators.tab.titleColorA = titleColor.A;
            barSettings.decorators.tab.titleColorR = titleColor.R;
            barSettings.decorators.tab.titleColorG = titleColor.G;
            barSettings.decorators.tab.titleColorB = titleColor.B;
        elseif (decorator == WINDOW_BAR_DECORATOR) then
            barSettings.decorators.window.titleColor = true;
            barSettings.decorators.window.titleColorA = titleColor.A;
            barSettings.decorators.window.titleColorR = titleColor.R;
            barSettings.decorators.window.titleColorG = titleColor.G;
            barSettings.decorators.window.titleColorB = titleColor.B;
        end
    end
    if (backColor ~= nil) then
        if (decorator == TAB_BAR_DECORATOR) then
            barSettings.decorators.tab.backColor = true;
            barSettings.decorators.tab.backColorA = backColor.A;
            barSettings.decorators.tab.backColorR = backColor.R;
            barSettings.decorators.tab.backColorG = backColor.G;
            barSettings.decorators.tab.backColorB = backColor.B;
        elseif (decorator == WINDOW_BAR_DECORATOR) then
            barSettings.decorators.window.backColor = true;
            barSettings.decorators.window.backColorA = backColor.A;
            barSettings.decorators.window.backColorR = backColor.R;
            barSettings.decorators.window.backColorG = backColor.G;
            barSettings.decorators.window.backColorB = backColor.B;
        end
    end
    self.settingsService:SetBarSettings(barSettings);
    return barSettings;
end


function ExtensionbarTest:TestAddExtensionbar()
    self.barService:Add(QUICKSLOTBAR);
    self.settingsService:GetBarSettings(1);

    self.barService:AddExtensionBar(self.settingsService:NewBar(), 1, 1);
    local bars = self.barService:GetBars();
    bars[1].extensionBars[1].bar:SetOrientation("Right");
    Assert.IsTrue(bars[1] ~= nil, "Bar service can't be constructed");
    Assert.IsTrue(bars[1].extensionBars[1].bar ~= nil, "Bar service can't be constructed");

    local settings, bar = self.barService:Add(QUICKSLOTBAR);
    self.barService:AddExtensionBar(self.settingsService:NewBar(), settings.id, 1);

    Assert.IsTrue(bar.extensionBars[1].bar ~= nil, "Bar service can't be constructed");
    bar.extensionBars[1].bar:SetOrientation("Right");
    Assert.IsTrue(bar ~= nil, "Bar service can't be constructed");
    Assert.IsTrue(bar.quickslotList.quickslots[1].MouseEnter ~= nil, "Bar service can't be constructed");

    self.barService:Remove(1);
    self.barService:Remove(2);
    self.barService:Remove(3);
    self.barService:Remove(4);
end

function ExtensionbarTest:TestShowExtensionbar()
    local barSettings, quickBar = self.barService:Add(QUICKSLOTBAR);
    self.settingsService:GetBarSettings(1);

    local barSettings, extBar = self.barService:AddExtensionBar(self.settingsService:NewBar(), 1, 1);
    extBar:SetOrientation("Left");

    Assert.IsTrue(not extBar:IsVisible(), "Bar Extension should be shown");

    quickBar.quickslotList.quickslots[1]:MouseEnter();

    Assert.IsTrue(extBar:IsVisible(), "Bar Extension should be shown");

    self.barService:Remove(1);
end
