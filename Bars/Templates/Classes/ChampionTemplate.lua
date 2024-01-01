-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

ChampionTemplate = class();

function ChampionTemplate:Constructor()
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	templateService:RegisterBarCreator( "Stances", 	 "Stance",	self.Stance );
	templateService:RegisterBarCreator( "Tier1 Skills", "Tier1", 	self.Tier1 );
	templateService:RegisterBarCreator( "Tier2 Skills", "Tier2", 	self.Tier2 );
	templateService:RegisterBarCreator( "Tier3 Skills", "Tier3", 	self.Tier3 );
	templateService:RegisterBarCreator( "Tier4 Skills", "Tier4", 	self.Tier4 );
	templateService:RegisterBarCreator( "Tier5 Skills", "Tier5", 	self.Tier5 );
	templateService:ConstructBars();
end

function ChampionTemplate:Stance( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	return templateService:CreateBar( override, "Stance", 4, 1, 3, 240, 30, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( false, false, barSettings );
		templateService:SetTrigger( templateService.CTRL, nil, barSettings );
		templateService:SetBuffTrigger( "Champion's Fervour", barSettings );
		templateService:SetBuffTrigger( "Glory", barSettings );
		templateService:SetBuffTrigger( "Ardour", barSettings );
		templateService:SetBGColor( 0.35, 1, 0, 0, barSettings );
		templateService:AddShortcut( 1, "0x70003DFF", 6, 4, barSettings );
		templateService:AddShortcut( 2, "0x7000D46C", 6, 10, barSettings );
		templateService:AddShortcut( 3, "0x7000967C", 6, 30, barSettings );
	end);
end

function ChampionTemplate:Tier1( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	return templateService:CreateBar( override, "Tier1", 18, 1, 3, 240, 350, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( true, false, barSettings );
		templateService:SetBuffTrigger( "Tier1", barSettings );
		templateService:SetClassRangeTrigger( CHAMPION_FERVOR, 1, 5, barSettings);
		templateService:AddShortcut( 1, "0x70003E06", 6, 18, barSettings );
		templateService:AddShortcut( 2, "0x70003E0C", 6, 32, barSettings );
		templateService:AddShortcut( 3, "0x70003E0E", 6, 36, barSettings );
	end);
end

function ChampionTemplate:Tier2( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	return templateService:CreateBar( override, "Tier2", 4, 1, 4, 240, 400, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( true, false, barSettings );
		templateService:SetBuffTrigger( "Tier2", barSettings );
		templateService:SetClassRangeTrigger( CHAMPION_FERVOR, 2, 5, barSettings);
		templateService:AddShortcut( 1, "0x70003E00", 6, 4, barSettings );
		templateService:AddShortcut( 2, "0x70003E02", 6, 8, barSettings );
		templateService:AddShortcut( 3, "0x70009E5C", 6, 42, barSettings );
		templateService:AddShortcut( 4, "0x7000F660", 6, 54, barSettings );
	end);
end

function ChampionTemplate:Tier3( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	return templateService:CreateBar( override, "Tier3", 14, 1, 2, 240, 450, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( true, false, barSettings );
		templateService:SetBuffTrigger( "Tier3", barSettings );
		templateService:SetClassRangeTrigger( CHAMPION_FERVOR, 3, 5, barSettings);
		templateService:AddShortcut( 1, "0x70003E04", 6, 14, barSettings );
		templateService:AddShortcut( 2, "0x7000F661", 6, 52, barSettings );
	end);
end

function ChampionTemplate:Tier4( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	return templateService:CreateBar( override, "Tier4", 6, 1, 4, 240, 500, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( true, false, barSettings );
		templateService:SetBuffTrigger( "Tier4", barSettings );
		templateService:SetClassRangeTrigger( CHAMPION_FERVOR, 4, 5, barSettings);
		templateService:AddShortcut( 1, "0x70003E01", 6, 6, barSettings );
		templateService:AddShortcut( 2, "0x70003E03", 6, 10, barSettings );
		templateService:AddShortcut( 3, "0x70009E5B", 6, 44, barSettings );
		templateService:AddShortcut( 4, "0x7001F4B3", 6, 62, barSettings );
	end);
end

function ChampionTemplate:Tier5( override )
	local templateService = SERVICE_CONTAINER:GetService(MyysticUI.Services.TemplateService);

	return templateService:CreateBar( override, "Tier5", 6, 1, 2, 240, 550, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( true, false, barSettings );
		templateService:SetBuffTrigger( "Tier5", barSettings );
		templateService:SetClassRangeTrigger( CHAMPION_FERVOR, 5, 5, barSettings);
		templateService:AddShortcut( 1, "0x70003E0D", 6, 34, barSettings );
		templateService:AddShortcut( 2, "0x7000F70C", 6, 58, barSettings );
	end);
end