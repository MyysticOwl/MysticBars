-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

BaseBar = class( Turbine.UI.Window );

BaseBar.Log = MysticBars.Utils.Logging.LogManager.GetLogger( "BaseBar" );

function BaseBar:Constructor( barSettings )
	Turbine.UI.Window.Constructor( self );
	self.Log:Debug("Constructor");

	self.id = barSettings.id;
	self.barSettings = barSettings;

	if (barSettings.decorator == WINDOW_BAR_DECORATOR) then
		self.decorator = MysticBars.Bars.Decorators.WindowBarDecorator( self, barSettings );
	else
		self.decorator = MysticBars.Bars.Decorators.TabbedBarDecorator( self, barSettings );
	end
	
	self.selected = false;
	self.dragged = false;
	self.isSelectedOnMainMenu = false;
	self.f12HideBar = false;
	self.inventoryShowBar = false;

	self:SetMouseVisible( true );
	self:SetAllowDrop( true );

--	self:SetPosition( barSettings.x, barSettings.y );
 
	self:Create();

	if ( barSettings.barType ~= EXTENSIONBAR ) then
		local title = barSettings.barName;
		if ( barSettings.barName == nil or barSettings.barName == "" ) then
			title = "Bar:" .. self.id;
		end
		self.DragBar = MysticBars.Menus.Core.UI.DragBar( self, title, true );
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

function BaseBar:PositionChanged( sender, args )
	-- self.decorator:Refresh();
end

function BaseBar:Create()
	self.Log:Debug("Create");

	self.quickslotList.SizeChanged = function (sender, args)
		self:SetSize(self.quickslotList:GetWidth(), self.quickslotList:GetHeight());
	end

	self.decorator:Create();
end

function BaseBar:ClearQuickslots()
	self.Log:Debug("ClearQuickslots");

	self.quickslotList:ClearQuickslots();
end

function BaseBar:Refresh( count )
	self.Log:Debug("Refresh ");--" .. sender .. " id:" .. self.id);

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local settings = settingsService:GetSettings();
	local barSettings = settingsService:GetBarSettings( self.id );
	if (barSettings == nil) then
		return; -- This bar is dead;
	else
		self.barSettings = barSettings;
	end

	self:BarSetup();

	if ( self.barSettings.barType ~= EXTENSIONBAR and self.DragBar ~= nil ) then
		self.DragBar:Refresh();
	end

	self.quickslotList:SetAllowDrop( not self.barSettings.locked );
	self.quickslotList:SetMaxItemsPerLine( self.barSettings.quickslotColumns );
	self.quickslotList:SetCountToShow( count );
	local showQuickslots = (settings.barMode ~= NORMAL_MODE) or self.barSettings.locked == false;
	self.quickslotList:Refresh( showQuickslots, self.barSettings.locked );

	self.decorator:Refresh();

	self:BarSelected();

	self:SetBarSize();
end

function BaseBar:BarSetup()
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local settings = settingsService:GetSettings();

	if (self.decorator.tab ~= nil and self.barSettings.decorator == WINDOW_BAR_DECORATOR) then
		self.decorator:Remove();
		self.decorator = MysticBars.Bars.Decorators.WindowBarDecorator( self, self.barSettings );
		self.decorator:Create();
	elseif (self.decorator.mainWindow ~= nil and self.barSettings.decorator == TAB_BAR_DECORATOR) then
		self.decorator:Remove();
		self.decorator = MysticBars.Bars.Decorators.TabbedBarDecorator( self, self.barSettings );
		self.decorator:Create();
	end

	if ( settings.barMode == NORMAL_MODE ) then
		if ( self.faded ) then
			self:SetOpacity( self.barSettings.fadeOpacity );
		else
			self:SetOpacity( 1 );
		end
		if ( self.barSettings.useBackgroundColor == true ) then
			local tempColor = Turbine.UI.Color( self.barSettings.opacity, self.barSettings.backgroundColorRed, self.barSettings.backgroundColorGreen, self.barSettings.backgroundColorBlue);
			self:SetBGColor( tempColor );
			self.decorator:SetBackColor(tempColor);
		else
			self:SetBGColor( Turbine.UI.Color( 0, 0, 0, 0) );
			self.decorator:SetBackColor(Turbine.UI.Color( 0, 0, 0, 0));
		end
		if ( self.barSettings.barType == EXTENSIONBAR ) then
			self:SetVisible( false );
		end
	else
		self:SetMenuBackColor( nil, settings.barMode );
		self:SetVisible( true );
	end
end

function BaseBar:SetMenuBackColor( color, opacity )
	self.Log:Debug("SetMenuBackColor");

	self:SetBackColor(color);
	self.decorator:SetBackColor(color);
	if ( self.selected ) then
		self:SetOpacity( opacity );
	end
end

function BaseBar:BarSelected()
	self.Log:Debug("SetMenuBackColor");

	if ( self.selected ) then
		self:SetBGColor( Turbine.UI.Color(1, 1,.5,0) );
		self.decorator:SetBGColor(Turbine.UI.Color(1, 1,.5,0));
		self:SetOpacity( 1 );
		self:SetVisible(true);
		self.quickslotList:Refresh( true, self.barSettings.locked );
		return
	end
	self:BarSetup();
end

function BaseBar:SetBGColor(color)
	self.Log:Debug("SetBGColor");

	self:SetBackColor(color);
end

function BaseBar:SetBarSize()
	self.Log:Debug("SetBarSize");

	self:SetSize( self.quickslotList:GetWidth(), self.quickslotList:GetHeight() );
end

function BaseBar:DetermineVisiblity()
	self.Log:Debug("DetermineVisiblity");

	if ( not self.f12HideBar  ) then --or self.inventoryShowBar ) then
		self:SetVisible( true );
	else
		self:SetVisible( false );
	end

	self:BarSelected();
end

function BaseBar:Remove()
	self.Log:Debug("Remove");

	self.decorator:Remove();
end

function BaseBar:F12Pressed()
	self.Log:Debug("F12Pressed");

	self.f12HideBar = not self.f12HideBar;
end

function BaseBar:InventoryPressed()
	self.Log:Debug("InventoryPressed");
end

function BaseBar:GetQuickslotList()
	self.Log:Debug("GetQuickslotList");

	return self.quickslotList;
end

function BaseBar:GetID()
	self.Log:Debug("GetID");

	return self.id;
end

function BaseBar:SetVisible( visible )
	Turbine.UI.Window.SetVisible(self, visible);
	self.decorator:SetVisible(visible);
end