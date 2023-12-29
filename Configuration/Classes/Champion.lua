-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

ChampionClass = class();

function ChampionClass:Constructor()
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	configurationService:RegisterBarCreator( "Stances", 	 "Stance",	self.Stance );
	configurationService:RegisterBarCreator( "Tier1 Skills", "Tier1", 	self.Tier1 );
	configurationService:RegisterBarCreator( "Tier2 Skills", "Tier2", 	self.Tier2 );
	configurationService:RegisterBarCreator( "Tier3 Skills", "Tier3", 	self.Tier3 );
	configurationService:RegisterBarCreator( "Tier4 Skills", "Tier4", 	self.Tier4 );
	configurationService:RegisterBarCreator( "Tier5 Skills", "Tier5", 	self.Tier5 );
	configurationService:ConstructBars();
end

function ChampionClass:Stance( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	configurationService:CreateBar( override, "Stance", 4, 1, 3, 240, 300 );
	configurationService:SetBuffTriggerOptions( false, false );
	configurationService:SetTrigger( configurationService.CTRL );
	configurationService:SetBuffTrigger( "Champion's Fervour" );
	configurationService:SetBuffTrigger( "Glory" );
	configurationService:SetBuffTrigger( "Ardour" );
	configurationService:SetBGColor( 0.35, 1, 0, 0 );
	configurationService:AddShortcut( 1, "0x70003DFF", 6, 4 );
	configurationService:AddShortcut( 2, "0x7000D46C", 6, 10 );
	configurationService:AddShortcut( 3, "0x7000967C", 6, 30 );
end

function ChampionClass:Tier1( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	configurationService:CreateBar( override, "Tier1", 18, 1, 3, 240, 350 );
	configurationService:SetBuffTriggerOptions( true, false );
	configurationService:SetBuffTrigger( "Tier1" );
	configurationService:SetClassRangeTrigger( CHAMPION_FERVOR, 1, 5);
	configurationService:AddShortcut( 1, "0x70003E06", 6, 18 );
	configurationService:AddShortcut( 2, "0x70003E0C", 6, 32 );
	configurationService:AddShortcut( 3, "0x70003E0E", 6, 36 );
end

function ChampionClass:Tier2( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	configurationService:CreateBar( override, "Tier2", 4, 1, 4, 240, 400 );
	configurationService:SetBuffTriggerOptions( true, false );
	configurationService:SetBuffTrigger( "Tier2" );
	configurationService:SetClassRangeTrigger( CHAMPION_FERVOR, 2, 5);
	configurationService:AddShortcut( 1, "0x70003E00", 6, 4 );
	configurationService:AddShortcut( 2, "0x70003E02", 6, 8 );
	configurationService:AddShortcut( 3, "0x70009E5C", 6, 42 );
	configurationService:AddShortcut( 4, "0x7000F660", 6, 54 );
end

function ChampionClass:Tier3( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	configurationService:CreateBar( override, "Tier3", 14, 1, 2, 240, 450 );
	configurationService:SetBuffTriggerOptions( true, false );
	configurationService:SetBuffTrigger( "Tier3" );
	configurationService:SetClassRangeTrigger( CHAMPION_FERVOR, 3, 5);
	configurationService:AddShortcut( 1, "0x70003E04", 6, 14 );
	configurationService:AddShortcut( 2, "0x7000F661", 6, 52 );
end

function ChampionClass:Tier4( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	configurationService:CreateBar( override, "Tier4", 6, 1, 4, 240, 500 );
	configurationService:SetBuffTriggerOptions( true, false );
	configurationService:SetBuffTrigger( "Tier4" );
	configurationService:SetClassRangeTrigger( CHAMPION_FERVOR, 4, 5);
	configurationService:AddShortcut( 1, "0x70003E01", 6, 6 );
	configurationService:AddShortcut( 2, "0x70003E03", 6, 10 );
	configurationService:AddShortcut( 3, "0x70009E5B", 6, 44 );
	configurationService:AddShortcut( 4, "0x7001F4B3", 6, 62 );
end

function ChampionClass:Tier5( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	configurationService:CreateBar( override, "Tier5", 6, 1, 2, 240, 550 );
	configurationService:SetBuffTriggerOptions( true, false );
	configurationService:SetBuffTrigger( "Tier5" );
	configurationService:SetClassRangeTrigger( CHAMPION_FERVOR, 5, 5);
	configurationService:AddShortcut( 1, "0x70003E0D", 6, 34 );
	configurationService:AddShortcut( 2, "0x7000F70C", 6, 58 );
end