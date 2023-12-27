-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "MyysticUI.Utils.Class";
import "MyysticUI.UI.Window";

WindowInventoryBar = class( MyysticUI.Core.Bars.InventoryBaseBar );

function WindowInventoryBar:Constructor( barid )
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);

	self.id = barid;
	self.mainWindow = MyysticUI.UI.Window();

	self.watchSizeChanges = false;
	self.changingSizes = false;
	
	local thebarSettings = settingsService:GetBarSettings( self.id );
	if ( thebarSettings.barType ~= WINDOW_INV_BAR ) then
		thebarSettings.barType = WINDOW_INV_BAR;
		thebarSettings.quickslotRows = 2;
		thebarSettings.quickslotColumns = 4;
		thebarSettings.quickslotCount = 12;
		thebarSettings.visible = false;
		settingsService:SetBarSettings( self.id, thebarSettings );
	end

	Turbine.Shell.WriteLine( "LOADED WindowBar" );

	MyysticUI.Core.Bars.InventoryBaseBar.Constructor( self );

	self:SetParent( self.mainWindow );
	self.mainWindow:SetPosition( thebarSettings.x, thebarSettings.y );
	self:SetPosition( 0, 0 );

	self.mainWindow.SizeChanged = function(sender,args)
		local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);
		local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);

		if ( barService:Alive( self.id ) and self.changingSizes == false ) then
			self.changingSizes = true;
			local barSettings = settingsService:GetBarSettings( self.id );
			local originalCols = barSettings.quickslotColumns;
			local originalRows = barSettings.quickslotRows;

			barSettings.quickslotColumns = math.floor(((sender:GetWidth() - 24) / barSettings.quickslotSize) * 1.1);
			barSettings.quickslotRows = math.floor(((sender:GetHeight() - 55) / barSettings.quickslotSize) * 1.1);
			barSettings.quickslotCount = barSettings.quickslotRows * barSettings.quickslotColumns;
			if ( self.watchSizeChanges and (originalCols ~= barSettings.quickslotColumns or originalRows ~= barSettings.quickslotRows) ) then
				self.quickslotList:SetMaxItemsPerLine( barSettings.quickslotColumns );
				settingsService:SetBarSettings( self.id, barSettings );
				self:SetSize( self.quickslotList:GetWidth(), self.quickslotList:GetHeight() );
			end
			self.changingSizes = false;
		end
	end
	self.mainWindow.MouseEnter = self.MouseEnter;
	self.mainWindow.MouseLeave = self.MouseLeave;
	self.mainWindow.PositionChanged = function( sender, args )
		local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);
		local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
		local settings = settingsService:GetSettings();
		local barSettings = settingsService:GetBarSettings( self.id );

		if ( barService:Alive( self.id ) and settings.barMode ~= NORMAL_MODE ) then
			local x,y = self.mainWindow:GetPosition();
			barSettings.x = x;
			barSettings.y = y;
			settingsService:SetBarSettings( self.id, barSettings );
		end
	end
	self.mainWindow.MouseDown = self.MouseDown;
	self.mainWindow.MouseMove = function( sender, args )
		local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);
		local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
		local settings = settingsService:GetSettings();

		local left, top = self:GetPosition();

		if ( barService:Alive( self.id ) and settings.barMode ~= NORMAL_MODE and self.dragging ) then
			self.mainWindow:SetPosition( left + ( args.X - self.dragStartX ), top + ( args.Y - self.dragStartY ) );
			self.dragged = true;
		end
	end
	self.mainWindow.MouseUp = function( sender, args )
		local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);

		if ( barService:Alive( self.id ) == true and args.Button == Turbine.UI.MouseButton.Left ) then
			self.dragging = false;
		  
			if( self.dragged ) then
				local x, y = self.mainWindow:GetPosition();
				local validX = x;
				local validY = y;
				if( x < 0 ) then
					x = 0;
				end
		
				if( y < 0 ) then
					y = 0;
				end
				if( x + self.mainWindow:GetWidth() > Turbine.UI.Display.GetWidth() ) then
					x = Turbine.UI.Display.GetWidth() - self.mainWindow:GetWidth();
				end
				if( y + self.mainWindow:GetHeight() > Turbine.UI.Display.GetHeight() ) then
					y = Turbine.UI.Display.GetHeight() - self.mainWindow:GetHeight();
				end
		
				self.mainWindow:SetPosition( x, y );
			end
		end
	end

	self.mainWindow:SetVisible( true );
end

function WindowInventoryBar:Create()
	MyysticUI.Core.Bars.InventoryBaseBar.Create( self );
	self.mainWindow:SetSize( self.quickslotList:GetWidth() + 24, self.quickslotList:GetHeight() + 55 );
	self.watchSizeChanges = true;
end

function WindowInventoryBar:Refresh()
	MyysticUI.Core.Bars.InventoryBaseBar.Refresh( self );

	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings( self.id );
	self:SetPosition( 10, 41 );
end

function WindowInventoryBar:SetBarSize(xsize, ysize)
	if ( xsize ~= nil or ysize ~= nil ) then
		self.mainWindow:SetSize( xsize, ysize );
	else
		self.mainWindow:SetSize( self.quickslotList:GetWidth() + 24, self.quickslotList:GetHeight() + 55);
	end
end

-- This function should ONLY be called by the Event Manager. Doing so in any other copacity
-- can and will cause issues with the visibility of the bars.
--
-- It is recommended to call: "eventService:NotifyClients();" if needed.
function WindowInventoryBar:DetermineVisiblity( eventValue, force )
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
	local settings = settingsService:GetSettings();
	local barSettings = settingsService:GetBarSettings( self.id );

	if ( settings.barMode == NORMAL_MODE ) then
		local visible = false;
		if ( eventValue ~= nil and eventValue ) then
			visible = true;
		end
		if ( self.inventoryShowBar ) then
			visible = true;
			if ( force ) then
				Turbine.Shell.WriteLine( "Forcing" );
			else
				Turbine.Shell.WriteLine( "Not Forcing" );
			end
		end
		if ( visible == false and self.isVisible == true ) then
			visible = barSettings.visible;
		end

		if ( self.f12HideBar or force ) then
			visible = false;
		end
		if ( visible ) then
			Turbine.Shell.WriteLine( "VISIBLE" );
		else
			Turbine.Shell.WriteLine( "NOT VISIBLE" );
		end
		self.mainWindow:SetVisible( visible );
		self:SetVisible( visible );
	end
end

function WindowInventoryBar:InventoryPressed()
	self.inventoryShowBar = not self.inventoryShowBar;
	self:DetermineVisiblity();
end

function WindowInventoryBar:SetMenuBackColor( selected )
	MyysticUI.Core.Bars.BaseBar.SetMenuBackColor( self, selected, INVENTORY_MODE );
	self:SetBackColor( Turbine.UI.Color(1,0,0,0) );
end