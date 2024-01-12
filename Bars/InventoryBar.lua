-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

InventoryBar = class( MysticBars.Bars.Core.BaseBar );

InventoryBar.Log = MysticBars.Utils.Logging.LogManager.GetLogger( "InventoryBaseBar" );

function InventoryBar:Constructor( barSettings )
	self.Log:Debug("Constructor");

	MysticBars.Bars.Core.BaseBar.Constructor( self, barSettings );

	self.faded = true;
	self.isVisible = true;

	self.MouseEnter = function(sender,args)
		local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
		local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

		local barSettings = settingsService:GetBarSettings( self.id );
		if ( barService ~= nil and barService:Alive( self.id ) and barSettings.useFading == true ) then
			self.faded = false;
			self:Refresh("MouseEnter");
		end
	end
	self.MouseLeave = function(sender,args)
		local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
		local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

		local barSettings = settingsService:GetBarSettings( self.id );
		if ( barService ~= nil and barService:Alive( self.id ) and barSettings.useFading == true ) then
			self.faded = true;
			self:Refresh("MouseLeave");
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

function InventoryBar:Create()
	self.Log:Error("Create");

	self.quickslotList = MysticBars.Bars.Core.ItemList( self.id );
	self.quickslotList:SetParent( self );

	MysticBars.Bars.Core.BaseBar.Create( self );

	self:Refresh("Create");
end

function InventoryBar:PositionChanged( sender, args )
	self.Log:Debug("PositionChanged");

	local settings = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):GetSettings();
	if ( settings.barMode ~= NORMAL_MODE or ( self.DragBar ~= nil and self.DragBar:IsHUDVisible() == true ) ) then
		SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.id, function(barSettings)
			local x, y = self:GetPosition();

			barSettings.relationalX = x / DISPLAYWIDTH;
			barSettings.relationalY = y / DISPLAYHEIGHT;

			barSettings.x = math.floor(barSettings.relationalX * DISPLAYWIDTH);
			barSettings.y = math.floor(barSettings.relationalY * DISPLAYHEIGHT);
			return barSettings;
		end, function(barSettings)
			self:SetPosition( barSettings.x, barSettings.y );
		end);
	end
end

function InventoryBar:SetMenuBackColor(selected, barMode)
	self.Log:Debug("SetMenuBackColor");

	if (barMode == QUICKSLOT_MODE) then
		MysticBars.Bars.Core.BaseBar.SetMenuBackColor(self, Turbine.UI.Color(1, 0, 1, 0), selected, 0.6);
	else
		MysticBars.Bars.Core.BaseBar.SetMenuBackColor(self, Turbine.UI.Color(1, 0.4, 0.6, 0.8), selected, 0.6);
	end
end


function InventoryBar:Refresh( sender )
	self.Log:Debug("Refresh");

	MysticBars.Bars.Core.BaseBar.Refresh( self, sender );

	SERVICE_CONTAINER:GetService(MysticBars.Services.EventService):NotifyClients();
end

function InventoryBar:ClearQuickslots()
	self.Log:Debug("ClearQuickslots");

	self.quickslotList:ClearQuickslots();
end

-- This function should ONLY be called by the Event Manager. Doing so in any other copacity
-- can and will cause issues with the visibility of the bars.
--
-- It is recommended to call: "eventService:NotifyClients();" if needed.
function InventoryBar:DetermineVisiblity( eventValue, force )
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

		self:BarSelected();
	end
end