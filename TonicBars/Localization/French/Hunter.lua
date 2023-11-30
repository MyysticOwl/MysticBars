-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com 
--
-- RESPECT!
local eventService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.EventService);

--              			English Skill Name		-- Description shown on Menus -- Acutal Skill Name must match BUFF name exactly -- Class Name
eventService:RegisterEffect( "Stance: Strength", 	"Position : Force", 	"Position : Force", 	Turbine.Gameplay.Class.Hunter );
eventService:RegisterEffect( "Stance: Endurance", 	"Position : Endurance", "Position : Endurance", Turbine.Gameplay.Class.Hunter );
eventService:RegisterEffect( "Stance: Precision", 	"Position : Précision", "Position : Précision", Turbine.Gameplay.Class.Hunter );
eventService:RegisterEffect( "Stance: Fleet", 		"Position : Rapidité", 	"Position : Rapidité", 	Turbine.Gameplay.Class.Hunter );
eventService:RegisterEffect( "Find the Path", 		"Orientation", 			"Orientation", 			Turbine.Gameplay.Class.Hunter );
eventService:RegisterEffect( "Needful Haste", 		"Hâte nécessaire", 		"Hâte nécessaire", 		Turbine.Gameplay.Class.Hunter );
eventService:RegisterEffect( "Swift Stroke", 		"Coup Rapide", 			"Coup Rapide", 			Turbine.Gameplay.Class.Hunter );
eventService:RegisterEffect( "Parry Response", 		"Si Parade", 			"Réaction de parade", 	Turbine.Gameplay.Class.Hunter );
eventService:RegisterEffect( "Beneath Notice", 		"Insignifiance", 		"Insignifiance", 		Turbine.Gameplay.Class.Hunter );
eventService:RegisterEffect( "Camp", 				"Feu de Camp", 			"Camp", 				Turbine.Gameplay.Class.Hunter );