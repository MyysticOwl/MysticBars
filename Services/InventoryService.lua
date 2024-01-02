-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine.Gameplay";
import "Turbine.UI";
import "MysticBars.Utils.Class";
import "MysticBars.Utils.Service";

InventoryService = class( MysticBars.Utils.Service );

function InventoryService:Constructor()
	self.ADD = 1;
	self.REMOVE = 2;
	
	if ( self.registeredEvents == nil ) then
		self.registeredEvents = { };
	end
	
	self:RegisterForBackpackCallbacks();
	self:NotifyClients( self.ADD );
end

function InventoryService:RegisterForEvents( registerant, rid )
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
	if ( self.clients ~= nil and self.clients[rid] ~= nil ) then
		self.clients[rid].registered = false;
		self.clients[rid].bar = nil;
		self.clients[rid] = nil;
	end
end

function InventoryService:NotifyClients( type, specificItem )
	if ( self.clients == nil ) then
		self.clients = { };
	end
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local playerService = SERVICE_CONTAINER:GetService(MysticBars.Services.PlayerService);
	local backpack = playerService.player:GetBackpack();

	for key, value in pairs (self.clients) do
		local visible = false;
		local barSettings = settingsService:GetBarSettings( key );
		local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);

		if ( barService ~= null and value ~= nil and value.registered == true and barService:Alive( key ) == true ) then
			local qlist = value.bar:GetQuickslotList();
			if ( qlist ~= nil and ( type == self.ADD or specificItem == nil) ) then
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
	if ( barSettings.events ~= nil and barSettings.events.inventory ~= nil ) then
		if ( type == nil or type == self.ADD ) then
			if ( barSettings.events.inventory.useCount ~= nil and barSettings.events.inventory.useCount == true and item:GetQuantity() >= barSettings.events.inventory["quantity"] ) then
				barObject.bar:GetQuickslotList():AddItem( item );
			end
			if ( barSettings.events.inventory.categories ~= nil ) then
								for key, value in pairs (barSettings.events.inventory.categories) do
					--Turbine.Shell.WriteLine( "key:" .. key .. " item:" .. Turbine.Gameplay.ItemCategory[4] );
					if ( Turbine.Gameplay.ItemCategory[ key ] == item:GetCategory() ) then
						barObject.bar:GetQuickslotList():AddItem( item );
					end
				end
			end
			if ( barSettings.events.inventory.nameFilters ~= nil ) then
				for key, value in pairs (barSettings.events.inventory.nameFilters) do
					--Turbine.Shell.WriteLine( "key:" .. key .. " item:" .. Turbine.Gameplay.ItemCategory[4] );
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
	return self.registeredEvents;
end

function InventoryService:RegisterForBackpackCallbacks()
	local eventService = SERVICE_CONTAINER:GetService(MysticBars.Services.EventService);
	local playerService = SERVICE_CONTAINER:GetService(MysticBars.Services.PlayerService);
	local backpack = playerService.player:GetBackpack();

	eventService.AddCallback( self, backpack, "ItemAdded", function( sender, args )
		self:NotifyClients( self.ADD, args.Item );
	end);
	eventService.AddCallback( self, backpack, "ItemRemoved", function( sender, args )
		self:NotifyClients( self.REMOVE, args.Item );
	end);
end
