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
				self.tab:SetVisible( true );
				self.tab.Label:SetVisible(true);
			end
		end
		self.DragDisable = function(sender,args)
			if( self.tab ~= nil ) then
				self.tab:SetVisible( false );
				self.tab.Label:SetVisible(false);
			end
		end
	end
end

function TabbedBarDecorator:Create()
	self.Log:Debug("Create");

	self.tab = MysticBars.Bars.Decorators.Tab( self.childWindow, self.barSettings );
	self.tab.PositionChanged = self.PositionChanged;
	self.tab:SetPosition(self.barSettings.x, self.barSettings.y - Tab.tabSize);

	self.tab.PositionChanged = function(sender, args)
		local settings = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):GetSettings();
		--if ( settings.barMode ~= NORMAL_MODE or ( self.childWindow.DragBar ~= nil and self.childWindow.DragBar:IsHUDVisible() == true ) ) then
			SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barSettings.id, function(barSettings)
				local x, y = self.tab:GetPosition();
	
				barSettings.relationalX = x / DISPLAYWIDTH;
				barSettings.relationalY = y / DISPLAYHEIGHT;
	
				barSettings.x = math.floor(barSettings.relationalX * DISPLAYWIDTH);
				barSettings.y = math.floor(barSettings.relationalY * DISPLAYHEIGHT) + Tab.tabSize;
				return barSettings;
			end);
		--end
	end

	self.back = Turbine.UI.Window();
	self.back:SetMouseVisible(true);
	self.back:SetPosition(self.barSettings.x, self.barSettings.y);
	self.back:SetVisible(true);
	self.back:SetSize(self.childWindow:GetSize());
	self.childWindow:SetParent(self.back);
	self.childWindow:SetPosition( 0, 0);

	self.childWindow.SizeChanged = function (sender, args)
		self.back:SetSize(self.childWindow:GetWidth(), self.childWindow:GetHeight());
	end
end

function TabbedBarDecorator:NormalModeRefresh(barSettings)
	self.Log:Debug("NormalModeRefresh");

	if ( barSettings.barType ~= EXTENSIONBAR and self.DragBar ~= nil ) then
		self.DragBar:Refresh();
	end

	self.back:SetPosition(barSettings.x, barSettings.y);

	self.childWindow:SetBGColor( Turbine.UI.Color( 0, 0, 0, 0) );
	self.back:SetBackColor(Turbine.UI.Color( 0, 0, 0, 0));
	self.tab:SetBackColor(Turbine.UI.Color( 0, 0, 0, 0));

	self.tab:Refresh();

	if (barSettings.decorators.tab.titleColor) then
		self.tab:SetBackColor(Turbine.UI.Color(barSettings.decorators.tab.titleColorA, barSettings.decorators.tab.titleColorR, barSettings.decorators.tab.titleColorG, barSettings.decorators.tab.titleColorB));
		self.tab.Label:SetBackColor(Turbine.UI.Color(barSettings.decorators.tab.titleColorA, barSettings.decorators.tab.titleColorR, barSettings.decorators.tab.titleColorG, barSettings.decorators.tab.titleColorB));
    else
		self.tab:SetBackColor(Turbine.UI.Color(0.5, 0, 0, 1));
        self.tab.Label:SetBackColor(Turbine.UI.Color(0.5, 0, 0, 1));
    end

    if (barSettings.decorators.tab.backColor == true) then
		self.childWindow:SetBackColor(Turbine.UI.Color(barSettings.decorators.tab.backColorA, barSettings.decorators.tab.backColorR, barSettings.decorators.tab.backColorG, barSettings.decorators.tab.backColorB));
		self.back:SetBackColor(self.childWindow:GetBackColor());
    end
	self.tab:SetOpacity( math.max( self.childWindow:GetOpacity(), 0.4 ) );
end

function TabbedBarDecorator:EditModeRefresh(barSettings)
	self.Log:Debug("EditModeRefresh");

	if ( barSettings.barType ~= EXTENSIONBAR and self.DragBar ~= nil ) then
		self.DragBar:Refresh();
	end

	self.tab:SetOpacity( 1 );
	self.tab:Refresh();
	self.tab:SetBackColor(Turbine.UI.Color(1, 0.4, 0.6, 0.8));
	self.tab.Label:SetBackColor(Turbine.UI.Color(1, 0.4, 0.6, 0.8));
	self.tab:SetVisible( true );
	self.tab.Label:SetVisible(true);

	self.back:SetPosition(self.barSettings.x, self.barSettings.y);
	self.back:SetVisible(true);
	self.childWindow:SetVisible(true);
end

function TabbedBarDecorator:SetVisible( visible )
	self.back:SetVisible(visible);

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings( self.id );
	if (barSettings == nil) then
		self.Log:Debug("SetVisible barSettings are nil");
		return; -- This bar is dead;
	end

	if ( settingsService:GetSettings().barMode == NORMAL_MODE and self.tab ~= nil and barSettings.decorators.tab.titleColor ~= true) then
		self.tab:SetVisible(false);
	elseif (settingsService:GetSettings().barMode == NORMAL_MODE and not barSettings.visible) then
		self.tab:SetVisible(false);
	else
		self.tab:SetVisible(true);
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

	self.childWindow.SizeChanged = nil;

	self.tab.Label:SetVisible(false);
	self.tab.Label = nil;

	self.tab:SetVisible( false );
	self.tab = nil;

	collectgarbage();
end
