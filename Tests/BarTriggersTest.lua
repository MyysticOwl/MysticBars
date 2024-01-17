
QuickslotbarTest = _G.unittest();

function QuickslotbarTest:Setup()
    SERVICE_CONTAINER:RemoveService(MysticBars.Services.SettingsService);
    SERVICE_CONTAINER:AddService(MysticBars.Tests.Services.TestSettingsService(), MysticBars.Services.SettingsService);
    SERVICE_CONTAINER:RemoveService(MysticBars.Services.BarService);
    SERVICE_CONTAINER:AddService(MysticBars.Services.BarService(), MysticBars.Services.BarService);
    SERVICE_CONTAINER:RemoveService(MysticBars.Services.EventService);
    SERVICE_CONTAINER:AddService(MysticBars.Services.EventService(), MysticBars.Services.EventService);

    self.barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
    self.eventService = SERVICE_CONTAINER:GetService(MysticBars.Services.EventService);
    self.playerService = SERVICE_CONTAINER:GetService(MysticBars.Services.PlayerService);
    self.settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

    self.eventService:StartManager();
end

function QuickslotbarTest:TearDown()
    self.barService = nil;
    self.settingsService = nil;
    SERVICE_CONTAINER:RemoveService(MysticBars.Services.SettingsService);
    SERVICE_CONTAINER:AddService(MysticBars.Services.SettingsService(), MysticBars.Services.SettingsService);
    SERVICE_CONTAINER:RemoveService(MysticBars.Services.BarService);
    SERVICE_CONTAINER:AddService(MysticBars.Services.BarService(), MysticBars.Services.BarService);
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

function QuickslotbarTest:Test_Tab_Buff_Triggered()
    local barSettings = self:NewBarSettings(6, nil, 5, 1, {}, false, false);

    barSettings.events = {triggered = {triggerOnClassBuffActive = true}};
    barSettings.events.effects = {["Superior Study"] = true};
    self.settingsService:SetBarSettings(barSettings);

    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);

    Assert.IsTrue(not quickslotBar:IsVisible(), "Bar should be visible");

    self.eventService.buffEvents.registeredEvents.classes[ self.playerService.playerClass ].effects["Superior Study"] = {count = 1};
    SERVICE_CONTAINER:GetService(MysticBars.Services.EventService):NotifyClients();

    Assert.IsTrue(quickslotBar:IsVisible(), "Bar should be visible");
    Assert.IsTrue(not quickslotBar.decorator.tab:IsVisible(), "Bar should be visible");
    self.barService:Remove(barSettings.id);
end
function QuickslotbarTest:Test_Window_Buff_Triggered()
    local barSettings = self:NewBarSettings(6, nil, 5, 1, {}, false, false, WINDOW_BAR_DECORATOR);

    barSettings.events = {triggered = {triggerOnClassBuffActive = true}};
    barSettings.events.effects = {["Camp-fire"] = true};
    self.settingsService:SetBarSettings(barSettings);

    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);

    Assert.IsTrue(not quickslotBar:IsVisible(), "Bar should be visible");

    self.eventService.buffEvents.registeredEvents.classes[ self.playerService.playerClass ].effects["Camp-fire"] = {count = 1};
    SERVICE_CONTAINER:GetService(MysticBars.Services.EventService):NotifyClients();

    Assert.IsTrue(quickslotBar:IsVisible(), "Bar should be visible");
    Assert.IsTrue(quickslotBar.decorator.mainWindow:IsVisible(), "Bar should be visible");
    self.barService:Remove(barSettings.id);
end


function QuickslotbarTest:Test_Tab_Health_Triggered()
    local barSettings = self:NewBarSettings(6, nil, 5, 1, {}, false, false);

    barSettings.events = {triggered = {displayOnHealth = true, healthTrigger=.85}};
    self.settingsService:SetBarSettings(barSettings);

    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);

    Assert.IsTrue(not quickslotBar:IsVisible(), "Bar should be visible");

    self.eventService.buffEvents.registeredEvents.healthTriggerActive = .90;
    SERVICE_CONTAINER:GetService(MysticBars.Services.EventService):NotifyClients();

    Assert.IsTrue(not quickslotBar:IsVisible(), "Bar should be visible");
    Assert.IsTrue(not quickslotBar.decorator.tab:IsVisible(), "Bar should be visible");

    self.eventService.buffEvents.registeredEvents.healthTriggerActive = .80;
    SERVICE_CONTAINER:GetService(MysticBars.Services.EventService):NotifyClients();

    Assert.IsTrue(quickslotBar:IsVisible(), "Bar should be visible");
    Assert.IsTrue(not quickslotBar.decorator.tab:IsVisible(), "Bar should be visible");

    self.barService:Remove(barSettings.id);
end
function QuickslotbarTest:Test_Window_Health_Triggered()
    local barSettings = self:NewBarSettings(6, nil, 5, 1, {}, false, false, WINDOW_BAR_DECORATOR);

    barSettings.events = {triggered = {displayOnHealth = true, healthTrigger=.75}};
    self.settingsService:SetBarSettings(barSettings);

    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);

    Assert.IsTrue(not quickslotBar:IsVisible(), "Bar should be visible");

    self.eventService.buffEvents.registeredEvents.healthTriggerActive = .90;
    SERVICE_CONTAINER:GetService(MysticBars.Services.EventService):NotifyClients();

    Assert.IsTrue(not quickslotBar:IsVisible(), "Bar should be visible");
    Assert.IsTrue(not quickslotBar.decorator.mainWindow:IsVisible(), "Bar should be visible");

    self.eventService.buffEvents.registeredEvents.healthTriggerActive = .74;
    SERVICE_CONTAINER:GetService(MysticBars.Services.EventService):NotifyClients();

    Assert.IsTrue(quickslotBar:IsVisible(), "Bar should be visible");
    Assert.IsTrue(quickslotBar.decorator.mainWindow:IsVisible(), "Bar should be visible");

    self.barService:Remove(barSettings.id);
end


function QuickslotbarTest:Test_Tab_Power_Triggered()
    local barSettings = self:NewBarSettings(6, nil, 5, 1, {}, false, false);

    barSettings.events = {triggered = {displayOnPower = true, powerTrigger=.45}};
    self.settingsService:SetBarSettings(barSettings);

    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);

    Assert.IsTrue(not quickslotBar:IsVisible(), "Bar should be visible");

    self.eventService.buffEvents.registeredEvents.powerTriggerActive = .46;
    SERVICE_CONTAINER:GetService(MysticBars.Services.EventService):NotifyClients();

    Assert.IsTrue(not quickslotBar:IsVisible(), "Bar should be visible");
    Assert.IsTrue(not quickslotBar.decorator.tab:IsVisible(), "Bar should be visible");

    self.eventService.buffEvents.registeredEvents.powerTriggerActive = .45;
    SERVICE_CONTAINER:GetService(MysticBars.Services.EventService):NotifyClients();

    Assert.IsTrue(quickslotBar:IsVisible(), "Bar should be visible");
    Assert.IsTrue(not quickslotBar.decorator.tab:IsVisible(), "Bar should be visible");

    self.barService:Remove(barSettings.id);
end
function QuickslotbarTest:Test_Window_Power_Triggered()
    local barSettings = self:NewBarSettings(6, nil, 5, 1, {}, false, false, WINDOW_BAR_DECORATOR);

    barSettings.events = {triggered = {displayOnPower = true, powerTrigger=.75}};
    self.settingsService:SetBarSettings(barSettings);

    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);

    Assert.IsTrue(not quickslotBar:IsVisible(), "Bar should be visible");

    self.eventService.buffEvents.registeredEvents.powerTriggerActive = .90;
    SERVICE_CONTAINER:GetService(MysticBars.Services.EventService):NotifyClients();

    Assert.IsTrue(not quickslotBar:IsVisible(), "Bar should be visible");
    Assert.IsTrue(not quickslotBar.decorator.mainWindow:IsVisible(), "Bar should be visible");

    self.eventService.buffEvents.registeredEvents.powerTriggerActive = .44;
    SERVICE_CONTAINER:GetService(MysticBars.Services.EventService):NotifyClients();

    Assert.IsTrue(quickslotBar:IsVisible(), "Bar should be visible");
    Assert.IsTrue(quickslotBar.decorator.mainWindow:IsVisible(), "Bar should be visible");

    self.barService:Remove(barSettings.id);

end


function QuickslotbarTest:Test_Tab_Combat_Triggered()
    local barSettings = self:NewBarSettings(6, nil, 5, 1, {}, false, false);

    barSettings.events = {triggered = {displayInCombat = true}};
    self.settingsService:SetBarSettings(barSettings);

    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);

    Assert.IsTrue(not quickslotBar:IsVisible(), "Bar should be visible");

    self.eventService.buffEvents.registeredEvents.playerInCombat = true;
    SERVICE_CONTAINER:GetService(MysticBars.Services.EventService):NotifyClients();

    Assert.IsTrue(quickslotBar:IsVisible(), "Bar should be visible");
    Assert.IsTrue(not quickslotBar.decorator.tab:IsVisible(), "Bar should be visible");

    self.barService:Remove(barSettings.id);
end
function QuickslotbarTest:Test_Window_Power_Triggered()
    local barSettings = self:NewBarSettings(6, nil, 5, 1, {}, false, false, WINDOW_BAR_DECORATOR);

    barSettings.events = {triggered = {displayInCombat = true}};
    self.settingsService:SetBarSettings(barSettings);

    local quickslotBar = MysticBars.Bars.QuickslotBar(barSettings);

    Assert.IsTrue(not quickslotBar:IsVisible(), "Bar should be visible");

    self.eventService.buffEvents.registeredEvents.playerInCombat = true;
    SERVICE_CONTAINER:GetService(MysticBars.Services.EventService):NotifyClients();

    Assert.IsTrue(quickslotBar:IsVisible(), "Bar should be visible");
    Assert.IsTrue(quickslotBar.decorator.mainWindow:IsVisible(), "Bar should be visible");

    self.barService:Remove(barSettings.id);
end
