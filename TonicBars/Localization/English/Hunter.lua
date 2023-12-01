-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!
local eventService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.EventService);

--              			English Skill Name		-- Description shown on Menus -- Acutal Skill Name must match BUFF name exactly -- Class Name
eventService:RegisterEffect( nil, "Stance: Strength", 		"Stance: Strength", 	Turbine.Gameplay.Class.Hunter );
eventService:RegisterEffect( nil, "Stance: Endurance", 		"Stance: Endurance", 	Turbine.Gameplay.Class.Hunter );
eventService:RegisterEffect( nil, "Stance: Precision", 		"Stance: Precision", 	Turbine.Gameplay.Class.Hunter );
eventService:RegisterEffect( nil, "Stance: Fleet", 			"Stance: Fleet", 		Turbine.Gameplay.Class.Hunter );
eventService:RegisterEffect( nil, "Find the Path", 			"Find the Path", 		Turbine.Gameplay.Class.Hunter );
eventService:RegisterEffect( nil, "Needful Haste", 			"Needful Haste", 		Turbine.Gameplay.Class.Hunter );
eventService:RegisterEffect( nil, "Swift Stroke", 			"Swift Stroke", 		Turbine.Gameplay.Class.Hunter );
eventService:RegisterEffect( nil, "Parry Response", 		"Parry Response", 		Turbine.Gameplay.Class.Hunter );
eventService:RegisterEffect( nil, "Beneath Notice", 		"Beneath Notice", 		Turbine.Gameplay.Class.Hunter );
eventService:RegisterEffect( nil, "Camp", 					"Camp", 				Turbine.Gameplay.Class.Hunter );
eventService:RegisterEffect( nil, "Burn Hot", 				"Burn Hot", 			Turbine.Gameplay.Class.Hunter );
eventService:RegisterEffect( nil, "Beneath Care", 			"Beneath Care", 		Turbine.Gameplay.Class.Hunter );

-- Other Non-Class specific buffs
eventService:RegisterEffect( nil, "Monster Play", 			"Monster Play", 		Turbine.Gameplay.Class.Hunter );
