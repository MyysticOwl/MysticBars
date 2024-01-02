-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine.Gameplay";
import "Turbine.UI";
import "MysticBars.Utils.Class";
import "MysticBars.Utils.Service";
import "MysticBars.Utils.Table";
import "MysticBars.Bars.Events.BuffEvents";
import "MysticBars.Bars.Events.KeyEvents";
import "MysticBars.Bars.Events.StatEvents";
import "MysticBars.Bars.Events.ClassSpecificEvents";
import "MysticBars.Bars.Events.MiscEvents";

EventService = class( MysticBars.Utils.Service );

function EventService:Constructor()
	self.effectsRegistered = false;
	self.currentClass = 0;

	if ( self.registeredEvents == nil ) then
		self.registeredEvents = { };
	end
	if ( self.registeredEvents.classes == nil ) then
		self.registeredEvents.classes = { };
	end
	self.registeredEvents.playerInCombat = false;

	self:RegisterCategory( "Diseased", Turbine.Gameplay.EffectCategory.Disease );
	self:RegisterCategory( "Feared", 	Turbine.Gameplay.EffectCategory.Fear );
	self:RegisterCategory( "Poisoned", Turbine.Gameplay.EffectCategory.Poison );
	self:RegisterCategory( "Wounded", 	Turbine.Gameplay.EffectCategory.Wound );
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
	self.buffEvents = MysticBars.Bars.Events.BuffEvents( self.registeredEvents );
	self.keyEvents = MysticBars.Bars.Events.KeyEvents( self.registeredEvents );
	self.classEvents = MysticBars.Bars.Events.ClassSpecificEvents( self.registeredEvents );
	self.statEvents = MysticBars.Bars.Events.StatEvents( self.registeredEvents );
	self.miscEvents = MysticBars.Bars.Events.MiscEvents( self.registeredEvents );
end

function EventService:NotifyClients()
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	
	if ( self.clients == nil ) then
		self.clients = { };
	end
	for key, value in pairs (self.clients) do
		local visible = false;
		local force = false;
		local barSettings = settingsService:GetBarSettings( key );
		local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);

		if ( value ~= nil and value.registered == true and barSettings.events ~= nil and barService ~= nil and barService:Alive( key ) == true) then
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