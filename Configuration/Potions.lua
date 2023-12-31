-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

Potions = class();

function Potions:Constructor()
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	configurationService:RegisterBarCreator( "Athelas", "Athelas", self.Health, true );
	configurationService:RegisterBarCreator( "Celebrant", "Celebrant", self.Power, true );
	configurationService:RegisterBarCreator( "Draughts/Salves", "Draughts/Salves", self.GeneralEffects, true );
	configurationService:ConstructBars();
end

function Potions:Health( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	return configurationService:CreateBar( override, "Athelas", 1, 1, 4, 300, 250, TABBED_INV_BAR, function(localBarSettings)
		configurationService:SetTrigger( configurationService.HEALTH, 30, localBarSettings );
		configurationService:SetInventoryFilter( "Athelas", localBarSettings );
	end);
end

function Potions:Power( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	return configurationService:CreateBar( override, "Celebrant", 1, 1, 4, 300, 350, TABBED_INV_BAR, function(localBarSettings)
		configurationService:SetTrigger( configurationService.POWER, 30, localBarSettings );
		configurationService:SetInventoryFilter( "Celebrant", localBarSettings );
	end);
end

function Potions:GeneralEffects( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	return configurationService:CreateBar( override, "Draughts/Salves", 1, 1, 4, 300, 450, TABBED_INV_BAR, function(localBarSettings)
		configurationService:SetBuffTriggerOptions( true, false, localBarSettings );
		configurationService:SetTrigger( Turbine.Gameplay.EffectCategory.Disease, nil, localBarSettings );
		configurationService:SetTrigger( Turbine.Gameplay.EffectCategory.Fear, nil, localBarSettings );
		configurationService:SetTrigger( Turbine.Gameplay.EffectCategory.Poison, nil, localBarSettings );
		configurationService:SetTrigger( Turbine.Gameplay.EffectCategory.Wound, nil, localBarSettings );	
		configurationService:SetInventoryFilter( "Salve", localBarSettings );
		configurationService:SetInventoryFilter( "Draught", localBarSettings );
	end);
end
