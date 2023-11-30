-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!
local eventService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.EventService);

eventService:RegisterCategory( "Erkrankt", Turbine.Gameplay.EffectCategory.Disease );
eventService:RegisterCategory( "Furcht", 	Turbine.Gameplay.EffectCategory.Fear );
eventService:RegisterCategory( "Vergiftet", Turbine.Gameplay.EffectCategory.Poison );
eventService:RegisterCategory( "Verwundet", 	Turbine.Gameplay.EffectCategory.Wound );
