-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

WardenTemplate = class();

function WardenTemplate:Constructor()
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	templateService:RegisterBarCreator( "Stances", 	"Stance", self.Stance );
	templateService:RegisterBarCreator( "Travel", 		"Travel", self.Travel );
	templateService:RegisterBarCreator( "Javelins", 	"Javelins", self.Javelin );
	templateService:RegisterBarCreator( "Recovery", 	"Recovery", self.Recovery );
	templateService:RegisterBarCreator( "March", 		"March", self.March );
	templateService:RegisterBarCreator( "Charge", 		"Charge", self.Charge );
	templateService:ConstructBars();
end

function WardenTemplate:Stance( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar(override, "Stance", 1, 3, 240, 300, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( false, false, barSettings );
		templateService:SetTrigger( templateService.CTRL, nil, barSettings );
		templateService:SetBuffTrigger( "Recklessness", barSettings );
		templateService:SetBuffTrigger( "Determination", barSettings );
		templateService:SetBuffTrigger( "Assailment", barSettings );
		templateService:SetBGColor( 0.35, 1, 0, 0, barSettings );
		templateService:AddShortcut( 1, "0x7003639B", 6, 10, barSettings );
		templateService:AddShortcut( 2, "0x7003639C", 6, 20, barSettings );
		templateService:AddShortcut( 3, "0x70014799", 6, 30, barSettings );
	end);
end

function WardenTemplate:Travel( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar(override, "Travel", 1, 4, 240, 350, QUICKSLOTBAR, function(barSettings)
		templateService:AddShortcut( 1, "0x70014798", 6, 26, barSettings );
		templateService:AddShortcut( 2, "0x70014786", 6, 32, barSettings );
		templateService:AddShortcut( 3, "0x7001478E", 6, 40, barSettings );
		templateService:AddShortcut( 4, "0x70014791", 6, 44, barSettings );
	end);
end

function WardenTemplate:Javelin( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar(override, "Javelins", 1, 4, 240, 400, QUICKSLOTBAR, function(barSettings)
		templateService:AddShortcut( 1, "0x700105C5", 6, 1, barSettings );
		templateService:AddShortcut( 2, "0x70014784", 6, 20, barSettings );
		templateService:AddShortcut( 3, "0x70014831", 6, 28, barSettings );
		templateService:AddShortcut( 4, "0x70014833", 6, 38, barSettings);
	end);
end

function WardenTemplate:Recovery( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar(override, "Recovery", 1, 2, 240, 450, QUICKSLOTBAR, function(barSettings)
		templateService:AddShortcut( 1, "0x70016A0A", 6, 10, barSettings );
		templateService:AddShortcut( 2, "0x70016A09", 6, 24, barSettings );
	end);
end

function WardenTemplate:March( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar(override, "March", 1, 2, 240, 500, QUICKSLOTBAR, function(barSettings)
		templateService:AddShortcut( 1, "0x700105CC", 6, 14, barSettings );
		templateService:AddShortcut( 2, "0x70014860", 6, 14, barSettings );
	end);
end

function WardenTemplate:Charge( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar(override, "Charge", 1, 1, 240, 550, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( true, false, barSettings );
		templateService:SetBuffTrigger( "Charge", barSettings );
		templateService:AddShortcut( 1, "0x700101D8", 6, 10, barSettings );
	end);
end