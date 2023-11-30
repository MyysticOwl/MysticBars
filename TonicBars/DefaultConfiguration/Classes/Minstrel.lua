-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

MinstrelClass = class();

function MinstrelClass:Constructor()
	local configurationService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.ConfigurationService);

	configurationService:RegisterBarCreator( "War-Speech Skills", 		"War-speech", 		self.WarSpeech );
	configurationService:RegisterBarCreator( "Stances", 				"Stances", 			self.Stances );
	configurationService:RegisterBarCreator( "Coda", 					"Coda", 			self.Coda );
	configurationService:RegisterBarCreator( "Anthem Skills", 			"Anthems", 			self.Anthems );
	configurationService:RegisterBarCreator( "Scribe Stance Skills", 	"Scribe Stance", 	self.Scribe );
	configurationService:ConstructBars();
end

function MinstrelClass:WarSpeech( override )
	local configurationService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.ConfigurationService);

	configurationService:CreateBar( override, "War-speech", 14, 1, 3, 240, 300 );
	configurationService:SetBuffTriggerOptions( true, false );
	configurationService:SetBuffTrigger( "War-speech" );
	configurationService:AddShortcut( 1, "0x7000B69A", 6, 14 );
	configurationService:AddShortcut( 2, "0x7000B69B", 6, 34 );
	configurationService:AddShortcut( 3, "0x7000F250", 6, 56 );
end

function MinstrelClass:Stances( override )
	local configurationService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.ConfigurationService);

	configurationService:CreateBar( override, "Stances", 10, 1, 2, 240, 350 );
	configurationService:AddShortcut( 2, "0x7000B699", 6, 10 );
	configurationService:AddShortcut( 1, "0x700293C8", 6, 22 );
end

function MinstrelClass:Coda( override )
	local configurationService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.ConfigurationService);

	configurationService:CreateBar( override, "Coda", 1, 1, 1, 240, 400 );
	configurationService:SetBuffTriggerOptions( true, false );
	configurationService:SetBuffTrigger( "Ballad Tier 3" );
	configurationService:AddShortcut( 1, "0x700293C4", 6, 1 );
end

function MinstrelClass:Anthems( override )
	local configurationService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.ConfigurationService);

	configurationService:CreateBar( override, "Anthems", 6, 1, 6, 240, 450 );
	configurationService:SetBuffTriggerOptions( true, false );
	configurationService:SetBuffTrigger( "Ballad Tier 3" );
	configurationService:AddShortcut( 1, "0x7000317F", 6, 6 );
	configurationService:AddShortcut( 2, "0x70003E88", 6, 18 );
	configurationService:AddShortcut( 3, "0x70003E7F", 6, 20 );
	configurationService:AddShortcut( 4, "0x70003E8A", 6, 24 );
	configurationService:AddShortcut( 5, "0x700264BA", 6, 28 );
	configurationService:AddShortcut( 6, "0x70003E80", 6, 36 );
end

function MinstrelClass:Scribe( override )
	local configurationService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.ConfigurationService);

	configurationService:CreateBar( override, "Scribe Stance", 30, 1, 3, 240, 500 );
	configurationService:SetBuffTriggerOptions( true, false );
	configurationService:SetBuffTrigger( "Scribe Stance" );
	configurationService:AddShortcut( 1, "0x7000C787", 6 );
	configurationService:AddShortcut( 2, "0x7000C788", 6 );
	configurationService:AddShortcut( 3, "0x7000C78B", 6 );
end