-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

local eventService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.EventService);

--              			English Skill Name		-- Description shown on Menus -- Acutal Skill Name must match BUFF name exactly -- Class Name
eventService:RegisterEffect( nil, "Critical Response", 	"Critical Response", 				Turbine.Gameplay.Class.Burglar );
eventService:RegisterEffect( nil, "Double Edged", 		"Double Edged", 					Turbine.Gameplay.Class.Burglar );
eventService:RegisterEffect( nil, "Mischievous", 		"Mischievous", 						Turbine.Gameplay.Class.Burglar );
eventService:RegisterEffect( nil, "Stunned", 			"Stunned",							Turbine.Gameplay.Class.Burglar );
eventService:RegisterEffect( nil, "Dazed", 				"Dazed", 							Turbine.Gameplay.Class.Burglar );
eventService:RegisterEffect( nil, "Knocked Down", 		"Knocked Down", 					Turbine.Gameplay.Class.Burglar );
eventService:RegisterEffect( nil, "FM Response", 		"Fellowship Manoeuvre Response",	Turbine.Gameplay.Class.Burglar );

-- Other Non-Class specific buffs
eventService:RegisterEffect( nil, "Monster Play", 			"Monster Play", 		Turbine.Gameplay.Class.Burglar );