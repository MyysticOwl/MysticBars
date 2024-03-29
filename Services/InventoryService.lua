-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

InventoryService = class( MysticBars.Utils.Service );

InventoryService.Log = MysticBars.Utils.Logging.LogManager.GetLogger( "InventoryService" );

function InventoryService:Constructor()
	self.Log:Debug("Constructor");

	self.ADD = 1;
	self.REMOVE = 2;
	
	if ( self.registeredEvents == nil ) then
		self.registeredEvents = { };
	end
	
	self:RegisterForBackpackCallbacks();
	self:NotifyClients( self.ADD );
end

function InventoryService:RegisterForEvents( registerant, rid )
	self.Log:Debug("RegisterForEvents");

	if ( self.clients == nil ) then
		self.clients = { };
	end
	if ( self.clients[rid] == nil ) then
		self.clients[rid] = { };

		self.clients[rid].registered = true;
		self.clients[rid].bar = registerant;
	
		self:NotifyClients( self.ADD );
	end
end

function InventoryService:UnregisterForEvents( rid )
	self.Log:Debug("UnregisterForEvents");

	if ( self.clients ~= nil and self.clients[rid] ~= nil ) then
		self.clients[rid].registered = false;
		self.clients[rid].bar = nil;
		self.clients[rid] = nil;
	end
end

function InventoryService:NotifyClients( type, specificItem )
	self.Log:Debug("NotifyClients");

	if ( self.clients == nil ) then
		self.clients = { };
	end
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local playerService = SERVICE_CONTAINER:GetService(MysticBars.Services.PlayerService);
	local backpack = playerService.player:GetBackpack();

	for key, value in pairs (self.clients) do
		local barSettings = settingsService:GetBarSettings( key );
		local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);

		if ( barService ~= nil and barSettings ~= nil and value ~= nil and value.registered == true ) then
			barSettings.quickslotCount = backpack:GetSize();

			local qlist = value.bar:GetQuickslotList();
			if ( qlist ~= nil and ( type == self.ADD or specificItem == nil) ) then
				self.Log:Debug("ItemAdded2");
				qlist:ClearQuickslots();
				for i=1, backpack:GetSize(), 1 do
					local item = backpack:GetItem(i);
					if ( item ~= nil ) then
						self:Inventory( value, barSettings, self.ADD, item );
					end
				end
			else
				self:Inventory( value, barSettings, type, specificItem );
			end
			value.bar:Refresh();
		end
	end
end

function InventoryService:Inventory( barObject, barSettings, type, item )
	self.Log:Debug("Inventory");

	if ( barSettings.events ~= nil and barSettings.events.inventory ~= nil ) then
		if ( type == nil or type == self.ADD ) then
			if ( barSettings.events.inventory.useCount ~= nil and barSettings.events.inventory.useCount == true and item:GetQuantity() >= barSettings.events.inventory["quantity"] ) then
				barObject.bar:GetQuickslotList():AddItem( item );
			end
			if ( barSettings.events.inventory.categories ~= nil ) then
								for key, value in pairs (barSettings.events.inventory.categories) do
					if ( Turbine.Gameplay.ItemCategory[ key ] == item:GetCategory() ) then
						barObject.bar:GetQuickslotList():AddItem( item );
					end
				end
			end
			if ( barSettings.events.inventory.nameFilters ~= nil ) then
				for key, value in pairs (barSettings.events.inventory.nameFilters) do
					if ( string.find( string.lower(item:GetName()), string.lower(key), 1, true ) ~= nil ) then
						barObject.bar:GetQuickslotList():AddItem( item );
					end
				end
			end
		else
			barObject.bar:GetQuickslotList():RemoveItem( item );
		end
	end
end

function InventoryService:GetRegisteredEvents()
	self.Log:Debug("GetRegisteredEvents");

	return self.registeredEvents;
end

function InventoryService:RegisterForBackpackCallbacks()
	self.Log:Debug("RegisterForBackpackCallbacks");

	local eventService = SERVICE_CONTAINER:GetService(MysticBars.Services.EventService);
	local playerService = SERVICE_CONTAINER:GetService(MysticBars.Services.PlayerService);
	local backpack = playerService.player:GetBackpack();

	eventService.AddCallback( self, backpack, "ItemAdded", function( sender, args )
		self.Log:Debug("ItemAdded");
		self:NotifyClients( self.ADD, args.Item );
	end);
	eventService.AddCallback( self, backpack, "ItemRemoved", function( sender, args )
		self:NotifyClients( self.REMOVE, args.Item );
	end);
end
