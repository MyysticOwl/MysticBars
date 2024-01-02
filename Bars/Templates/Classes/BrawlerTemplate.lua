-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

BrawlerTemplate = class();

function BrawlerTemplate:Constructor()
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);
	templateService:RegisterBarCreator( "Battle Flow 3+", 	"Battle Flow 3+", self.BattleFlow3 );
	templateService:ConstructBars();
end

function BrawlerTemplate:BattleFlow3( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar( override, "Battle Flow 3+", 1, 6, 3, 240, 350, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( true, false, barSettings );
		templateService:SetBuffTrigger( "Battle Flow 3", barSettings );
		templateService:SetBuffTrigger( "Battle Flow 4", barSettings );
		templateService:SetBuffTrigger( "Battle Flow 5", barSettings );
		templateService:SetBuffTrigger( "Battle Flow 6", barSettings );
		templateService:SetBuffTrigger( "Battle Flow 7", barSettings );
		templateService:SetBuffTrigger( "Battle Flow 8", barSettings );
		templateService:SetBuffTrigger( "Battle Flow 9", barSettings );
		templateService:AddShortcut( 1, "0x70058C3D", 6, 1, barSettings );
		templateService:AddShortcut( 2, "0x70058C4F", 6, 1, barSettings );
		templateService:AddShortcut( 3, "0x7005B609", 6, 1, barSettings );
		templateService:AddShortcut( 4, "0x70058C44", 6, 1, barSettings );
		templateService:AddShortcut( 5, "0x70058C43", 6, 1, barSettings );
		templateService:AddShortcut( 6, "0x70058C42", 6, 1, barSettings );
		templateService:AddShortcut( 7, "0x7005BDAA", 6, 1, barSettings );
		templateService:AddShortcut( 8, "0x700598BC", 6, 1, barSettings );
		templateService:AddShortcut( 9, "0x70058C41", 6, 1, barSettings );
		templateService:AddShortcut( 10, "0x7005B558", 6, 1, barSettings );
	end);
end