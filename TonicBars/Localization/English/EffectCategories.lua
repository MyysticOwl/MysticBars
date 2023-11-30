-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!
local eventService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.EventService);

eventService:RegisterCategory( "Diseased", Turbine.Gameplay.EffectCategory.Disease );
eventService:RegisterCategory( "Feared", 	Turbine.Gameplay.EffectCategory.Fear );
eventService:RegisterCategory( "Poisoned", Turbine.Gameplay.EffectCategory.Poison );
eventService:RegisterCategory( "Wounded", 	Turbine.Gameplay.EffectCategory.Wound );
