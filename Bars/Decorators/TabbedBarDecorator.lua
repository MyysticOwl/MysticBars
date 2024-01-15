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
	self.Log:Error("NormalModeRefresh");

	if ( self.barSettings.barType ~= EXTENSIONBAR and self.DragBar ~= nil ) then
		self.DragBar:Refresh();
	end

	-- if ( self.barSettings.useBackgroundColor == true ) then
	-- 	local tempColor = Turbine.UI.Color( self.barSettings.opacity, self.barSettings.backgroundColorRed, self.barSettings.backgroundColorGreen, self.barSettings.backgroundColorBlue);
	-- 	self.childWindow:SetBGColor( tempColor );
	-- 	self.tab:SetBackColor(tempColor);
	-- else
	-- 	self.childWindow:SetBGColor( Turbine.UI.Color( 0, 0, 0, 0) );
	-- 	self.tab:SetBackColor(Turbine.UI.Color( 0, 0, 0, 0));
	-- end
	self.tab:Refresh();

	if (self.barSettings.decorators.tab.titleColor) then
		self.tab:SetBackColor(Turbine.UI.Color(self.barSettings.decorators.tab.titleColorA, self.barSettings.decorators.tab.titleColorR, self.barSettings.decorators.tab.titleColorG, self.barSettings.decorators.tab.titleColorB));
		self.tab.Label:SetBackColor(Turbine.UI.Color(self.barSettings.decorators.tab.titleColorA, self.barSettings.decorators.tab.titleColorR, self.barSettings.decorators.tab.titleColorG, self.barSettings.decorators.tab.titleColorB));
    else
		self.tab:SetBackColor(Turbine.UI.Color(0.5, 0, 0, 1));
        self.tab.Label:SetBackColor(Turbine.UI.Color(0.5, 0, 0, 1));
    end

    if (self.barSettings.decorators.tab.backColor == true) then
		self.childWindow.quickslotList:SetBackColor(Turbine.UI.Color(self.barSettings.decorators.tab.backColorA, self.barSettings.decorators.tab.backColorR, self.barSettings.decorators.tab.backColorG, self.barSettings.decorators.tab.backColorB));
    end
	self.tab:SetOpacity( math.max( self.childWindow:GetOpacity(), 0.4 ) );

	self.tab:SetVisible( false );
	self.tab.Label:SetVisible(false);
end

function TabbedBarDecorator:EditModeRefresh()
	self.Log:Error("EditModeRefresh");

	if ( self.barSettings.barType ~= EXTENSIONBAR and self.DragBar ~= nil ) then
		self.DragBar:Refresh();
	end

	self.tab:SetOpacity( 1 );
	self.tab:Refresh();
	self.tab:SetBackColor(Turbine.UI.Color(1, 0.4, 0.6, 0.8));
	self.tab.Label:SetBackColor(Turbine.UI.Color(1, 0.4, 0.6, 0.8));
	self.tab:SetVisible( true );
	self.tab.Label:SetVisible(true);
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

	if (self.tab ~= nil) then
		self.tab:SetBackColor( color );
	end
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
