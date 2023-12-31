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

	return configurationService:CreateBar( override, "Skirmishes", 20, 1, 1, 170, 300, function(localBarSettings)
		configurationService:SetBuffTriggerOptions( true, false, localBarSettings );
		configurationService:SetTrigger( configurationService.CTRL, nil, localBarSettings );
		configurationService:SetBuffTrigger( "Skirmish : Tier 1", localBarSettings );
		configurationService:SetBuffTrigger( "Skirmish : Tier 2", localBarSettings );
		configurationService:SetBuffTrigger( "Skirmish : Tier 3", localBarSettings );
		configurationService:AddShortcut( 1, "0x7001C4C8", 6, 20, localBarSettings );
	end);
end