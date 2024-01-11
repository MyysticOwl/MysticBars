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

	self.selected = false;
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
end

function BaseBar:Create()
	self.Log:Debug("Create");

	self.quickslotList:SetParent( self );
	self.quickslotList:SetMaxItemsPerLine( self.barSettings.quickslotColumns );
	self.quickslotList:SetPosition(0, 0 );

	self.qsCreated = true;

	self:Refresh("BaseBar:Create");
end

function BaseBar:ClearQuickslots()
	self.Log:Debug("ClearQuickslots");

	self.quickslotList:ClearQuickslots();
end

function BaseBar:Refresh( sender )
	self.Log:Debug("Refresh " .. sender .. " id:" .. self.id);

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
	local showQuickslots = (settings.barMode ~= NORMAL_MODE) or self.barSettings.locked == false;
	self.quickslotList:Refresh( showQuickslots, self.barSettings.locked );

	self:BarSelected();

	self:SetBarSize();
end

function BaseBar:BarSetup()
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local settings = settingsService:GetSettings();

	if ( settings.barMode == NORMAL_MODE ) then
		if ( self.faded ) then
			self:SetOpacity( self.barSettings.fadeOpacity );
		else
			self:SetOpacity( 1 );
		end
		if ( self.barSettings.useBackgroundColor == true ) then
			local tempColor = Turbine.UI.Color( self.barSettings.opacity, self.barSettings.backgroundColorRed, self.barSettings.backgroundColorGreen, self.barSettings.backgroundColorBlue);
			self:SetBGColor( tempColor );
		else
			self:SetBGColor( Turbine.UI.Color( 0, 0, 0, 0) );
		end
		if ( self.barSettings.barType == EXTENSIONBAR ) then
			self:SetVisible( false );
		end
	else
		self:SetMenuBackColor( self.id == settings.selectedBar, settings.barMode );
		self:SetVisible( true );
	end
end

function BaseBar:SetMenuBackColor( selected, barMode )
	self.Log:Debug("SetMenuBackColor");

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local settings = settingsService:GetSettings();
	if ( selected ) then
		self:SetOpacity( 0.6 );
	end
end

function BaseBar:BarSelected()
	self.Log:Debug("SetMenuBackColor");

	if ( self.selected ) then
		self.selectedProirColor = self:GetBackColor();
		self.selectedProirOpacity = self:GetOpacity();
		self.selectedProirVisible = self:IsVisible();

		self:SetBGColor( Turbine.UI.Color(1, 1,.5,0) );
		self:SetOpacity( 1 );
		self:SetVisible(true);
		self.quickslotList:Refresh( true, self.barSettings.locked );
	else
		self:BarSetup();
		-- if (self.selectedProirColor ~= nil) then
		-- 	self:SetBGColor( self.selectedProirColor );
		-- 	self.selectedProirColor = nil;
		-- 	self:SetOpacity( self.selectedProirOpacity );
		-- 	self.selectedProirOpacity = nil;
		-- 	self:SetVisible( self.selectedProirVisible );
		-- 	self.selectedProirVisible = nil;

		-- 	self.quickslotList:Refresh( true, self.barSettings.locked );
		-- end
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

	self:BarSelected();
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