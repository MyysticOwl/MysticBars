-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

TabbedBarDecorator = class( );

TabbedBarDecorator.Log = MysticBars.Utils.Logging.LogManager.GetLogger( "TabbedBarDecorator" );

function TabbedBarDecorator:Constructor( childWindow, barSettings )
	self.Log:Debug("Constructor");

	self.childWindow = childWindow;
	self.decorator = nil;
	self.barSettings = barSettings;
	self.id = barSettings.id;

	if ( barSettings.barType ~= EXTENSIONBAR ) then
		local title = barSettings.barName;
		if ( barSettings.barName == nil or barSettings.barName == "" ) then
			title = "Bar:" .. self.id;
		end
		self.DragBar = MysticBars.Menus.Core.UI.DragBar( self.childWindow, title, true );
		self.DragBar:SetAllowsHUDHiding( false, true );
		self.DragBar.PositionChanged = function(sender,args)
			self.Log:Debug("DragBar:PositionChanged");
			self:PositionChanged(sender,args);
		end
		self.DragEnable = function(sender,args)
			if( self.tab ~= nil ) then
				self.tab:SetHidden( true );
			end
		end
		self.DragDisable = function(sender,args)
			if( self.tab ~= nil ) then
				self.tab:SetHidden( false );
			end
		end
	end
end

function TabbedBarDecorator:Create()
	self.Log:Debug("Create");

	self.tab = MysticBars.Bars.Decorators.Tab( self.childWindow, self.barSettings );
	self.childWindow:SetParent( self.tab );
	self.childWindow:SetPosition( 0, self.tab:GetHeight() );

	self.tab.PositionChanged = self.PositionChanged;
	self.tab:SetPosition(self.barSettings.x, self.barSettings.y);

	self.tab.PositionChanged = function(sender, args)
		local settings = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):GetSettings();
		if ( settings.barMode ~= NORMAL_MODE or ( self.childWindow.DragBar ~= nil and self.childWindow.DragBar:IsHUDVisible() == true ) ) then
			SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barSettings.id, function(barSettings)
				local x, y = self.tab:GetPosition();
	
				barSettings.relationalX = x / DISPLAYWIDTH;
				barSettings.relationalY = y / DISPLAYHEIGHT;
	
				barSettings.x = math.floor(barSettings.relationalX * DISPLAYWIDTH);
				barSettings.y = math.floor(barSettings.relationalY * DISPLAYHEIGHT);
				return barSettings;
			end);
		end
	end
end

function TabbedBarDecorator:NormalModeRefresh()
	if ( self.barSettings.barType ~= EXTENSIONBAR and self.DragBar ~= nil ) then
		self.DragBar:Refresh();
	end

	if ( self.barSettings.useBackgroundColor == true ) then
		local tempColor = Turbine.UI.Color( self.barSettings.opacity, self.barSettings.backgroundColorRed, self.barSettings.backgroundColorGreen, self.barSettings.backgroundColorBlue);
		self.childWindow:SetBGColor( tempColor );
		self:SetBackColor(tempColor);
	else
		self.childWindow:SetBGColor( Turbine.UI.Color( 0, 0, 0, 0) );
		self:SetBackColor(Turbine.UI.Color( 0, 0, 0, 0));
	end
	self.tab:Refresh();
end

function TabbedBarDecorator:EditModeRefresh()
	if ( self.barSettings.barType ~= EXTENSIONBAR and self.DragBar ~= nil ) then
		self.DragBar:Refresh();
	end
	self.tab:Refresh();
end

function TabbedBarDecorator:SetVisible( visible )
	if (self.tab ~= nil) then
		self.tab:SetVisible(visible);
	end
end

function TabbedBarDecorator:PositionChanged( sender, args )
	self.Log:Debug("PositionChanged");
	self.tab.PositionChanged(sender, args);
end

function TabbedBarDecorator:SetBackColor( color )
	self.Log:Debug("SetBackColor");

	self.tab:SetBackColor( color );
end

function TabbedBarDecorator:SetBGColor(color)
	self.Log:Debug("SetBGColor");

	self:SetBackColor(color);
end

function TabbedBarDecorator:Remove()
	self.Log:Debug("Remove");

	self.tab:SetHidden( true );
	self.tab = nil;
end
