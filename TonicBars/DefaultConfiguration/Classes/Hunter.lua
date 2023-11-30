-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

HunterClass = class();

function HunterClass:Constructor()
	local configurationService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.ConfigurationService);

	configurationService:RegisterBarCreator( "Stances", 			"Stance", self.Stance );
	configurationService:RegisterBarCreator( "Focus >= 3 Skills", 	"3 Focus", self.Focus3 );
	configurationService:RegisterBarCreator( "Find The Path", 	"Find The Path", self.FindThePath );
	configurationService:RegisterBarCreator( "Focus >= 6 Skills", 	"6 Focus", self.Focus6 );
	configurationService:ConstructBars();
end

function HunterClass:Stance( override )
	local configurationService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.ConfigurationService);
	
	configurationService:CreateBar( override, "Stance", 6, 1, 4, 240, 300 );
	configurationService:SetBuffTriggerOptions( false, false );
	configurationService:SetTrigger( configurationService.CTRL );
	configurationService:SetBuffTrigger( "Stance: Fleet" );
	configurationService:SetBuffTrigger( "Stance: Strength" );
	configurationService:SetBuffTrigger( "Stance: Endurance" );
	configurationService:SetBuffTrigger( "Stance: Precision" );
	configurationService:SetBGColor( 0.35, 1, 0, 0 );
	configurationService:AddShortcut( 1, "0x70003F4E", 6, 6 );
	configurationService:AddShortcut( 2, "0x70003F4D", 6, 18 );
	configurationService:AddShortcut( 3, "0x70003F4F", 6, 28 );
	configurationService:AddShortcut( 4, "0x70010065", 6, 56 );
end

function HunterClass:Focus3( override )
	local configurationService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.ConfigurationService);

	configurationService:CreateBar( override, "3 Focus", 2, 1, 4, 240, 350 );
	configurationService:SetBuffTriggerOptions( true, false );
	configurationService:SetClassRangeTrigger( HUNTER_FOCUS, 3, 9);
	configurationService:AddShortcut( 1, "0x70003F35", 6, 2 );
	configurationService:AddShortcut( 2, "0x70021D0D", 6, 20 );
	configurationService:AddShortcut( 3, "0x700030F3", 6, 34 );
	configurationService:AddShortcut( 4, "0x70003F36", 6, 44 );
end

function HunterClass:Focus6( override )
	local configurationService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.ConfigurationService);

	configurationService:CreateBar( override, "6 Focus", 30, 1, 2, 240, 400 );
	configurationService:SetBuffTriggerOptions( true, false );
	configurationService:SetClassRangeTrigger( HUNTER_FOCUS, 6, 9);
	configurationService:AddShortcut( 1, "0x70003F37", 6, 30 );
	configurationService:AddShortcut( 1, "0x700153E5", 6, 52 );
	configurationService:AddShortcut( 2, "0x700010F4", 6, 41 );
end

function HunterClass:FindThePath( override )
	local configurationService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.ConfigurationService);

	configurationService:CreateBar( override, "Find The Path", 14, 1, 1, 240, 450 );
	configurationService:SetBuffTriggerOptions( false, false );
	configurationService:SetBuffTrigger( "Find the Path" );
	configurationService:AddShortcut( 1, "0x70003F3D", 6, 14 );
end