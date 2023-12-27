-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine.Gameplay";
import "Turbine.UI";
import "MyysticUI.Utils.Class";
import "MyysticUI.Utils.Table";

KeyEvents = class( Turbine.UI.Control  );

function KeyEvents:Constructor( regEvents )
	Turbine.UI.Control.Constructor( self );

	self.registeredEvents = regEvents;
	self:SetWantsKeyEvents( true );

	self.KeyDown = function( sender, args )
		local changed = false;
		if ( args.Action == 268435556 ) then	-- ALT
			self.registeredEvents.altIsDown = true;
			changed = true;
		end
		if ( args.Action == 268435575 ) then	-- CTRL
			self.registeredEvents.controlIsDown = true;
			changed = true;
		end
		if ( args.Action == 268435458 ) then	-- SHIFT
			self.registeredEvents.shiftIsDown = true;
			changed = true;
		end
		if ( args.Action == 268435635 ) then	-- F12
			self.registeredEvents.F12 = true;
			changed = true;
		end
		-- if ( args.Action == Turbine.UI.Lotro.Action.Quickslot_1 ) then	-- F12
		-- 	Turbine.Shell.WriteLine("Quickslot 1 Fired");
		-- 	local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);
		-- 	if ( barService  ~= nil and barService:Alive( 1 ) ) then
		-- 		local bars = barService:GetBars();
		-- 		local bar1 = bars[1];
		-- 		local bar1List = bar1:GetQuickslotList();
		-- 		local quickslot1 = bar1List.quickslots[ 1 ];
		-- 		local dump = MyysticUI.Utils.TableDump();
		-- 		dump.Dump(getmetatable(quickslot1.__implementation));
		-- 		quickslot1:MouseClick({["Button"] = 1});
		-- 	end
		-- 	changed = true;
		-- end
		if ( args.Action == Turbine.UI.Lotro.Action.Escape ) then	-- Escape
			self.registeredEvents.Escape = true;
			changed = true;
		end
		if ( args.Action == Turbine.UI.Lotro.Action.ToggleBag1 or args.Action == Turbine.UI.Lotro.Action.ToggleBag2 or args.Action == Turbine.UI.Lotro.Action.ToggleBag3 or
		     args.Action == Turbine.UI.Lotro.Action.ToggleBag4 or args.Action == Turbine.UI.Lotro.Action.ToggleBag5 or args.Action == Turbine.UI.Lotro.Action.ToggleBags ) then	-- Inventory
			self.registeredEvents.inventory = true;
			changed = true;
		end

		if ( changed ) then
			local eventService = SERVICE_CONTAINER:GetService(MyysticUI.Services.EventService);
			eventService:NotifyClients();
		end
	end

	self.KeyUp = function( sender, args )
		local changed = false;
		if ( args.Action == 268435556 and self.registeredEvents.altIsDown ~= nil ) then
			self.registeredEvents.altIsDown = nil;
			changed = true;
		end
		if ( args.Action == 268435575 and self.registeredEvents.controlIsDown ~= nil ) then
			self.registeredEvents.controlIsDown = nil;
			changed = true;
		end
		if ( args.Action == 268435458 and self.registeredEvents.shiftIsDown ~= nil ) then
			self.registeredEvents.shiftIsDown = nil;
			changed = true;
		end
		if ( args.Action == Turbine.UI.Lotro.Action.Escape and self.registeredEvents.Escape ~= nil ) then
			self.registeredEvents.Escape = nil;
			changed = true;
		end
		if ( (args.Action == Turbine.UI.Lotro.Action.ToggleBag1 or args.Action == Turbine.UI.Lotro.Action.ToggleBag2 or args.Action == Turbine.UI.Lotro.Action.ToggleBag3 or
		     args.Action == Turbine.UI.Lotro.Action.ToggleBag4 or args.Action == Turbine.UI.Lotro.Action.ToggleBag5 or args.Action == Turbine.UI.Lotro.Action.ToggleBags) and
			 self.registeredEvents.inventory ~= nil ) then	-- Inventory
			self.registeredEvents.inventory = nil;
			changed = true;
		end

		if ( changed ) then
			local eventService = SERVICE_CONTAINER:GetService(MyysticUI.Services.EventService);
			eventService:NotifyClients();
		end
	end
end

function KeyEvents:CheckVisibility( barSettings, value, force )
	local visible = false;
	-- Send all Keypress based events to all clients
	if ( (self.registeredEvents.altIsDown ~= nil and barSettings.events.isAlt == true) or 
		 (self.registeredEvents.controlIsDown ~= nil and barSettings.events.isControl == true) or 
		 (self.registeredEvents.shiftIsDown ~= nil and barSettings.events.isShift == true)
		) then
		visible = true;
	end

	-- If 12 is pressed TOGGLE display on all clients
	if ( self.registeredEvents.F12 ~= nil ) then
		value.bar:F12Pressed();
	end
	-- If I is pressed TOGGLE display on all clients
	if ( self.registeredEvents.inventory ~= nil ) then
		value.bar:InventoryPressed();
	end
	-- If Escape is pressed hide on all clients
	if ( barSettings.barType == WINDOW_INV_BAR and self.registeredEvents.Escape ~= nil ) then
		force = true;
		self.registeredEvents.Escape = nil;
	end
	return visible;
end