-- Created by MyysticOwlself.eventService
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

import "Tonic.Utils.Class";
import "Tonic.TonicBars.Bars.Decorator.Tab"

QuickslotBar = class( Tonic.TonicBars.Bars.BaseBar );

function QuickslotBar:Constructor( barid )
	self.barService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.BarService);
	self.settingsService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.SettingsService);

	self.id = barid;
	Tonic.TonicBars.Bars.BaseBar.Constructor( self );

	local barSettings = self.settingsService:GetBarSettings( self.id );

	self.quickslotList.loading = true;
	self.settingsService:LoadQuickslots( barSettings, self.quickslotList.quickslots );
	self.quickslotList.loading = false;

	if ( barSettings.barType ~= QUICKSLOTBAR ) then
		barSettings.barType = QUICKSLOTBAR;
		if ( self.barService ~= nil and self.barService:Alive( self.id ) ) then
			self.settingsService:SetBarSettings( self.id, barSettings );
		end
	end

	self.faded = true;
	self.isVisible = true;

	self.MouseEnter = function(sender,args)
		local barSettings = self.settingsService:GetBarSettings( self.id );
		if ( self.barService:Alive( self.id ) and barSettings.useFading == true ) then
			self.faded = false;
			self:Refresh();
		end
	end
	self.MouseLeave = function(sender,args)
		local barSettings = self.settingsService:GetBarSettings( self.id );
		if ( self.barService:Alive( self.id ) and barSettings.useFading == true ) then
			self.faded = true;
			self:Refresh();
		end
	end
	self.MouseDown = function( sender, args )
		if ( self.barService:Alive( self.id ) == true ) then
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
		if ( self.barService:Alive( self.id ) and settings.barMode ~= NORMAL_MODE and self.dragging ) then
			self:SetPosition( left + ( args.X - self.dragStartX ), top + ( args.Y - self.dragStartY ) );
			self.dragged = true;
			self.barService:UpdateBarExtensions();
		end
	end
	self.MouseUp = function( sender, args )
		if ( self.barService:Alive( self.id ) == true and args.Button == Turbine.UI.MouseButton.Left ) then
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

	self:UpdateBarExtensions();

	local eventService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.EventService)
	eventService:RegisterForEvents( self, self.id );
end

function QuickslotBar:PositionChanged( sender, args )
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
			self.barService:UpdateBarExtensions();
		end
	end
end

function QuickslotBar:Create()
	local barSettings = self.settingsService:GetBarSettings( self.id );

	self.quickslotList = Tonic.TonicBars.Bars.QuickslotList( self.id );
	self.quickslotList:SetParent( self );

	local title = barSettings.barName;
	if ( barSettings.barName == nil or barSettings.barName == "" ) then
		title = "Bar:" .. self.id;
	end
	self.tab = Tonic.TonicBars.Bars.Decorator.Tab( self, title );

	self.qsCreated = true;
	self:Refresh();

	self.quickslotList:SetPosition(0, 0 );
end

function QuickslotBar:Remove()
	if ( self.tab ~= nil ) then
		self.tab:SetHidden( true );
		self.tab = nil;
	end
end

function QuickslotBar:SetBGColor( color )
	self:SetBackColor( color );
	self.tab:SetBackColor( color );
end

function QuickslotBar:Refresh()
	Tonic.TonicBars.Bars.BaseBar.Refresh( self );
	self.tab:Refresh();

	local eventService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.EventService)
	eventService:NotifyClients();
end

-- This function should ONLY be called by the Event Manager. Doing so in any other copacity
-- can and will cause issues with the visibility of the bars.
--
-- It is recommended to call: "eventService:NotifyClients();" if needed.
function QuickslotBar:DetermineVisiblity( eventValue, force )
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

function QuickslotBar:ClearQuickslots( removed )
	self.quickslotList:ClearQuickslots();
	if ( self.extensionBars ~= nil and removed ~= nil ) then
		for key, value in pairs (self.extensionBars) do
			self.barService:Remove( self.extensionBars[ key ].bar:GetID() );
			self.extensionBars[ key ].bar = nil;
			self.extensionBars[ key ] = nil;
		end
	end
end

function QuickslotBar:UpdateBarExtensions()
	local barSettings = self.settingsService:GetBarSettings( self.id );
	if ( self.extensionBars == nil ) then
		return;
	end

	for key, value in pairs ( self.extensionBars ) do
		local x, y = self.quickslotList:GetQuickslotLocation( value.quickslot );
		self.extensionBars[ key ].bar:Setup( x, y );
	end
end

function QuickslotBar:RegisterBarExtension( extBar, index, extensionBarID )
	local attachedbarSettings = self.settingsService:GetBarSettings( extensionBarID );
	if ( attachedbarSettings.connectionQuickslotID ~= index or attachedbarSettings.connectionBarID ~= self.id ) then
		attachedbarSettings.connectionQuickslotID = index;
		attachedbarSettings.connectionBarID = self.id;
		if ( self.barService  ~= nil and self.barService:Alive( self.id ) ) then
			self.settingsService:SetBarSettings( extensionBarID, attachedbarSettings );
		end
	end

	local barSettings = self.settingsService:GetBarSettings( self.id );
	if ( self.nextExtension == nil ) then
		self.nextExtension = 1;
	end

	if ( barSettings.barType == QUICKSLOTBAR ) then
		if ( self.extensionBars == nil ) then
			self.extensionBars = {};
		end
		self.extensionBars[ self.nextExtension ] = {};
		self.extensionBars[ self.nextExtension ].bar = extBar;
		self.extensionBars[ self.nextExtension ].quickslot = index;
		self.extensionBars[ self.nextExtension ].cycleCount = 0;
		self.nextExtension = self.nextExtension + 1;

		self.quickslotList:SetupExtensionSlot( self.extensionBars, index );
	else
		Turbine.Shell.WriteLine( "You can not add extensions to an extension slot. Please choose a green bar." );
	end
end

function QuickslotBar:SetMenuBackColor( selected, barMode )
	Tonic.TonicBars.Bars.BaseBar.SetMenuBackColor( self, selected, QUICKSLOT_MODE );
	if ( barMode == QUICKSLOT_MODE ) then
		self:SetBackColor( Turbine.UI.Color(1,0,1,0) );
		self.tab:SetBackColor( Turbine.UI.Color(1,0,1,0) );
	else
		self:SetBackColor( Turbine.UI.Color(1,0.4,0.6,0.8) );
		self.tab:SetBackColor( Turbine.UI.Color(1,0.4,0.6,0.8) );
	end
end