-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!
local eventService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.EventService);

-- 							English Skill Name -- Description shown on Menus -- Acutal Skill Name must match BUFF name exactly -- Class Name
eventService:RegisterEffect( 'Overpower',					'Überwältigen', 	 				'Überwältigen', 						Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( "Guardian's Block Stance",		'Verteidigung d. Wächters',			'Blockhaltung des Wächters', 			Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( "Guardian's Parry Stance",		'Parade des Wächters', 				'Paradehaltung des Wächters', 				Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( "Warrior's Block",				'Kriegerherz', 						'Kriegerherz', 								Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( 'Parry Response',				'Erwiderung "Parade"', 				'Erwiderung "Parade"', 					Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( 'Block Response',				'Erwiderung "Blocken"', 			'Block Response', 						Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( "Guardian's Pledge",			'Gelöbnis des Wächters', 			'Gelöbnis des Wächters', 				Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( 'Shield Swipe',				'Schildstreich', 					'Schildstreich', 						Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( 'Retaliation',					'Vergeltung', 						'Vergeltung', 							Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( 'Engaging',					'Angreifen', 						'Angreifen', 							Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( "Guardian's Ward",				'Wächterschild', 					'Wächterschild', 						Turbine.Gameplay.Class.Guardian );
eventService:RegisterEffect( "Dazed",						'Betäubung', 		 				'Betäubung', 								Turbine.Gameplay.Class.Champion );

-- eventService:RegisterEffect( 'Ward', 					'Guardians Ward', 					Turbine.Gameplay.Class.Guardian );
-- eventService:RegisterEffect( 'Improved Ward', 			'Improved Guardians Ward', 			Turbine.Gameplay.Class.Guardian );
-- eventService:RegisterEffect( 'Stunned', 	 				'Stunned', 							Turbine.Gameplay.Class.Guardian );
-- eventService:RegisterEffect( 'Knocked Down', 			'Knocked Down', 					Turbine.Gameplay.Class.Guardian );

