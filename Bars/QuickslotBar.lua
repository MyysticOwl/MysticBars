-- Created by MyysticOwlself.eventServicesettingsService
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "MysticBars.Utils.Class";
import "MysticBars.Bars.Core.Tab"

QuickslotBar = class(MysticBars.Bars.Core.BaseBar);

function QuickslotBar:Constructor(barid)
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings(self.id);

	self.id = barid;
	MysticBars.Bars.Core.BaseBar.Constructor(self);

	self.quickslotList.loading = true;
	settingsService:LoadQuickslots(barSettings, self.quickslotList.quickslots);
	self.quickslotList.loading = false;

	if (barSettings.barType ~= QUICKSLOTBAR) then
		barSettings.barType = QUICKSLOTBAR;
		settingsService:SetBarSettings(self.id, barSettings);
	end

	self.faded = true;
	self.isVisible = true;

	self.MouseEnter = function(sender, args)
		local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
		local barSettings = settingsService:GetBarSettings(self.id);
		local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);

		if (barService:Alive(self.id) and barSettings.useFading == true) then
			self.faded = false;
			self:Refresh();
		end
	end
	self.MouseLeave = function(sender, args)
		local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
		local barSettings = settingsService:GetBarSettings(self.id);
		local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);

		if (barService:Alive(self.id) and barSettings.useFading == true) then
			self.faded = true;
			self:Refresh();
		end
	end
	self.MouseDown = function(sender, args)
		local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
		local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);

		if (barService:Alive(self.id) == true) then
			local settings = settingsService:GetSettings();
			if (settings.barMode ~= NORMAL_MODE) then
				if (args.Button == Turbine.UI.MouseButton.Left) then
					self.dragStartX = args.X;
					self.dragStartY = args.Y;
					self.dragging = true;
					self.dragged = false;
					-- local barSettings = settingsService:GetBarSettings( self.id );
					-- Turbine.Shell.WriteLine("MouseDown: " .. self.id )
				end
			end
		end
	end
	self.MouseMove = function(sender, args)
		local left, top = self:GetPosition();
		local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
		local settings = settingsService:GetSettings();
		local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);

		if (barService:Alive(self.id) and settings.barMode ~= NORMAL_MODE and self.dragging) then
			self:SetPosition(left + (args.X - self.dragStartX), top + (args.Y - self.dragStartY));
			self.dragged = true;
			-- Turbine.Shell.WriteLine("MouseMove: " .. self.id )
			barService:UpdateBarExtensions();
		end
	end
	self.MouseUp = function(sender, args)
		local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);

		if (barService:Alive(self.id) == true and args.Button == Turbine.UI.MouseButton.Left) then
			self.dragging = false;

			if (self.dragged) then
				local x, y = self:GetPosition();
				local validX = x;
				local validY = y;
				if (x < 0) then
					x = 0;
				end

				if (y < 0) then
					y = 0;
				end
				if (x + self:GetWidth() > Turbine.UI.Display.GetWidth()) then
					x = Turbine.UI.Display.GetWidth() - self:GetWidth();
				end
				if (y + self:GetHeight() > Turbine.UI.Display.GetHeight()) then
					y = Turbine.UI.Display.GetHeight() - self:GetHeight();
				end

				self:SetPosition(x, y);
			end
		end
	end

	self:UpdateBarExtensions();

	local eventService = SERVICE_CONTAINER:GetService(MysticBars.Services.EventService)
	eventService:RegisterForEvents(self, self.id);
end

function QuickslotBar:PositionChanged(sender, args)
	SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.id, function(barSettings)
		local settings = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):GetSettings();
		if (settings.barMode ~= NORMAL_MODE or (self.DragBar ~= nil and self.DragBar:IsHUDVisible() == true)) then
			local x, y = self:GetPosition();

			barSettings.relationalX = x / DISPLAYWIDTH;
			barSettings.relationalY = y / DISPLAYHEIGHT;

			barSettings.x = math.floor(barSettings.relationalX * DISPLAYWIDTH);
			barSettings.y = math.floor(barSettings.relationalY * DISPLAYHEIGHT);
		end
		return barSettings;
	end, function()
		local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
		if (barService ~= nil) then
			barService:UpdateBarExtensions();
		end
	end);
end

function QuickslotBar:Create()
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings(self.id);

	self.quickslotList = MysticBars.Bars.Core.QuickslotList(self.id);
	self.quickslotList:SetParent(self);

	local title = barSettings.barName;
	if (barSettings.barName == nil or barSettings.barName == "") then
		title = "Bar:" .. self.id;
	end
	self.tab = MysticBars.Bars.Core.Tab(self, title);

	self.qsCreated = true;
	self:Refresh();

	self.quickslotList:SetPosition(0, 0);
end

function QuickslotBar:Remove()
	if (self.tab ~= nil) then
		self.tab:SetHidden(true);
		self.tab = nil;
	end
end

function QuickslotBar:SetBGColor(color)
	self:SetBackColor(color);
	self.tab:SetBackColor(color);
end

function QuickslotBar:Refresh()
	MysticBars.Bars.Core.BaseBar.Refresh(self);
	self.tab:Refresh();

	local eventService = SERVICE_CONTAINER:GetService(MysticBars.Services.EventService)
	eventService:NotifyClients();
end

-- This function should ONLY be called by the Event Manager. Doing so in any other copacity
-- can and will cause issues with the visibility of the bars.
--
-- It is recommended to call: "eventService:NotifyClients();" if needed.
function QuickslotBar:DetermineVisiblity(eventValue, force)
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
		self:SetVisible(visible);
	end
end

function QuickslotBar:ClearQuickslots(removed)
	self.quickslotList:ClearQuickslots();
	if (self.extensionBars ~= nil and removed ~= nil) then
		for key, value in pairs(self.extensionBars) do
			local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);

			barService:Remove(self.extensionBars[key].bar:GetID());
			self.extensionBars[key].bar = nil;
			self.extensionBars[key] = nil;
		end
	end
end

function QuickslotBar:UpdateBarExtensions()
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings(self.id);
	if (self.extensionBars == nil) then
		return;
	end

	for key, value in pairs(self.extensionBars) do
		local x, y = self.quickslotList:GetQuickslotLocation(value.quickslot);
		self.extensionBars[key].bar:Setup(x, y);
	end
end

function QuickslotBar:RegisterBarExtension(extBar, index, extensionBarID)
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(extensionBarID,
		function(barSettings)
			if (barSettings.connectionQuickslotID ~= index or barSettings.connectionBarID ~= self.id) then
				barSettings.connectionQuickslotID = index;
				barSettings.connectionBarID = self.id;
			end
			return barSettings;
		end, function()
		SERVICE_CONTAINER:GetService(MysticBars.Services.InventoryService):NotifyClients();
	end, true);

	local barSettings = settingsService:GetBarSettings(self.id);
	if (self.nextExtension == nil) then
		self.nextExtension = 1;
	end

	if (barSettings.barType == QUICKSLOTBAR) then
		if (self.extensionBars == nil) then
			self.extensionBars = {};
		end
		self.extensionBars[self.nextExtension] = {};
		self.extensionBars[self.nextExtension].bar = extBar;
		self.extensionBars[self.nextExtension].quickslot = index;
		self.extensionBars[self.nextExtension].cycleCount = 0;
		self.nextExtension = self.nextExtension + 1;

		self.quickslotList:SetupExtensionSlot(self.extensionBars, index);
	else
		Turbine.Shell.WriteLine("You can not add extensions to an extension slot. Please choose a green bar.");
	end
end

function QuickslotBar:SetMenuBackColor(selected, barMode)
	MysticBars.Bars.Core.BaseBar.SetMenuBackColor(self, selected, QUICKSLOT_MODE);
	if (barMode == QUICKSLOT_MODE) then
		self:SetBackColor(Turbine.UI.Color(1, 0, 1, 0));
		self.tab:SetBackColor(Turbine.UI.Color(1, 0, 1, 0));
	else
		self:SetBackColor(Turbine.UI.Color(1, 0.4, 0.6, 0.8));
		self.tab:SetBackColor(Turbine.UI.Color(1, 0.4, 0.6, 0.8));
	end
end
