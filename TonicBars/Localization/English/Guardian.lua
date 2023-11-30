-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!
local eventService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.EventService);

--              			English Skill Name		-- Description shown on Menus -- Acutal Skill Name must match BUFF name exactly -- Class Name
eventService:RegisterEffect( nil, "Overpower", 	 	"Overpower", 					Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( nil, "Block Stance", 	"Guardian's Block Stance", 		Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( nil, "Parry Stance", 	"Guardian's Parry Stance", 		Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( nil, "Threat Stance", 	"Guardian's Threat Stance", 	Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( nil, "Guardian's Pledge", "Guardian's Pledge", 		Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( nil, "Parry Response", "Parry Response", 				Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( nil, "Block Response", "Block Response", 				Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( nil, "Shield Swipe", 	"Shield Swipe", 				Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( nil, "Retaliation", 	"Retaliation", 					Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( nil, "Ward", 			"Guardian's Ward", 				Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( nil, "Improved Ward", 	"Improved Guardian's Ward", 	Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( nil, "Stunned", 	 	"Stunned", 						Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( nil, "Dazed", 		 	"Dazed", 						Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( nil, "Knocked Down", 	"Knocked Down", 				Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( nil, "Engaging", 		"Engaging", 					Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( nil, "Warrior's Fortitude", "Warrior's Block", 			Turbine.Gameplay.Class.Guardian );

-- Other Non-Class specific buffs
eventService:RegisterEffect( nil, "Monster Play", 			"Monster Play", 		Turbine.Gameplay.Class.Guardian );
