-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

LoreMasterClass = class();

function LoreMasterClass:Constructor()
end

function LoreMasterClass:Constructor()
	local configurationService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.ConfigurationService);

	configurationService:RegisterBarCreator( "Warding", 			"Warding", 		self.Warding );
	configurationService:RegisterBarCreator( "Sign of the Wild", 	"Wild", 		self.Wild );
	configurationService:RegisterBarCreator( "Sign of Power", 		"SoPower", 		self.SoPower );
	configurationService:RegisterBarCreator( "Lore", 				"Lore", 		self.Lore );
	configurationService:ConstructBars();
end

function LoreMasterClass:Warding( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.ConfigurationService);

	configurationService:CreateBar( override, "Warding", 26, 1, 3, 240, 300 );
	configurationService:AddShortcut( 1, "0x7000B625", 6, 26 );
	configurationService:AddShortcut( 2, "0x7000B623", 6, 38 );
	configurationService:AddShortcut( 3, "0x7000B624", 6, 40 );
end

function LoreMasterClass:Wild( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.ConfigurationService);

	configurationService:CreateBar( override, "Wild", 11, 1, 2, 240, 350 );
	configurationService:AddShortcut( 1, "0x7000312B", 6, 11 );
	configurationService:AddShortcut( 2, "0x70003139", 6, 14 );
	configurationService:AddShortcut( 2, "0x70028C98", 6, 65 );
end

function LoreMasterClass:SoPower( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.ConfigurationService);

	configurationService:CreateBar( override, "SoPower", 1, 1, 4, 240, 400 );
	configurationService:AddShortcut( 1, "0x70003EBB", 6, 1 );
	configurationService:AddShortcut( 1, "0x70028B80", 6, 65 );
	configurationService:AddShortcut( 2, "0x70003EBC", 6, 24 );
	configurationService:AddShortcut( 3, "0x70003EBD", 6, 32 );
	configurationService:AddShortcut( 4, "0x7000F801", 6, 58 );
end

function LoreMasterClass:Lore( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.ConfigurationService);

	configurationService:CreateBar( override, "Lore", 12, 1, 6, 240, 450 );
	configurationService:AddShortcut( 1, "0x70003EBE", 6, 12 );
	configurationService:AddShortcut( 2, "0x70003EBF", 6, 12 );
	configurationService:AddShortcut( 3, "0x70003EC0", 6, 36 );
	configurationService:AddShortcut( 4, "0x70024BE7", 6, 40 );
	configurationService:AddShortcut( 5, "0x7000B8AC", 6, 44 );
	configurationService:AddShortcut( 5, "0x70020DF7", 6, 64 );
	configurationService:AddShortcut( 6, "0x7000B63C", 6, 48 );
end