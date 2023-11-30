-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

import "Turbine.Gameplay";
import "Turbine.UI";
import "Tonic.Utils.Class";
import "Tonic.Utils.Service";
import "Tonic.Utils.Table";
import "Tonic.TonicBars.Events.BuffEvents";
import "Tonic.TonicBars.Events.KeyEvents";
import "Tonic.TonicBars.Events.StatEvents";
import "Tonic.TonicBars.Events.ClassSpecificEvents";
import "Tonic.TonicBars.Events.MiscEvents";

EventService = class( Tonic.Utils.Service );

function EventService:Constructor()
	self.barService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.BarService);
	self.settingsService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.SettingsService);

	self.effectsRegistered = false;
	self.currentClass = 0;

	if ( self.registeredEvents == nil ) then
		self.registeredEvents = { };
	end
	if ( self.registeredEvents.classes == nil ) then
		self.registeredEvents.classes = { };
	end
	self.registeredEvents.playerInCombat = false;
end

function EventService:RegisterForEvents( registerant, rid )
	if ( self.clients == nil ) then
		self.clients = { };
	end
	if ( self.clients[rid] == nil ) then
		self.clients[rid] = { };
	end

	self.clients[rid].registered = true;
	self.clients[rid].bar = registerant;

	self:NotifyClients();
end

function EventService:UnregisterForEvents( rid )
	if ( self.clients ~= nil and self.clients[rid] ~= nil ) then
		self.clients[rid].registered = false;
		self.clients[rid].bar = nil;
		self.clients[rid] = nil;
	end
end

function EventService:StartManager()
	self.buffEvents = Tonic.TonicBars.Events.BuffEvents( self.registeredEvents );
	self.keyEvents = Tonic.TonicBars.Events.KeyEvents( self.registeredEvents );
	self.classEvents = Tonic.TonicBars.Events.ClassSpecificEvents( self.registeredEvents );
	self.statEvents = Tonic.TonicBars.Events.StatEvents( self.registeredEvents );
	self.miscEvents = Tonic.TonicBars.Events.MiscEvents( self.registeredEvents );
end

function EventService:NotifyClients()
	if ( self.clients == nil ) then
		self.clients = { };
	end
	for key, value in pairs (self.clients) do
		local visible = false;
		local force = false;
		local barSettings = self.settingsService:GetBarSettings( key );
		if ( value ~= nil and value.registered == true and barSettings.events ~= nil and self.barService ~= nil and self.barService:Alive( key ) == true) then
			-- Send all Effect based events to all clients
			visible = visible or self.buffEvents:CheckVisibility( barSettings );
			visible = visible or self.classEvents:CheckVisibility( barSettings );
			visible = visible or self.statEvents:CheckVisibility( barSettings );
			visible = visible or self.miscEvents:CheckVisibility( barSettings );
			visible = self.keyEvents:CheckVisibility( barSettings, value ) or visible;

			value.bar:DetermineVisiblity( visible, force );
		end
	end
	if ( self.keyEvents.registeredEvents.F12 ~= nil ) then
		self.keyEvents.registeredEvents.F12 = nil;
	end
end

function EventService:RegisterEffect( englishSkillName, descriptionString, name, class )
	if ( self.currentClass ~= class ) then
		self.currentClass = class;
		self.currentIndex = 1;
	end
	if ( self.registeredEvents.classes[ class ] == nil ) then
		self.registeredEvents.classes[ class ] = { };
	end
	if ( self.registeredEvents.classes[ class ].effects == nil ) then
		self.registeredEvents.classes[ class ].effects = { };
	end
	if ( self.registeredEvents.classes[ class ].effects[name] == nil ) then
		self.registeredEvents.classes[ class ].effects[name] = { };
	end
	self.registeredEvents.classes[ class ].effects[name].index = self.currentIndex;
	self.registeredEvents.classes[ class ].effects[name].description = descriptionString;
	self.registeredEvents.classes[ class ].effects[name].englishSkillName = englishSkillName;
	self.registeredEvents.classes[ class ].effects[name].count = 0;
	self.currentIndex = self.currentIndex + 1;
end

function EventService:RegisterCategory( descriptionString, category )
	if ( self.registeredEvents.categories == nil ) then
		self.registeredEvents.categories = { };
	end
	if ( self.registeredEvents.categories[category] == nil ) then
		self.registeredEvents.categories[category] = { };
	end
	self.registeredEvents.categories[category].description = descriptionString;
	self.registeredEvents.categories[category].count = 0;
end

function EventService:GetRegisteredEvents()
	return self.registeredEvents;
end

function EventService:AddCallback(object, event, callback)
    if (object[event] == nil) then
        object[event] = callback;
    else
        if (type(object[event]) == "table") then
            table.insert(object[event], callback);
        else
            object[event] = {object[event], callback};
        end
    end
    return callback;
end