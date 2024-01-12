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

	self:UpdateBarExtensions();

	self.faded = true;
	self.isVisible = true;

	self.MouseEnter = function(sender, args)
		local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
		local barSettings = settingsService:GetBarSettings(self.id);
		local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);

		if (barService:Alive(self.id) and barSettings.useFading == true) then
			self.faded = false;
			self:Refresh("QuickslotBar:MouseEnter");
		end
	end
	self.MouseLeave = function(sender, args)
		local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
		local barSettings = settingsService:GetBarSettings(self.id);
		local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);

		if (barService:Alive(self.id) and barSettings.useFading == true) then
			self.faded = true;
			self:Refresh("QuickslotBar:MouseLeave");
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
			-- Turbine.Shell.WriteLine("MouseMove: " .. self.id );
			self.dragged = true;
			self:SetPosition(left + (args.X - self.dragStartX), top + (args.Y - self.dragStartY));
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

	local eventService = SERVICE_CONTAINER:GetService(MysticBars.Services.EventService)
	eventService:RegisterForEvents(self, self.id);
end

function QuickslotBar:PositionChanged(sender, args)
	self.Log:Debug("PositionChanged " .. self.id);

	self.decorator:PositionChanged(sender, args);
end

function QuickslotBar:Create()
	self.Log:Error("Create");

	self.quickslotList = MysticBars.Bars.Core.QuickslotList(self, self.barSettings);
	self.quickslotList:SetParent(self);

	MysticBars.Bars.Core.BaseBar.Create( self );

	self:Refresh("QuickslotBar:Create", true);

	self.quickslotList:SetPosition(0, 0);
end

function QuickslotBar:SetBGColor(color)
	self.Log:Debug("SetBGColor");

	self:SetBackColor(color);
end

function QuickslotBar:Refresh( sender, drawShortcuts )
	MysticBars.Bars.Core.BaseBar.Refresh( self, sender );

	self.Log:Debug("Refresh " .. self.id .. " --" .. sender);

	if (drawShortcuts) then
		self.quickslotList:LoadQuickslots();
	end

	if (self.extensionBars ~= nil) then
		for key, value in pairs(self.extensionBars) do
			if (value ~= nil) then
				value.bar:Refresh(sender);
			end
		end
	end
	SERVICE_CONTAINER:GetService(MysticBars.Services.EventService):NotifyClients();
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
		self:SetVisible(visible);

		self:BarSelected();
	end
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

function QuickslotBar:UpdateBarExtensions()
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
		self.nextExtension = self.nextExtension + 1;

		self.quickslotList:SetupExtensionSlot(self.extensionBars, index);
	else
		Turbine.Shell.WriteLine("You can not add extensions to an extension slot. Please choose a green bar.");
	end
end

function QuickslotBar:SetMenuBackColor(selected, barMode)
	self.Log:Debug("SetMenuBackColor");

	if (barMode == QUICKSLOT_MODE) then
		MysticBars.Bars.Core.BaseBar.SetMenuBackColor(self, Turbine.UI.Color(1, 0, 1, 0), selected, 0.6);
	else
		MysticBars.Bars.Core.BaseBar.SetMenuBackColor(self, Turbine.UI.Color(1, 0.4, 0.6, 0.8), selected, 0.6);
	end
end
