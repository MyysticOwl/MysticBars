-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!
local eventService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.EventService);

--              			English Skill Name		-- Description shown on Menus -- Acutal Skill Name must match BUFF name exactly -- Class Name
eventService:RegisterEffect( nil, "Defeat Response", 		"Enemy Defeat Response", 		Turbine.Gameplay.Class.Captain );
eventService:RegisterEffect( nil, "Battle-Readied",			"Battle-readied", 				Turbine.Gameplay.Class.Captain );
eventService:RegisterEffect( nil, "Battle-Hardened", 		"Battle-hardened", 				Turbine.Gameplay.Class.Captain );
eventService:RegisterEffect( nil, "Banner of Hope", 		"Banner of Hope", 				Turbine.Gameplay.Class.Captain );
eventService:RegisterEffect( nil, "Banner of War", 			"Banner of War", 				Turbine.Gameplay.Class.Captain );
eventService:RegisterEffect( nil, "Banner of Victory", 		"Banner of Victory", 			Turbine.Gameplay.Class.Captain );
eventService:RegisterEffect( nil, "Imp Banner of Hope",		"Improved Banner of Hope",		Turbine.Gameplay.Class.Captain );
eventService:RegisterEffect( nil, "Imp Banner of War", 		"Improved Banner of War", 		Turbine.Gameplay.Class.Captain );
eventService:RegisterEffect( nil, "Imp Banner of Victory", 	"Improved Banner of Victory", 	Turbine.Gameplay.Class.Captain );
eventService:RegisterEffect( nil, "IDoMe", 					"In Defence of Middle-earth", 	Turbine.Gameplay.Class.Captain );
eventService:RegisterEffect( nil, "Fellow Defeated", 		"Fellow Defeat Response", 		Turbine.Gameplay.Class.Captain );
eventService:RegisterEffect( nil, "Motivated", 				"Motivated", 					Turbine.Gameplay.Class.Captain );
eventService:RegisterEffect( nil, "Relentless Attack", 		"Relentless Attack", 			Turbine.Gameplay.Class.Captain );
eventService:RegisterEffect( nil, "On Guard", 				"On Guard", 					Turbine.Gameplay.Class.Captain );
eventService:RegisterEffect( nil, "Focus", 					"Focus", 						Turbine.Gameplay.Class.Captain );
eventService:RegisterEffect( nil, "Last Stand", 			"Last Stand", 					Turbine.Gameplay.Class.Captain );
eventService:RegisterEffect( nil, "War-cry", 				"War-cry", 						Turbine.Gameplay.Class.Captain );
eventService:RegisterEffect( nil, "Defending", 				"Defending", 					Turbine.Gameplay.Class.Captain );
eventService:RegisterEffect( nil, "Make Haste", 			"Make Haste", 					Turbine.Gameplay.Class.Captain );
eventService:RegisterEffect( nil, "Courage", 				"Courage", 						Turbine.Gameplay.Class.Captain );

-- Other Non-Class specific buffs
eventService:RegisterEffect( nil, "Monster Play", 			"Monster Play", 		Turbine.Gameplay.Class.Captain );