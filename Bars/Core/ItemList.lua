	-- Created by MyysticOwl
-- If reusing this code, please keep the name of the original author listed
-- in respect for borrowing said authors code.
-- RESPECT!

ItemList = class( Turbine.UI.Control );

ItemList.Log = MysticBars.Utils.Logging.LogManager.GetLogger( "ItemList" );

function ItemList:Constructor( bid )
	Turbine.UI.Control.Constructor( self );

	self.Log:Debug("Constructor");

	self.id = bid;

	self.quickslots = { };
	self.items = { };
	self.currentIemCount = 0;
	self.count = 0;
	self.countToShow = 0;
	self.itemsPerLine = 0;
	self.isClearingQuickslots = false;
	self.fixQuickslotID = false;
	self.entered = false;
	self.loading = false;
end

function ItemList:ClearItems()
	self.Log:Debug("ClearItems");
end

function ItemList:SetMaxItemsPerLine( maxPerLine )
	self.Log:Debug("SetMaxItemsPerLine");

	self.itemsPerLine = maxPerLine;
end

function ItemList:SetCountToShow( count )
	self.countToShow = tonumber(count);
end

function ItemList:Refresh()
	self.Log:Debug("Refresh " .. self.itemsPerLine);

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings( self.id );

	self:RefreshQuickslots();

	for key, value in pairs (self.quickslots) do
		value:SetAllowDrop( false );
		value:SetItem( self.items[key] );
	end

	for i = 1, self.count do
		if (self.countToShow ~= nil and i > self.countToShow) then
			self.quickslots[i]:SetVisible(false);
		else
			local x = ((i - 1) % self.itemsPerLine) * ((barSettings.quickslotSize + barSettings.quickslotSpacing) - 4);
			local y = math.floor((i - 1) / self.itemsPerLine) * ((barSettings.quickslotSize + barSettings.quickslotSpacing) - 4);
			self.quickslots[i]:SetPosition(x, y);
			self.quickslots[i]:SetSize(barSettings.quickslotSize, barSettings.quickslotSize);
		end
	end

	local ysize = math.floor((self.count - 1) / self.itemsPerLine) * ((barSettings.quickslotSize + barSettings.quickslotSpacing) - 4) + barSettings.quickslotSize;
	-- The minus 4 is a bit of a hack... turns out each quickslot is rendered slightly smaller than its actual size. When stacked with many of their own size,
	-- there are size issues, this corrects those problems.
	local xsize = (self.itemsPerLine * (barSettings.quickslotSize - 4)) + ((self.itemsPerLine - 1) * barSettings.quickslotSpacing) + 4;

	if ( ysize >= barSettings.quickslotSize ) then
		self:SetSize(xsize, ysize);
	else
		self:SetHeight(barSettings.quickslotSize);
		self:SetWidth(xsize);
	end
end

function ItemList:RefreshQuickslots()
	self.Log:Debug("RefreshQuickslots");

	local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings( self.id );
	self.loading = true;

	for i = self.currentIemCount + 1, self.count, 1 do
		self.quickslots[i]:SetVisible( false );
		self.quickslots[i]:SetParent( nil );
		self.quickslots[i]:SetItem( nil );
		self.quickslots[i] = nil;
	end

	for i=self.count + 1, self.currentIemCount do
		if ( self.items[i] ~= nil ) then
			self.quickslots[i] = Turbine.UI.Lotro.ItemControl();
			self.quickslots[i]:SetParent( self );
			self.quickslots[i]:SetSize( barSettings.quickslotSize, barSettings.quickslotSize );
			self.quickslots[i]:SetVisible( true );
			self.quickslots[i]:SetItem( self.items[i] );
		end
	end
	
	self.loading = false;
	self.count = self.currentIemCount;
end

function ItemList:ClearQuickslots()
	self.Log:Debug("ClearQuickslots");

	self.isClearingQuickslots = true;
	for key, value in pairs (self.quickslots) do
		value:SetVisible( false );
		value:SetParent( nil );
		value:SetItem( nil );
		value = nil;
	end
	self.items = { };

	SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.id, function(barSettings)
		self.currentIemCount = 0;
		return barSettings;
	end);
	self.isClearingQuickslots = false;
end

function ItemList:GetQuickslotLocation( index )
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

function ItemList:SetupExtensionSlot( bars, index )
	self.Log:Debug("SetupExtensionSlot");
end

function ItemList:AddItem( item )
	self.Log:Debug("AddItem");

	local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

	local found = false;
	for key, value in pairs (self.items) do
		if ( value == item ) then
			found = true;
		end
	end
	if ( found == false ) then
		local barSettings = settingsService:GetBarSettings( self.id );
		if ( self.currentIemCount < barSettings.quickslotCount ) then
			self.currentIemCount = self.currentIemCount + 1;
			self.items[self.currentIemCount] = item;
			self.items[self.currentIemCount].QuantityChanged = function(sender,args)
				if ( barService:Alive( self.id ) == true ) then
					SERVICE_CONTAINER:GetService(MysticBars.Services.InventoryService):NotifyClients();
				end
			end	
		end
	end
end

function ItemList:RemoveItem( item )
	self.Log:Debug("RemoveItem");
	
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings( self.id );
	local found = nil;
	for index=1, self.currentIemCount, 1 do
		if ( found ~= nil ) then
			self.items[index - 1] = self.items[index];
		end
		if ( self.items[index] == item ) then
			-- Turbine.Shell.WriteLine( "Removing Item:" .. self.items[index]:GetName() );
			found = true;
			self.items[index] = nil;
			self.currentIemCount = self.currentIemCount - 1;
		end
	end	
end