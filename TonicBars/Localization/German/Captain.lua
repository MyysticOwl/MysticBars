-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!
local eventService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.EventService);

-- 							English Skill Name -- Description shown on Menus -- Acutal Skill Name must match BUFF name exactly -- Class Name
eventService:RegisterEffect( 'Banner of Hope', 				'Banner der Hoffnung', 				'Banner der Hoffnung', 					Turbine.Gameplay.Class.Captain );
eventService:RegisterEffect( 'Banner of War', 				'Kriegsbanner', 					'Kriegsbanner', 						Turbine.Gameplay.Class.Captain );
eventService:RegisterEffect( 'Banner of Victory', 	  		'Banner des Sieges',				'Banner des Sieges', 					Turbine.Gameplay.Class.Captain );
eventService:RegisterEffect( 'In Defence of Middle-earth',  'Verteid. v. Mittelerde', 			'Verteidigung von Mittelerde', 			Turbine.Gameplay.Class.Captain );
-- eventService:RegisterEffect( 'Fellow Defeat Response',		'Fellow Defeated', 					'Fellow Defeat Response', 				Turbine.Gameplay.Class.Captain );
eventService:RegisterEffect( 'Last Stand', 					'Letztes Gefecht', 					'Letztes Gefecht', 						Turbine.Gameplay.Class.Captain );
eventService:RegisterEffect( 'Motivated', 					'Motivierende Rede', 				'Motiviert', 							Turbine.Gameplay.Class.Captain );
eventService:RegisterEffect( 'Make Haste',					'Beeilung', 						'Beeilung', 							Turbine.Gameplay.Class.Captain );
eventService:RegisterEffect( 'On Guard', 					'Taktik: In Bereitschaft', 			'In Bereitschaft', 						Turbine.Gameplay.Class.Captain );
eventService:RegisterEffect( 'War-cry',						'Kriegsschrei', 					'Kriegsschrei', 						Turbine.Gameplay.Class.Captain );
eventService:RegisterEffect( 'Relentless Attack',			'Gnadenloser Angriff', 				'Gnadenloser Angriff', 					Turbine.Gameplay.Class.Captain );
eventService:RegisterEffect( 'Defending',					'Defensiver Schlag', 				'Verteidigend', 						Turbine.Gameplay.Class.Captain );
eventService:RegisterEffect( 'Enemy Defeat Response',		'Gegner vernichtet', 				'Erwiderung "Vernichtung des Gegners"', Turbine.Gameplay.Class.Captain );
eventService:RegisterEffect( 'Focus',						'Fokus', 							'Fokus', 								Turbine.Gameplay.Class.Captain );
eventService:RegisterEffect( 'Courage',						'Mut fassen', 						'Mut', 									Turbine.Gameplay.Class.Captain );
-- eventService:RegisterEffect( "Battle-readied", 				"Battle-Readied",					"Battle-readied", 						Turbine.Gameplay.Class.Captain );
-- eventService:RegisterEffect( "Battle-readied", 				"Battle-Hardened", 					"Battle-hardened", 						Turbine.Gameplay.Class.Captain );

eventService:RegisterEffect( "Dazed",						'Bet�ubung', 		 				'Bet�ubung', 								Turbine.Gameplay.Class.Champion );