
QuickbarListTest = _G.unittest();

function QuickbarListTest:Setup()
    local bars = {};
    bars[1] = {
        ["visible"] = false,
        ["onMouseOver"] = 1.000000,
        ["relationalY"] = 0.556117,
        ["opacity"] = 1.000000,
        ["quickslotColumns"] = 5.000000,
        ["locked"] = false,
        ["backgroundColorBlue"] = 0.000000,
        ["backgroundColorGreen"] = 0.000000,
        ["quickslots"] = 
        {
            [1.000000] = 
            {
                ["Data"] = "0x70003E0D",
                ["Type"] = 6.000000
            },
            [2.000000] = 
            {
                ["Data"] = "0x7000F70C",
                ["Type"] = 6.000000
            }
        },
        ["quickslotSpacing"] = 1.000000,
        ["quickslotSize"] = 36.000000,
        ["useBackgroundColor"] = false,
        ["barName"] = "Tier5",
        ["useFading"] = false,
        ["quickslotCount"] = 5.000000,
        ["y"] = 550.000000,
        ["x"] = 240.000000,
        ["events"] = 
        {
            ["inventory"] = 
            {
                ["quantity"] = 50.000000
            },
            ["classRange"] = 
            {
                ["Fervor"] = 
                {
                    ["maxValue"] = 5.000000,
                    ["minValue"] = 5.000000,
                    ["active"] = true
                }
            },
            ["triggered"] = 
            {
                ["triggerBuffType"] = "or",
                ["healthTrigger"] = 0.250000,
                ["powerTrigger"] = 0.250000,
                ["triggerOnClassBuffActive"] = true
            },
            ["effects"] = 
            {
                ["Tier5"] = true
            }
        },
        ["fadeOpacity"] = 1.000000,
        ["relationalX"] = 0.126249,
        ["barType"] = 1.000000,
        ["quickslotRows"] = 1.000000,
        ["backgroundColorRed"] = 0.000000
    };

    SERVICE_CONTAINER:RemoveService(MysticBars.Services.SettingsService);
    SERVICE_CONTAINER:AddService(MysticBars.Tests.Services.TestSettingsService(nil, bars), MysticBars.Services.SettingsService);
    SERVICE_CONTAINER:RemoveService(MysticBars.Services.BarService);
    SERVICE_CONTAINER:AddService(MysticBars.Services.BarService(), MysticBars.Services.BarService);
    self.barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
    self.settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
end

function QuickbarListTest:TearDown()
    self.barService = nil;
    self.settingsService = nil;
    SERVICE_CONTAINER:RemoveService(MysticBars.Services.SettingsService);
    SERVICE_CONTAINER:AddService(MysticBars.Services.SettingsService(), MysticBars.Services.SettingsService);
    SERVICE_CONTAINER:RemoveService(MysticBars.Services.BarService);
    SERVICE_CONTAINER:AddService(MysticBars.Services.BarService(), MysticBars.Services.BarService);
end

function QuickbarListTest:TestConstruction()
    local quickbarList = MysticBars.Bars.Core.QuickslotList();
    Assert.IsTrue(quickbarList ~= nil, "Bar service can't be constructed");
end

function QuickbarListTest:SlotCount()
    local quickbarList = MysticBars.Bars.Core.QuickslotList(1);
    quickbarList:Refresh(false, false);

    local count = 0;
    for key,value in pairs(quickbarList.quickslots) do
        count = count + 1;
    end

    Assert.IsTrue(count == 5, "Bar service can't be constructed");
end