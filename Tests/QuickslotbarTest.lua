
QuickslotbarTest = _G.unittest();

function QuickslotbarTest:Setup()
    SERVICE_CONTAINER:RemoveService(MysticBars.Services.SettingsService);
    SERVICE_CONTAINER:AddService(MysticBars.Tests.Services.TestSettingsService(), MysticBars.Services.SettingsService);
    SERVICE_CONTAINER:RemoveService(MysticBars.Services.BarService);
    SERVICE_CONTAINER:AddService(MysticBars.Services.BarService(), MysticBars.Services.BarService);
    self.barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
    self.settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
end

function QuickslotbarTest:TearDown()
    self.barService = nil;
    self.settingsService = nil;
    SERVICE_CONTAINER:RemoveService(MysticBars.Services.SettingsService);
    SERVICE_CONTAINER:AddService(MysticBars.Services.SettingsService(), MysticBars.Services.SettingsService);
    SERVICE_CONTAINER:RemoveService(MysticBars.Services.BarService);
    SERVICE_CONTAINER:AddService(MysticBars.Services.BarService(), MysticBars.Services.BarService);
end

function QuickslotbarTest:TestConstruction()
    local control = Turbine.UI.Control();
    local quickbarList = MysticBars.Bars.Core.QuickslotList(control, self.settingsService:NewBar());
    Assert.IsTrue(quickbarList ~= nil, "Bar service can't be constructed");
end

function QuickslotbarTest:NewBarSettings(id, name, cols, rows, quickslots, visible, locked, decorator, titleColor, backColor)
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

function QuickslotbarTest:Test_Tab_LoadSlots()
    local bar = self:NewBarSettings(1, "TestSlotCount5", 5, 1, {
            [1.000000] = {
                ["Data"] = "0x70003E0D",
                ["Type"] = 6.000000
            }, [2.000000] = {
                ["Data"] = "0x7000F70C",
                ["Type"] = 6.000000
            }}, true, false);
    local quickslotBar = MysticBars.Bars.QuickslotBar(bar);

    for key,value in pairs(quickslotBar.quickslotList.quickslots) do
        if (key == 1) then
            Assert.IsTrue(value:GetShortcut():GetData() == "0x70003E0D", "Quickslots valid");
        end
        if (key == 2) then
            Assert.IsTrue(value:GetShortcut():GetData() == "0x7000F70C", "Quickslots valid");
        end
    end

    self.barService:Remove(bar.id);
end
function QuickslotbarTest:Test_Tab_LoadSlots_2()
    local bar = self:NewBarSettings(1, "TestSlotCount5", 5, 1, {
            [5.000000] = {
                ["Data"] = "0x70003E0D",
                ["Type"] = 6.000000
            }, [3.000000] = {
                ["Data"] = "0x7000F70C",
                ["Type"] = 6.000000
            }, [1.000000] = {
                ["Data"] = "0x70003EBF",
                ["Type"] = 6.000000
            }}, true, false);
    local quickslotBar = MysticBars.Bars.QuickslotBar(bar);

    for key,value in pairs(quickslotBar.quickslotList.quickslots) do
        if (key == 1) then
            Assert.IsTrue(value:GetShortcut():GetData() == "0x70003EBF", "Quickslots valid");
        end
        if (key == 5) then
            Assert.IsTrue(value:GetShortcut():GetData() == "0x70003E0D", "Quickslots valid");
        end
        if (key == 3) then
            Assert.IsTrue(value:GetShortcut():GetData() == "0x7000F70C", "Quickslots valid");
        end
    end

    self.barService:Remove(bar.id);
end
function QuickslotbarTest:Test_Window_LoadSlots()
    local bar = self:NewBarSettings(1, "TestSlotCount5", 5, 1, {
            [1.000000] = {
                ["Data"] = "0x70003E0D",
                ["Type"] = 6.000000
            }, [2.000000] = {
                ["Data"] = "0x7000F70C",
                ["Type"] = 6.000000
            }}, true, false, WINDOW_BAR_DECORATOR);
    local quickslotBar = MysticBars.Bars.QuickslotBar(bar);

    for key,value in pairs(quickslotBar.quickslotList.quickslots) do
        if (key == 1) then
            Assert.IsTrue(value:GetShortcut():GetData() == "0x70003E0D", "Quickslots valid");
        end
        if (key == 2) then
            Assert.IsTrue(value:GetShortcut():GetData() == "0x7000F70C", "Quickslots valid");
        end
    end

    self.barService:Remove(bar.id);
end
function QuickslotbarTest:Test_Window_LoadSlots_2()
    local bar = self:NewBarSettings(1, "TestSlotCount5", 5, 1, {
            [5.000000] = {
                ["Data"] = "0x70003E0D",
                ["Type"] = 6.000000
            }, [3.000000] = {
                ["Data"] = "0x7000F70C",
                ["Type"] = 6.000000
            }, [1.000000] = {
                ["Data"] = "0x70003EBF",
                ["Type"] = 6.000000
            }}, true, false, WINDOW_BAR_DECORATOR);
    local quickslotBar = MysticBars.Bars.QuickslotBar(bar);

    for key,value in pairs(quickslotBar.quickslotList.quickslots) do
        if (key == 1) then
            Assert.IsTrue(value:GetShortcut():GetData() == "0x70003EBF", "Quickslots valid");
        end
        if (key == 5) then
            Assert.IsTrue(value:GetShortcut():GetData() == "0x70003E0D", "Quickslots valid");
        end
        if (key == 3) then
            Assert.IsTrue(value:GetShortcut():GetData() == "0x7000F70C", "Quickslots valid");
        end
    end

    self.barService:Remove(bar.id);
end


function QuickslotbarTest:TestSlotCount5()
    local bar = self:NewBarSettings(1, "TestSlotCount5", 5, 1, {}, false, false);
    local quickslotBar = MysticBars.Bars.QuickslotBar(bar);

    local count = 0;
    for key,value in pairs(quickslotBar.quickslotList.quickslots) do
        count = count + 1;
    end

    Assert.IsTrue(count == 5, "Bar service can't be constructed");
    self.barService:Remove(bar.id);
end
function QuickslotbarTest:TestSlotCount10()
    local bar = self:NewBarSettings(1, "TestSlotCount10", 5, 2, {}, false, false);
    local quickslotBar = MysticBars.Bars.QuickslotBar(bar);

    local count = 0;
    for key,value in pairs(quickslotBar.quickslotList.quickslots) do
        count = count + 1;
    end

    Assert.IsTrue(count == 10, "Bar service can't be constructed");
    self.barService:Remove(bar.id);
end
function QuickslotbarTest:TestSlotCount25()
    local bar = self:NewBarSettings(1, "TestSlotCount25", 5, 5, {}, false, false);
    local quickslotBar = MysticBars.Bars.QuickslotBar(bar);

    local count = 0;
    for key,value in pairs(quickslotBar.quickslotList.quickslots) do
        count = count + 1;
    end

    Assert.IsTrue(count == 25, "Bar service can't be constructed");
    self.barService:Remove(bar.id);
end
function QuickslotbarTest:TestSlotCount5to1()
    local barSettings = self:NewBarSettings(1, "TestSlotCount5", 5, 1, {}, false, false);
    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);

    barSettings.quickslotRows = 1;
    barSettings.quickslotCount = 1;
    self.settingsService:SetBarSettings(barSettings);

    quickslotBar:Refresh(false);

    local count = 0;
    for key,value in pairs(quickslotBar.quickslotList.quickslots) do
        count = count + 1;
    end

    Assert.IsTrue(count == 1, "Bar service can't be constructed");
    self.barService:Remove(barSettings.id);
end
function QuickslotbarTest:TestSlotCount5to13()
    local barSettings = self:NewBarSettings(1, "TestSlotCount5", 5, 1, {}, false, false);
    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);

    barSettings.quickslotRows = 13;
    barSettings.quickslotCount = 13;
    self.settingsService:SetBarSettings(barSettings);

    quickslotBar:Refresh(false);

    local count = 0;
    for key,value in pairs(quickslotBar.quickslotList.quickslots) do
        count = count + 1;
    end

    Assert.IsTrue(count == 13, "Bar service can't be constructed");
    self.barService:Remove(barSettings.id);
end
function QuickslotbarTest:TestSlotCount5to20()
    local barSettings = self:NewBarSettings(1, "TestSlotCount5", 5, 1, {}, false, false);
    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);

    barSettings.quickslotRows = 4;
    barSettings.quickslotColumns = 5;
    barSettings.quickslotCount = 20;
    self.settingsService:SetBarSettings(barSettings);

    quickslotBar:Refresh(false);

    local count = 0;
    for key,value in pairs(quickslotBar.quickslotList.quickslots) do
        count = count + 1;
    end

    Assert.IsTrue(count == 20, "Bar service can't be constructed");
    self.barService:Remove(barSettings.id);
end


function QuickslotbarTest:Test_Tab_Normal_Mode_Visible()
    local bar = self:NewBarSettings(1, nil, 5, 1, {}, true, false);
    local quickslotBar = MysticBars.Bars.QuickslotBar(bar);

    Assert.IsTrue(quickslotBar:IsVisible(), "Bar should be visible");
    Assert.IsTrue(quickslotBar.quickslotList:IsVisible(), "Bar should be visible");
    Assert.IsTrue(not quickslotBar.decorator.tab:IsVisible(), "Bar should be visible");
    for key,value in pairs(quickslotBar.quickslotList.quickslots) do
        Assert.IsTrue(value:IsVisible(), "Quickslots should be visible");
    end
    self.barService:Remove(bar.id);
end
function QuickslotbarTest:Test_Tab_EditMode_Visible()
    local bar = self:NewBarSettings(1, nil, 5, 1, {}, true, false);
    self.settingsService.settings.barMode=QUICKSLOT_MODE;
    local quickslotBar = MysticBars.Bars.QuickslotBar(bar);

    Assert.IsTrue(quickslotBar:IsVisible(), "Bar should be visible");
    Assert.IsTrue(quickslotBar.quickslotList:IsVisible(), "Bar should be visible");
    Assert.IsTrue(quickslotBar.decorator.tab:IsVisible(), "Bar should be visible");
    for key,value in pairs(quickslotBar.quickslotList.quickslots) do
        Assert.IsTrue(value:IsVisible(), "Quickslots should be visible");
    end
    self.barService:Remove(bar.id);
end
function QuickslotbarTest:Test_Window_Normal_Mode_Visible()
    local barSettings = self:NewBarSettings(1, nil, 5, 1, {}, true, false, WINDOW_BAR_DECORATOR);
    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);

    Assert.IsTrue(quickslotBar:IsVisible(), "Bar should be visible");
    Assert.IsTrue(quickslotBar.quickslotList:IsVisible(), "Bar should be visible");
    Assert.IsTrue(quickslotBar.decorator.mainWindow:IsVisible(), "Bar should be visible");
    for key,value in pairs(quickslotBar.quickslotList.quickslots) do
        Assert.IsTrue(value:IsVisible(), "Quickslots should be visible");
    end
    self.barService:Remove(barSettings.id);
end
function QuickslotbarTest:Test_Window_EditMode_Visible()
    local barSettings = self:NewBarSettings(1, nil, 5, 1, {}, true, false, WINDOW_BAR_DECORATOR);
    self.settingsService.settings.barMode=QUICKSLOT_MODE;
    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);

    Assert.IsTrue(quickslotBar:IsVisible(), "Bar should be visible");
    Assert.IsTrue(quickslotBar.quickslotList:IsVisible(), "Bar should be visible");
    Assert.IsTrue(quickslotBar.decorator.mainWindow:IsVisible(), "Bar should be visible");
    for key,value in pairs(quickslotBar.quickslotList.quickslots) do
        Assert.IsTrue(value:IsVisible(), "Quickslots should be visible");
    end
    self.barService:Remove(barSettings.id);
end


function QuickslotbarTest:Test_Tab_Normal_Mode_Visible_TitleColor()
    local titleColor = Turbine.UI.Color(1, 1, 0, 0);
    local barSettings = self:NewBarSettings(1, nil, 5, 1, {}, true, false, TAB_BAR_DECORATOR, titleColor);
    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);

    local actualTabColor = quickslotBar.decorator.tab:GetBackColor();

    Assert.IsTrue(quickslotBar:IsVisible(), "Bar should be visible");
    Assert.IsTrue(quickslotBar.quickslotList:IsVisible(), "Bar should be visible");
    Assert.IsTrue(quickslotBar.decorator.tab:IsVisible(), "Bar should be visible");
    Assert.IsTrue(actualTabColor.A == titleColor.A and actualTabColor.R == titleColor.R and actualTabColor.G == titleColor.G and actualTabColor.B == titleColor.B, "Bar should be visible");

    self.barService:Remove(barSettings.id);
end
function QuickslotbarTest:Test_Tab_Normal_Mode_Visible_BackColor()
    local backColor = Turbine.UI.Color(1, 0, 0, 1);
    local barSettings = self:NewBarSettings(1, nil, 5, 1, {}, true, false, TAB_BAR_DECORATOR, nil, backColor);
    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);

    local actualBackColor = quickslotBar.decorator.back:GetBackColor();

    Assert.IsTrue(quickslotBar:IsVisible(), "Bar should be visible");
    Assert.IsTrue(quickslotBar.quickslotList:IsVisible(), "Bar should be visible");
    Assert.IsTrue(not quickslotBar.decorator.tab:IsVisible(), "Bar should be visible");
    Assert.IsTrue(actualBackColor.A == backColor.A and actualBackColor.R == backColor.R and actualBackColor.G == backColor.G and actualBackColor.B == backColor.B, "Bar should be visible");

    self.barService:Remove(barSettings.id);
end
function QuickslotbarTest:Test_Tab_Normal_Mode_Visible_TitleColor_BackColor()
    local titleColor = Turbine.UI.Color(1, 1, 0, 0);
    local backColor = Turbine.UI.Color(1, 0, 0, 1);
    local barSettings = self:NewBarSettings(1, nil, 5, 1, {}, true, false, TAB_BAR_DECORATOR, titleColor, backColor);
    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);

    local actualTabColor = quickslotBar.decorator.tab:GetBackColor();
    local actualBackColor = quickslotBar.decorator.back:GetBackColor();

    Assert.IsTrue(quickslotBar:IsVisible(), "Bar should be visible");
    Assert.IsTrue(quickslotBar.quickslotList:IsVisible(), "Bar should be visible");
    Assert.IsTrue(quickslotBar.decorator.tab:IsVisible(), "Bar should be visible");
    Assert.IsTrue(actualTabColor.A == titleColor.A and actualTabColor.R == titleColor.R and actualTabColor.G == titleColor.G and actualTabColor.B == titleColor.B, "Bar should be visible");
    Assert.IsTrue(actualBackColor.A == backColor.A and actualBackColor.R == backColor.R and actualBackColor.G == backColor.G and actualBackColor.B == backColor.B, "Bar should be visible");

    self.barService:Remove(barSettings.id);
end

function QuickslotbarTest:Test_Window_Normal_Mode_Visible_TitleColor()
    local titleColor = Turbine.UI.Color(1, 1, 0, 0);
    local barSettings = self:NewBarSettings(1, nil, 5, 1, {}, true, false, WINDOW_BAR_DECORATOR, titleColor);
    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);

    local actualTabColor = quickslotBar.decorator.mainWindow.title:GetBackColor();

    Assert.IsTrue(quickslotBar:IsVisible(), "Bar should be visible");
    Assert.IsTrue(quickslotBar.quickslotList:IsVisible(), "Bar should be visible");
    Assert.IsTrue(quickslotBar.decorator.mainWindow.title:IsVisible(), "Bar should be visible");
    Assert.IsTrue(actualTabColor.A == titleColor.A and actualTabColor.R == titleColor.R and actualTabColor.G == titleColor.G and actualTabColor.B == titleColor.B, "Bar should be visible");

    self.barService:Remove(barSettings.id);
end
function QuickslotbarTest:Test_Window_Normal_Mode_Visible_BackColor()
    local backColor = Turbine.UI.Color(1, 0, 1, 1);
    local barSettings = self:NewBarSettings(1, nil, 5, 1, {}, true, false, WINDOW_BAR_DECORATOR, nil, backColor);
    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);

    local actualBackColor = quickslotBar.decorator.mainWindow.center:GetBackColor();

    Assert.IsTrue(quickslotBar:IsVisible(), "Bar should be visible");
    Assert.IsTrue(quickslotBar.quickslotList:IsVisible(), "Bar should be visible");
    Assert.IsTrue(quickslotBar.decorator.mainWindow.center:IsVisible(), "Bar should be visible");
    Assert.IsTrue(actualBackColor.A == backColor.A and actualBackColor.R == backColor.R and actualBackColor.G == backColor.G and actualBackColor.B == backColor.B, "Bar should be visible");

    self.barService:Remove(barSettings.id);
end
function QuickslotbarTest:Test_Window_Normal_Mode_Visible_TitleColor_BackColor()
    local titleColor = Turbine.UI.Color(1, 1, 1, 0);
    local backColor = Turbine.UI.Color(0.5, 1, 0, 1);
    local barSettings = self:NewBarSettings(1, nil, 5, 1, {}, true, false, WINDOW_BAR_DECORATOR, titleColor, backColor);
    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);

    local actualTabColor = quickslotBar.decorator.mainWindow.title:GetBackColor();
    local actualBackColor = quickslotBar.decorator.mainWindow.center:GetBackColor();

    Assert.IsTrue(quickslotBar:IsVisible(), "Bar should be visible");
    Assert.IsTrue(quickslotBar.quickslotList:IsVisible(), "Bar should be visible");
    Assert.IsTrue(quickslotBar.decorator.mainWindow.title:IsVisible(), "Bar should be visible");
    Assert.IsTrue(quickslotBar.decorator.mainWindow.center:IsVisible(), "Bar should be visible");
    Assert.IsTrue(actualTabColor.A == titleColor.A and actualTabColor.R == titleColor.R and actualTabColor.G == titleColor.G and actualTabColor.B == titleColor.B, "Bar should be visible");
    Assert.IsTrue(actualBackColor.A == backColor.A and actualBackColor.R == backColor.R and actualBackColor.G == backColor.G and actualBackColor.B == backColor.B, "Bar should be visible");

    self.barService:Remove(barSettings.id);
end

function QuickslotbarTest:Test_Tab_Normal_Mode_NotVisible()
    local barSettings = self:NewBarSettings(1, nil, 5, 1, {}, false, false);
    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);

    Assert.IsTrue(not quickslotBar:IsVisible(), "Bar should be visible");
    Assert.IsTrue(not quickslotBar.decorator.tab:IsVisible(), "Bar should be visible");

    self.barService:Remove(barSettings.id);
end
function QuickslotbarTest:Test_Tab_EditMode_NotVisible()
    local barSettings = self:NewBarSettings(1, nil, 5, 1, {}, false, false);
    self.settingsService.settings.barMode=QUICKSLOT_MODE;
    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);

    Assert.IsTrue(quickslotBar:IsVisible(), "Bar should be visible");
    Assert.IsTrue(quickslotBar.quickslotList:IsVisible(), "Bar should be visible");
    Assert.IsTrue(quickslotBar.decorator.tab:IsVisible(), "Bar should be visible");
    for key,value in pairs(quickslotBar.quickslotList.quickslots) do
        Assert.IsTrue(value:IsVisible(), "Quickslots should be visible");
    end

    self.barService:Remove(barSettings.id);
end
function QuickslotbarTest:Test_Window_Normal_Mode_NotVisible()
    local barSettings = self:NewBarSettings(1, nil, 5, 1, {}, false, false, WINDOW_BAR_DECORATOR);
    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);

    Assert.IsTrue(not quickslotBar:IsVisible(), "Bar should be visible");
    Assert.IsTrue(not quickslotBar.decorator.mainWindow:IsVisible(), "Bar should be visible");

    self.barService:Remove(barSettings.id);
end
function QuickslotbarTest:Test_Window_EditMode_NotVisible()
    local barSettings = self:NewBarSettings(1, nil, 5, 1, {}, false, false, WINDOW_BAR_DECORATOR);
    self.settingsService.settings.barMode=QUICKSLOT_MODE;
    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);

    Assert.IsTrue(quickslotBar:IsVisible(), "Bar should be visible");
    Assert.IsTrue(quickslotBar.quickslotList:IsVisible(), "Bar should be visible");
    Assert.IsTrue(quickslotBar.decorator.mainWindow:IsVisible(), "Bar should be visible");
    for key,value in pairs(quickslotBar.quickslotList.quickslots) do
        Assert.IsTrue(value:IsVisible(), "Quickslots should be visible");
    end
    
    self.barService:Remove(barSettings.id);
end


function QuickslotbarTest:Test_Tab_Normal_Mode_Unlocked()
    local barSettings = self:NewBarSettings(1, nil, 5, 1, {}, true, false);
    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);

    for key,value in pairs(quickslotBar.quickslotList.quickslots) do
        Assert.IsTrue(value:GetAllowDrop(), "Quickslots should allow drops");
    end
    
    self.barService:Remove(barSettings.id);
end
function QuickslotbarTest:Test_Tab_EditMode_Visible_Unlocked()
    local barSettings = self:NewBarSettings(1, nil, 5, 1, {}, true, false);
    self.settingsService.settings.barMode=QUICKSLOT_MODE;
    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);

    for key,value in pairs(quickslotBar.quickslotList.quickslots) do
        Assert.IsTrue(value:GetAllowDrop(), "Quickslots should allow drops");
    end

    self.barService:Remove(barSettings.id);
end
function QuickslotbarTest:Test_Window_Normal_Mode_Visible_Unlocked()
    local barSettings = self:NewBarSettings(1, nil, 5, 1, {}, true, false, WINDOW_BAR_DECORATOR);
    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);

    for key,value in pairs(quickslotBar.quickslotList.quickslots) do
        Assert.IsTrue(value:GetAllowDrop(), "Quickslots should allow drops");
    end
    
    self.barService:Remove(barSettings.id);
end
function QuickslotbarTest:Test_Window_EditMode_Visible_Unlocked()
    local barSettings = self:NewBarSettings(1, nil, 5, 1, {}, true, false, WINDOW_BAR_DECORATOR);
    self.settingsService.settings.barMode=QUICKSLOT_MODE;
    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);

    for key,value in pairs(quickslotBar.quickslotList.quickslots) do
        Assert.IsTrue(value:GetAllowDrop(), "Quickslots should allow drops");
    end

    self.barService:Remove(barSettings.id);
end


function QuickslotbarTest:Test_Tab_Normal_Mode_Locked()
    local barSettings = self:NewBarSettings(1, nil, 5, 1, {}, true, true);
    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);

    for key,value in pairs(quickslotBar.quickslotList.quickslots) do
        Assert.IsTrue(not value:GetAllowDrop(), "Quickslots should allow drops");
    end
    
    self.barService:Remove(barSettings.id);
end
function QuickslotbarTest:Test_Tab_EditMode_Visible_Locked()
    local barSettings = self:NewBarSettings(1, nil, 5, 1, {}, true, true);
    self.settingsService.settings.barMode=QUICKSLOT_MODE;
    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);

    for key,value in pairs(quickslotBar.quickslotList.quickslots) do
        Assert.IsTrue(not value:GetAllowDrop(), "Quickslots should allow drops");
    end
    
    self.barService:Remove(barSettings.id);
end
function QuickslotbarTest:Test_Window_Normal_Mode_Visible_Locked()
    local barSettings = self:NewBarSettings(1, nil, 5, 1, {}, true, true, WINDOW_BAR_DECORATOR);
    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);

    for key,value in pairs(quickslotBar.quickslotList.quickslots) do
        Assert.IsTrue(not value:GetAllowDrop(), "Quickslots should allow drops");
    end

    self.barService:Remove(barSettings.id);
end
function QuickslotbarTest:Test_Window_EditMode_Visible_Locked()
    local barSettings = self:NewBarSettings(1, nil, 5, 1, {}, true, true, WINDOW_BAR_DECORATOR);
    self.settingsService.settings.barMode=QUICKSLOT_MODE;
    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);

    for key,value in pairs(quickslotBar.quickslotList.quickslots) do
        Assert.IsTrue(not value:GetAllowDrop(), "Quickslots should allow drops");
    end

    self.barService:Remove(barSettings.id);
end


function QuickslotbarTest:Test_Tab_To_Window()
    local barSettings = self:NewBarSettings(1, nil, 5, 1, {}, true, true, TAB_BAR_DECORATOR);
    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);
    barSettings.decorator = WINDOW_BAR_DECORATOR;

    quickslotBar:Refresh(false);

    Assert.IsTrue(quickslotBar.decorator.tab == nil, "Bar should be visible");
    Assert.IsTrue(quickslotBar.decorator.mainWindow.title:IsVisible(), "Bar should be visible");
    Assert.IsTrue(quickslotBar.decorator.mainWindow.center:IsVisible(), "Bar should be visible");

    self.barService:Remove(barSettings.id);
end
function QuickslotbarTest:Test_Window_To_Tab()
    local barSettings = self:NewBarSettings(1, nil, 5, 1, {}, true, true, WINDOW_BAR_DECORATOR);
    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);
    barSettings.decorator = TAB_BAR_DECORATOR;

    quickslotBar:Refresh(false);

    Assert.IsTrue(quickslotBar.decorator.tab ~= nil, "Bar should be visible");
    Assert.IsTrue(quickslotBar.decorator.mainWindow == nil, "Bar should be visible");

    self.barService:Remove(barSettings.id);
end
function QuickslotbarTest:Test_Tab_To_Window_And_Back()
    local barSettings = self:NewBarSettings(1, nil, 5, 1, {}, true, true, TAB_BAR_DECORATOR);
    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);

    barSettings.decorator = WINDOW_BAR_DECORATOR;
    quickslotBar:Refresh(false);

    barSettings.decorator = TAB_BAR_DECORATOR;
    quickslotBar:Refresh(false);

    Assert.IsTrue(quickslotBar.decorator.tab ~= nil, "Bar should be visible");
    Assert.IsTrue(quickslotBar.decorator.mainWindow == nil, "Bar should be visible");

    self.barService:Remove(barSettings.id);
end
function QuickslotbarTest:Test_Window_To_Tab_And_Back()
    local barSettings = self:NewBarSettings(1, nil, 5, 1, {}, true, true, WINDOW_BAR_DECORATOR);
    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);

    barSettings.decorator = TAB_BAR_DECORATOR;
    quickslotBar:Refresh(false);

    barSettings.decorator = WINDOW_BAR_DECORATOR;
    quickslotBar:Refresh(false);

    Assert.IsTrue(quickslotBar.decorator.tab == nil, "Bar should be visible");
    Assert.IsTrue(quickslotBar.decorator.mainWindow ~= nil, "Bar should be visible");

    self.barService:Remove(barSettings.id);
end
