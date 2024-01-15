-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

CaptainTemplate = class();

function CaptainTemplate:Constructor()
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	templateService:RegisterBarCreator( "Heralds", 		"Heralds", 	self.Heralds );
	templateService:RegisterBarCreator( "Tier1 Skills", 	"Tier1", 	self.Tier1 );
	templateService:RegisterBarCreator( "Tier2 Skills", 	"Tier2",	self.Tier2 );
	templateService:RegisterBarCreator( "Marks", 			"Marks",	self.Marks );
	templateService:RegisterBarCreator( "Tactics", 		"Tactics",	self.Tactics );
	templateService:RegisterBarCreator( "Defeat Skills", 	"DefeatResponse",	self.DefeatResponse );
	templateService:ConstructBars();
end

function CaptainTemplate:Heralds( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar(override, "Heralds", 1, 3, 240, 300, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( false, false, barSettings );
		templateService:SetTrigger( templateService.CTRL, nil, barSettings );
		templateService:SetBuffTrigger( "Banner of War", barSettings );
		templateService:SetBuffTrigger( "Banner of Hope", barSettings );
		templateService:SetBuffTrigger( "Banner of Victory", barSettings );
		templateService:SetBGColor( 0.35, 1, 0, 0, barSettings );
		templateService:AddShortcut( 1, "0x70002F7A", 6, 10, barSettings );
		templateService:AddShortcut( 2, "0x70002FAF", 6, 24, barSettings );
		templateService:AddShortcut( 3, "0x70002F1A", 6, 34, barSettings );
	end);
end

function CaptainTemplate:Tier1( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar(override, "Tier1", 1, 2, 240, 350, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( true, false, barSettings );
		templateService:SetBuffTrigger( "Battle-readied", barSettings );
		templateService:AddShortcut( 1, "0x70002FCF", 6, 2, barSettings );
		templateService:AddShortcut( 2, "0x70003E50", 6, 10, barSettings );
	end);
end

function CaptainTemplate:Tier2( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar(override, "Tier2", 1, 1, 240, 400, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( true, false, barSettings );
		templateService:SetBuffTrigger( "Battle-hardened", barSettings );
		templateService:AddShortcut( 1, "0x7000AD9A", 6, 30, barSettings );
		templateService:AddShortcut( 1, "0x70017D31", 6, 52, barSettings );
	end);
end

function CaptainTemplate:Marks( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar(override, "Marks", 1, 3, 240, 450, QUICKSLOTBAR, function(barSettings)
		templateService:AddShortcut( 1, "0x70003E4F", 6, 12, barSettings );
		templateService:AddShortcut( 2, "0x70003E4D", 6, 18, barSettings );
		templateService:AddShortcut( 3, "0x70003E56", 6, 30, barSettings );
	end);
end

function CaptainTemplate:Tactics( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar(override, "Tactics", 1, 3, 240, 500, QUICKSLOTBAR, function(barSettings)
		templateService:AddShortcut( 1, "0x70003E53", 6, 6, barSettings );
		templateService:AddShortcut( 2, "0x70003E55", 6, 28, barSettings );
		templateService:AddShortcut( 3, "0x70003E59", 6, 38, barSettings );
	end);
end

function CaptainTemplate:DefeatResponse( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar(override, "DefeatResponse", 1, 4, 240, 550, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( true, false, barSettings );
		templateService:SetBuffTrigger( "Enemy Defeat Response", barSettings );
		templateService:AddShortcut( 1, "0x70002F4F", 6, 2, barSettings );
		templateService:AddShortcut( 2, "0x70002F58", 6, 4, barSettings );
		templateService:AddShortcut( 3, "0x7000FF8B", 6, 8, barSettings );
		templateService:AddShortcut( 4, "0x70002F61", 6, 60, barSettings );
	end);
end