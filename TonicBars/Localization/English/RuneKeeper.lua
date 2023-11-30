-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!
local eventService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.EventService);

--              -- Description shown on Menus -- Acutal Skill Name must match BUFF name exactly -- Class Name
eventService:RegisterEffect( nil, "Rune of Restoration", 	"Rune of Restoration", 		Turbine.Gameplay.Class.RuneKeeper );

-- Other Non-Class specific buffs
eventService:RegisterEffect( nil, "Monster Play", 			"Monster Play", 		Turbine.Gameplay.Class.RuneKeeper );