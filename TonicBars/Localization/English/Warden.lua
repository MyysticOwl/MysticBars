-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

Warden = 194;
local eventService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.EventService);

--              			English Skill Name		-- Description shown on Menus -- Acutal Skill Name must match BUFF name exactly -- Class Name
eventService:RegisterEffect( nil, "Forced March", 			"Forced March", 					Warden );
eventService:RegisterEffect( nil, "Conservation", 			"Conservation", 					Warden );
eventService:RegisterEffect( nil, "Recklessness", 			"Recklessness", 					Warden );
eventService:RegisterEffect( nil, "Careful Step", 			"Careful Step", 					Warden );
eventService:RegisterEffect( nil, "Way of the Warden", 		"Way of the Warden",				Warden );
eventService:RegisterEffect( nil, "Warden's Determination", "Warden's Determination", 			Warden );
eventService:RegisterEffect( nil, "Charge", 				"Charge", 							Warden );

-- Other Non-Class specific buffs
eventService:RegisterEffect( nil, "Monster Play", 			"Monster Play", 					Warden );