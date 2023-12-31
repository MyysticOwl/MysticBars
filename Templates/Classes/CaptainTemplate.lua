-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

CaptainTemplate = class();

function CaptainTemplate:Constructor()
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:RegisterBarCreator( "Heralds", 		"Heralds", 	self.Heralds );
	templateService:RegisterBarCreator( "Tier1 Skills", 	"Tier1", 	self.Tier1 );
	templateService:RegisterBarCreator( "Tier2 Skills", 	"Tier2",	self.Tier2 );
	templateService:RegisterBarCreator( "Marks", 			"Marks",	self.Marks );
	templateService:RegisterBarCreator( "Tactics", 		"Tactics",	self.Tactics );
	templateService:RegisterBarCreator( "Defeat Skills", 	"DefeatResponse",	self.DefeatResponse );
	templateService:ConstructBars();
end

function CaptainTemplate:Heralds( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:CreateBar( override, "Heralds", 12, 1, 3, 240, 300 );
	templateService:SetBuffTriggerOptions( false, false );
	templateService:SetTrigger( templateService.CTRL );
	templateService:SetBuffTrigger( "Banner of War" );
	templateService:SetBuffTrigger( "Banner of Hope" );
	templateService:SetBuffTrigger( "Banner of Victory" );
	templateService:SetBGColor( 0.35, 1, 0, 0 );
	templateService:AddShortcut( 1, "0x70002F7A", 6, 10 );
	templateService:AddShortcut( 2, "0x70002FAF", 6, 24 );
	templateService:AddShortcut( 3, "0x70002F1A", 6, 34 );
end

function CaptainTemplate:Tier1( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:CreateBar( override, "Tier1", 2, 1, 2, 240, 350 );
	templateService:SetBuffTriggerOptions( true, false );
	templateService:SetBuffTrigger( "Battle-readied" );
	templateService:AddShortcut( 1, "0x70002FCF", 6, 2 );
	templateService:AddShortcut( 2, "0x70003E50", 6, 10 );
end

function CaptainTemplate:Tier2( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:CreateBar( override, "Tier2", 30, 1, 1, 240, 400 );
	templateService:SetBuffTriggerOptions( true, false );
	templateService:SetBuffTrigger( "Battle-hardened" );
	templateService:AddShortcut( 1, "0x7000AD9A", 6, 30 );
	templateService:AddShortcut( 1, "0x70017D31", 6, 52 );
end

function CaptainTemplate:Marks( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:CreateBar( override, "Marks", 12, 1, 3, 240, 450 );
	templateService:AddShortcut( 1, "0x70003E4F", 6, 12 );
	templateService:AddShortcut( 2, "0x70003E4D", 6, 18 );
	templateService:AddShortcut( 3, "0x70003E56", 6, 30 );
end

function CaptainTemplate:Tactics( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:CreateBar( override, "Tactics", 6, 1, 3, 240, 500 );
	templateService:AddShortcut( 1, "0x70003E53", 6, 6 );
	templateService:AddShortcut( 2, "0x70003E55", 6, 28 );
	templateService:AddShortcut( 3, "0x70003E59", 6, 38 );
end

function CaptainTemplate:DefeatResponse( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:CreateBar( override, "DefeatResponse", 2, 1, 4, 240, 550 );
	templateService:SetBuffTriggerOptions( true, false );
	templateService:SetBuffTrigger( "Enemy Defeat Response" );
	templateService:AddShortcut( 1, "0x70002F4F", 6, 2 );
	templateService:AddShortcut( 2, "0x70002F58", 6, 4 );
	templateService:AddShortcut( 3, "0x7000FF8B", 6, 8 );
	templateService:AddShortcut( 4, "0x70002F61", 6, 60 );
end