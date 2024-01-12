-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

WindowBarDecorator = class( );

WindowBarDecorator.Log = MysticBars.Utils.Logging.LogManager.GetLogger( "WindowBarDecorator" );

function WindowBarDecorator:Constructor( parentWindow, barSettings )
	self.Log:Debug("Constructor");

	self.parentWindow = parentWindow;
	self.barSettings = barSettings;

	self.watchSizeChanges = true;
end

function WindowBarDecorator:Create()
	self.Log:Debug("Create");

	self.mainWindow = MysticBars.Bars.Decorators.Window(self.barSettings);
	self.parentWindow:SetParent( self.mainWindow );
	self.parentWindow:SetPosition( 8, 28 );

	self.mainWindow:SetVisible(self.barSettings.visible);

	self.Log:Error("Create X:" .. self.parentWindow.quickslotList:GetWidth() .. " Y:" .. self.parentWindow.quickslotList:GetHeight());
	self.mainWindow.PositionChanged = self.PositionChanged;
	self.mainWindow:SetPosition( self.barSettings.x, self.barSettings.y );
	self.mainWindow:SetSize( self.parentWindow.quickslotList:GetWidth() + 24, self.parentWindow.quickslotList:GetHeight() + 55 );

	self.mainWindow.SizeChanged = function(sender,args)
	--	self.Log:Error("mainWindow.SizeChanged");
--		local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
		local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
		
		if ( self.changingSizes == false ) then
			self.changingSizes = true;

			local originalCols = self.barSettings.quickslotColumns;
			local originalRows = self.barSettings.quickslotRows;

			self.barSettings.quickslotColumns = math.floor(((sender:GetWidth() - 24) / self.barSettings.quickslotSize) * 1.1);
			self.barSettings.quickslotRows = math.floor(((sender:GetHeight() - 55) / self.barSettings.quickslotSize) * 1.1);
			self.barSettings.quickslotCount = self.barSettings.quickslotRows * self.barSettings.quickslotColumns;
			if ( self.watchSizeChanges and (originalCols ~= self.barSettings.quickslotColumns or originalRows ~= self.barSettings.quickslotRows) ) then
				self.parentWindow.quickslotList:SetMaxItemsPerLine( self.barSettings.quickslotColumns );
				settingsService:SetBarSettings( self.barSettings );
				self.mainWindow:SetSize( self.parentWindow.quickslotList:GetWidth(), self.parentWindow.quickslotList:GetHeight() );
			end
			self.changingSizes = false;
		end
	end
	self.mainWindow.PositionChanged = function( sender, args )
	--	self.Log:Error("PositionChanged");
	
		--if ( settings.barMode ~= NORMAL_MODE or ( self.DragBar ~= nil and self.DragBar:IsHUDVisible() == true ) ) then
			SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barSettings.id, function(barSettings)
				local x, y = self.mainWindow:GetPosition();
	
				barSettings.relationalX = x / DISPLAYWIDTH;
				barSettings.relationalY = y / DISPLAYHEIGHT;
	
				barSettings.x = math.floor(barSettings.relationalX * DISPLAYWIDTH);
				barSettings.y = math.floor(barSettings.relationalY * DISPLAYHEIGHT);
				return barSettings;
			end, function(barSettings)
				self.mainWindow:SetPosition( barSettings.x, barSettings.y );
			end);
		--end
	end
end

function WindowBarDecorator:PositionChanged(sender, args)
	self.mainWindow:PositionChanged(sender, args);
end

function WindowBarDecorator:Remove()
	self.Log:Debug("Remove");

--	self.tab:SetHidden( true );
--	self.tab = nil;
end

function WindowBarDecorator:SetBackColor( color )
	self.Log:Debug("SetBackColor");

	self.parentWindow:SetBackColor( color );
end

function WindowBarDecorator:SetVisible( visible )
	self.mainWindow:SetVisible(visible);
	--self.parentWindow:SetVisible(visible);
end

function WindowBarDecorator:Refresh()
	self.Log:Debug("Refresh");

	self.mainWindow:SetVisible(self.barSettings.visible);
	self.mainWindow:SetSize( self.parentWindow.quickslotList:GetWidth() + 24, self.parentWindow.quickslotList:GetHeight() + 55 );
--	self.tab:Refresh();
end

function WindowBarDecorator:SetBGColor(color)
	self.Log:Debug("SetBGColor");

	self.parentWindow:SetBackColor( color );
end
