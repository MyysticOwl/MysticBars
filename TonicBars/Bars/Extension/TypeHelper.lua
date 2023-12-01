import "Turbine";
import "Turbine.UI";

TypeHelper = class();

function TypeHelper:GetNewHunterTravelSettings( extensionBarId, quickslotList )
	local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings( extensionBarId );

	barSettings.quickslotCount = 15;
	barSettings.barName = "Hunter Travel";
	
	self:MakeSettingsQuickslot( barSettings.quickslots[1], "0x7000A2C1" );
	self:MakeSettingsQuickslot( barSettings.quickslots[2], "0x70003F42" );
	self:MakeSettingsQuickslot( barSettings.quickslots[3], "0x70003F41" );
	self:MakeSettingsQuickslot( barSettings.quickslots[4], "0x7000A2C3" );
	self:MakeSettingsQuickslot( barSettings.quickslots[5], "0x7000A2C6" );
	self:MakeSettingsQuickslot( barSettings.quickslots[6], "0x70017C81" );
	self:MakeSettingsQuickslot( barSettings.quickslots[7], "0x70003F43" );
	self:MakeSettingsQuickslot( barSettings.quickslots[8], "0x7000A2C4" );
	self:MakeSettingsQuickslot( barSettings.quickslots[9], "0x700235EF" );
	self:MakeSettingsQuickslot( barSettings.quickslots[10], "0x7001F459" );
	self:MakeSettingsQuickslot( barSettings.quickslots[11], "0x7000A2C2" );
	self:MakeSettingsQuickslot( barSettings.quickslots[12], "0x70003F44" );
	self:MakeSettingsQuickslot( barSettings.quickslots[13], "0x70017C82" );
	self:MakeSettingsQuickslot( barSettings.quickslots[14], "0x7000A2C5" );
	self:MakeSettingsQuickslot( barSettings.quickslots[15], "0x70017C7A" );
	settingsService:SetBarSettings( extensionBarId, barSettings );
	
	self:MakeQuickslot( quickslotList.quickslots[1], "0x7000A2C1" );
	self:MakeQuickslot( quickslotList.quickslots[2],  "0x70003F42" );
	self:MakeQuickslot( quickslotList.quickslots[3],  "0x70003F41" );
	self:MakeQuickslot( quickslotList.quickslots[4],  "0x7000A2C3" );
	self:MakeQuickslot( quickslotList.quickslots[5],  "0x7000A2C6" );
	self:MakeQuickslot( quickslotList.quickslots[6],  "0x70017C81" );
	self:MakeQuickslot( quickslotList.quickslots[7],  "0x70003F43" );
	self:MakeQuickslot( quickslotList.quickslots[8],  "0x7000A2C4" );
	self:MakeQuickslot( quickslotList.quickslots[9],  "0x700235EF" );
	self:MakeQuickslot( quickslotList.quickslots[10],  "0x7001F459" );
	self:MakeQuickslot( quickslotList.quickslots[11],  "0x7000A2C2" );
	self:MakeQuickslot( quickslotList.quickslots[12],  "0x70003F44" );
	self:MakeQuickslot( quickslotList.quickslots[13],  "0x70017C82" );
	self:MakeQuickslot( quickslotList.quickslots[14],  "0x7000A2C5" );
	self:MakeQuickslot( quickslotList.quickslots[15],  "0x70017C7A" );
end

function TypeHelper:GetNewWardenTravelSettings( extensionBarId, quickslotList )
	local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings( extensionBarId );

	barSettings.quickslotCount = 8;
	barSettings.barName = "Warden Travel";
	
	self:MakeSettingsQuickslot( barSettings.quickslots[1], "0x70014786" );	-- Muster in Ost Guruth
	self:MakeSettingsQuickslot( barSettings.quickslots[2], "0x70014798" );  -- Muster in Esteld�n
	self:MakeSettingsQuickslot( barSettings.quickslots[3], "0x7001478E" );  -- Muster in Evendim
	self:MakeSettingsQuickslot( barSettings.quickslots[4], "0x700235EB" );  -- Muster in Harndirion 
	self:MakeSettingsQuickslot( barSettings.quickslots[5], "0x7001F45C" );  -- Muster in Mirk-Eaves
	self:MakeSettingsQuickslot( barSettings.quickslots[6], "0x70014791" );  -- Muster in Rivendell
	self:MakeSettingsQuickslot( barSettings.quickslots[7], "0x700237D4" );  -- Muster in S�ri-Kyl�
	self:MakeSettingsQuickslot( barSettings.quickslots[8], "0x7001819E" );  -- Muster in Twenty-First Hall
	settingsService:SetBarSettings( extensionBarId, barSettings );

	self:MakeQuickslot( quickslotList.quickslots[1], "0x70014786" );	-- Muster in Ost Guruth
	self:MakeQuickslot( quickslotList.quickslots[2], "0x70014798" );  -- Muster in Esteld�n
	self:MakeQuickslot( quickslotList.quickslots[3], "0x7001478E" );  -- Muster in Evendim
	self:MakeQuickslot( quickslotList.quickslots[4], "0x700235EB" );  -- Muster in Harndirion 
	self:MakeQuickslot( quickslotList.quickslots[5], "0x7001F45C" );  -- Muster in Mirk-Eaves
	self:MakeQuickslot( quickslotList.quickslots[6], "0x70014791" );  -- Muster in Rivendell
	self:MakeQuickslot( quickslotList.quickslots[7], "0x700237D4" );  -- Muster in S�ri-Kyl�
	self:MakeQuickslot( quickslotList.quickslots[8], "0x7001819E" );  -- Muster in Twenty-First Hall
end

function TypeHelper:GetNewHousingTravelSettings( extensionBarId, quickslotList )
	local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings( extensionBarId );

	barSettings.quickslotCount = 2;
	barSettings.barName = "Housing Travel";
	
	self:MakeSettingsQuickslot( barSettings.quickslots[1], "0x7000D046" );  -- House
	self:MakeSettingsQuickslot( barSettings.quickslots[2], "0x7000D047" );  -- Kin
	settingsService:SetBarSettings( extensionBarId, barSettings );

	self:MakeQuickslot( quickslotList.quickslots[1], "0x7000D046" );  -- House
	self:MakeQuickslot( quickslotList.quickslots[2], "0x7000D047" );  -- Kin
end

function TypeHelper:GetNewReputationTravelSettings( extensionBarId, quickslotList )
	local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings( extensionBarId );

	barSettings.quickslotCount = 7;
	barSettings.barName = "Housing Travel";
	
	self:MakeSettingsQuickslot( barSettings.quickslots[1], "0x7001BF90" );  -- Return to Bree
	self:MakeSettingsQuickslot( barSettings.quickslots[2], "0x70021FA2" );  -- Return to Return to Enedwaith
	self:MakeSettingsQuickslot( barSettings.quickslots[3], "0x7001F374" );  -- Return to Mirkwood
	self:MakeSettingsQuickslot( barSettings.quickslots[4], "0x70020441" );  -- Return to Return to Ost Guruth
	self:MakeSettingsQuickslot( barSettings.quickslots[5], "0x70023263" );  -- Return to Rivendell
	self:MakeSettingsQuickslot( barSettings.quickslots[6], "0x70023262" );  -- Return to Shire
	self:MakeSettingsQuickslot( barSettings.quickslots[7], "0x7001BF91" );  -- Return to Thorin's
	settingsService:SetBarSettings( extensionBarId, barSettings );

	self:MakeQuickslot( quickslotList.quickslots[1], "0x7001BF90" );  -- Return to Bree
	self:MakeQuickslot( quickslotList.quickslots[2], "0x70021FA2" );  -- Return to Return to Enedwaith
	self:MakeQuickslot( quickslotList.quickslots[3], "0x7001F374" );  -- Return to Mirkwood
	self:MakeQuickslot( quickslotList.quickslots[4], "0x70020441" );  -- Return to Return to Ost Guruth
	self:MakeQuickslot( quickslotList.quickslots[5], "0x70023263" );  -- Return to Rivendell
	self:MakeQuickslot( quickslotList.quickslots[6], "0x70023262" );  -- Return to Shire
	self:MakeQuickslot( quickslotList.quickslots[7], "0x7001BF91" );  -- Return to Thorin's
end

function TypeHelper:GetNewLMCombatPetsSettings( extensionBarId, quickslotList )
	local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings( extensionBarId );

	barSettings.quickslotCount = 6;
	barSettings.barName = "LM Combat Pets";
	
	self:MakeSettingsQuickslot( barSettings.quickslots[1], "0x70003EB5" );  -- Raven
	self:MakeSettingsQuickslot( barSettings.quickslots[2], "0x70003EB8" );  -- Bear
	self:MakeSettingsQuickslot( barSettings.quickslots[3], "0x7000B8D3" );  -- Lynx
	self:MakeSettingsQuickslot( barSettings.quickslots[4], "0x70000FB2" );  -- Eagle
	self:MakeSettingsQuickslot( barSettings.quickslots[5], "0x7000F530" );  -- Saber Tooth
	self:MakeSettingsQuickslot( barSettings.quickslots[6], "0x7000F54D" );  -- Bog Guardian
	settingsService:SetBarSettings( extensionBarId, barSettings );

	
	self:MakeQuickslot( quickslotList.quickslots[1], "0x70003EB5" );  -- Raven
	self:MakeQuickslot( quickslotList.quickslots[2], "0x70003EB8" );  -- Bear
	self:MakeQuickslot( quickslotList.quickslots[3], "0x7000B8D3" );  -- Lynx
	self:MakeQuickslot( quickslotList.quickslots[4], "0x70000FB2" );  -- Eagle
	self:MakeQuickslot( quickslotList.quickslots[5], "0x7000F530" );  -- Saber Tooth
	self:MakeQuickslot( quickslotList.quickslots[6], "0x7000F54D" );  -- Bog Guardian
end

function TypeHelper:GetNewLMCosmeticPetsSettings( extensionBarId, quickslotList )
	local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings( extensionBarId );

	barSettings.quickslotCount = 9;
	barSettings.barName = "LM Cosmetic Pets";
	
	self:MakeSettingsQuickslot( barSettings.quickslots[1], "0x7000BF8E" );  -- Turtle
	self:MakeSettingsQuickslot( barSettings.quickslots[2], "0x7000BF72" );  -- Bird
	self:MakeSettingsQuickslot( barSettings.quickslots[3], "0x7000BF73" );  -- Cat
	self:MakeSettingsQuickslot( barSettings.quickslots[4], "0x7000BF74" );  -- Dog
	self:MakeSettingsQuickslot( barSettings.quickslots[5], "0x7000BF75" );  -- Fox
	self:MakeSettingsQuickslot( barSettings.quickslots[6], "0x7000BF76" );  -- Frog
	self:MakeSettingsQuickslot( barSettings.quickslots[7], "0x7000BF77" );  -- Rabbit
	self:MakeSettingsQuickslot( barSettings.quickslots[8], "0x7000BF78" );  -- Snake
	self:MakeSettingsQuickslot( barSettings.quickslots[9], "0x7000BF79" );  -- Squirrel

	settingsService:SetBarSettings( extensionBarId, barSettings );

	self:MakeQuickslot( quickslotList.quickslots[1], "0x7000BF8E" );  -- Turtle
	self:MakeQuickslot( quickslotList.quickslots[2], "0x7000BF72" );  -- Bird
	self:MakeQuickslot( quickslotList.quickslots[3], "0x7000BF73" );  -- Cat
	self:MakeQuickslot( quickslotList.quickslots[4], "0x7000BF74" );  -- Dog
	self:MakeQuickslot( quickslotList.quickslots[5], "0x7000BF75" );  -- Fox
	self:MakeQuickslot( quickslotList.quickslots[6], "0x7000BF76" );  -- Frog
	self:MakeQuickslot( quickslotList.quickslots[7], "0x7000BF77" );  -- Rabbit
	self:MakeQuickslot( quickslotList.quickslots[8], "0x7000BF78" );  -- Snake
	self:MakeQuickslot( quickslotList.quickslots[9], "0x7000BF79" );  -- Squirrel
end

function TypeHelper:MakeSettingsQuickslot( storedQuickslot, data )
	storedQuickslot = {};
	storedQuickslot.Type = 6;
	storedQuickslot.Data = data;
end

function TypeHelper:MakeQuickslot( actualQuickslot, data )
	local shortcut = Turbine.UI.Lotro.Shortcut( 6, data );
	actualQuickslot:SetShortcut( shortcut );
end

function TypeHelper:GetNewHorsesSettings( extensionBarId, quickslotList )
	local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings( extensionBarId );

	barSettings.quickslotCount = 15;
	barSettings.barName = "Horses";
	
	self:MakeSettingsQuickslot( barSettings.quickslots[1],  "0x70022C61" );
	self:MakeSettingsQuickslot( barSettings.quickslots[2],  "0x7001B4D9" );
	self:MakeSettingsQuickslot( barSettings.quickslots[3],  "0x7001B4B8" );
	self:MakeSettingsQuickslot( barSettings.quickslots[4],  "0x7001B4D0" );
	self:MakeSettingsQuickslot( barSettings.quickslots[5],  "0x7001B4D3" );
	self:MakeSettingsQuickslot( barSettings.quickslots[6],  "0x7001E980" );
	self:MakeSettingsQuickslot( barSettings.quickslots[7],  "0x7001B4C4" );
	self:MakeSettingsQuickslot( barSettings.quickslots[8],  "0x7001E981" );
	self:MakeSettingsQuickslot( barSettings.quickslots[9],  "0x7001B4AC" );
	self:MakeSettingsQuickslot( barSettings.quickslots[10],  "0x7002054D" );
	self:MakeSettingsQuickslot( barSettings.quickslots[11],  "0x7001CF5D" );
	self:MakeSettingsQuickslot( barSettings.quickslots[12],  "0x7001E97D" );
	self:MakeSettingsQuickslot( barSettings.quickslots[13],  "0x7001E97A" );
	self:MakeSettingsQuickslot( barSettings.quickslots[14],  "0x7001B4B1" );
	self:MakeSettingsQuickslot( barSettings.quickslots[15],  "0x70022C73" );

	settingsService:SetBarSettings( extensionBarId, barSettings );
	
	self:MakeQuickslot( quickslotList.quickslots[1],  "0x70022C61" );
	self:MakeQuickslot( quickslotList.quickslots[2],  "0x7001B4D9" );
	self:MakeQuickslot( quickslotList.quickslots[3],  "0x7001B4B8" );
	self:MakeQuickslot( quickslotList.quickslots[4],  "0x7001B4D0" );
	self:MakeQuickslot( quickslotList.quickslots[5],  "0x7001B4D3" );
	self:MakeQuickslot( quickslotList.quickslots[6],  "0x7001E980" );
	self:MakeQuickslot( quickslotList.quickslots[7],  "0x7001B4C4" );
	self:MakeQuickslot( quickslotList.quickslots[8],  "0x7001E981" );
	self:MakeQuickslot( quickslotList.quickslots[9],  "0x7001B4AC" );
	self:MakeQuickslot( quickslotList.quickslots[10],  "0x7002054D" );
	self:MakeQuickslot( quickslotList.quickslots[11],  "0x7001CF5D" );
	self:MakeQuickslot( quickslotList.quickslots[12],  "0x7001E97D" );
	self:MakeQuickslot( quickslotList.quickslots[13],  "0x7001E97A" );
	self:MakeQuickslot( quickslotList.quickslots[14],  "0x7001B4B1" );
	self:MakeQuickslot( quickslotList.quickslots[15],  "0x70022C73" );
end
function TypeHelper:GetFesHorsesSettings( extensionBarId, quickslotList )
	local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings( extensionBarId );

	barSettings.quickslotCount = 17;
	barSettings.barName = "Horses2";
	
	self:MakeSettingsQuickslot( barSettings.quickslots[1],  "0x7001E8EE" );
	self:MakeSettingsQuickslot( barSettings.quickslots[2],  "0x70020550" );
	self:MakeSettingsQuickslot( barSettings.quickslots[3],  "0x7001B4C9" );
	self:MakeSettingsQuickslot( barSettings.quickslots[4],  "0x700216F9" );
	self:MakeSettingsQuickslot( barSettings.quickslots[5],  "0x7001CEAA" );
	self:MakeSettingsQuickslot( barSettings.quickslots[6],  "0x7001B4C0" );
	self:MakeSettingsQuickslot( barSettings.quickslots[7],  "0x7001B4B0" );
	self:MakeSettingsQuickslot( barSettings.quickslots[8],  "0x7001B4A8" );
	self:MakeSettingsQuickslot( barSettings.quickslots[9],  "0x7001B4B7" );
	self:MakeSettingsQuickslot( barSettings.quickslots[10],  "0x7001B4C7" );
	self:MakeSettingsQuickslot( barSettings.quickslots[11],  "0x7001B4C5" );
	self:MakeSettingsQuickslot( barSettings.quickslots[12],  "0x7001E8ED" );
	self:MakeSettingsQuickslot( barSettings.quickslots[13],  "0x7002353F" );
	self:MakeSettingsQuickslot( barSettings.quickslots[14],  "0x7002353E" );

	self:MakeSettingsQuickslot( barSettings.quickslots[15],  "0x7001B4C1" );
	self:MakeSettingsQuickslot( barSettings.quickslots[16],  "0x7001B4B4" );
	self:MakeSettingsQuickslot( barSettings.quickslots[17],  "0x7001BFFE" );
--	self:MakeSettingsQuickslot( barSettings.quickslots[18],  "0x7001B4C2" );

	settingsService:SetBarSettings( extensionBarId, barSettings );

	self:MakeQuickslot( quickslotList.quickslots[1],  "0x7001E8EE" );
	self:MakeQuickslot( quickslotList.quickslots[2],  "0x70020550" );
	self:MakeQuickslot( quickslotList.quickslots[3],  "0x7001B4C9" );
	self:MakeQuickslot( quickslotList.quickslots[4],  "0x700216F9" );
	self:MakeQuickslot( quickslotList.quickslots[5],  "0x7001CEAA" );
	self:MakeQuickslot( quickslotList.quickslots[6],  "0x7001B4C0" );
	self:MakeQuickslot( quickslotList.quickslots[7],  "0x7001B4B0" );
	self:MakeQuickslot( quickslotList.quickslots[8],  "0x7001B4A8" );
	self:MakeQuickslot( quickslotList.quickslots[9],  "0x7001B4B7" );
	self:MakeQuickslot( quickslotList.quickslots[10],  "0x7001B4C7" );
	self:MakeQuickslot( quickslotList.quickslots[11],  "0x7001B4C5" );
	self:MakeQuickslot( quickslotList.quickslots[12],  "0x7001E8ED" );
	self:MakeQuickslot( quickslotList.quickslots[13],  "0x7002353F" );
	self:MakeQuickslot( quickslotList.quickslots[14],  "0x7002353E" );

	self:MakeQuickslot( quickslotList.quickslots[15],  "0x7001B4C1" );
	self:MakeQuickslot( quickslotList.quickslots[16],  "0x7001B4B4" );
	self:MakeQuickslot( quickslotList.quickslots[17],  "0x7001BFFE" );
--	self:MakeQuickslot( quickslotList.quickslots[18],  "0x7001B4C2" );
end

function TypeHelper:GetNewPoniesSettings( extensionBarId, quickslotList )
	local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings( extensionBarId );

	barSettings.quickslotCount = 15;
	barSettings.barName = "Ponies";
	
	self:MakeSettingsQuickslot( barSettings.quickslots[1],  "0x70022C6C" );
	self:MakeSettingsQuickslot( barSettings.quickslots[2],  "0x7001B4DA" );
	self:MakeSettingsQuickslot( barSettings.quickslots[3],  "0x7001B4C6" );
	self:MakeSettingsQuickslot( barSettings.quickslots[4],  "0x7001B809" );
	self:MakeSettingsQuickslot( barSettings.quickslots[5],  "0x7001B4C8" );
	self:MakeSettingsQuickslot( barSettings.quickslots[6],  "0x7001E97F" );
	self:MakeSettingsQuickslot( barSettings.quickslots[7],  "0x7001B4CF" );
	self:MakeSettingsQuickslot( barSettings.quickslots[8],  "0x7001E97C" );
	self:MakeSettingsQuickslot( barSettings.quickslots[9],  "0x7001B4D4" );
	self:MakeSettingsQuickslot( barSettings.quickslots[10],  "0x7002054F" );
	self:MakeSettingsQuickslot( barSettings.quickslots[11],  "0x7001CF5E" );
	self:MakeSettingsQuickslot( barSettings.quickslots[12],  "0x7001E97B" );
	self:MakeSettingsQuickslot( barSettings.quickslots[13],  "0x7001E97E" );
	self:MakeSettingsQuickslot( barSettings.quickslots[14],  "0x7001B4AA" );
	self:MakeSettingsQuickslot( barSettings.quickslots[15],  "0x70022C73" );

	settingsService:SetBarSettings( extensionBarId, barSettings );
	
	self:MakeQuickslot( quickslotList.quickslots[1],  "0x70022C6C" );
	self:MakeQuickslot( quickslotList.quickslots[2],  "0x7001B4DA" );
	self:MakeQuickslot( quickslotList.quickslots[3],  "0x7001B4C6" );
	self:MakeQuickslot( quickslotList.quickslots[4],  "0x7001B809" );
	self:MakeQuickslot( quickslotList.quickslots[5],  "0x7001B4C8" );
	self:MakeQuickslot( quickslotList.quickslots[6],  "0x7001E97F" );
	self:MakeQuickslot( quickslotList.quickslots[7],  "0x7001B4CF" );
	self:MakeQuickslot( quickslotList.quickslots[8],  "0x7001E97C" );
	self:MakeQuickslot( quickslotList.quickslots[9],  "0x7001B4D4" );
	self:MakeQuickslot( quickslotList.quickslots[10],  "0x7002054F" );
	self:MakeQuickslot( quickslotList.quickslots[11],  "0x7001CF5E" );
	self:MakeQuickslot( quickslotList.quickslots[12],  "0x7001E97B" );
	self:MakeQuickslot( quickslotList.quickslots[13],  "0x7001E97E" );
	self:MakeQuickslot( quickslotList.quickslots[14],  "0x7001B4AA" );
	self:MakeQuickslot( quickslotList.quickslots[15],  "0x70022C73" );
end

function TypeHelper:GetFesPoniesSettings( extensionBarId, quickslotList )
	local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings( extensionBarId );

	barSettings.quickslotCount = 18;
	barSettings.barName = "Ponies2";
	
	self:MakeSettingsQuickslot( barSettings.quickslots[1],  "0x7001E8F0" );
	self:MakeSettingsQuickslot( barSettings.quickslots[2],  "0x70020551" );
	self:MakeSettingsQuickslot( barSettings.quickslots[3],  "0x7001B4BE" );
	self:MakeSettingsQuickslot( barSettings.quickslots[4],  "0x700216FA" );
	self:MakeSettingsQuickslot( barSettings.quickslots[5],  "0x7001CEA9" );
	self:MakeSettingsQuickslot( barSettings.quickslots[6],  "0x7001B4D7" );
	self:MakeSettingsQuickslot( barSettings.quickslots[7],  "0x7001B4B2" );
	self:MakeSettingsQuickslot( barSettings.quickslots[8],  "0x7001B4CB" );
	self:MakeSettingsQuickslot( barSettings.quickslots[9],  "0x7001B4B9" );
	self:MakeSettingsQuickslot( barSettings.quickslots[10],  "0x7001B4D2" );
	self:MakeSettingsQuickslot( barSettings.quickslots[11],  "0x7001B4BD" );
	self:MakeSettingsQuickslot( barSettings.quickslots[12],  "0x7001E8EF" );
	self:MakeSettingsQuickslot( barSettings.quickslots[13],  "0x70023540" );
	self:MakeSettingsQuickslot( barSettings.quickslots[14],  "0x7002353E" );

	self:MakeSettingsQuickslot( barSettings.quickslots[15],  "0x7001B4D8" );
	self:MakeSettingsQuickslot( barSettings.quickslots[16],  "0x7001B4B4" );
	self:MakeSettingsQuickslot( barSettings.quickslots[17],  "0x7001BFFE" );
	self:MakeSettingsQuickslot( barSettings.quickslots[18],  "0x7001B4C2" );

	settingsService:SetBarSettings( extensionBarId, barSettings );

	self:MakeQuickslot( quickslotList.quickslots[1],  "0x7001E8F0" );
	self:MakeQuickslot( quickslotList.quickslots[2],  "0x70020551" );
	self:MakeQuickslot( quickslotList.quickslots[3],  "0x7001B4BE" );
	self:MakeQuickslot( quickslotList.quickslots[4],  "0x700216FA" );
	self:MakeQuickslot( quickslotList.quickslots[5],  "0x7001CEA9" );
	self:MakeQuickslot( quickslotList.quickslots[6],  "0x7001B4D7" );
	self:MakeQuickslot( quickslotList.quickslots[7],  "0x7001B4B2" );
	self:MakeQuickslot( quickslotList.quickslots[8],  "0x7001B4CB" );
	self:MakeQuickslot( quickslotList.quickslots[9],  "0x7001B4B9" );
	self:MakeQuickslot( quickslotList.quickslots[10],  "0x7001B4D2" );
	self:MakeQuickslot( quickslotList.quickslots[11],  "0x7001B4BD" );
	self:MakeQuickslot( quickslotList.quickslots[12],  "0x7001E8EF" );
	self:MakeQuickslot( quickslotList.quickslots[13],  "0x70023540" );
	self:MakeQuickslot( quickslotList.quickslots[14],  "0x7002353E" );

	self:MakeQuickslot( quickslotList.quickslots[15],  "0x7001B4D8" );
	self:MakeQuickslot( quickslotList.quickslots[16],  "0x7001B4B4" );
	self:MakeQuickslot( quickslotList.quickslots[17],  "0x7001BFFE" );
	self:MakeQuickslot( quickslotList.quickslots[18],  "0x7001B4C2" );
end

function TypeHelper:GetNewMentorSettings( extensionBarId, quickslotList )
	local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings( extensionBarId );

	barSettings.quickslotCount = 9;
	barSettings.barName = "Instruments";
	
	self:MakeSettingsQuickslot( barSettings.quickslots[1],  "0x7000C787" );
	self:MakeSettingsQuickslot( barSettings.quickslots[2],  "0x7000C789" );
	self:MakeSettingsQuickslot( barSettings.quickslots[3],  "0x7000C78A" );
	self:MakeSettingsQuickslot( barSettings.quickslots[4],  "0x7000C6C8" );
	self:MakeSettingsQuickslot( barSettings.quickslots[5],  "0x7000C78B" );
	self:MakeSettingsQuickslot( barSettings.quickslots[6],  "0x7000C78D" );
	self:MakeSettingsQuickslot( barSettings.quickslots[7],  "0x7000C786" );
	self:MakeSettingsQuickslot( barSettings.quickslots[8],  "0x7000C788" );
	self:MakeSettingsQuickslot( barSettings.quickslots[9],  "0x7000C78C" );
	settingsService:SetBarSettings( extensionBarId, barSettings );
	
	self:MakeQuickslot( quickslotList.quickslots[1],  "0x7000C787" );
	self:MakeQuickslot( quickslotList.quickslots[2],  "0x7000C789" );
	self:MakeQuickslot( quickslotList.quickslots[3],  "0x7000C78A" );
	self:MakeQuickslot( quickslotList.quickslots[4],  "0x7000C6C8" );
	self:MakeQuickslot( quickslotList.quickslots[5],  "0x7000C78B" );
	self:MakeQuickslot( quickslotList.quickslots[6],  "0x7000C78D" );
	self:MakeQuickslot( quickslotList.quickslots[7],  "0x7000C786" );
	self:MakeQuickslot( quickslotList.quickslots[8],  "0x7000C788" );
	self:MakeQuickslot( quickslotList.quickslots[9],  "0x7000C78C" );
end

function TypeHelper:GetNewMinstrelDpsSettings( extensionBarId, quickslotList )
	local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings( extensionBarId );

	barSettings.quickslotCount = 10;
	barSettings.barName = "Minstrel DPS";
	
	self:MakeSettingsQuickslot( barSettings.quickslots[1],  "0x7000B697" );
	self:MakeSettingsQuickslot( barSettings.quickslots[2],  "0x700031A8" );
	self:MakeSettingsQuickslot( barSettings.quickslots[3],  "0x7000B69A" );
	self:MakeSettingsQuickslot( barSettings.quickslots[4],  "0x70003E7D" );
	self:MakeSettingsQuickslot( barSettings.quickslots[5],  "0x7000B69B" );
	self:MakeSettingsQuickslot( barSettings.quickslots[6],  "0x7000F250" );
	self:MakeSettingsQuickslot( barSettings.quickslots[7],  "0x70003E83" );
	self:MakeSettingsQuickslot( barSettings.quickslots[8],  "0x7000317F" );
	self:MakeSettingsQuickslot( barSettings.quickslots[9],  "0x70003E80" );
	self:MakeSettingsQuickslot( barSettings.quickslots[10], "0x70003184" );
	settingsService:SetBarSettings( extensionBarId, barSettings );
	
	self:MakeQuickslot( quickslotList.quickslots[1],  "0x7000B697" );
	self:MakeQuickslot( quickslotList.quickslots[2],  "0x700031A8" );
	self:MakeQuickslot( quickslotList.quickslots[3],  "0x7000B69A" );
	self:MakeQuickslot( quickslotList.quickslots[4],  "0x70003E7D" );
	self:MakeQuickslot( quickslotList.quickslots[5],  "0x7000B69B" );
	self:MakeQuickslot( quickslotList.quickslots[6],  "0x7000F250" );
	self:MakeQuickslot( quickslotList.quickslots[7],  "0x70003E83" );
	self:MakeQuickslot( quickslotList.quickslots[8],  "0x7000317F" );
	self:MakeQuickslot( quickslotList.quickslots[9],  "0x70003E80" );
	self:MakeQuickslot( quickslotList.quickslots[10], "0x70003184" );
end

function TypeHelper:GetNewCaptainPetsSettings( extensionBarId, quickslotList )
	local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings( extensionBarId );

	barSettings.quickslotCount = 4;
	barSettings.barName = "Captain pets";
	
	self:MakeSettingsQuickslot( barSettings.quickslots[1],  "0x7000FC78" );
	self:MakeSettingsQuickslot( barSettings.quickslots[2],  "0x70002FAF" );
	self:MakeSettingsQuickslot( barSettings.quickslots[3],  "0x70002F1A" );
	self:MakeSettingsQuickslot( barSettings.quickslots[4],  "0x70002F7A" );

	settingsService:SetBarSettings( extensionBarId, barSettings );
	
	self:MakeQuickslot( quickslotList.quickslots[1],  "0x7000FC78" );
	self:MakeQuickslot( quickslotList.quickslots[2],  "0x70002FAF" );
	self:MakeQuickslot( quickslotList.quickslots[3],  "0x70002F1A" );
	self:MakeQuickslot( quickslotList.quickslots[4],  "0x70002F7A" );
end

function TypeHelper:GetNewChampionDpsSettings( extensionBarId, quickslotList )
	local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings( extensionBarId );

	barSettings.quickslotCount = 9;
	barSettings.barName = "Champion DPS";
	
	self:MakeSettingsQuickslot( barSettings.quickslots[1],  "0x70003E83" );
	self:MakeSettingsQuickslot( barSettings.quickslots[2],  "0x7000B697" );
	self:MakeSettingsQuickslot( barSettings.quickslots[3],  "0x700031A8" );
	self:MakeSettingsQuickslot( barSettings.quickslots[4],  "0x70003E7D" );
	self:MakeSettingsQuickslot( barSettings.quickslots[5],  "0x7000317F" );
	self:MakeSettingsQuickslot( barSettings.quickslots[6],  "0x70003E80" );
	self:MakeSettingsQuickslot( barSettings.quickslots[7],  "0x7000B69B" );
	self:MakeSettingsQuickslot( barSettings.quickslots[8],  "0x70003184" );
	self:MakeSettingsQuickslot( barSettings.quickslots[9],  "0x7000B69A" );
	settingsService:SetBarSettings( extensionBarId, barSettings );
	
	self:MakeQuickslot( quickslotList.quickslots[1],  "0x70003E83" );
	self:MakeQuickslot( quickslotList.quickslots[2],  "0x7000B697" );
	self:MakeQuickslot( quickslotList.quickslots[3],  "0x700031A8" );
	self:MakeQuickslot( quickslotList.quickslots[4],  "0x70003E7D" );
	self:MakeQuickslot( quickslotList.quickslots[5],  "0x7000317F" );
	self:MakeQuickslot( quickslotList.quickslots[6],  "0x70003E80" );
	self:MakeQuickslot( quickslotList.quickslots[7],  "0x7000B69B" );
	self:MakeQuickslot( quickslotList.quickslots[8],  "0x70003184" );
	self:MakeQuickslot( quickslotList.quickslots[9],  "0x7000B69A" );
end

