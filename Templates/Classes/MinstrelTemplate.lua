-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

MinstrelTemplate = class();

function MinstrelTemplate:Constructor()
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:RegisterBarCreator( "War-Speech Skills", 		"War-speech", 		self.WarSpeech );
	templateService:RegisterBarCreator( "Stances", 				"Stances", 			self.Stances );
	templateService:RegisterBarCreator( "Coda", 					"Coda", 			self.Coda );
	templateService:RegisterBarCreator( "Anthem Skills", 			"Anthems", 			self.Anthems );
	templateService:RegisterBarCreator( "Scribe Stance Skills", 	"Scribe Stance", 	self.Scribe );
	templateService:ConstructBars();
end

function MinstrelTemplate:WarSpeech( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:CreateBar( override, "War-speech", 14, 1, 3, 240, 300 );
	templateService:SetBuffTriggerOptions( true, false );
	templateService:SetBuffTrigger( "War-speech" );
	templateService:AddShortcut( 1, "0x7000B69A", 6, 14 );
	templateService:AddShortcut( 2, "0x7000B69B", 6, 34 );
	templateService:AddShortcut( 3, "0x7000F250", 6, 56 );
end

function MinstrelTemplate:Stances( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:CreateBar( override, "Stances", 10, 1, 2, 240, 350 );
	templateService:AddShortcut( 2, "0x7000B699", 6, 10 );
	templateService:AddShortcut( 1, "0x700293C8", 6, 22 );
end

function MinstrelTemplate:Coda( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:CreateBar( override, "Coda", 1, 1, 1, 240, 400 );
	templateService:SetBuffTriggerOptions( true, false );
	templateService:SetBuffTrigger( "Ballad Tier 3" );
	templateService:AddShortcut( 1, "0x700293C4", 6, 1 );
end

function MinstrelTemplate:Anthems( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:CreateBar( override, "Anthems", 6, 1, 6, 240, 450 );
	templateService:SetBuffTriggerOptions( true, false );
	templateService:SetBuffTrigger( "Ballad Tier 3" );
	templateService:AddShortcut( 1, "0x7000317F", 6, 6 );
	templateService:AddShortcut( 2, "0x70003E88", 6, 18 );
	templateService:AddShortcut( 3, "0x70003E7F", 6, 20 );
	templateService:AddShortcut( 4, "0x70003E8A", 6, 24 );
	templateService:AddShortcut( 5, "0x700264BA", 6, 28 );
	templateService:AddShortcut( 6, "0x70003E80", 6, 36 );
end

function MinstrelTemplate:Scribe( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:CreateBar( override, "Scribe Stance", 30, 1, 3, 240, 500 );
	templateService:SetBuffTriggerOptions( true, false );
	templateService:SetBuffTrigger( "Scribe Stance" );
	templateService:AddShortcut( 1, "0x7000C787", 6 );
	templateService:AddShortcut( 2, "0x7000C788", 6 );
	templateService:AddShortcut( 3, "0x7000C78B", 6 );
end