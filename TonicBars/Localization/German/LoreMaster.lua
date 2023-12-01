-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!
local eventService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.EventService);

-- 							English Skill Name -- Description shown on Menus -- Acutal Skill Name must match BUFF name exactly -- Class Name
eventService:RegisterEffect( "Sign of Power: Righteousness", "ZdM:R", 				"Zeichen der Macht: Rechtschaffenheit", Turbine.Gameplay.Class.LoreMaster );
eventService:RegisterEffect( "Sign of Power: Vigilance", 	"ZdM:W", 				"Zeichen der Macht: Wachsamkeit", 		Turbine.Gameplay.Class.LoreMaster );
eventService:RegisterEffect( "Tend the Sick", 				"Kranke versorgen", 	"Kranke versorgen", 					Turbine.Gameplay.Class.LoreMaster );
eventService:RegisterEffect( "Leechcraft", 					"Heilkunde", 			"Heilkunde", 							Turbine.Gameplay.Class.LoreMaster );
eventService:RegisterEffect( "Ancient Wisdom", 				"Uralte Weiheit", 		"Uralte Weisheit", 						Turbine.Gameplay.Class.LoreMaster );
eventService:RegisterEffect( "Improved Ancient Wisdom", 	"Verbesserte Uralte Weiheit", 	"Verbesserte Uralte Weisheit", 	Turbine.Gameplay.Class.LoreMaster );
eventService:RegisterEffect( "Wisdom of the Council", 		"Weisheit des Rates", 	"Weisheit des Rates", 					Turbine.Gameplay.Class.LoreMaster );

eventService:RegisterEffect( "Dazed",						'Bet�ubung', 		 				'Bet�ubung', 								Turbine.Gameplay.Class.Champion );