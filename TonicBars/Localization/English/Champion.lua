-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

local eventService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.EventService);

--              			English Skill Name		-- Description shown on Menus -- Acutal Skill Name must match BUFF name exactly -- Class Name
eventService:RegisterEffect( nil, "Defeat Response", 	"Enemy Defeat Response", 		Turbine.Gameplay.Class.Champion );
eventService:RegisterEffect( nil, "Blocking Blades", 	"Blocking Blades", 				Turbine.Gameplay.Class.Champion );
eventService:RegisterEffect( nil, "Ardent Flurry", 		"Ardent Flurry", 				Turbine.Gameplay.Class.Champion );
eventService:RegisterEffect( nil, "Ardour", 			"Ardour", 						Turbine.Gameplay.Class.Champion );
eventService:RegisterEffect( nil, "Glory", 				"Glory", 						Turbine.Gameplay.Class.Champion );
eventService:RegisterEffect( nil, "Flurry", 			"Flurry", 						Turbine.Gameplay.Class.Champion );
eventService:RegisterEffect( nil, "Improved Flurry", 	"Improved Flurry", 				Turbine.Gameplay.Class.Champion );
eventService:RegisterEffect( nil, "Glorious Exchange", 	"Glorious Exchange", 			Turbine.Gameplay.Class.Champion );
eventService:RegisterEffect( nil, "Exch of Blows", 		"Exchange of Blows", 			Turbine.Gameplay.Class.Champion );
eventService:RegisterEffect( nil, "Imp Exch Blows", 	"Improved Exchange of Blows", 	Turbine.Gameplay.Class.Champion );
eventService:RegisterEffect( nil, "Disarmed", 			"Primary Weapon: Disarmed", 	Turbine.Gameplay.Class.Champion );
eventService:RegisterEffect( nil, "Stunned", 	 		"Stunned", 						Turbine.Gameplay.Class.Champion );
eventService:RegisterEffect( nil, "Dazed", 		 		"Dazed", 						Turbine.Gameplay.Class.Champion );
eventService:RegisterEffect( nil, "Knocked Down", 		"Knocked Down", 				Turbine.Gameplay.Class.Champion );
eventService:RegisterEffect( nil, "Fervour", 			"Champion's Fervour", 			Turbine.Gameplay.Class.Champion );
eventService:RegisterEffect( nil, "Controlled Burn", 	"Controlled Burn", 				Turbine.Gameplay.Class.Champion );
eventService:RegisterEffect( nil, "Sudden Defence", 	"Sudden Defence", 				Turbine.Gameplay.Class.Champion );

-- Other Non-Class specific buffs
eventService:RegisterEffect( nil, "Monster Play", 			"Monster Play", 		Turbine.Gameplay.Class.Champion );