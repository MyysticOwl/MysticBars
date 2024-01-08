-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

BaseBar = class( Turbine.UI.Window );

BaseBar.Log = MysticBars.Utils.Logging.LogManager.GetLogger( "BaseBar", false );

function BaseBar:Constructor()
	Turbine.UI.Window.Constructor( self );

	self.Log:Debug("Constructor");

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings( self.id );

	self.dragged = false;
	self.qsCreated = false;
	self.isSelectedOnMainMenu = false;
	self.f12HideBar = false;
	self.inventoryShowBar = false;

	self:SetMouseVisible( true );
	self:SetAllowDrop( true );
	self:SetPosition( barSettings.x, barSettings.y );
 
	self:Create();

	if ( barSettings.barType ~= EXTENSIONBAR ) then
		local title = barSettings.barName;
		if ( barSettings.barName == nil or barSettings.barName == "" ) then
			title = "Bar:" .. self.id;
		end
		self.DragBar = MysticBars.Menus.Core.UI.DragBar( self, title, true );
		self.DragBar:SetAllowsHUDHiding( false, true );
		self.DragBar.PositionChanged = function(sender,args)
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
	self.Log:Debug("PositionChanged");
end

function BaseBar:Create()
	self.Log:Debug("Create");

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings( self.id );

	self.quickslotList:SetParent( self );
	self.quickslotList:SetMaxItemsPerLine( barSettings.quickslotColumns );
	self.quickslotList:SetPosition(0, 0 );

	self.qsCreated = true;

	self:Refresh();
end

function BaseBar:ClearQuickslots()
	self.Log:Debug("ClearQuickslots");

	self.quickslotList:ClearQuickslots();
end

function BaseBar:Refresh()
	self.Log:Debug("Refresh");

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local settings = settingsService:GetSettings();
	local barSettings = settingsService:GetBarSettings( self.id );
	if ( settings.barMode == NORMAL_MODE ) then
		if ( self.faded ) then
			self:SetOpacity( barSettings.fadeOpacity );
		else
			self:SetOpacity( 1 );
		end
		if ( barSettings.useBackgroundColor == true ) then
			local tempColor = Turbine.UI.Color( barSettings.opacity, barSettings.backgroundColorRed, barSettings.backgroundColorGreen, barSettings.backgroundColorBlue);
			self:SetBGColor( tempColor );
		else
			self:SetBGColor( Turbine.UI.Color( 0, 0, 0, 0) );
		end
		if ( barSettings.barType == EXTENSIONBAR ) then
			self:SetVisible( false );
		end
	else
		self:SetMenuBackColor( self.id == settings.selectedBar, settings.barMode );
		self:SetVisible( true );
	end
	
	self:SetPosition( barSettings.x, barSettings.y );
	if ( barSettings.barType ~= EXTENSIONBAR and self.DragBar ~= nil ) then
		self.DragBar:Refresh();
	end

	self.quickslotList:SetAllowDrop( not barSettings.locked );
	self.quickslotList:SetMaxItemsPerLine( barSettings.quickslotColumns );
	local showQuickslots = (settings.barMode ~= NORMAL_MODE) or barSettings.locked == false;
	self.quickslotList:Refresh( showQuickslots, barSettings.locked );

	self:SetBarSize();
end

function BaseBar:SetMenuBackColor( selected, barMode )
	self.Log:Debug("SetMenuBackColor");

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local settings = settingsService:GetSettings();
	if ( selected ) then
		self:SetOpacity( 0.6 );
	end
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