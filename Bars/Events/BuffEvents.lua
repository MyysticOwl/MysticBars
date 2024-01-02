-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine.Gameplay";
import "Turbine.UI";
import "MysticBars.Utils.Class";
import "MysticBars.Utils.Table";

BuffEvents = class( Turbine.Object  );

function BuffEvents:Constructor( regEvents )
	local eventService = SERVICE_CONTAINER:GetService(MysticBars.Services.EventService);
	local playerService = SERVICE_CONTAINER:GetService(MysticBars.Services.PlayerService);
	local playerClass = playerService.playerClass;
	self.registeredEvents = regEvents;

    local effects = playerService.player:GetEffects();
	for i = 1, effects:GetCount() do
		local effect = effects:Get(i);
		local name = effect:GetName();
		
		if ( self.registeredEvents.classes[ playerClass ] ~= nil and self.registeredEvents.classes[ playerClass ].effects ~= nil and self.registeredEvents.classes[ playerClass ].effects[name] ~= nil ) then
			self.registeredEvents.classes[ playerClass ].effects[name].count = self.registeredEvents.classes[ playerClass ].effects[name].count + 1;
		end

		local category = effect:GetCategory();
		if ( self.registeredEvents.categories ~= nil and self.registeredEvents.categories[category] ~= nil ) then
			self.registeredEvents.categories[category].count = self.registeredEvents.categories[category].count + 1;
		end
	end

	eventService:AddCallback( effects, "EffectAdded", function(sender, args)
		local eventService = SERVICE_CONTAINER:GetService(MysticBars.Services.EventService);
		local playerService = SERVICE_CONTAINER:GetService(MysticBars.Services.PlayerService);
		
		local effects = playerService.player:GetEffects()
		local effect = effects:Get(args.Index);

		local name = effect:GetName();
		if ( self.registeredEvents.classes[ playerClass ] ~= nil and self.registeredEvents.classes[ playerClass ].effects[name] ~= nil ) then
			self.registeredEvents.classes[ playerClass ].effects[name].count = self.registeredEvents.classes[ playerClass ].effects[name].count + 1;
		end

		local category = effect:GetCategory();
		if ( self.registeredEvents.categories[category] ~= nil ) then
			self.registeredEvents.categories[category].count = self.registeredEvents.categories[category].count + 1;
		end
		eventService:NotifyClients();
	end);

	eventService:AddCallback( effects, "EffectRemoved", function(sender, args)
		local eventService = SERVICE_CONTAINER:GetService(MysticBars.Services.EventService);
		
		local effect = args.Effect;

		local name = effect:GetName();
		if ( self.registeredEvents.classes[ playerClass ] ~= nil and self.registeredEvents.classes[ playerClass ].effects[name] ~= nil ) then
			self.registeredEvents.classes[ playerClass ].effects[name].count = self.registeredEvents.classes[ playerClass ].effects[name].count - 1;
		end

		local category = effect:GetCategory();
		if ( self.registeredEvents.categories[category] ~= nil ) then
			self.registeredEvents.categories[category].count = self.registeredEvents.categories[category].count - 1;
		end
		eventService:NotifyClients();
	end);

	eventService:AddCallback( effects, "EffectsCleared", function(sender, args)
		local eventService = SERVICE_CONTAINER:GetService(MysticBars.Services.EventService);

		local effect = args.Effect;

		local name = effect:GetName();
		if ( self.registeredEvents.classes[ playerClass ].effects[name] ~= nil ) then
			self.registeredEvents.classes[ playerClass ].effects[name].count = self.registeredEvents.classes[ playerClass ].effects[name].count - 1;
		end

		local category = effect:GetCategory();
		if ( self.registeredEvents.categories[category] ~= nil ) then
			self.registeredEvents.categories[category].count = self.registeredEvents.categories[category].count - 1;
		end
		eventService:NotifyClients();
	end);
end

function BuffEvents:CheckVisibility( barSettings )
	local visible = false;
	-- Send all Effect based events to all clients
	if (barSettings.events.effects ~= nil and self.registeredEvents.classes[ playerClass ] ~= nil and self.registeredEvents.classes[ playerClass ].effects ~= nil ) then
		if ( barSettings.events.triggered.triggerOnClassBuffActive == true ) then
			for key2, value2 in pairs (self.registeredEvents.classes[ playerClass ].effects) do
				if ( value2 ~= nil and value2.count > 0 and barSettings.events.effects[ key2 ] == true ) then
					visible = true;
				end
			end
		else
			visible = true;
			for key2, value2 in pairs (self.registeredEvents.classes[ playerClass ].effects) do
				if ( value2 ~= nil and value2.count > 0 and barSettings.events.effects[ key2 ] == true ) then
					visible = false;
				end
			end
		end
	end
	-- Send all Category Effect based events to all clients
	if (barSettings.events.triggered ~= nil and barSettings.events.triggered.categories ~= nil ) then
		for key3, value3 in pairs (self.registeredEvents.categories) do
			if ( value3 ~= nil and value3.count > 0 and barSettings.events ~= nil and barSettings.events.triggered.categories[ key3 ] ~= nil ) then
				visible = true;
			end
		end
	end
	return visible;
end