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

	configurationService:CreateBar( override, "Athelas", 1, 1, 4, 300, 250, TABBED_INV_BAR );
	configurationService:SetTrigger( configurationService.HEALTH, 30 );
	configurationService:SetInventoryFilter( "Athelas" );
end

function Potions:Power( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	configurationService:CreateBar( override, "Celebrant", 1, 1, 4, 300, 350, TABBED_INV_BAR );
	configurationService:SetTrigger( configurationService.POWER, 30 );
	configurationService:SetInventoryFilter( "Celebrant" );
end

function Potions:GeneralEffects( override )
	local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);

	configurationService:CreateBar( override, "Draughts/Salves", 1, 1, 4, 300, 450, TABBED_INV_BAR );
	configurationService:SetBuffTriggerOptions( true, false );
	configurationService:SetTrigger( Turbine.Gameplay.EffectCategory.Disease );
	configurationService:SetTrigger( Turbine.Gameplay.EffectCategory.Fear );
	configurationService:SetTrigger( Turbine.Gameplay.EffectCategory.Poison );
	configurationService:SetTrigger( Turbine.Gameplay.EffectCategory.Wound );	
	configurationService:SetInventoryFilter( "Salve" );
	configurationService:SetInventoryFilter( "Draught" );
end
