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
	self.quickslotList = nil;

	if (barSettings.barType == EXTENSIONBAR) then
		self.decorator = MysticBars.Bars.Decorators.NoBarDecorator( self, barSettings );
	elseif (barSettings.decorator == WINDOW_BAR_DECORATOR) then
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

	self:Create();
end

function BaseBar:PositionChanged( sender, args )
end

function BaseBar:Create()
	self.Log:Debug("Create");

	self.quickslotList.SizeChanged = function (sender, args)
		self:SetSize(self.quickslotList:GetWidth() + 4, self.quickslotList:GetHeight() + 4);
	end

	self.decorator:Create();
end

function BaseBar:ClearQuickslots()
	self.Log:Debug("ClearQuickslots");

	self.quickslotList:ClearQuickslots();
end

function BaseBar:Refresh()
	self.Log:Debug("Refresh ");

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings( self.id );
	if (barSettings == nil) then
		return; -- This bar is dead;
	else
		self.barSettings = barSettings;
	end

	if (self.decorator.tab ~= nil and self.barSettings.decorator == WINDOW_BAR_DECORATOR) then
		self.decorator:Remove();
		self.decorator = nil;
		self.decorator = MysticBars.Bars.Decorators.WindowBarDecorator( self, self.barSettings );
		self.decorator:Create();
	elseif (self.decorator.mainWindow ~= nil and self.barSettings.decorator == TAB_BAR_DECORATOR) then
		self.decorator:Remove();
		self.decorator = nil;
		self.decorator = MysticBars.Bars.Decorators.TabbedBarDecorator( self, self.barSettings );
		self.decorator:Create();
	end

	self.quickslotList:Refresh();

	self:SetSize( self.quickslotList:GetWidth() + 4, self.quickslotList:GetHeight() + 4);

	if ( settingsService:GetSettings().barMode == NORMAL_MODE ) then
		self:NormalModeRefresh(barSettings);
	else
		self:EditModeRefresh(barSettings);
	end

	self:IsSelected();
end

function BaseBar:NormalModeRefresh(barSettings)
	self.Log:Debug("NormalModeRefresh before");
	self.decorator:NormalModeRefresh(barSettings);
	self.Log:Debug("NormalModeRefresh after");
end

function BaseBar:EditModeRefresh(barSettings)
	self.Log:Debug("EditModeRefresh before");
	self.decorator:EditModeRefresh(barSettings);
	self.Log:Debug("EditModeRefresh after");
end

function BaseBar:IsSelected()
	if ( self.selected ) then
		self:SetBGColor( Turbine.UI.Color(1, 1,.5,0) );
		self.decorator:SetBGColor(Turbine.UI.Color(1, 1,.5,0));
		self:SetOpacity( 1 );
		self:SetVisible(true);
		self.decorator:SetVisible(true);
		self.quickslotList:Refresh();
	end
end

function BaseBar:DetermineVisiblity()
	self.Log:Debug("DetermineVisiblity");

	if ( not self.f12HideBar  ) then --or self.inventoryShowBar ) then
		self:SetVisible( true );
	else
		self:SetVisible( false );
	end

	self:IsSelected();
end

function BaseBar:SetBGColor(color)
	self.Log:Debug("SetBGColor");

	self:SetBackColor(color);
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

function BaseBar:SetBarVisible( visible )
	Turbine.UI.Window.SetVisible(self, visible);
	if (self.decorator ~= nil) then
		self.decorator:SetVisible(visible);
	end
end