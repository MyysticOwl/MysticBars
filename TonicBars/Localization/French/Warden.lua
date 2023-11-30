-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

Warden = 194
local eventService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.EventService);

--              			English Skill Name		-- Description shown on Menus -- Acutal Skill Name must match BUFF name exactly -- Class Name
eventService:RegisterEffect( "Forced March", 			"Marche forcée", 		"Marche forcée", 			Warden );
eventService:RegisterEffect( "Conservation", 			"Conservation", 		"Conservation", 			Warden );
eventService:RegisterEffect( "Recklessness", 			"Imprudence", 			"Imprudence", 				Warden );
eventService:RegisterEffect( "Careful Step", 			"Marche prudente", 		"Marche prudente", 			Warden );
eventService:RegisterEffect( "Way of the Warden", 		"Voie Sentinelle", 		"Voie de la Sentinelle",	Warden );
eventService:RegisterEffect( "Warden's Determination", 	"Détermination", 		"Détermination", 			Warden );

-- Other Non-Class specific buffs
eventService:RegisterEffect( nil, "Monster Play", 			"Monster Play", 					Warden );