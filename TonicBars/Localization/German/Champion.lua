-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!
local eventService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.EventService);

-- 							English Skill Name -- Description shown on Menus -- Acutal Skill Name must match BUFF name exactly -- Class Name
eventService:RegisterEffect( 'Enemy Defeat Response', 		'Gegner vernichtet', 				'Erwiderung "Vernichtung des Gegners"', Turbine.Gameplay.Class.Champion );
eventService:RegisterEffect( 'Blocking Blades',				'Blockende Klingen', 				'Blockende Klingen', 					Turbine.Gameplay.Class.Champion );
eventService:RegisterEffect( "Champion's Fervour",			'Leidenschaft', 					'Leidenschaft des Waffenmeisters', 	Turbine.Gameplay.Class.Champion );
eventService:RegisterEffect( 'Glory',						'Ruhm', 							'Ruhm', 								Turbine.Gameplay.Class.Champion );
eventService:RegisterEffect( 'Ardour',						'Eifer', 							'Eifer', 								Turbine.Gameplay.Class.Champion );
eventService:RegisterEffect( 'Sprint',						'Sprint', 							'Sprint', 								Turbine.Gameplay.Class.Champion );
eventService:RegisterEffect( 'Flurry',						'Wirbel', 							'Wirbel', 								Turbine.Gameplay.Class.Champion );
eventService:RegisterEffect( 'Sudden Defence', 				'Plötzliche Verteidigung', 			'Plötzliche Verteidigung', 				Turbine.Gameplay.Class.Champion );
eventService:RegisterEffect( 'Red Haze', 					'Roter Nebel', 						'Roter Nebel', 								Turbine.Gameplay.Class.Champion );
eventService:RegisterEffect( nil, 							'Heimtückischer Kampf', 			'Heimtückischer Kampf',							Turbine.Gameplay.Class.Champion );
eventService:RegisterEffect( nil, 							'Schlagabtausch', 					'Schlagabtausch',									Turbine.Gameplay.Class.Champion );
eventService:RegisterEffect( "Dazed",						'Betäubung', 		 				'Betäubung', 								Turbine.Gameplay.Class.Champion );

-- eventService:RegisterEffect( 'Ardent Flurry', 			'Ardent Flurry', 						Turbine.Gameplay.Class.Champion );
-- eventService:RegisterEffect( 'Improved Flurry', 			'Improved Flurry', 						Turbine.Gameplay.Class.Champion );
-- eventService:RegisterEffect( 'Glorious Exchange', 		'Glorious Exchange', 					Turbine.Gameplay.Class.Champion );
-- eventService:RegisterEffect( 'Imp Exch Blows', 			'Improved Exchange of Blows', 			Turbine.Gameplay.Class.Champion );
-- eventService:RegisterEffect( 'Disarmed', 				'Primary Weapon: Disarmed', 			Turbine.Gameplay.Class.Champion );
-- eventService:RegisterEffect( 'Stunned', 	 				'Stunned', 								Turbine.Gameplay.Class.Champion );

-- eventService:RegisterEffect( 'Knocked Down', 			'Knocked Down', 						Turbine.Gameplay.Class.Champion );
-- eventService:RegisterEffect( 'Controlled Burn', 			'Controlled Burn', 						Turbine.Gameplay.Class.Champion );