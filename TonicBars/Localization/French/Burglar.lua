-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!
local eventService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.EventService);

--              				English Skill Name		-- Description shown on Menus -- Acutal Skill Name must match BUFF name exactly -- Class Name
eventService:RegisterEffect( "Critical Response", 				"Critical Response", 	"Critical Response", 				Turbine.Gameplay.Class.Burglar );
eventService:RegisterEffect( "Double Edged", 					"Double Edged", 		"Double Edged", 					Turbine.Gameplay.Class.Burglar );
eventService:RegisterEffect( "Mischievous",						"Mischievous", 			"Mischievous", 						Turbine.Gameplay.Class.Burglar );
eventService:RegisterEffect( "Stunned",							"Etourdissement", 		"Etourdissement",					Turbine.Gameplay.Class.Burglar );
eventService:RegisterEffect( "Dazed",							"Hébété", 				"Hébété", 							Turbine.Gameplay.Class.Burglar );
eventService:RegisterEffect( "Knocked Down",					"Renversé", 			"Renversé", 						Turbine.Gameplay.Class.Burglar );
eventService:RegisterEffect( "Fellowship Manoeuvre Response",	"FM Response", 			"Fellowship Manoeuvre Response",	Turbine.Gameplay.Class.Burglar );