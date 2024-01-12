-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

PotionsTemplate = class();

function PotionsTemplate:Constructor()
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	templateService:RegisterBarCreator( "Athelas", "Athelas", self.Health, true );
	templateService:RegisterBarCreator( "Celebrant", "Celebrant", self.Power, true );
	templateService:RegisterBarCreator( "Draughts/Salves", "Draughts/Salves", self.GeneralEffects, true );
	templateService:ConstructBars();
end

function PotionsTemplate:Health()
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar( "Athelas", 1, 4, 300, 250, TABBED_INV_BAR, function(localBarSettings)
		templateService:SetTrigger( templateService.HEALTH, 30, localBarSettings );
		templateService:SetInventoryFilter( "Athelas", localBarSettings );
	end);
end

function PotionsTemplate:Power()
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar( "Celebrant", 1, 4, 300, 350, TABBED_INV_BAR, function(localBarSettings)
		templateService:SetTrigger( templateService.POWER, 30, localBarSettings );
		templateService:SetInventoryFilter( "Celebrant", localBarSettings );
	end);
end

function PotionsTemplate:GeneralEffects()
	local templateService = SERVICE_CONTAINER:GetService(MysticBars.Services.TemplateService);

	return templateService:CreateBar( "Draughts/Salves", 1, 4, 300, 450, TABBED_INV_BAR, function(localBarSettings)
		templateService:SetBuffTriggerOptions( true, false, localBarSettings );
		templateService:SetTrigger( Turbine.Gameplay.EffectCategory.Disease, nil, localBarSettings );
		templateService:SetTrigger( Turbine.Gameplay.EffectCategory.Fear, nil, localBarSettings );
		templateService:SetTrigger( Turbine.Gameplay.EffectCategory.Poison, nil, localBarSettings );
		templateService:SetTrigger( Turbine.Gameplay.EffectCategory.Wound, nil, localBarSettings );
		templateService:SetInventoryFilter( "Salve", localBarSettings );
		templateService:SetInventoryFilter( "Draught", localBarSettings );
	end);
end
