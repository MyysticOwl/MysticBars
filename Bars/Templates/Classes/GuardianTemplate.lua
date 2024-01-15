-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

GuardianTemplate = class();

function GuardianTemplate:Constructor()
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	templateService:RegisterBarCreator( "Stances", 			"Stance", 		self.Stance );
	templateService:RegisterBarCreator( "Overpower Skills", 	"Overpower",	self.Overpower );
	templateService:RegisterBarCreator( "Parry Skills", 		"Parry",		self.Parry );
	templateService:RegisterBarCreator( "Block Skills", 		"Block",		self.Block );
	templateService:ConstructBars();
end

function GuardianTemplate:Stance( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar(override, "Stance", 1, 3, 240, 300, QUICKSLOTBAR, function(localBarSettings)
		templateService:SetBuffTriggerOptions( false, false, localBarSettings );
		templateService:SetTrigger( templateService.CTRL, nil, localBarSettings );
		templateService:SetBuffTrigger( "Overpower", localBarSettings );
		templateService:SetBuffTrigger( "Guardian's Parry Stance", localBarSettings );
		templateService:SetBuffTrigger( "Guardian's Block Stance", localBarSettings );
		templateService:SetBGColor( 0.35, 1, 0, 0, localBarSettings );
		templateService:AddShortcut( 1, "0x70003EDF", 6, 4, localBarSettings );
		templateService:AddShortcut( 2, "0x7000D4B1", 6, 10, localBarSettings );
		templateService:AddShortcut( 3, "0x70003EE3", 6, 12, localBarSettings );
	end);
end

function GuardianTemplate:Overpower( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar(override, "Overpower", 1, 2, 240, 350, QUICKSLOTBAR, function(localBarSettings)
		templateService:SetBuffTriggerOptions( true, false, localBarSettings );
		templateService:SetBuffTrigger( "Overpower", localBarSettings );
		templateService:AddShortcut( 1, "0x7000D4B0", 6, 30, localBarSettings );
		templateService:AddShortcut( 2, "0x7000D4B3", 6, 46, localBarSettings );
	end);
end

function GuardianTemplate:Parry( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar(override, "Parry", 1, 4, 240, 400, QUICKSLOTBAR, function(localBarSettings)
		templateService:SetBuffTriggerOptions( true, false, localBarSettings );
		templateService:SetBuffTrigger( "Parry Response", localBarSettings );
		templateService:SetBuffTrigger( "Retaliation", localBarSettings );
		templateService:AddShortcut( 1, "0x70003EE0", 6, 8, localBarSettings );
		templateService:AddShortcut( 2, "0x70003EE2", 6, 8, localBarSettings );
		templateService:AddShortcut( 3, "0x70003EE4", 6, 14, localBarSettings );
		templateService:AddShortcut( 4, "0x70003EE5", 6, 18, localBarSettings );
	end);
end

function GuardianTemplate:Block( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar(override, "Block", 1, 4, 240, 450, QUICKSLOTBAR, function(localBarSettings)
		templateService:SetBuffTriggerOptions( true, false, localBarSettings );
		templateService:SetBuffTrigger( "Block Response", localBarSettings );
		templateService:AddShortcut( 1, "0x7000305D", 6, 2, localBarSettings );
		templateService:AddShortcut( 2, "0x70003EE1", 6, 10, localBarSettings );
		templateService:AddShortcut( 3, "0x7000307D", 6, 16, localBarSettings );
		templateService:AddShortcut( 4, "0x70003EE6", 6, 22, localBarSettings  );
	end);
end