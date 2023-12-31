-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

BurglarTemplate = class();

function BurglarTemplate:Constructor()
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:RegisterBarCreator( "Tier1 Skills", 	"Tier1", self.Tier1 );
	templateService:RegisterBarCreator( "Tier2 Skills", 	"Tier2", self.Tier2 );
	templateService:RegisterBarCreator( "Tier3 Skills", 	"Tier3", self.Tier3 );
	templateService:RegisterBarCreator( "Tricks", 			"Tricks", self.Tricks );
	templateService:RegisterBarCreator( "Trick Removals", 	"TrickRemovals", self.TrickRemovals );
	templateService:RegisterBarCreator( "Mischief Skills", "Mischief",	self.Mischief );
	templateService:RegisterBarCreator( "Knockdown Skills", "KnockedDown",	self.KnockedDown );
	templateService:ConstructBars();
end

function BurglarTemplate:Tier1( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:CreateBar( override, "Tier1", 2, 1, 1, 240, 300 );
	templateService:SetBuffTriggerOptions( true, false );
	templateService:SetBuffTrigger( "Critical Response" );
	templateService:AddShortcut( 1, "0x70003F0B", 6, 2 );
end

function BurglarTemplate:Tier2( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:CreateBar( override, "Tier2", 24, 1, 1, 240, 350 );
	templateService:AddShortcut( 1, "0x70003F0C", 6, 24 );
end

function BurglarTemplate:Tier3( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:CreateBar( override, "Tier3", 56, 1, 3, 240, 400 );
	templateService:SetBuffTriggerOptions( true, false );
	templateService:SetBuffTrigger( "Double Edged" );
	templateService:AddShortcut( 1, "0x7000FD86", 6, 56 );
	templateService:AddShortcut( 2, "0x7000FB71", 6, 58 );
	templateService:AddShortcut( 3, "0x7000FB73", 6, 60 );
end

function BurglarTemplate:Tricks( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:CreateBar( override, "Tricks", 8, 1, 4, 240, 450 );
	templateService:AddShortcut( 1, "0x700031FA", 6, 8 );
	templateService:AddShortcut( 2, "0x700031E7", 6, 16 );
	templateService:AddShortcut( 3, "0x70003200", 6, 26 );
	templateService:AddShortcut( 4, "0x70003218", 6, 38 );
end

function BurglarTemplate:TrickRemovals( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:CreateBar( override, "TrickRemovals", 20, 1, 2, 240, 500 );
	templateService:AddShortcut( 1, "0x70015A04", 6, 20 );
	templateService:AddShortcut( 1, "0x70015A04", 6, 52 );
	templateService:AddShortcut( 2, "0x70020DD0", 6, 64 );
end

function BurglarTemplate:Mischief( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:CreateBar( override, "Mischief", 30, 1, 2, 240, 550 );
	templateService:SetBuffTriggerOptions( true, false );
	templateService:SetBuffTrigger( "Mischievous" );
	templateService:AddShortcut( 1, "0x7000D440", 6, 30 );
	templateService:AddShortcut( 2, "0x7000D441", 6, 46 );
end

function BurglarTemplate:KnockedDown( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:CreateBar( override, "KnockedDown", 32, 1, 1, 240, 600 );
	templateService:SetBuffTriggerOptions( true, false );
	templateService:SetBuffTrigger( "Stunned" );
	templateService:SetBuffTrigger( "Knocked Down" );
	templateService:SetBuffTrigger( "Dazed" );
	templateService:AddShortcut( 1, "0x70003F14", 6, 32 );
end