	-- Created by MyysticOwl
-- If reusing this code, please keep the name of the original author listed
-- in respect for borrowing said authors code.
-- RESPECT!

QuickslotList = class( Turbine.UI.Control );

QuickslotList.Log = MysticBars.Utils.Logging.LogManager.GetLogger( "QuickslotList", false );

function QuickslotList:Constructor( bid )
	Turbine.UI.Control.Constructor( self );

	self.Log:Debug("Constructor");

	self.id = bid;
	
	self.quickslots = { };
	self.count = 0;
	self.itemsPerLine = 0;
	self.isClearingQuickslots = false;
	self.fixQuickslotID = false;
	self.entered = false;
	self.loading = false;
end

function QuickslotList:ClearItems()
	self.Log:Debug("ClearItems");
end

function QuickslotList:SetMaxItemsPerLine( maxPerLine )
	self.Log:Debug("SetMaxItemsPerLine");

	self.itemsPerLine = maxPerLine;
end

function QuickslotList:Refresh( showAllQuickslots, lockQuickslots )
	self.Log:Debug("Refresh");

	self:RefreshQuickslots();

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings( self.id );

	for key, value in pairs (self.quickslots) do
		local shortcut = value:GetShortcut();
		if (showAllQuickslots == false and shortcut:GetData() == "" and shortcut:GetType() == 0) then
			value:SetVisible( false );
		else
			value:SetVisible( true );
		end
		value:SetAllowDrop( not lockQuickslots );
	end

	for i = 1, self.count do
		local x = ((i - 1) % self.itemsPerLine) * ((barSettings.quickslotSize + barSettings.quickslotSpacing) - 4);
		local y = math.floor((i - 1) / self.itemsPerLine) * ((barSettings.quickslotSize + barSettings.quickslotSpacing) - 4);
		self.quickslots[i]:SetPosition(x, y);
		self.quickslots[i]:SetStretchMode(1);
		self.quickslots[i]:SetSize(barSettings.quickslotSize, barSettings.quickslotSize);
	end

	local ysize = math.floor((self.count - 1) / self.itemsPerLine) * ((barSettings.quickslotSize + barSettings.quickslotSpacing) - 4) + barSettings.quickslotSize;
	-- The minus 4 is a bit of a hack... turns out each quickslot is rendered slightly smaller than its actual size. When stacked with many of their own size,
	-- there are size issues, this corrects those problems.
	local xsize = (self.itemsPerLine * (barSettings.quickslotSize - 4)) + ((self.itemsPerLine - 1) * barSettings.quickslotSpacing) + 4; 
	self:SetSize(xsize, ysize);
end

function QuickslotList:RefreshQuickslots()
	self.Log:Debug("RefreshQuickslots");

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings( self.id );

	self.loading = true;

	if ( self.extensions ~= nil ) then
		for i = barSettings.quickslotCount + 1, self.count, 1 do
			for key, value in pairs (self.extensions) do
				if ( value.quickslot == i ) then
					local id = self.extensions[ key ].bar:GetID();
					self.extensions[ key ].quickslot = nil;
					self.extensions[ key ] = nil;

					local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
					barService:Remove( id );
				end
			end
		end
	end


	for i = barSettings.quickslotCount + 1, self.count, 1 do
		self.quickslots[i]:SetVisible( false );
		self.quickslots[i]:SetParent( nil );
		self.quickslots[i]:SetShortcut( nil );
		self.quickslots[i] = nil;
	end

	-- local dump = MysticBars.Utils.TableDump();
	-- dump.Dump(barSettings.quickslots);

	for i=self.count + 1, barSettings.quickslotCount do
		self.quickslots[i] = Turbine.UI.Lotro.Quickslot();
		self.quickslots[i].index = i;
		self.quickslots[i].locked = barSettings.locked;
		self.quickslots[i]:SetParent( self );
		--self.quickslots[i]:SetStretchMode(1);
		self.quickslots[i]:SetSize( barSettings.quickslotSize, barSettings.quickslotSize );
		self.quickslots[i]:SetUseOnRightClick( true );

		self.quickslots[i].DragDrop = function( sender, args )
			local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
			local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

			if ( barService ~= nil and barService:Alive( self.id ) ) then

				local bars = barService:GetBars();
				if ( barService.originItem ~= nil and barService.performingDrop == nil ) then
					barService.performingDrop = true;
					local origindata = barService.originData;
					local origintype = barService.originType;
					local originitem = barService.originItem;
					local originbar = barService.originBar;
					local newdata = barService.newData;
					local newtype = barService.newType;
					local newitem = barService.newItem;
	
	--				Turbine.Shell.WriteLine( "originItem:" .. originitem .. " originBar:" .. originbar .. " origindata:" .. origindata );
	--				Turbine.Shell.WriteLine( "newItem:" .. newitem .. " newBar:" .. self.id .. " newdata:" .. newdata );

					barService.originData = nil;
					barService.originType = nil;
					barService.originItem = nil;
					barService.originBar = nil;
					barService.newData = nil;
					barService.newType = nil;
					barService.newItem = nil;

					local barSettings = settingsService:GetBarSettings( self.id );
					local barSettings2 = settingsService:GetBarSettings( originbar );

					if (barSettings2.locked ~= true and barSettings.locked ~= true) then
						local shortcut = Turbine.UI.Lotro.Shortcut( origintype, origindata );
						local shortcut2 = Turbine.UI.Lotro.Shortcut( newtype, newdata );

						self.quickslots[newitem]:SetShortcut( shortcut );
						bars[originbar].quickslotList.quickslots[originitem]:SetShortcut( shortcut2 );
					else
	--					Turbine.Shell.WriteLine( "Locked" );
						local shortcut = Turbine.UI.Lotro.Shortcut( origintype, origindata );
						bars[originbar].quickslotList.quickslots[originitem]:SetShortcut( shortcut );
					end

					if ( self.isClearingQuickslots == false and self.loading == false) then
						settingsService:SaveQuickslots( barSettings, self.quickslots, false );
						settingsService:SaveQuickslots( barSettings2, bars[originbar].quickslotList.quickslots );
					end

					barService.performingDrop = nil;
					barService.ActiveObject = nil;
				elseif ( self.isClearingQuickslots == false and self.loading == false) then
					settingsService:SaveQuickslots( barSettings, self.quickslots, false );
				end
			end
		end

		self.quickslots[i].DragEnter = function( sender, args )
			local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);

			if ( barService ~= nil ) then
				barService.newData = self.quickslots[sender.index]:GetShortcut():GetData();
				barService.newType = self.quickslots[sender.index]:GetShortcut():GetType();
				barService.newItem = sender.index;
--			Turbine.Shell.WriteLine( "DE sender:" .. sender.index .. " on bar:" .. self.id .. " data:" .. barService.newData );
			end
		end
		self.quickslots[i].DragLeave = function( sender, args )
			local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
			local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

			if ( barService ~= nil and sender.index == barService.originItem and self.id == barService.originBar) then
				self.quickslots[barService.originItem]:SetShortcut( nil );
	
				if ( self.isClearingQuickslots == false and self.loading == false) then
					local barSettings = settingsService:GetBarSettings( self.id );
					settingsService:SaveQuickslots( barSettings, self.quickslots );
				end
				self.quickslots[barService.originItem]:SetVisible( true );
			end
		end

		self.quickslots[i].MouseDown = function( sender, args )
			local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);

			if ( barService ~= nil ) then
				barService.originData = self.quickslots[sender.index]:GetShortcut():GetData();
				barService.originType = self.quickslots[sender.index]:GetShortcut():GetType();
				barService.originItem = sender.index;
				barService.originBar = self.id;
--				Turbine.Shell.WriteLine( "MouseDown " .. sender.index .. " on bar:" .. self.id .. " data:" .. barService.originData );
			end
		end
		self.quickslots[i].MouseClick = function( sender,args )
			--Turbine.UI.Lotro.Quickslot()
			local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
			local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

			local settings = settingsService:GetSettings();
			local bSettings = settingsService:GetBarSettings( self.id );
			if ( barService ~= nil and barService:Alive( self.id ) and args.Button == 2 and settings.barMode == EXTENSION_MODE) then
				local barid = barService:Add( EXTENSIONBAR, self.id, sender.index );
				barService:ShowExtensionBarMenu( barid );
				barService:UpdateBarExtensions();
				SERVICE_CONTAINER:GetService(MysticBars.Services.MenuService):GetMenu():Refresh(true);
			elseif( barService ~= nil and barService:Alive( self.id ) and args.Button == 1 and settings.barMode == NORMAL_MODE and bSettings.onMouseOver == ROLL_UP_SELECTION ) then
				local thebars = barService:GetBars();
				thebars[self.id]:RollupSelection( thebars[self.id], sender.index );
			end
		end
	end
	
	self.loading = false;
	self.count = barSettings.quickslotCount;
end

function QuickslotList:ClearQuickslots()
	self.Log:Debug("ClearQuickslots");

	self.isClearingQuickslots = true;
	for key, value in pairs (self.quickslots) do
		value:SetVisible( false );
		value:SetParent( nil );
		value:SetShortcut( nil );
		value = nil;
	end
	if ( self.extensions ~= nil ) then
		for key, value in pairs (self.extensions) do
			value.quickslot = nil;
			value = nil;
		end
	end
	self.isClearingQuickslots = false;
end

function QuickslotList:GetQuickslotLocation( index )
	self.Log:Debug("GetQuickslotLocation");

	if ( index <= self.count ) then
		local x, y = self.quickslots[index]:GetPosition();
		local x2, y2 = self:PointToScreen( x, y );
		return math.abs(x2), math.abs(y2);
	else
		Turbine.Shell.WriteLine( "ERROR ExtensionSlot not removed corretly." );
		return 0,0;
	end
end

function QuickslotList:SetupExtensionSlot( bars, index )
	self.Log:Debug("SetupExtensionSlot");

	if ( index <= self.count ) then
		self.extensions = bars;
		
		self.quickslots[ index ].MouseEnter = function(sender,args)
			local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
			local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

			if ( barService ~= nil and barService:Alive( self.id ) and self.entered == false ) then
				self.entered = true;
				for key, value in pairs (self.extensions) do
					local barSettings = settingsService:GetBarSettings( value.bar.id );
					if ( value.quickslot == index ) then
						local thebars = barService:GetBars();
						if ( barSettings.onMouseOver == SHOW_EXTENSIONS or barSettings.onMouseOver == ROLL_UP_SELECTION ) then
							value.bar:Show( true );
						elseif ( barSettings.onMouseOver == SELECT_RANDOM_SHORTCUT ) then
							value.bar:SelectRandomShortcut( thebars[self.id], index );
						elseif ( barSettings.onMouseOver == CYCLE_EXTENSIONS ) then
							value.bar:CycleShortcut( thebars[self.id], index, args );
						end
					end
				end
			end
		end

		self.quickslots[ index ].MouseLeave = function(sender,args)
			local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
			local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

			if ( barService ~= nil and barService:Alive( self.id ) and self.entered == true ) then
				for key, value in pairs (self.extensions) do
					local barSettings = settingsService:GetBarSettings( value.bar );
					if ( value.quickslot == index and (barSettings.onMouseOver == SHOW_EXTENSIONS or barSettings.onMouseOver == ROLL_UP_SELECTION) ) then
						value.bar:Show( false );
					end
				end
				self.entered = false;
			end
		end
	else
		Turbine.Shell.WriteLine( "ERROR 29 ExtensionSlot not removed corretly." );
	end
end