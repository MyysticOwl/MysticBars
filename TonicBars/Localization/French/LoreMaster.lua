-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!
local eventService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.EventService);

--              			English Skill Name		-- Description shown on Menus -- Acutal Skill Name must match BUFF name exactly -- Class Name
eventService:RegisterEffect( "Sign of Power: Righteousness",	"Signe Pouvoir Intégrité", 		"Signe de pouvoir : Intégrité améliorée",	Turbine.Gameplay.Class.LoreMaster );
eventService:RegisterEffect( "Sign of Power: Vigilance", 		"Signe Pouvoir Vigilance", 		"Signe de pouvoir : Vigilance", 			Turbine.Gameplay.Class.LoreMaster );
eventService:RegisterEffect( "Tend the Sick", 					"Aides Malades", 				"Aides aux malades", 						Turbine.Gameplay.Class.LoreMaster );
eventService:RegisterEffect( "Leechcraft", 						"Absorbe Blessures", 			"Absorption des blessures", 				Turbine.Gameplay.Class.LoreMaster );
eventService:RegisterEffect( "Ancient Wisdom", 					"Sagesse antique", 				"Sagesse antique", 							Turbine.Gameplay.Class.LoreMaster );
eventService:RegisterEffect( "Improved Ancient Wisdom", 		"Amélioration Sagesse antique", "Amélioration de la sagesse antique", 		Turbine.Gameplay.Class.LoreMaster );
eventService:RegisterEffect( "Wisdom of the Council", 			"Sagesse Conseil", 				"Sagesse du Conseil", 						Turbine.Gameplay.Class.LoreMaster );