-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

RuneKeeperTemplate = class();

function RuneKeeperTemplate:Constructor()
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:RegisterBarCreator( "Restoration Skill", 			"Restoration", 	self.Restoration );
	templateService:RegisterBarCreator( "DPS Attonement Skill", 		"Attun 1-10", 	self.Attun110 );
	templateService:RegisterBarCreator( "Healing Attonement Skill", 	"Attun 10-19", 	self.Attun1019 );
	templateService:RegisterBarCreator( "3 DPS Attonement, Skills", 	"Attun 7", 		self.Attun7 );
	templateService:RegisterBarCreator( "6 DPS Attonement, Skills", 	"Attun 4", 		self.Attun4 );
	templateService:RegisterBarCreator( "Full DPS Attonement, Skills", "Attun 1", 		self.Attun1 );
	templateService:RegisterBarCreator( "3 Heal Attonement Skills", 	"Attun 13", 		self.Attun13 );
	templateService:RegisterBarCreator( "6 Heal Attonement Skills", 	"Attun 16", 		self.Attun16 );
	templateService:RegisterBarCreator( "Full Heal Attonement Skills", "Attun 19", 		self.Attun19 );
	templateService:ConstructBars();
end

function RuneKeeperTemplate:Restoration( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	return templateService:CreateBar( override, "Restoration", 4, 1, 1, 240, 350, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( false, false, barSettings );
		templateService:SetTrigger( templateService.CTRL, nil, barSettings );
		templateService:SetBuffTrigger( "Rune of Restoration", barSettings );
		templateService:SetBGColor( 0.35, 1, 0, 0, barSettings );
		templateService:AddShortcut( 1, "0x7000EEA5", 6, 4, barSettings );
	end);
end

function RuneKeeperTemplate:Attun7( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	return templateService:CreateBar( override, "Attun 7", 2, 5, 1, 468, 300, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( true, false, barSettings );
		templateService:SetClassRangeTrigger( RK_ATTUNEMENT, 1, 7, barSettings);
		templateService:AddShortcut( 1, "0x7000EEAE", 6, 2, barSettings );
		templateService:AddShortcut( 2, "0x7000EE00", 6, 12, barSettings );
		templateService:AddShortcut( 3, "0x7000EEAB", 6, 16, barSettings );
		templateService:AddShortcut( 4, "0x7000EDFF", 6, 38, barSettings );
		templateService:AddShortcut( 5, "0x700180F5", 6, 60, barSettings );
	end);
end

function RuneKeeperTemplate:Attun4( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	return templateService:CreateBar( override, "Attun 4", 24, 6, 1, 429, 300, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( true, false, barSettings );
		templateService:SetClassRangeTrigger( RK_ATTUNEMENT, 1, 4, barSettings);
		templateService:AddShortcut( 1, "0x7000EE01", 6, 24, barSettings );
		templateService:AddShortcut( 2, "0x7000E969", 6, 28, barSettings );
		templateService:AddShortcut( 3, "0x70024D3A", 6, 30, barSettings );
		templateService:AddShortcut( 4, "0x7000EFEF", 6, 36, barSettings );
		templateService:AddShortcut( 5, "0x70024D39", 6, 50, barSettings );
		templateService:AddShortcut( 6, "0x700180F9", 6, 56, barSettings );
	end);
end

function RuneKeeperTemplate:Attun1( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	return templateService:CreateBar( override, "Attun 1", 20, 3, 1, 387, 300, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( true, false, barSettings );
		templateService:SetClassRangeTrigger( RK_ATTUNEMENT, 1, 1, barSettings);
		templateService:AddShortcut( 1, "0x7000EEAF", 6, 20, barSettings );
		templateService:AddShortcut( 2, "0x7000EE03", 6, 32, barSettings );
		templateService:AddShortcut( 3, "0x7000E96D", 6, 40, barSettings );
	end);
end

function RuneKeeperTemplate:Attun1019( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	return templateService:CreateBar( override, "Attun 10-19", 1, 1, 1, 508, 336, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( true, false, barSettings );
		templateService:SetClassRangeTrigger( RK_ATTUNEMENT, 10, 19, barSettings);
		templateService:AddShortcut( 1, "0x7000EEA8", 6, 1, barSettings );
	end);
end

function RuneKeeperTemplate:Attun13( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	return templateService:CreateBar( override, "Attun 13", 12, 2, 1, 547, 300, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( true, false, barSettings );
		templateService:SetClassRangeTrigger( RK_ATTUNEMENT, 13, 19, barSettings);
		templateService:AddShortcut( 1, "0x7000EEA9", 6, 12, barSettings );
		templateService:AddShortcut( 2, "0x7000EEA4", 6, 14, barSettings );
	end);
end

function RuneKeeperTemplate:Attun16( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	return templateService:CreateBar( override, "Attun 16", 18, 3, 1, 585, 300, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( true, false, barSettings );
		templateService:SetClassRangeTrigger( RK_ATTUNEMENT, 16, 19, barSettings);
		templateService:AddShortcut( 1, "0x7000EEA6", 6, 18, barSettings );
		templateService:AddShortcut( 2, "0x7000EEA7", 6, 28, barSettings );
		templateService:AddShortcut( 3, "0x700180F7", 6, 58, barSettings );
	end);
end

function RuneKeeperTemplate:Attun19( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	return templateService:CreateBar( override, "Attun 19", 41, 3, 1, 623, 300, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( true, false, barSettings );
		templateService:SetClassRangeTrigger( RK_ATTUNEMENT, 19, 19, barSettings);
		templateService:AddShortcut( 1, "0x70018636", 6, 42, barSettings );
		templateService:AddShortcut( 2, "0x70018776", 6, 54, barSettings );
		templateService:AddShortcut( 3, "0x700180F4", 6, 41, barSettings );
	end);
end

function RuneKeeperTemplate:Attun110( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	return templateService:CreateBar( override, "Attun 1-10", 1, 1, 1, 508, 300, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( true, false, barSettings );
		templateService:SetClassRangeTrigger( RK_ATTUNEMENT, 1, 10, barSettings);
		templateService:AddShortcut( 1, "0x7000E96B", 6, 1, barSettings );
	end);
end