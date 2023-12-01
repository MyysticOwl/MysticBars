-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

BurglarClass = class();

function BurglarClass:Constructor()
	local configurationService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.ConfigurationService);

	configurationService:RegisterBarCreator( "Tier1 Skills", 	"Tier1", self.Tier1 );
	configurationService:RegisterBarCreator( "Tier2 Skills", 	"Tier2", self.Tier2 );
	configurationService:RegisterBarCreator( "Tier3 Skills", 	"Tier3", self.Tier3 );
	configurationService:RegisterBarCreator( "Tricks", 			"Tricks", self.Tricks );
	configurationService:RegisterBarCreator( "Trick Removals", 	"TrickRemovals", self.TrickRemovals );
	configurationService:RegisterBarCreator( "Mischief Skills", "Mischief",	self.Mischief );
	configurationService:RegisterBarCreator( "Knockdown Skills", "KnockedDown",	self.KnockedDown );
	configurationService:ConstructBars();
end

function BurglarClass:Tier1( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.ConfigurationService);

	configurationService:CreateBar( override, "Tier1", 2, 1, 1, 240, 300 );
	configurationService:SetBuffTriggerOptions( true, false );
	configurationService:SetBuffTrigger( "Critical Response" );
	configurationService:AddShortcut( 1, "0x70003F0B", 6, 2 );
end

function BurglarClass:Tier2( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.ConfigurationService);

	configurationService:CreateBar( override, "Tier2", 24, 1, 1, 240, 350 );
	configurationService:AddShortcut( 1, "0x70003F0C", 6, 24 );
end

function BurglarClass:Tier3( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.ConfigurationService);

	configurationService:CreateBar( override, "Tier3", 56, 1, 3, 240, 400 );
	configurationService:SetBuffTriggerOptions( true, false );
	configurationService:SetBuffTrigger( "Double Edged" );
	configurationService:AddShortcut( 1, "0x7000FD86", 6, 56 );
	configurationService:AddShortcut( 2, "0x7000FB71", 6, 58 );
	configurationService:AddShortcut( 3, "0x7000FB73", 6, 60 );
end

function BurglarClass:Tricks( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.ConfigurationService);

	configurationService:CreateBar( override, "Tricks", 8, 1, 4, 240, 450 );
	configurationService:AddShortcut( 1, "0x700031FA", 6, 8 );
	configurationService:AddShortcut( 2, "0x700031E7", 6, 16 );
	configurationService:AddShortcut( 3, "0x70003200", 6, 26 );
	configurationService:AddShortcut( 4, "0x70003218", 6, 38 );
end

function BurglarClass:TrickRemovals( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.ConfigurationService);

	configurationService:CreateBar( override, "TrickRemovals", 20, 1, 2, 240, 500 );
	configurationService:AddShortcut( 1, "0x70015A04", 6, 20 );
	configurationService:AddShortcut( 1, "0x70015A04", 6, 52 );
	configurationService:AddShortcut( 2, "0x70020DD0", 6, 64 );
end

function BurglarClass:Mischief( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.ConfigurationService);

	configurationService:CreateBar( override, "Mischief", 30, 1, 2, 240, 550 );
	configurationService:SetBuffTriggerOptions( true, false );
	configurationService:SetBuffTrigger( "Mischievous" );
	configurationService:AddShortcut( 1, "0x7000D440", 6, 30 );
	configurationService:AddShortcut( 2, "0x7000D441", 6, 46 );
end

function BurglarClass:KnockedDown( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.ConfigurationService);

	configurationService:CreateBar( override, "KnockedDown", 32, 1, 1, 240, 600 );
	configurationService:SetBuffTriggerOptions( true, false );
	configurationService:SetBuffTrigger( "Stunned" );
	configurationService:SetBuffTrigger( "Knocked Down" );
	configurationService:SetBuffTrigger( "Dazed" );
	configurationService:AddShortcut( 1, "0x70003F14", 6, 32 );
end