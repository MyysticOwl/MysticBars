-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

CaptainClass = class();

function CaptainClass:Constructor()
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	configurationService:RegisterBarCreator( "Heralds", 		"Heralds", 	self.Heralds );
	configurationService:RegisterBarCreator( "Tier1 Skills", 	"Tier1", 	self.Tier1 );
	configurationService:RegisterBarCreator( "Tier2 Skills", 	"Tier2",	self.Tier2 );
	configurationService:RegisterBarCreator( "Marks", 			"Marks",	self.Marks );
	configurationService:RegisterBarCreator( "Tactics", 		"Tactics",	self.Tactics );
	configurationService:RegisterBarCreator( "Defeat Skills", 	"DefeatResponse",	self.DefeatResponse );
	configurationService:ConstructBars();
end

function CaptainClass:Heralds( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	configurationService:CreateBar( override, "Heralds", 12, 1, 3, 240, 300 );
	configurationService:SetBuffTriggerOptions( false, false );
	configurationService:SetTrigger( configurationService.CTRL );
	configurationService:SetBuffTrigger( "Banner of War" );
	configurationService:SetBuffTrigger( "Banner of Hope" );
	configurationService:SetBuffTrigger( "Banner of Victory" );
	configurationService:SetBGColor( 0.35, 1, 0, 0 );
	configurationService:AddShortcut( 1, "0x70002F7A", 6, 10 );
	configurationService:AddShortcut( 2, "0x70002FAF", 6, 24 );
	configurationService:AddShortcut( 3, "0x70002F1A", 6, 34 );
end

function CaptainClass:Tier1( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	configurationService:CreateBar( override, "Tier1", 2, 1, 2, 240, 350 );
	configurationService:SetBuffTriggerOptions( true, false );
	configurationService:SetBuffTrigger( "Battle-readied" );
	configurationService:AddShortcut( 1, "0x70002FCF", 6, 2 );
	configurationService:AddShortcut( 2, "0x70003E50", 6, 10 );
end

function CaptainClass:Tier2( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	configurationService:CreateBar( override, "Tier2", 30, 1, 1, 240, 400 );
	configurationService:SetBuffTriggerOptions( true, false );
	configurationService:SetBuffTrigger( "Battle-hardened" );
	configurationService:AddShortcut( 1, "0x7000AD9A", 6, 30 );
	configurationService:AddShortcut( 1, "0x70017D31", 6, 52 );
end

function CaptainClass:Marks( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	configurationService:CreateBar( override, "Marks", 12, 1, 3, 240, 450 );
	configurationService:AddShortcut( 1, "0x70003E4F", 6, 12 );
	configurationService:AddShortcut( 2, "0x70003E4D", 6, 18 );
	configurationService:AddShortcut( 3, "0x70003E56", 6, 30 );
end

function CaptainClass:Tactics( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	configurationService:CreateBar( override, "Tactics", 6, 1, 3, 240, 500 );
	configurationService:AddShortcut( 1, "0x70003E53", 6, 6 );
	configurationService:AddShortcut( 2, "0x70003E55", 6, 28 );
	configurationService:AddShortcut( 3, "0x70003E59", 6, 38 );
end

function CaptainClass:DefeatResponse( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	configurationService:CreateBar( override, "DefeatResponse", 2, 1, 4, 240, 550 );
	configurationService:SetBuffTriggerOptions( true, false );
	configurationService:SetBuffTrigger( "Enemy Defeat Response" );
	configurationService:AddShortcut( 1, "0x70002F4F", 6, 2 );
	configurationService:AddShortcut( 2, "0x70002F58", 6, 4 );
	configurationService:AddShortcut( 3, "0x7000FF8B", 6, 8 );
	configurationService:AddShortcut( 4, "0x70002F61", 6, 60 );
end