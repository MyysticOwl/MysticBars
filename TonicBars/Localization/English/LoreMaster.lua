-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!
local eventService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.EventService);

--              			English Skill Name		-- Description shown on Menus -- Acutal Skill Name must match BUFF name exactly -- Class Name
eventService:RegisterEffect( nil, "SoP:R", 						"Sign of Power: Righteousness", Turbine.Gameplay.Class.LoreMaster );
eventService:RegisterEffect( nil, "SoP:V", 						"Sign of Power: Vigilance", 	Turbine.Gameplay.Class.LoreMaster );
eventService:RegisterEffect( nil, "Tend the Sick", 				"Tend the Sick", 				Turbine.Gameplay.Class.LoreMaster );
eventService:RegisterEffect( nil, "Leechcraft", 				"Leechcraft", 					Turbine.Gameplay.Class.LoreMaster );
eventService:RegisterEffect( nil, "Ancient Wisdom", 			"Ancient Wisdom", 				Turbine.Gameplay.Class.LoreMaster );
eventService:RegisterEffect( nil, "Improved Ancient Wisdom",	"Improved Ancient Wisdom", 		Turbine.Gameplay.Class.LoreMaster );
eventService:RegisterEffect( nil, "Wisdom otC", 				"Wisdom of the Council", 		Turbine.Gameplay.Class.LoreMaster );

-- Other Non-Class specific buffs
eventService:RegisterEffect( nil, "Monster Play", 			"Monster Play", 		Turbine.Gameplay.Class.LoreMaster );