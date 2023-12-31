-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

WardenTemplate = class();

function WardenTemplate:Constructor()
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:RegisterBarCreator( "Stances", 	"Stance", self.Stance );
	templateService:RegisterBarCreator( "Travel", 		"Travel", self.Travel );
	templateService:RegisterBarCreator( "Javelins", 	"Javelins", self.Javelin );
	templateService:RegisterBarCreator( "Recovery", 	"Recovery", self.Recovery );
	templateService:RegisterBarCreator( "March", 		"March", self.March );
	templateService:RegisterBarCreator( "Charge", 		"Charge", self.Charge );
	templateService:ConstructBars();
end

function WardenTemplate:Stance( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:CreateBar( override, "Stance", 10, 1, 3, 240, 300 );
	templateService:SetBuffTriggerOptions( false, false );
	templateService:SetTrigger( templateService.CTRL );
	templateService:SetBuffTrigger( "Recklessness" );
	templateService:SetBuffTrigger( "Determination" );
	templateService:SetBuffTrigger( "Assailment" );
	templateService:SetBGColor( 0.35, 1, 0, 0 );
	templateService:AddShortcut( 1, "0x70014832", 6, 10 );
	templateService:AddShortcut( 2, "0x7000ECD7", 6, 20 );
	templateService:AddShortcut( 3, "0x70014799", 6, 30 );
end

function WardenTemplate:Travel( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:CreateBar( override, "Travel", 26, 1, 4, 240, 350 );
	templateService:AddShortcut( 1, "0x70014798", 6, 26 );
	templateService:AddShortcut( 2, "0x70014786", 6, 32 );
	templateService:AddShortcut( 3, "0x7001478E", 6, 40 );
	templateService:AddShortcut( 4, "0x70014791", 6, 44 );
end

function WardenTemplate:Javelin( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:CreateBar( override, "Javelins", 1, 1, 4, 240, 400 );
	templateService:AddShortcut( 1, "0x700105C5", 6, 1 );
	templateService:AddShortcut( 2, "0x70014784", 6, 20 );
	templateService:AddShortcut( 3, "0x70014831", 6, 28 );
	templateService:AddShortcut( 4, "0x70014833", 6, 38 );
end

function WardenTemplate:Recovery( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);
	
	templateService:CreateBar( override, "Recovery", 10, 1, 2, 240, 450 );
	templateService:AddShortcut( 1, "0x70016A0A", 6, 10 );
	templateService:AddShortcut( 2, "0x70016A09", 6, 24 );
end

function WardenTemplate:March( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:CreateBar( override, "March", 14, 1, 2, 240, 500 );
	templateService:AddShortcut( 1, "0x700105CC", 6, 14 );
	templateService:AddShortcut( 2, "0x70014860", 6, 14 );
end

function WardenTemplate:Charge( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:CreateBar( override, "Charge", 10, 1, 1, 240, 550 );
	templateService:SetBuffTriggerOptions( true, false );
	templateService:SetBuffTrigger( "Charge" );
	templateService:AddShortcut( 1, "0x700101D8", 6, 10 );
end