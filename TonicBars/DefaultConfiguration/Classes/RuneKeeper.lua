-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

RuneKeeperClass = class();

function RuneKeeperClass:Constructor()
	local configurationService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.ConfigurationService);

	configurationService:RegisterBarCreator( "Restoration Skill", 			"Restoration", 	self.Restoration );
	configurationService:RegisterBarCreator( "DPS Attonement Skill", 		"Attun 1-10", 	self.Attun110 );
	configurationService:RegisterBarCreator( "Healing Attonement Skill", 	"Attun 10-19", 	self.Attun1019 );
	configurationService:RegisterBarCreator( "3 DPS Attonement, Skills", 	"Attun 7", 		self.Attun7 );
	configurationService:RegisterBarCreator( "6 DPS Attonement, Skills", 	"Attun 4", 		self.Attun4 );
	configurationService:RegisterBarCreator( "Full DPS Attonement, Skills", "Attun 1", 		self.Attun1 );
	configurationService:RegisterBarCreator( "3 Heal Attonement Skills", 	"Attun 13", 		self.Attun13 );
	configurationService:RegisterBarCreator( "6 Heal Attonement Skills", 	"Attun 16", 		self.Attun16 );
	configurationService:RegisterBarCreator( "Full Heal Attonement Skills", "Attun 19", 		self.Attun19 );
	configurationService:ConstructBars();
end

function RuneKeeperClass:Restoration( override )
	local configurationService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.ConfigurationService);

	configurationService:CreateBar( override, "Restoration", 4, 1, 1, 240, 350 );
	configurationService:SetBuffTriggerOptions( false, false );
	configurationService:SetTrigger( configurationService.CTRL );
	configurationService:SetBuffTrigger( "Rune of Restoration" );
	configurationService:SetBGColor( 0.35, 1, 0, 0 );
	configurationService:AddShortcut( 1, "0x7000EEA5", 6, 4 );
end

function RuneKeeperClass:Attun7( override )
	local configurationService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.ConfigurationService);

	configurationService:CreateBar( override, "Attun 7", 2, 5, 1, 468, 300 );
	configurationService:SetBuffTriggerOptions( true, false );
	configurationService:SetClassRangeTrigger( RK_ATTUNEMENT, 1, 7);
	configurationService:AddShortcut( 1, "0x7000EEAE", 6, 2 );
	configurationService:AddShortcut( 2, "0x7000EE00", 6, 12 );
	configurationService:AddShortcut( 3, "0x7000EEAB", 6, 16 );
	configurationService:AddShortcut( 4, "0x7000EDFF", 6, 38 );
	configurationService:AddShortcut( 5, "0x700180F5", 6, 60 );
end

function RuneKeeperClass:Attun4( override )
	local configurationService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.ConfigurationService);

	configurationService:CreateBar( override, "Attun 4", 24, 6, 1, 429, 300 );
	configurationService:SetBuffTriggerOptions( true, false );
	configurationService:SetClassRangeTrigger( RK_ATTUNEMENT, 1, 4);
	configurationService:AddShortcut( 1, "0x7000EE01", 6, 24 );
	configurationService:AddShortcut( 2, "0x7000E969", 6, 28 );
	configurationService:AddShortcut( 3, "0x70024D3A", 6, 30 );
	configurationService:AddShortcut( 4, "0x7000EFEF", 6, 36 );
	configurationService:AddShortcut( 5, "0x70024D39", 6, 50 );
	configurationService:AddShortcut( 6, "0x700180F9", 6, 56 );
end

function RuneKeeperClass:Attun1( override )
	local configurationService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.ConfigurationService);

	configurationService:CreateBar( override, "Attun 1", 20, 3, 1, 387, 300 );
	configurationService:SetBuffTriggerOptions( true, false );
	configurationService:SetClassRangeTrigger( RK_ATTUNEMENT, 1, 1);
	configurationService:AddShortcut( 1, "0x7000EEAF", 6, 20 );
	configurationService:AddShortcut( 2, "0x7000EE03", 6, 32 );
	configurationService:AddShortcut( 3, "0x7000E96D", 6, 40 );
end

function RuneKeeperClass:Attun1019( override )
	local configurationService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.ConfigurationService);

	configurationService:CreateBar( override, "Attun 10-19", 1, 1, 1, 508, 336 );
	configurationService:SetBuffTriggerOptions( true, false );
	configurationService:SetClassRangeTrigger( RK_ATTUNEMENT, 10, 19);
	configurationService:AddShortcut( 1, "0x7000EEA8", 6, 1 );
end

function RuneKeeperClass:Attun13( override )
	local configurationService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.ConfigurationService);

	configurationService:CreateBar( override, "Attun 13", 12, 2, 1, 547, 300 );
	configurationService:SetBuffTriggerOptions( true, false );
	configurationService:SetClassRangeTrigger( RK_ATTUNEMENT, 13, 19);
	configurationService:AddShortcut( 1, "0x7000EEA9", 6, 12 );
	configurationService:AddShortcut( 2, "0x7000EEA4", 6, 14 );
end

function RuneKeeperClass:Attun16( override )
	local configurationService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.ConfigurationService);

	configurationService:CreateBar( override, "Attun 16", 18, 3, 1, 585, 300 );
	configurationService:SetBuffTriggerOptions( true, false );
	configurationService:SetClassRangeTrigger( RK_ATTUNEMENT, 16, 19);
	configurationService:AddShortcut( 1, "0x7000EEA6", 6, 18 );
	configurationService:AddShortcut( 2, "0x7000EEA7", 6, 28 );
	configurationService:AddShortcut( 3, "0x700180F7", 6, 58 );
end

function RuneKeeperClass:Attun19( override )
	local configurationService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.ConfigurationService);

	configurationService:CreateBar( override, "Attun 19", 41, 3, 1, 623, 300 );
	configurationService:SetBuffTriggerOptions( true, false );
	configurationService:SetClassRangeTrigger( RK_ATTUNEMENT, 19, 19);
	configurationService:AddShortcut( 1, "0x70018636", 6, 42 );
	configurationService:AddShortcut( 2, "0x70018776", 6, 54 );
	configurationService:AddShortcut( 3, "0x700180F4", 6, 41 );
end

function RuneKeeperClass:Attun110( override )
	local configurationService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.ConfigurationService);

	configurationService:CreateBar( override, "Attun 1-10", 1, 1, 1, 508, 300 );
	configurationService:SetBuffTriggerOptions( true, false );
	configurationService:SetClassRangeTrigger( RK_ATTUNEMENT, 1, 10);
	configurationService:AddShortcut( 1, "0x7000E96B", 6, 1 );
end