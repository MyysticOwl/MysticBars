-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

WardenClass = class();

function WardenClass:Constructor()
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	configurationService:RegisterBarCreator( "Stances", 	"Stance", self.Stance );
	configurationService:RegisterBarCreator( "Travel", 		"Travel", self.Travel );
	configurationService:RegisterBarCreator( "Javelins", 	"Javelins", self.Javelin );
	configurationService:RegisterBarCreator( "Recovery", 	"Recovery", self.Recovery );
	configurationService:RegisterBarCreator( "March", 		"March", self.March );
	configurationService:RegisterBarCreator( "Charge", 		"Charge", self.Charge );
	configurationService:ConstructBars();
end

function WardenClass:Stance( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	configurationService:CreateBar( override, "Stance", 10, 1, 3, 240, 300 );
	configurationService:SetBuffTriggerOptions( false, false );
	configurationService:SetTrigger( configurationService.CTRL );
	configurationService:SetBuffTrigger( "Recklessness" );
	configurationService:SetBuffTrigger( "Determination" );
	configurationService:SetBuffTrigger( "Assailment" );
	configurationService:SetBGColor( 0.35, 1, 0, 0 );
	configurationService:AddShortcut( 1, "0x70014832", 6, 10 );
	configurationService:AddShortcut( 2, "0x7000ECD7", 6, 20 );
	configurationService:AddShortcut( 3, "0x70014799", 6, 30 );
end

function WardenClass:Travel( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	configurationService:CreateBar( override, "Travel", 26, 1, 4, 240, 350 );
	configurationService:AddShortcut( 1, "0x70014798", 6, 26 );
	configurationService:AddShortcut( 2, "0x70014786", 6, 32 );
	configurationService:AddShortcut( 3, "0x7001478E", 6, 40 );
	configurationService:AddShortcut( 4, "0x70014791", 6, 44 );
end

function WardenClass:Javelin( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	configurationService:CreateBar( override, "Javelins", 1, 1, 4, 240, 400 );
	configurationService:AddShortcut( 1, "0x700105C5", 6, 1 );
	configurationService:AddShortcut( 2, "0x70014784", 6, 20 );
	configurationService:AddShortcut( 3, "0x70014831", 6, 28 );
	configurationService:AddShortcut( 4, "0x70014833", 6, 38 );
end

function WardenClass:Recovery( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);
	
	configurationService:CreateBar( override, "Recovery", 10, 1, 2, 240, 450 );
	configurationService:AddShortcut( 1, "0x70016A0A", 6, 10 );
	configurationService:AddShortcut( 2, "0x70016A09", 6, 24 );
end

function WardenClass:March( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	configurationService:CreateBar( override, "March", 14, 1, 2, 240, 500 );
	configurationService:AddShortcut( 1, "0x700105CC", 6, 14 );
	configurationService:AddShortcut( 2, "0x70014860", 6, 14 );
end

function WardenClass:Charge( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	configurationService:CreateBar( override, "Charge", 10, 1, 1, 240, 550 );
	configurationService:SetBuffTriggerOptions( true, false );
	configurationService:SetBuffTrigger( "Charge" );
	configurationService:AddShortcut( 1, "0x700101D8", 6, 10 );
end