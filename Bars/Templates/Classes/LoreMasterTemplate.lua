-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

LoreMasterTemplate = class();

function LoreMasterTemplate:Constructor()
end

function LoreMasterTemplate:Constructor()
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	templateService:RegisterBarCreator( "Warding", 			"Warding", 		self.Warding );
	templateService:RegisterBarCreator( "Sign of the Wild", 	"Wild", 		self.Wild );
	templateService:RegisterBarCreator( "Sign of Power", 		"SoPower", 		self.SoPower );
	templateService:RegisterBarCreator( "Lore", 				"Lore", 		self.Lore );
	templateService:ConstructBars();
end

function LoreMasterTemplate:Warding( )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar( "Warding", 1, 3, 240, 300, QUICKSLOTBAR, function(barSettings)
		templateService:AddShortcut( 1, "0x7000B625", 6, 26, barSettings );
		templateService:AddShortcut( 2, "0x7000B623", 6, 38, barSettings );
		templateService:AddShortcut( 3, "0x7000B624", 6, 40, barSettings );
	end);
end

function LoreMasterTemplate:Wild( )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar( "Wild", 1, 2, 240, 350, QUICKSLOTBAR, function(barSettings)
		templateService:AddShortcut( 1, "0x7000312B", 6, 11, barSettings );
		templateService:AddShortcut( 2, "0x70003139", 6, 14, barSettings );
		templateService:AddShortcut( 2, "0x70028C98", 6, 65, barSettings );
	end);
end

function LoreMasterTemplate:SoPower( )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar( "SoPower", 1, 4, 240, 400, QUICKSLOTBAR, function(barSettings)
		templateService:AddShortcut( 1, "0x70003EBB", 6, 1, barSettings );
		templateService:AddShortcut( 1, "0x70028B80", 6, 65, barSettings );
		templateService:AddShortcut( 2, "0x70003EBC", 6, 24, barSettings );
		templateService:AddShortcut( 3, "0x70003EBD", 6, 32, barSettings );
		templateService:AddShortcut( 4, "0x7000F801", 6, 58, barSettings );
	end);
end

function LoreMasterTemplate:Lore( )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar( "Lore", 1, 6, 240, 450, QUICKSLOTBAR, function(barSettings)
		barSettings = templateService:AddShortcut( 1, "0x70003EBE", 6, 12, barSettings );
		barSettings = templateService:AddShortcut( 2, "0x70003EBF", 6, 12, barSettings );
		barSettings = templateService:AddShortcut( 3, "0x70003EC0", 6, 36, barSettings );
		barSettings = templateService:AddShortcut( 4, "0x70024BE7", 6, 40, barSettings );
		barSettings = templateService:AddShortcut( 5, "0x7000B8AC", 6, 44, barSettings );
		barSettings = templateService:AddShortcut( 6, "0x70020DF7", 6, 64, barSettings );
		barSettings = templateService:AddShortcut( 7, "0x7000B63C", 6, 48, barSettings );
	end);
end