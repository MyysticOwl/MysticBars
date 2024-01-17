-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

WindowBarDecorator = class();

WindowBarDecorator.Log = MysticBars.Utils.Logging.LogManager.GetLogger("WindowBarDecorator");

function WindowBarDecorator:Constructor(childWindow, barSettings)
	self.Log:Debug("Constructor");

	self.childWindow = childWindow;
	self.barSettings = barSettings;

	self.watchSizeChanges = true;
	self.changingSizes = false;
end

function WindowBarDecorator:Create()
	self.Log:Debug("Create");

	self.mainWindow = MysticBars.Bars.Decorators.Window(self.barSettings);
	self.childWindow:SetParent(self.mainWindow);
	self.childWindow:SetPosition(8, 28);

	self.mainWindow:SetVisible(self.barSettings.visible);

	-- self.mainWindow.PositionChanged = self.PositionChanged;
	self.mainWindow:SetPosition(self.barSettings.x, self.barSettings.y - 36);
	self.mainWindow:SetSize(self.childWindow:GetWidth() + 12, self.childWindow:GetHeight() + 36);

	if (self.barSettings.barType == INVENTORY_BAR) then
		self.dragging = false;
		self.mainWindow.rightGrab.MouseDown = function(sender, args)
			sender.dragStartX = args.X;
			sender.dragStartY = args.Y;
			sender.dragging = true;
			self.dragging = true;
		end

		self.mainWindow.rightGrab.MouseMove = function(sender, args)
			local width, height = self.mainWindow:GetSize();

			if (sender.dragging and self.mainWindow ~= nil and self.childWindow.quickslotList ~= nil and self.childWindow.quickslotList.count ~= nil) then
				local tempCols = width / self.barSettings.quickslotSize;
				if (tempCols <= 0) then
					tempCols = 1;
				end
				local tempRow = self.childWindow.quickslotList.count / tempCols;
				if (tempCols <= 0) then
					tempCols = 1;
				end
				tempCols = math.floor(tempCols);
				tempRow = math.ceil(self.childWindow.quickslotList.count / tempCols);

				self.barSettings.quickslotColumns = tempCols;
				self.barSettings.quickslotRows = tempRow;
				self.childWindow.quickslotList:Refresh(self.barSettings);
			end

			if (sender.dragging) then
				self.mainWindow:SetSize(width + (args.X - sender.dragStartX), self.barSettings.quickslotRows * self.barSettings.quickslotSize + 36);
			end
		end

		self.mainWindow.rightGrab.MouseUp = function(sender, args)
			sender.dragging = false;
			self.dragging = false;
			local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
			settingsService:SetBarSettings(self.barSettings);
			self.mainWindow:SetSize(self.childWindow.quickslotList:GetWidth() + 12, self.childWindow.quickslotList:GetHeight() + 36);
		end
		self.mainWindow.right.MouseUp = self.mainWindow.rightGrab.MouseUp;
		self.mainWindow.right.MouseDown = self.mainWindow.rightGrab.MouseDown;
		self.mainWindow.right.MouseMove = self.mainWindow.rightGrab.MouseMove;
	end

	self.childWindow.SizeChanged = function (sender, args)
		if (self.dragging ~= true) then
			self.mainWindow:SetSize(self.childWindow:GetWidth() + 16, self.childWindow:GetHeight() + 36);
		end
	end

	self.mainWindow.PositionChanged = function(sender, args)
		if (sender.dragging) then
			SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barSettings.id, function(barSettings)
				local x, y = self.mainWindow:GetPosition();

				barSettings.relationalX = x / DISPLAYWIDTH;
				barSettings.relationalY = y / DISPLAYHEIGHT;

				barSettings.x = math.floor(barSettings.relationalX * DISPLAYWIDTH);
				barSettings.y = math.floor(barSettings.relationalY * DISPLAYHEIGHT) + 36;
				return barSettings;
			end);
		end
	end
end

function WindowBarDecorator:NormalModeRefresh( barSettings )
	self.childWindow:SetBGColor( Turbine.UI.Color( 0, 0, 0, 0) );

	if (self.mainWindow ~= nil) then
		self.mainWindow:SetVisible(barSettings.visible);
		self.mainWindow:Refresh(barSettings);

		if (barSettings.decorators.window.titleColor == true) then
			self.mainWindow.title:SetBackColor(Turbine.UI.Color(barSettings.decorators.window.titleColorA, barSettings.decorators.window.titleColorR, barSettings.decorators.window.titleColorG, barSettings.decorators.window.titleColorB));
		else
			self.mainWindow.title:SetBackColor(Turbine.UI.Color(0.5, 0, 0, 0));
		end
	
		if (barSettings.decorators.window.backColor == true) then
			self.mainWindow.center:SetBackColor(Turbine.UI.Color(barSettings.decorators.window.backColorA, barSettings.decorators.window.backColorR, barSettings.decorators.window.backColorG, barSettings.decorators.window.backColorB));
		else
			self.mainWindow.center:SetBackColor(Turbine.UI.Color(0.7, 0, 0, 0));
		end

		self.childWindow:SetVisible(barSettings.visible);
	end
end

function WindowBarDecorator:EditModeRefresh( barSettings )
	if (self.mainWindow ~= nil) then
		self.mainWindow:SetVisible(true);

		if (barSettings.decorators.window.titleColor == true) then
			self.mainWindow.title:SetBackColor(Turbine.UI.Color(barSettings.decorators.window.titleColorA, barSettings.decorators.window.titleColorR, barSettings.decorators.window.titleColorG, barSettings.decorators.window.titleColorB));
		else
			self.mainWindow.title:SetBackColor(Turbine.UI.Color(0.5, 0, 0, 1));
		end
	
		if (barSettings.decorators.window.backColor == true) then
			self.mainWindow.center:SetBackColor(Turbine.UI.Color(barSettings.decorators.window.backColorA, barSettings.decorators.window.backColorR, barSettings.decorators.window.backColorG, barSettings.decorators.window.backColorB));
		else
			self.mainWindow.center:SetBackColor(Turbine.UI.Color(0.7, 0, 0, 0));
		end

		self.childWindow:SetBackColor(Turbine.UI.Color(1, 0.4, 0.6, 0.8));
		self.childWindow:SetVisible(true);
	end
end

function WindowBarDecorator:SetVisible(visible)
	if (self.mainWindow ~= nil) then
		self.mainWindow:SetVisible(visible);
	end
end

function WindowBarDecorator:SetBackColor(color)
	self.Log:Debug("SetBackColor");

	self.childWindow:SetBackColor(color);
end

function WindowBarDecorator:SetBGColor(color)
	self.Log:Debug("SetBGColor");

	self.childWindow:SetBackColor(color);
end

function WindowBarDecorator:Remove()
	self.Log:Debug("Remove");

	self.childWindow.SizeChanged = nil;
	self.childWindow:SetParent(nil);

	self.mainWindow:SetVisible(false);
	self.mainWindow = nil;

	collectgarbage();
end
