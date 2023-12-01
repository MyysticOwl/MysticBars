-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

BrawlerClass = class();

function BrawlerClass:Constructor()
	local configurationService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.ConfigurationService);
	configurationService:RegisterBarCreator( "Battle Flow 3+", 	"Battle Flow 3+", self.BattleFlow3 );
	configurationService:ConstructBars();
end

function BrawlerClass:BattleFlow3( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.ConfigurationService);

	configurationService:CreateBar( override, "Battle Flow 3+", 1, 6, 3, 240, 350 );
	configurationService:SetBuffTriggerOptions( true, false );
	configurationService:SetBuffTrigger( "Battle Flow 3" );
	configurationService:SetBuffTrigger( "Battle Flow 4" );
	configurationService:SetBuffTrigger( "Battle Flow 5" );
	configurationService:SetBuffTrigger( "Battle Flow 6" );
	configurationService:SetBuffTrigger( "Battle Flow 7" );
	configurationService:SetBuffTrigger( "Battle Flow 8" );
	configurationService:SetBuffTrigger( "Battle Flow 9" );
	configurationService:AddShortcut( 1, "0x70058C3D", 6, 1 );
	configurationService:AddShortcut( 2, "0x70058C4F", 6, 1 );
	configurationService:AddShortcut( 3, "0x7005B609", 6, 1 );
	configurationService:AddShortcut( 4, "0x70058C44", 6, 1 );
	configurationService:AddShortcut( 5, "0x70058C43", 6, 1 );
	configurationService:AddShortcut( 6, "0x70058C42", 6, 1 );
	configurationService:AddShortcut( 7, "0x7005BDAA", 6, 1 );
	configurationService:AddShortcut( 8, "0x700598BC", 6, 1 );
	configurationService:AddShortcut( 9, "0x70058C41", 6, 1 );
	configurationService:AddShortcut( 10, "0x7005B558", 6, 1 );
end