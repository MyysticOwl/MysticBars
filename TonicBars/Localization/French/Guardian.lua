-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!
local eventService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.EventService);

--              			English Skill Name		-- Description shown on Menus -- Acutal Skill Name must match BUFF name exactly -- Class Name
eventService:RegisterEffect( "Overpower", 					"Surpuissance", 	 	"Surpuissance", 				Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( "Guardian's Block Stance", 	"Stance Blocage", 		"Défense du gardien", 			Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( "Guardian's Parry Stance", 	"Stance Parade", 		"Parade du gardien", 			Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( "Guardian's Threat Stance", 	"Stance Menace", 		"Menace de Gardien", 			Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( "Parry Response", 				"Si Parade", 			"Réaction de parade", 			Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( "Block Response", 				"Si Blocage", 			"Block Response", 				Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( "Shield Swipe", 				"Balayage Bouclier", 	"Balayage au bouclier", 		Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( "Retaliation", 				"Riposte", 				"Riposte", 						Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( "Guardian's Ward", 			"Protection", 			"Protection de gardien", 		Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( "Improved Guardian's Ward", 	"Protect Amélio", 		"Protection de gardien améliorée", 	Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( "Stunned", 					"Etourdi", 	 			"Etourdissement", 				Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( "Dazed", 						"Hébété", 		 		"Hébété", 						Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( "Knocked Down", 				"Renversé", 			"Renversé", 					Turbine.Gameplay.Class.Guardian );

