-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

GuardianClass = class();

function GuardianClass:Constructor()
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	configurationService:RegisterBarCreator( "Stances", 			"Stance", 		self.Stance );
	configurationService:RegisterBarCreator( "Overpower Skills", 	"Overpower",	self.Overpower );
	configurationService:RegisterBarCreator( "Parry Skills", 		"Parry",		self.Parry );
	configurationService:RegisterBarCreator( "Block Skills", 		"Block",		self.Block );
	configurationService:ConstructBars();
end

function GuardianClass:Stance( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	configurationService:CreateBar( override, "Stance", 4, 1, 3, 240, 300 );
	configurationService:SetBuffTriggerOptions( false, false );
	configurationService:SetTrigger( configurationService.CTRL );
	configurationService:SetBuffTrigger( "Overpower" );
	configurationService:SetBuffTrigger( "Guardian's Parry Stance" );
	configurationService:SetBuffTrigger( "Guardian's Block Stance" );
	configurationService:SetBGColor( 0.35, 1, 0, 0 );
	configurationService:AddShortcut( 1, "0x70003EDF", 6, 4 );
	configurationService:AddShortcut( 2, "0x7000D4B1", 6, 10 );
	configurationService:AddShortcut( 3, "0x70003EE3", 6, 12 );
end

function GuardianClass:Overpower( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	configurationService:CreateBar( override, "Overpower", 30, 1, 2, 240, 350 );
	configurationService:SetBuffTriggerOptions( true, false );
	configurationService:SetBuffTrigger( "Overpower" );
	configurationService:AddShortcut( 1, "0x7000D4B0", 6, 30 );
	configurationService:AddShortcut( 2, "0x7000D4B3", 6, 46 );
end

function GuardianClass:Parry( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	configurationService:CreateBar( override, "Parry", 8, 1, 4, 240, 400 );
	configurationService:SetBuffTriggerOptions( true, false );
	configurationService:SetBuffTrigger( "Parry Response" );
	configurationService:SetBuffTrigger( "Retaliation" );
	configurationService:AddShortcut( 1, "0x70003EE0", 6, 8 );
	configurationService:AddShortcut( 2, "0x70003EE2", 6, 8 );
	configurationService:AddShortcut( 3, "0x70003EE4", 6, 14 );
	configurationService:AddShortcut( 4, "0x70003EE5", 6, 18 );
end

function GuardianClass:Block( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);
	
	configurationService:CreateBar( override, "Block", 2, 1, 4, 240, 450 );
	configurationService:SetBuffTriggerOptions( true, false );
	configurationService:SetBuffTrigger( "Block Response" );
	configurationService:AddShortcut( 1, "0x7000305D", 6, 2 );
	configurationService:AddShortcut( 2, "0x70003EE1", 6, 10 );
	configurationService:AddShortcut( 3, "0x7000307D", 6, 16 );
	configurationService:AddShortcut( 4, "0x70003EE6", 6, 22  );
end