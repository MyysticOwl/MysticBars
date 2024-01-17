-- Created by MyysticOwlself.eventServicesettingsService
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

QuickslotBar = class(MysticBars.Bars.Core.BaseBar);

QuickslotBar.Log = MysticBars.Utils.Logging.LogManager.GetLogger( "QuickslotBar" );

function QuickslotBar:Constructor( barSettings )
	self.Log:Debug("Constructor");
	MysticBars.Bars.Core.BaseBar.Constructor(self, barSettings);

	self.isVisible = true;

	local eventService = SERVICE_CONTAINER:GetService(MysticBars.Services.EventService)
	eventService:RegisterForEvents(self, self.id);
end

function QuickslotBar:Create()
	self.Log:Debug("Create");

	self.quickslotList = MysticBars.Bars.Core.QuickslotList(self, self.barSettings);
	self.quickslotList:SetParent(self);

	MysticBars.Bars.Core.BaseBar.Create( self );

	self:Refresh( true);

	self.quickslotList:SetPosition(0, 0);
end

function QuickslotBar:PositionChanged(sender, args)
	self.Log:Debug("PositionChanged");
	self:UpdateBarExtensions();
end

function QuickslotBar:Refresh( drawShortcuts )
	self.Log:Debug("Refresh");
	MysticBars.Bars.Core.BaseBar.Refresh( self );

	if (drawShortcuts) then
		self.quickslotList:LoadQuickslots();
	end

	if (self.extensionBars ~= nil) then
		for key, value in pairs(self.extensionBars) do
			if (value ~= nil) then
				value.bar:Refresh();
			end
		end
	end
	SERVICE_CONTAINER:GetService(MysticBars.Services.EventService):NotifyClients();
end

function QuickslotBar:UpdateBarExtensions()
	self.Log:Debug("UpdateBarExtensions");
	if (self.extensionBars == nil) then
		return;
	end

	for key, value in pairs(self.extensionBars) do
		local x, y = self.quickslotList:GetQuickslotLocation(value.quickslot);
		self.extensionBars[key].bar:Setup(x, y);
	end
end

function QuickslotBar:RegisterBarExtension(extBar, index, extensionBarID)
	self.Log:Debug("RegisterBarExtension");

	SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(extensionBarID,
		function(barSettings)
			if (barSettings.connectionQuickslotID ~= index or barSettings.connectionBarID ~= self.id) then
				barSettings.connectionQuickslotID = index;
				barSettings.connectionBarID = self.id;
			end
			return barSettings;
		end, function()
		SERVICE_CONTAINER:GetService(MysticBars.Services.InventoryService):NotifyClients();
	end);

	if (self.nextExtension == nil) then
		self.nextExtension = 1;
	end

	if (self.barSettings.barType == QUICKSLOTBAR) then
		if (self.extensionBars == nil) then
			self.extensionBars = {};
		end
		self.extensionBars[self.nextExtension] = {};
		self.extensionBars[self.nextExtension].bar = extBar;
		self.extensionBars[self.nextExtension].quickslot = index;
		self.extensionBars[self.nextExtension].cycleCount = 0;
		self.extensionBars[self.nextExtension].setup = false;
		self.nextExtension = self.nextExtension + 1;
		self.Log:Debug("RegisterBarExtension setup -------------------------------------");
		self.quickslotList:SetupExtensionSlot(self.extensionBars, index);
	else
		Turbine.Shell.WriteLine("You can not add extensions to an extension slot. Please choose a green bar.");
	end
end

function QuickslotBar:EditModeRefresh( barSettings )
	self.Log:Debug("EditModeRefresh");

	self:SetBackColor(Turbine.UI.Color(1, 0.4, 0.6, 0.8));
	MysticBars.Bars.Core.BaseBar.EditModeRefresh( self, barSettings );
end

function QuickslotBar:ClearQuickslots(removed)
	self.Log:Debug("ClearQuickslots");

	self.quickslotList:ClearQuickslots();
	if (self.extensionBars ~= nil and removed ~= nil) then
		for key, value in pairs(self.extensionBars) do
			local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);

			self.extensionBars[key].bar:SetVisible(false);
			barService:Remove(self.extensionBars[key].bar:GetID());
			self.extensionBars[key].bar = nil;
			self.extensionBars[key] = nil;
		end
	end
end

-- This function should ONLY be called by the Event Manager. Doing so in any other copacity
-- can and will cause issues with the visibility of the bars.
--
-- It is recommended to call: "eventService:NotifyClients();" if needed.
function QuickslotBar:DetermineVisiblity(eventValue, force)
	self.Log:Debug("DetermineVisiblity");

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local settings = settingsService:GetSettings();
	local barSettings = settingsService:GetBarSettings(self.id);

	if (settings.barMode == NORMAL_MODE) then
		local visible = false;
		if (eventValue ~= nil and eventValue) then
			visible = true;
		end
		if (visible == false and self.isVisible == true) then
			visible = barSettings.visible;
		end

		if (self.f12HideBar) then
			visible = false;
		end

		self:SetBarVisible(visible);

		self:IsSelected();
	end
end