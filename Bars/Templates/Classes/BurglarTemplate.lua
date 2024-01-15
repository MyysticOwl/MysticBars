-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

BurglarTemplate = class();

function BurglarTemplate:Constructor()
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	templateService:RegisterBarCreator( "Tier1 Skills", 	"Tier1", self.Tier1 );
	templateService:RegisterBarCreator( "Tier2 Skills", 	"Tier2", self.Tier2 );
	templateService:RegisterBarCreator( "Tier3 Skills", 	"Tier3", self.Tier3 );
	templateService:RegisterBarCreator( "Tricks", 			"Tricks", self.Tricks );
	templateService:RegisterBarCreator( "Trick Removals", 	"TrickRemovals", self.TrickRemovals );
	templateService:RegisterBarCreator( "Mischief Skills", "Mischief",	self.Mischief );
	templateService:RegisterBarCreator( "Knockdown Skills", "KnockedDown",	self.KnockedDown );
	templateService:ConstructBars();
end

function BurglarTemplate:Tier1( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar(override, "Tier1", 1, 1, 240, 300, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( true, false, barSettings );
		templateService:SetBuffTrigger( "Critical Response", barSettings );
		templateService:AddShortcut( 1, "0x70003F0B", 6, 2, barSettings );
	end );
end

function BurglarTemplate:Tier2( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar(override, "Tier2", 1, 1, 240, 350, QUICKSLOTBAR, function(barSettings)
		templateService:AddShortcut( 1, "0x70003F0C", 6, 24, barSettings );
	end );
end

function BurglarTemplate:Tier3( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar(override, "Tier3", 1, 3, 240, 400, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( true, false, barSettings );
		templateService:SetBuffTrigger( "Double Edged", barSettings );
		templateService:AddShortcut( 1, "0x7000FD86", 6, 56, barSettings );
		templateService:AddShortcut( 2, "0x7000FB71", 6, 58, barSettings );
		templateService:AddShortcut( 3, "0x7000FB73", 6, 60, barSettings );
	end );
end

function BurglarTemplate:Tricks( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar(override, "Tricks", 1, 4, 240, 450, QUICKSLOTBAR, function(barSettings)
		templateService:AddShortcut( 1, "0x700031FA", 6, 8, barSettings );
		templateService:AddShortcut( 2, "0x700031E7", 6, 16, barSettings );
		templateService:AddShortcut( 3, "0x70003200", 6, 26, barSettings );
		templateService:AddShortcut( 4, "0x70003218", 6, 38, barSettings );
	end );
end

function BurglarTemplate:TrickRemovals( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar(override, "TrickRemovals", 1, 2, 240, 500, QUICKSLOTBAR, function(barSettings)
		templateService:AddShortcut( 1, "0x70015A04", 6, 20, barSettings );
		templateService:AddShortcut( 1, "0x70015A04", 6, 52, barSettings );
		templateService:AddShortcut( 2, "0x70020DD0", 6, 64, barSettings );
	end );
end

function BurglarTemplate:Mischief( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar(override, "Mischief", 1, 2, 240, 550, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( true, false, barSettings );
		templateService:SetBuffTrigger( "Mischievous", barSettings );
		templateService:AddShortcut( 1, "0x7000D440", 6, 30, barSettings );
		templateService:AddShortcut( 2, "0x7000D441", 6, 46, barSettings );
	end );
end

function BurglarTemplate:KnockedDown( override )
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar(override, "KnockedDown", 1, 1, 240, 600, QUICKSLOTBAR, function(barSettings)
		templateService:SetBuffTriggerOptions( true, false, barSettings );
		templateService:SetBuffTrigger( "Stunned", barSettings );
		templateService:SetBuffTrigger( "Knocked Down", barSettings );
		templateService:SetBuffTrigger( "Dazed", barSettings );
		templateService:AddShortcut( 1, "0x70003F14", 6, 32, barSettings );
	end );
end