-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

SkirmishTemplate = class();

function SkirmishTemplate:Constructor()
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	templateService:RegisterBarCreator( "Skirmishes", "Skirmishes", self.Skirmish, true );
	templateService:ConstructBars();
end

function SkirmishTemplate:Skirmish( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar(override, "Skirmishes", 20, 1, 170, 300, QUICKSLOTBAR, function(localBarSettings)
		templateService:SetBuffTriggerOptions( true, false, localBarSettings );
		templateService:SetTrigger( templateService.CTRL, nil, localBarSettings );
		templateService:SetBuffTrigger( "Skirmish : Tier 1", localBarSettings );
		templateService:SetBuffTrigger( "Skirmish : Tier 2", localBarSettings );
		templateService:SetBuffTrigger( "Skirmish : Tier 3", localBarSettings );
		templateService:AddShortcut( 1, "0x7001C4C8", 6, 20, localBarSettings );
	end);
end