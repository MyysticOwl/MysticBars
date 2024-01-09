-- Created by MyysticOwl
-- If reusing this code, please keep the name of the original author listed
-- in respect for borrowing said authors code.
-- RESPECT!

ExtensionBar = class( MysticBars.Bars.Core.BaseBar );

ExtensionBar.Log = MysticBars.Utils.Logging.LogManager.GetLogger( "ExtensionBar", false );

function ExtensionBar:Constructor( barId )
	self.Log:Debug("Constructor");

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings( barId );

	local changedBarSettings = false;
	self.faded = false;
	if ( barSettings.barType ~= EXTENSIONBAR or barSettings.locked ~= true ) then
		barSettings.barType = EXTENSIONBAR;
		barSettings.locked = true;
		changedBarSettings = true;
	end

	if ( barSettings.orientation == nil ) then
		barSettings.orientation = "Right";
		changedBarSettings = true;
	end
	if ( barSettings.barTermination == nil ) then
		barSettings.barTermination = 1;
		changedBarSettings = true;
	end
	self.keepVisible = false;
	self.cycleCount = 0;
	
	MysticBars.Bars.Core.BaseBar.Constructor( self, barId );

	self.quickslotList.loading = true;
	settingsService:LoadQuickslots( barSettings, self.quickslotList.quickslots );
	self.quickslotList.loading = false;

	if ( changedBarSettings ) then
		settingsService:SetBarSettings( self.id, barSettings );
	else
		self:Refresh();
	end
	
	self:SetVisible( false );
end

function ExtensionBar:Create()
	self.Log:Debug("Create");

	self.quickslotList = MysticBars.Bars.Core.QuickslotList( self.id );
	MysticBars.Bars.Core.BaseBar.Create( self );
end

function ExtensionBar:CheckMakeVisible()
	self.Log:Debug("CheckMakeVisible");

	if ( self.keepVisible == false ) then
		self:SetVisible( false );
	end
end

function ExtensionBar:Show( visible )
	self.Log:Debug("Show");

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

	if ( visible ) then
		self:SetWantsUpdates( false );
		self.count = 0;
	end

	local settings = settingsService:GetSettings();
	if ( self.keepVisible == true or ( self.keepVisible == false and visible and settings.barMode == NORMAL_MODE) ) then
		self.wasVisible = true;
		self.visible = visible;

		self.MouseEnter = function(sender,args)
			self.keepVisible = true;
		end
		self.MouseLeave = function(sender,args)
			local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
			
			if ( barService:Alive( self.id ) ) then
				local barSettings = settingsService:GetBarSettings( self.id );
				if ( barSettings.barTermination ~= 2 ) then
					self.keepVisible = false;
				end
			end
		end
		self.Update = function(sender,args)
			if ( self.count >= 10 and self.keepVisible == false ) then
				self:SetWantsUpdates( false );
				self.visible = false;
				self.Update = nil;
				self.MouseLeave = nil;
				self.MouseEnter = nil;
				self:SetVisible( false );
			else
				local barSettings = settingsService:GetBarSettings( self.id );
				if ( self.count >= 10 and barSettings.barTermination == 2 and player:IsInCombat() == false ) then
					self.keepVisible = false;
				end
				self.count = self.count + 1;
			end
		end
		
		self:SetVisible( true );
	elseif ( self.wasVisible == true and self.keepVisible == false ) then
		self.count = 0;
		self:SetWantsUpdates( true );
		self.wasVisible = false;
	end
end

function ExtensionBar:Setup( pX, pY )
	self.Log:Debug("Setup");

	self.positionX = pX;
	self.positionY = pY;

	self.created = true;
	self:SetupPosition();
end

function ExtensionBar:SetupPosition( refresh )
	self.Log:Debug("SetupPosition");

	local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

	if ( barService  ~= nil and barService:Alive( self.id ) ) then
		local barSettings = settingsService:GetBarSettings( self.id );
		local changedBarSettings = false;
		if ( self.created == true ) then
			if ( barSettings.orientation == "Left" ) then
				self:SetPosition( self.positionX - self:GetWidth(), self.positionY );
				if (  barSettings.quickslotCount ~= barSettings.quickslotColumns) then
					barSettings.quickslotColumns = barSettings.quickslotCount;
					changedBarSettings = true;
				end
			elseif ( barSettings.orientation == "Right" ) then
				self:SetPosition( self.positionX + barSettings.quickslotSize, self.positionY );
				if (  barSettings.quickslotCount ~= barSettings.quickslotColumns) then
					barSettings.quickslotColumns = barSettings.quickslotCount;
					changedBarSettings = true;
				end
			elseif ( barSettings.orientation == "Up" ) then
				self:SetPosition( self.positionX, self.positionY - self:GetHeight() );
				if (  barSettings.quickslotColumns ~= 1 ) then
					barSettings.quickslotColumns = 1;
					changedBarSettings = true;
				end
			elseif ( barSettings.orientation == "Down" ) then
				self:SetPosition( self.positionX, self.positionY + barSettings.quickslotSize );
				if (  barSettings.quickslotColumns ~= 1 ) then
					barSettings.quickslotColumns = 1;
					changedBarSettings = true;
				end
			end
		end
		if ( changedBarSettings ) then
			settingsService:SetBarSettings( self.id, barSettings, true );
		else
			if ( refresh == nil ) then
				self:Refresh();
			end
		end
	end
end

function ExtensionBar:Created()
	self.Log:Debug("Created");

	if ( self.created ~= nil and self.created == true) then
		return true;
	else
		return false;
	end
end

function ExtensionBar:Refresh()
	self.Log:Debug("Refresh");

	self:SetupPosition( false );
	MysticBars.Bars.Core.BaseBar.Refresh( self );
	self:SetupPosition( false );
end

function ExtensionBar:SetBGColor( color )
	self.Log:Debug("SetBGColor");

	self:SetBackColor( color );
end

function ExtensionBar:ShowBarMenu()
	self.Log:Debug("ShowBarMenu");

	local orientationMenu = Turbine.UI.ContextMenu();

	local menuItems = orientationMenu:GetItems();
	menuItems:Add( Turbine.UI.MenuItem( "Orientation:", false ) );
	menuItems:Add( Turbine.UI.MenuItem( "Left" ) );
	menuItems:Add( Turbine.UI.MenuItem( "Right" ) );
	menuItems:Add( Turbine.UI.MenuItem( "Up" ) );
	menuItems:Add( Turbine.UI.MenuItem( "Down" ) );

	local i;

	for i = 1, menuItems:GetCount() do
		local menuItem = menuItems:Get( i );
		local itemText = menuItem:GetText();

		if ( itemText == self.menuSelectedItem ) then
			menuItem:SetChecked( true );
			menuItem:SetEnabled( false );
		end

		menuItem.Click = function( sender, args )
			self.menuSelectedItem = itemText;
			self:SetOrientation( self.menuSelectedItem );
		end
	end

	orientationMenu:ShowMenu();
end

function ExtensionBar:SetOrientation( orientation )
	self.Log:Debug("SetOrientation");

	if ( orientation == nil or (orientation ~= "Left" and orientation ~= "Right" and orientation ~= "Up" and orientation ~= "Down") ) then
		return nil
	else
		local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
		local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

		local barSettings = settingsService:GetBarSettings( self.id );

		if ( orientation ~= barSettings.orientation and barService  ~= nil and barService:Alive( self.id ) ) then
			barSettings.orientation = orientation;
			settingsService:SetBarSettings( self.id, barSettings );
		else
			self:Refresh();
		end
		self:SetupPosition();
		--barService:UpdateBarExtensions();
		return 1;
	end
end

function ExtensionBar:SelectRandomShortcut( parentBar, quickslotToReplace )
	self.Log:Debug("SelectRandomShortcut");

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

	local i = 0;
	local barSettings = settingsService:GetBarSettings( self.id );
	for key, value in pairs ( barSettings.quickslots ) do
		i = i + 1;
	end
	if ( i == 0) then
		return;
	end
	selection = math.random( i );

	local quickslot = self:FindNthQuickslot( selection );
	if ( quickslot ~= nil and quickslot:GetShortcut() ~= nil ) then
		parentBar:GetQuickslotList().quickslots[ quickslotToReplace ]:SetShortcut( quickslot:GetShortcut() );
		return;
	end
end

function ExtensionBar:CycleShortcut( parentBar, quickslotToReplace, args )
	self.Log:Debug("CycleShortcut");

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

	local barSettings = settingsService:GetBarSettings( self.id );
	self.cycleCount = (self.cycleCount + 1) % (barSettings.quickslotCount + 1);	  -- 0 - quickslot count will return 1 minus the number we want because LUA is 1 based.
	if ( self.cycleCount == 0 ) then
		self.cycleCount = 1;
	end
	local quickslot = self:GetQuickslotList().quickslots[ self.cycleCount ];  -- So, add 1 to the output.
	if ( quickslot ~= nil and quickslot:GetShortcut() ~= nil ) then
		parentBar:GetQuickslotList().quickslots[ quickslotToReplace ]:SetShortcut( quickslot:GetShortcut() );
		return;
	end
end

function ExtensionBar:RollupSelection( parentBar, indexToUse )
	self.Log:Debug("RollupSelection");

	local quickslot = self:GetQuickslotList().quickslots[ indexToUse ];
	if ( quickslot ~= nil and quickslot:GetShortcut() ~= nil ) then
		local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
		local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

		local theBars = barService:GetBars();
		local barSettings = settingsService:GetBarSettings( self.id );
		local parentQuickslot = theBars[ barSettings.connectionBarID ]:GetQuickslotList().quickslots[ barSettings.connectionQuickslotID ];		
		parentQuickslot:SetShortcut( quickslot:GetShortcut() );
		return;
	end
end

function ExtensionBar:FindNthQuickslot( selection )
	self.Log:Debug("FindNthQuickslot");

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

	local barSettings = settingsService:GetBarSettings( self.id );
	for key2, value2 in pairs ( barSettings.quickslots ) do
		if ( selection - 1 <= 0 ) then
			return self:GetQuickslotList().quickslots[ key2 ];
		else
			selection = selection - 1;
		end
	end
	return nil;
end

function ExtensionBar:SetMenuBackColor( selected, barMode )
	self.Log:Debug("SetMenuBackColor");

	MysticBars.Bars.Core.BaseBar.SetMenuBackColor( self, selected, EXTENSION_MODE );
	self:SetBackColor( Turbine.UI.Color(1,1,1,0) );
end