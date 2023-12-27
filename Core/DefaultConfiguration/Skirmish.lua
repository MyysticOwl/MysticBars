-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

Skirmish = class();

function Skirmish:Constructor()
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	configurationService:RegisterBarCreator( "Skirmishes", "Skirmishes", self.Skirmish );
	configurationService:ConstructBars();
end

function Skirmish:Skirmish( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	configurationService:CreateBar( override, "Skirmishes", 20, 1, 1, 170, 300 );
	configurationService:SetBuffTriggerOptions( true, false );
	configurationService:SetTrigger( configurationService.CTRL );
	configurationService:SetBuffTrigger( "Skirmish : Tier 1" );
	configurationService:SetBuffTrigger( "Skirmish : Tier 2" );
	configurationService:SetBuffTrigger( "Skirmish : Tier 3" );
	configurationService:AddShortcut( 1, "0x7001C4C8", 6, 20 );
end