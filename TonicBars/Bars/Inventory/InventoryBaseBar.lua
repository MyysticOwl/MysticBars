-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

import "Tonic.Utils.Class";
import "Tonic.UI.Window";

InventoryBaseBar = class( Tonic.TonicBars.Bars.BaseBar );

function InventoryBaseBar:Constructor()
	Tonic.TonicBars.Bars.BaseBar.Constructor( self );

	self.barService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.BarService);
	self.eventService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.EventService);
	self.inventoryService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.InventoryService);
	self.settingsService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.SettingsService);

	self.faded = true;
	self.isVisible = true;

	self.MouseEnter = function(sender,args)
		local barSettings = self.settingsService:GetBarSettings( self.id );
		if ( self.barService ~= nil and self.barService:Alive( self.id ) and barSettings.useFading == true ) then
			self.faded = false;
			self:Refresh();
		end
	end
	self.MouseLeave = function(sender,args)
		local barSettings = self.settingsService:GetBarSettings( self.id );
		if ( self.barService ~= nil and self.barService:Alive( self.id ) and barSettings.useFading == true ) then
			self.faded = true;
			self:Refresh();
		end
	end
	self.PositionChanged = function( sender, args )
		local settings = self.settingsService:GetSettings();
		local barSettings = self.settingsService:GetBarSettings( self.id );
		if ( settings.barMode ~= NORMAL_MODE or ( dragBarAvailable and self.DragBar ~= nil and self.DragBar:IsHUDVisible() == true ) ) then
			local x,y = self:GetPosition();

			barSettings.relationalX = x / DISPLAYWIDTH;
			barSettings.relationalY = y / DISPLAYHEIGHT;
	
			barSettings.x = math.floor(barSettings.relationalX * DISPLAYWIDTH);
			barSettings.y = math.floor(barSettings.relationalY * DISPLAYHEIGHT);

			if ( self.barService ~= nil and self.barService:Alive( self.id ) ) then
				self.settingsService:SetBarSettings( self.id, barSettings );
			end
		end
	end
	self.MouseDown = function( sender, args )
		if ( self.barService ~= nil and self.barService:Alive( self.id ) == true ) then
			local settings = self.settingsService:GetSettings();
			if ( settings.barMode ~= NORMAL_MODE ) then
				if ( args.Button == Turbine.UI.MouseButton.Left ) then
					self.dragStartX = args.X;
					self.dragStartY = args.Y;
					self.dragging = true;
					self.dragged = false;
				end
			end
		end
	end
	self.MouseMove = function( sender, args )
		local left, top = self:GetPosition();
		local settings = self.settingsService:GetSettings();
		if ( self.barService ~= nil and self.barService:Alive( self.id ) and settings.barMode ~= NORMAL_MODE and self.dragging ) then
			self:SetPosition( left + ( args.X - self.dragStartX ), top + ( args.Y - self.dragStartY ) );
			self.dragged = true;
		end
	end
	self.MouseUp = function( sender, args )
		if ( self.barService ~= nil and self.barService:Alive( self.id ) == true and args.Button == Turbine.UI.MouseButton.Left ) then
			self.dragging = false;
		  
			if( self.dragged ) then
				local x, y = self:GetPosition();
				local validX = x;
				local validY = y;
				if( x < 0 ) then
					x = 0;
				end
		
				if( y < 0 ) then
					y = 0;
				end
				if( x + self:GetWidth() > Turbine.UI.Display.GetWidth() ) then
					x = Turbine.UI.Display.GetWidth() - self:GetWidth();
				end
				if( y + self:GetHeight() > Turbine.UI.Display.GetHeight() ) then
					y = Turbine.UI.Display.GetHeight() - self:GetHeight();
				end
		
				self:SetPosition( x, y );
			end
		end
	end

	self.eventService:RegisterForEvents( self, self.id );
	self.inventoryService:RegisterForEvents( self, self.id );
end

function InventoryBaseBar:Create()
	local barSettings = self.settingsService:GetBarSettings( self.id );

	self.quickslotList = ItemList( self.id );
	self.quickslotList:SetParent( self );
	
	self.qsCreated = true;
	self:Refresh();
end

function InventoryBaseBar:SetBGColor( color )
	self:SetBackColor( color );
end

function InventoryBaseBar:Refresh()
	Tonic.TonicBars.Bars.BaseBar.Refresh( self );
	self.eventService:NotifyClients();
end

function InventoryBaseBar:ClearQuickslots()
	self.quickslotList:ClearQuickslots();
	--self.quickslotList:SetVisible( false );
	--self.quickslotList:SetBackColor( Turbine.UI.Color( 0, 0, 0, 0) );
	--self.quickslotList = nil;
end

-- This function should ONLY be called by the Event Manager. Doing so in any other copacity
-- can and will cause issues with the visibility of the bars.
--
-- It is recommended to call: "eventService:NotifyClients();" if needed.
function InventoryBaseBar:DetermineVisiblity( eventValue, force )
	local settings = self.settingsService:GetSettings();
	local barSettings = self.settingsService:GetBarSettings( self.id );

	if ( settings.barMode == NORMAL_MODE ) then
		local visible = false;
		if ( eventValue ~= nil and eventValue ) then
			visible = true;
		end
		if ( visible == false and self.isVisible == true ) then
			visible = barSettings.visible;
		end
		if ( self.f12HideBar ) then
			visible = false;
		end
		self:SetVisible( visible );
	end
end