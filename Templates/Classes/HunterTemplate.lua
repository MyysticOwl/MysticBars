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
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:RegisterBarCreator( "Stances", 			"Stance", self.Stance );
	templateService:RegisterBarCreator( "Focus >= 3 Skills", 	"3 Focus", self.Focus3 );
	templateService:RegisterBarCreator( "Find The Path", 	"Find The Path", self.FindThePath );
	templateService:RegisterBarCreator( "Focus >= 6 Skills", 	"6 Focus", self.Focus6 );
	templateService:ConstructBars();
end

function HunterTemplate:Stance( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);
	
	templateService:CreateBar( override, "Stance", 6, 1, 4, 240, 300 );
	templateService:SetBuffTriggerOptions( false, false );
	templateService:SetTrigger( templateService.CTRL );
	templateService:SetBuffTrigger( "Stance: Fleet" );
	templateService:SetBuffTrigger( "Stance: Strength" );
	templateService:SetBuffTrigger( "Stance: Endurance" );
	templateService:SetBuffTrigger( "Stance: Precision" );
	templateService:SetBGColor( 0.35, 1, 0, 0 );
	templateService:AddShortcut( 1, "0x70003F4E", 6, 6 );
	templateService:AddShortcut( 2, "0x70003F4D", 6, 18 );
	templateService:AddShortcut( 3, "0x70003F4F", 6, 28 );
	templateService:AddShortcut( 4, "0x70010065", 6, 56 );
end

function HunterTemplate:Focus3( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:CreateBar( override, "3 Focus", 2, 1, 4, 240, 350 );
	templateService:SetBuffTriggerOptions( true, false );
	templateService:SetClassRangeTrigger( HUNTER_FOCUS, 3, 9);
	templateService:AddShortcut( 1, "0x70003F35", 6, 2 );
	templateService:AddShortcut( 2, "0x70021D0D", 6, 20 );
	templateService:AddShortcut( 3, "0x700030F3", 6, 34 );
	templateService:AddShortcut( 4, "0x70003F36", 6, 44 );
end

function HunterTemplate:Focus6( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:CreateBar( override, "6 Focus", 30, 1, 2, 240, 400 );
	templateService:SetBuffTriggerOptions( true, false );
	templateService:SetClassRangeTrigger( HUNTER_FOCUS, 6, 9);
	templateService:AddShortcut( 1, "0x70003F37", 6, 30 );
	templateService:AddShortcut( 1, "0x700153E5", 6, 52 );
	templateService:AddShortcut( 2, "0x700010F4", 6, 41 );
end

function HunterTemplate:FindThePath( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:CreateBar( override, "Find The Path", 14, 1, 1, 240, 450 );
	templateService:SetBuffTriggerOptions( false, false );
	templateService:SetBuffTrigger( "Find the Path" );
	templateService:AddShortcut( 1, "0x70003F3D", 6, 14 );
end