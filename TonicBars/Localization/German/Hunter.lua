-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!
local eventService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.EventService);

-- 							English Skill Name -- Description shown on Menus -- Acutal Skill Name must match BUFF name exactly -- Class Name
eventService:RegisterEffect( "Stance: Strength", 			'Haltung: Stärke', 					'Haltung: Stärke', 						Turbine.Gameplay.Class.Hunter );
eventService:RegisterEffect( "Swift Stroke",				'Schneller Hieb', 					'Schneller Hieb', 						Turbine.Gameplay.Class.Hunter );
eventService:RegisterEffect( "Stance: Endurance",			'Haltung: Ausdauer', 				'Haltung: Ausdauer', 					Turbine.Gameplay.Class.Hunter );
eventService:RegisterEffect( "Parry Response",				'Erwiderung "Parade"', 				'Erwiderung "Parade"',					Turbine.Gameplay.Class.Hunter );
eventService:RegisterEffect( "Stance: Precision",			'Haltung: Präzision', 				'Haltung: Präzision', 					Turbine.Gameplay.Class.Hunter );
eventService:RegisterEffect( "Burn Hot",					'Heisse Flamme', 					'Heisse Flamme',						Turbine.Gameplay.Class.Hunter );
eventService:RegisterEffect( "Stance: Fleet",				'Leichtfüssige Haltung', 			'Leichtfüssige Haltung', 				Turbine.Gameplay.Class.Hunter );
eventService:RegisterEffect( "Needful Haste",				'Nötige Hast', 						'Nötige Hast', 							Turbine.Gameplay.Class.Hunter );
eventService:RegisterEffect( "Beneath Notice",				'Unscheinbar', 						'Unscheinbar', 							Turbine.Gameplay.Class.Hunter );
eventService:RegisterEffect( "Find the Path",				'Weg finden', 						'Weg finden',							Turbine.Gameplay.Class.Hunter );
eventService:RegisterEffect( "Beneath Care",				'Vernachlässigbar', 				'Vernachlässigbar', 					Turbine.Gameplay.Class.Hunter );
eventService:RegisterEffect( "Camp",						'Lagerfeuer', 						'Lager', 								Turbine.Gameplay.Class.Hunter );

eventService:RegisterEffect( "Dazed",						'Betäubung', 		 				'Betäubung', 								Turbine.Gameplay.Class.Champion );