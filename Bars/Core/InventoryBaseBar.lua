-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

InventoryBaseBar = class( MysticBars.Bars.Core.BaseBar );

InventoryBaseBar.Log = MysticBars.Utils.Logging.LogManager.GetLogger( "InventoryBaseBar", false );

function InventoryBaseBar:Constructor( barId )
	MysticBars.Bars.Core.BaseBar.Constructor( self, barId );

	self.Log:Debug("Constructor");

	self.faded = true;
	self.isVisible = true;

	self.MouseEnter = function(sender,args)
		local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
		local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

		local barSettings = settingsService:GetBarSettings( self.id );
		if ( barService ~= nil and barService:Alive( self.id ) and barSettings.useFading == true ) then
			self.faded = false;
			self:Refresh();
		end
	end
	self.MouseLeave = function(sender,args)
		local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
		local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

		local barSettings = settingsService:GetBarSettings( self.id );
		if ( barService ~= nil and barService:Alive( self.id ) and barSettings.useFading == true ) then
			self.faded = true;
			self:Refresh();
		end
	end
	self.PositionChanged = function( sender, args )
		local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
		local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

		--Turbine.Shell.WriteLine("InvBar: PositionChanged: " .. self.id);

		local settings = settingsService:GetSettings();
		local barSettings = settingsService:GetBarSettings( self.id );
		if ( settings.barMode ~= NORMAL_MODE or ( self.DragBar ~= nil and self.DragBar:IsHUDVisible() == true ) ) then
			local x,y = self:GetPosition();

			barSettings.relationalX = x / DISPLAYWIDTH;
			barSettings.relationalY = y / DISPLAYHEIGHT;
	
			barSettings.x = math.floor(barSettings.relationalX * DISPLAYWIDTH);
			barSettings.y = math.floor(barSettings.relationalY * DISPLAYHEIGHT);

			if ( barService ~= nil and barService:Alive( self.id ) ) then
				settingsService:SetBarSettings( self.id, barSettings );
			end
		end
	end
	self.MouseDown = function( sender, args )
		local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
		local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

		if ( barService ~= nil and barService:Alive( self.id ) == true ) then
			local settings = settingsService:GetSettings();
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
		local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
		local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
		local settings = settingsService:GetSettings();

		local left, top = self:GetPosition();

		if ( barService ~= nil and barService:Alive( self.id ) and settings.barMode ~= NORMAL_MODE and self.dragging ) then
			self:SetPosition( left + ( args.X - self.dragStartX ), top + ( args.Y - self.dragStartY ) );
			self.dragged = true;
		end
	end
	self.MouseUp = function( sender, args )
		local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);

		if ( barService ~= nil and barService:Alive( self.id ) == true and args.Button == Turbine.UI.MouseButton.Left ) then
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

	SERVICE_CONTAINER:GetService(MysticBars.Services.EventService):RegisterForEvents( self, self.id );
	SERVICE_CONTAINER:GetService(MysticBars.Services.InventoryService):RegisterForEvents( self, self.id );
end

function InventoryBaseBar:Create()
	self.Log:Debug("Create");

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

	self.quickslotList = MysticBars.Bars.Core.ItemList( self.id );
	self.quickslotList:SetParent( self );

	self.qsCreated = true;
	self:Refresh();
end

function InventoryBaseBar:SetBGColor( color )
	self.Log:Debug("SetBGColor");

	self:SetBackColor( color );
end

function InventoryBaseBar:Refresh()
	self.Log:Debug("Refresh");

	MysticBars.Bars.Core.BaseBar.Refresh( self );
	
	local eventService = SERVICE_CONTAINER:GetService(MysticBars.Services.EventService);
	eventService:NotifyClients();
end

function InventoryBaseBar:ClearQuickslots()
	self.Log:Debug("ClearQuickslots");

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
	self.Log:Debug("DetermineVisiblity");

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local settings = settingsService:GetSettings();
	local barSettings = settingsService:GetBarSettings( self.id );

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