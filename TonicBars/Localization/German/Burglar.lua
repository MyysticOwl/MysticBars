-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!
local eventService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.EventService);

-- 							English Skill Name -- Description shown on Menus -- Acutal Skill Name must match BUFF name exactly -- Class Name
eventService:RegisterEffect( nil, 							"Gewandtheit", 						"Gewandtheit", 						Turbine.Gameplay.Class.Burglar );
eventService:RegisterEffect( nil, 							"Bösartige Schadenfreude", 			"Bösartige Schadenfreude", 						Turbine.Gameplay.Class.Burglar );
eventService:RegisterEffect( "Critical Response", 			"Kritische Erwiderung", 			"Kritische Erwiderung", 			Turbine.Gameplay.Class.Burglar );
eventService:RegisterEffect( "Mischievous", 				"Schelmisch", 						"Schelmisch", 						Turbine.Gameplay.Class.Burglar );
eventService:RegisterEffect( nil, 							"Zielen", 							"Anlegen", 				Turbine.Gameplay.Class.Burglar );
-- eventService:RegisterEffect( "Double Edged", 				"Double Edged", 					"Double Edged", 					Turbine.Gameplay.Class.Burglar );
-- eventService:RegisterEffect( "Fellowship Manoeuvre Response","FM Response", 					"Fellowship Manoeuvre Response",	Turbine.Gameplay.Class.Burglar );
-- eventService:RegisterEffect( "Stunned",						"Stunned", 							"Stunned",							Turbine.Gameplay.Class.Burglar );
eventService:RegisterEffect( "Dazed", 						"Betäubung", 						"Betäubung", 							Turbine.Gameplay.Class.Burglar );
eventService:RegisterEffect( "Knocked Down", 				"Zu Boden geschlagen", 				"Zu Boden geschlagen", 					Turbine.Gameplay.Class.Burglar );