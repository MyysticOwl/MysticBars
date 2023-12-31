-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

GuardianClass = class();

function GuardianClass:Constructor()
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	configurationService:RegisterBarCreator( "Stances", 			"Stance", 		self.Stance );
	configurationService:RegisterBarCreator( "Overpower Skills", 	"Overpower",	self.Overpower );
	configurationService:RegisterBarCreator( "Parry Skills", 		"Parry",		self.Parry );
	configurationService:RegisterBarCreator( "Block Skills", 		"Block",		self.Block );
	configurationService:ConstructBars();
end

function GuardianClass:Stance( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	return configurationService:CreateBar( override, "Stance", 4, 1, 3, 240, 300, QUICKSLOTBAR, function(localBarSettings)
		configurationService:SetBuffTriggerOptions( false, false, localBarSettings );
		configurationService:SetTrigger( configurationService.CTRL, nil, localBarSettings );
		configurationService:SetBuffTrigger( "Overpower", localBarSettings );
		configurationService:SetBuffTrigger( "Guardian's Parry Stance", localBarSettings );
		configurationService:SetBuffTrigger( "Guardian's Block Stance", localBarSettings );
		configurationService:SetBGColor( 0.35, 1, 0, 0, localBarSettings );
		configurationService:AddShortcut( 1, "0x70003EDF", 6, 4, localBarSettings );
		configurationService:AddShortcut( 2, "0x7000D4B1", 6, 10, localBarSettings );
		configurationService:AddShortcut( 3, "0x70003EE3", 6, 12, localBarSettings );
	end);
end

function GuardianClass:Overpower( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	return configurationService:CreateBar( override, "Overpower", 30, 1, 2, 240, 350, QUICKSLOTBAR, function(localBarSettings)
		configurationService:SetBuffTriggerOptions( true, false, localBarSettings );
		configurationService:SetBuffTrigger( "Overpower", localBarSettings );
		configurationService:AddShortcut( 1, "0x7000D4B0", 6, 30, localBarSettings );
		configurationService:AddShortcut( 2, "0x7000D4B3", 6, 46, localBarSettings );
	end);
end

function GuardianClass:Parry( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	return configurationService:CreateBar( override, "Parry", 8, 1, 4, 240, 400, QUICKSLOTBAR, function(localBarSettings)
		configurationService:SetBuffTriggerOptions( true, false, localBarSettings );
		configurationService:SetBuffTrigger( "Parry Response", localBarSettings );
		configurationService:SetBuffTrigger( "Retaliation", localBarSettings );
		configurationService:AddShortcut( 1, "0x70003EE0", 6, 8, localBarSettings );
		configurationService:AddShortcut( 2, "0x70003EE2", 6, 8, localBarSettings );
		configurationService:AddShortcut( 3, "0x70003EE4", 6, 14, localBarSettings );
		configurationService:AddShortcut( 4, "0x70003EE5", 6, 18, localBarSettings );
	end);
end

function GuardianClass:Block( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	return configurationService:CreateBar( override, "Block", 2, 1, 4, 240, 450, QUICKSLOTBAR, function(localBarSettings)
		configurationService:SetBuffTriggerOptions( true, false, localBarSettings );
		configurationService:SetBuffTrigger( "Block Response", localBarSettings );
		configurationService:AddShortcut( 1, "0x7000305D", 6, 2, localBarSettings );
		configurationService:AddShortcut( 2, "0x70003EE1", 6, 10, localBarSettings );
		configurationService:AddShortcut( 3, "0x7000307D", 6, 16, localBarSettings );
		configurationService:AddShortcut( 4, "0x70003EE6", 6, 22, localBarSettings  );
	end);
end