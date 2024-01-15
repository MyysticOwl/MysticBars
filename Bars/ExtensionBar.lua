-- Created by MyysticOwl
-- If reusing this code, please keep the name of the original author listed
-- in respect for borrowing said authors code.
-- RESPECT!

ExtensionBar = class( MysticBars.Bars.Core.BaseBar );

ExtensionBar.Log = MysticBars.Utils.Logging.LogManager.GetLogger( "ExtensionBar" );

function ExtensionBar:Constructor( barSettings )
	self.Log:Debug("Constructor");

	self.keepVisible = false;
	self.cycleCount = 0;

	MysticBars.Bars.Core.BaseBar.Constructor( self, barSettings );

	self.quickslotList:LoadQuickslots();

	self:Refresh("ExtensionBar:Constructor");
	self:SetVisible( false );
end

function ExtensionBar:Create()
	self.Log:Debug("Create");

	self.quickslotList = MysticBars.Bars.Core.QuickslotList( self, self.barSettings );
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

function ExtensionBar:SetupPosition()
	self.Log:Debug("SetupPosition");

	local newX = nil;
	local newY = nil;

	if ( self.created == true ) then
		if ( self.barSettings.orientation == "Left" ) then
			newX = self.positionX - self:GetWidth();
			newY = self.positionY;
			if (  self.barSettings.quickslotCount ~= self.barSettings.quickslotColumns) then
				self.barSettings.quickslotColumns = self.barSettings.quickslotCount;
			end
		elseif ( self.barSettings.orientation == "Right" ) then
			newX = self.positionX + self.barSettings.quickslotSize;
			newY = self.positionY;
			if (  self.barSettings.quickslotCount ~= self.barSettings.quickslotColumns) then
				self.barSettings.quickslotColumns = self.barSettings.quickslotCount;
			end
		elseif ( self.barSettings.orientation == "Up" ) then
			newX = self.positionX;
			newY = self.positionY - self:GetHeight();
			if (  self.barSettings.quickslotColumns ~= 1 ) then
				self.barSettings.quickslotColumns = 1;
			end
		elseif ( self.barSettings.orientation == "Down" ) then
			newX = self.positionX;
			newY = self.positionY + self.barSettings.quickslotSize;
			if (  self.barSettings.quickslotColumns ~= 1 ) then
				self.barSettings.quickslotColumns = 1;
			end
		end
	end
	if (newX ~= nil) then
		self:SetPosition( newX, newY );
		MysticBars.Bars.Core.BaseBar.Refresh( self, "ExtensionBar:SetupPosition");
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

function ExtensionBar:Refresh( sender, drawShortcuts )
	self.Log:Debug("Refresh");

	MysticBars.Bars.Core.BaseBar.Refresh( self);
	self:SetupPosition();

	if (drawShortcuts) then
		self.quickslotList:LoadQuickslots();
	end
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
		local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

		if ( orientation ~= self.barSettings.orientation ) then
			self.barSettings.orientation = orientation;
			settingsService:SetBarSettings( self.barSettings );
		else
			self:Refresh("ExtensionBar:SetOrientation");
		end
		self:SetupPosition();
		return 1;
	end
end

function ExtensionBar:SelectRandomShortcut( parentBar, quickslotToReplace )
	self.Log:Debug("SelectRandomShortcut");

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

	local i = 0;

	for key, value in pairs ( self.barSettings.quickslots ) do
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

	self.cycleCount = (self.cycleCount + 1) % (self.barSettings.quickslotCount + 1);	  -- 0 - quickslot count will return 1 minus the number we want because LUA is 1 based.
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

		local parentQuickslot = theBars[ self.barSettings.connectionBarID ]:GetQuickslotList().quickslots[ self.barSettings.connectionQuickslotID ];		
		parentQuickslot:SetShortcut( quickslot:GetShortcut() );
		return;
	end
end

function ExtensionBar:FindNthQuickslot( selection )
	self.Log:Debug("FindNthQuickslot");

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

	for key2, value2 in pairs ( self.barSettings.quickslots ) do
		if ( selection - 1 <= 0 ) then
			return self:GetQuickslotList().quickslots[ key2 ];
		else
			selection = selection - 1;
		end
	end
	return nil;
end

function ExtensionBar:NormalModeRefresh()
	self.Log:Debug("NormalModeRefresh");

	self:SetVisible( false );
end

function ExtensionBar:EditModeRefresh()
	self.Log:Debug("EditModeRefresh");

	self:SetBackColor(Turbine.UI.Color(1,1,1,0));
	self:SetVisible( true );
end