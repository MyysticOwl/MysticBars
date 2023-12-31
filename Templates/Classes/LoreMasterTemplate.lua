-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

LoreMasterTemplate = class();

function LoreMasterTemplate:Constructor()
end

function LoreMasterTemplate:Constructor()
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:RegisterBarCreator( "Warding", 			"Warding", 		self.Warding );
	templateService:RegisterBarCreator( "Sign of the Wild", 	"Wild", 		self.Wild );
	templateService:RegisterBarCreator( "Sign of Power", 		"SoPower", 		self.SoPower );
	templateService:RegisterBarCreator( "Lore", 				"Lore", 		self.Lore );
	templateService:ConstructBars();
end

function LoreMasterTemplate:Warding( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:CreateBar( override, "Warding", 26, 1, 3, 240, 300 );
	templateService:AddShortcut( 1, "0x7000B625", 6, 26 );
	templateService:AddShortcut( 2, "0x7000B623", 6, 38 );
	templateService:AddShortcut( 3, "0x7000B624", 6, 40 );
end

function LoreMasterTemplate:Wild( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:CreateBar( override, "Wild", 11, 1, 2, 240, 350 );
	templateService:AddShortcut( 1, "0x7000312B", 6, 11 );
	templateService:AddShortcut( 2, "0x70003139", 6, 14 );
	templateService:AddShortcut( 2, "0x70028C98", 6, 65 );
end

function LoreMasterTemplate:SoPower( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:CreateBar( override, "SoPower", 1, 1, 4, 240, 400 );
	templateService:AddShortcut( 1, "0x70003EBB", 6, 1 );
	templateService:AddShortcut( 1, "0x70028B80", 6, 65 );
	templateService:AddShortcut( 2, "0x70003EBC", 6, 24 );
	templateService:AddShortcut( 3, "0x70003EBD", 6, 32 );
	templateService:AddShortcut( 4, "0x7000F801", 6, 58 );
end

function LoreMasterTemplate:Lore( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:CreateBar( override, "Lore", 12, 1, 6, 240, 450 );
	templateService:AddShortcut( 1, "0x70003EBE", 6, 12 );
	templateService:AddShortcut( 2, "0x70003EBF", 6, 12 );
	templateService:AddShortcut( 3, "0x70003EC0", 6, 36 );
	templateService:AddShortcut( 4, "0x70024BE7", 6, 40 );
	templateService:AddShortcut( 5, "0x7000B8AC", 6, 44 );
	templateService:AddShortcut( 5, "0x70020DF7", 6, 64 );
	templateService:AddShortcut( 6, "0x7000B63C", 6, 48 );
end