-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

HunterTemplate = class();

function HunterTemplate:Constructor()
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	templateService:RegisterBarCreator( "Stances", 			"Stance", self.Stance );
	templateService:RegisterBarCreator( "Focus >= 3 Skills", 	"3 Focus", self.Focus3 );
	templateService:RegisterBarCreator( "Find The Path", 	"Find The Path", self.FindThePath );
	templateService:RegisterBarCreator( "Focus >= 6 Skills", 	"6 Focus", self.Focus6 );
	templateService:ConstructBars();
end

function HunterTemplate:Stance( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar( "Stance", 1, 4, 240, 300, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( false, false, barSettings );
		templateService:SetTrigger( templateService.CTRL, nil, barSettings );
		templateService:SetBuffTrigger( "Stance: Fleet", barSettings );
		templateService:SetBuffTrigger( "Stance: Strength", barSettings );
		templateService:SetBuffTrigger( "Stance: Endurance", barSettings );
		templateService:SetBuffTrigger( "Stance: Precision", barSettings );
		templateService:SetBGColor( 0.35, 1, 0, 0, barSettings );
		templateService:AddShortcut( 1, "0x70003F4E", 6, 6, barSettings );
		templateService:AddShortcut( 2, "0x70003F4D", 6, 18, barSettings );
		templateService:AddShortcut( 3, "0x70003F4F", 6, 28, barSettings );
		templateService:AddShortcut( 4, "0x70010065", 6, 56, barSettings );
	end);
end

function HunterTemplate:Focus3( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar( "3 Focus", 1, 4, 240, 350, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( true, false, barSettings );
		templateService:SetClassRangeTrigger( HUNTER_FOCUS, 3, 9, barSettings);
		templateService:AddShortcut( 1, "0x70003F35", 6, 2, barSettings );
		templateService:AddShortcut( 2, "0x70021D0D", 6, 20, barSettings );
		templateService:AddShortcut( 3, "0x700030F3", 6, 34, barSettings );
		templateService:AddShortcut( 4, "0x70003F36", 6, 44, barSettings );
	end);
end

function HunterTemplate:Focus6( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar( "6 Focus", 1, 2, 240, 400, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( true, false, barSettings );
		templateService:SetClassRangeTrigger( HUNTER_FOCUS, 6, 9, barSettings);
		templateService:AddShortcut( 1, "0x70003F37", 6, 30, barSettings );
		templateService:AddShortcut( 1, "0x700153E5", 6, 52, barSettings );
		templateService:AddShortcut( 2, "0x700010F4", 6, 41, barSettings );
	end);
end

function HunterTemplate:FindThePath( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar( "Find The Path", 1, 1, 240, 450, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( false, false, barSettings );
		templateService:SetBuffTrigger( "Find the Path", barSettings );
		templateService:AddShortcut( 1, "0x70003F3D", 6, 14, barSettings );
	end);
end