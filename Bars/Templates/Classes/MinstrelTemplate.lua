-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

MinstrelTemplate = class();

function MinstrelTemplate:Constructor()
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	templateService:RegisterBarCreator( "Dissonance Skills", 		"Dissonance", 		self.Dissonance );
	templateService:RegisterBarCreator( "Stances", 				"Stances", 			self.Stances );
	templateService:RegisterBarCreator( "Coda", 					"Coda", 			self.Coda );
	templateService:RegisterBarCreator( "Anthem Skills", 			"Anthems", 			self.Anthems );
	templateService:RegisterBarCreator( "Scribe Stance Skills", 	"Scribe Stance", 	self.Scribe );
	templateService:ConstructBars();
end

function MinstrelTemplate:Dissonance( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar(override, "Dissonance", 1, 3, 240, 300, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( true, false, barSettings );
		templateService:SetBuffTrigger( "Dissonance", barSettings );
		templateService:AddShortcut( 1, "0x7000B69A", 6, 14, barSettings );
		templateService:AddShortcut( 2, "0x7000B69B", 6, 34, barSettings );
		templateService:AddShortcut( 3, "0x7000F250", 6, 56, barSettings );
	end);
end

function MinstrelTemplate:Stances( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar(override, "Stances", 1, 2, 240, 350, QUICKSLOTBAR, function(barSettings)
		templateService:AddShortcut( 2, "0x7000B699", 6, 10, barSettings );
		templateService:AddShortcut( 1, "0x700293C8", 6, 22, barSettings );
	end);
end

function MinstrelTemplate:Coda( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar(override, "Coda", 1, 1, 240, 400, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( true, false, barSettings );
		templateService:SetBuffTrigger( "Ballad Tier 3", barSettings );
		templateService:AddShortcut( 1, "0x700293C4", 6, 1, barSettings );
	end);
end

function MinstrelTemplate:Anthems( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar(override, "Anthems", 1, 6, 240, 450, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( true, false, barSettings );
		templateService:SetBuffTrigger( "Ballad Tier 3, barSettings", barSettings );
		templateService:AddShortcut( 1, "0x7000317F", 6, 6, barSettings );
		templateService:AddShortcut( 2, "0x70003E88", 6, 18, barSettings );
		templateService:AddShortcut( 3, "0x70003E7F", 6, 20, barSettings );
		templateService:AddShortcut( 4, "0x70003E8A", 6, 24, barSettings );
		templateService:AddShortcut( 5, "0x700264BA", 6, 28, barSettings );
		templateService:AddShortcut( 6, "0x70003E80", 6, 36, barSettings );
	end);
end

function MinstrelTemplate:Scribe( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar(override, "Scribe Stance", 1, 3, 240, 500, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( true, false, barSettings );
		templateService:SetBuffTrigger( "Scribe Stance", barSettings );
		templateService:AddShortcut( 1, "0x7000C787", 6, 1, barSettings );
		templateService:AddShortcut( 2, "0x7000C788", 6, 1, barSettings );
		templateService:AddShortcut( 3, "0x7000C78B", 6, 1, barSettings );
	end)
end