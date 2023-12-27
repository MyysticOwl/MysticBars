-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "MyysticUI.UI.AutoListBox";
import "MyysticUI.UI.MenuUtils";

PredefinedExtensionPanel = class();

function PredefinedExtensionPanel:Constructor( panel, mainMenu )
	menu = mainMenu;
	self.utils = MyysticUI.UI.MenuUtils();

	self.utils:AddCategoryBox(panel, "Predefined Extensions");


	self.utils:AddLabelBox( panel, "This will change shortcuts on the current bar perminately!!!!", selectionWidth + 150, selectionHeight + 10 );

	self.typeList = MyysticUI.UI.ComboBox();
	self.typeList:SetSize( 200, 20 );
	self.typeList:SetParent( panel );
	-- self.typeList:AddItem( "Hunters Travel", 	HUNTER_TRAVEL_TYPE );
	-- self.typeList:AddItem( "Wardens Travel", 	WARDEN_TRAVEL_TYPE );
	-- self.typeList:AddItem( "Reputation Travel", 	REP_TRAVEL_TYPE );
	-- self.typeList:AddItem( "Housing Travel", 	HOUSING_TRAVEL_TYPE );
	-- self.typeList:AddItem( "LM Combat Pets", 	LM_COMBAT_PETS_TYPE );
	-- self.typeList:AddItem( "LM Cosmetic Pets", 	LM_COSMETIC_PETS_TYPE );
	-- self.typeList:AddItem( "Captain Pets", 	CAPTAIN_PETS_TYPE );
	-- self.typeList:AddItem( "Horses", 	HORSE1_TYPE );
	-- self.typeList:AddItem( "Horses (more)", 	HORSE2_TYPE );
	-- self.typeList:AddItem( "Ponies", 	PONY1_TYPE );
	-- self.typeList:AddItem( "Ponies (more)", 	PONY2_TYPE );

	-- self.typeList:AddItem( "Instruments", 	INSTRUMENTS_TYPE );
	-- self.typeList:AddItem( "Mini DPS", 	MINI_DPS_TYPE );

	panel:AddItem( self.typeList );
end

function PredefinedExtensionPanel:DisplaySettings()
    self.typeList.SelectedIndexChanged = function(sender, args)
	--	local hte = MyysticUI.Core.Bars.Quickslots.TypeHelper();
--		local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);
--		local theBars = barService.GetBars();
--		local selection = menu:GetSelection();

	--	TODO:SE Use PlayerService to pull this back together.
	-- 	if ( self.typeList:GetSelection() == HUNTER_TRAVEL_TYPE ) then
	-- 		hte:GetNewHunterTravelSettings( selection, theBars[selection]:GetQuickslotList() );
	-- 	elseif ( self.typeList:GetSelection() == WARDEN_TRAVEL_TYPE ) then
	-- 		hte:GetNewWardenTravelSettings( selection, theBars[selection]:GetQuickslotList() );
	-- 	elseif ( self.typeList:GetSelection() == HOUSING_TRAVEL_TYPE ) then
	-- 		hte:GetNewHousingTravelSettings( selection, theBars[selection]:GetQuickslotList() );
	-- 	elseif ( self.typeList:GetSelection() == LM_COMBAT_PETS_TYPE ) then
	-- 		hte:GetNewLMCombatPetsSettings( selection, theBars[selection]:GetQuickslotList() );
	-- 	elseif ( self.typeList:GetSelection() == LM_COSMETIC_PETS_TYPE ) then
	-- 		hte:GetNewLMCosmeticPetsSettings( selection, theBars[selection]:GetQuickslotList() );
	-- 	elseif ( self.typeList:GetSelection() == REP_TRAVEL_TYPE ) then
	-- 		hte:GetNewReputationTravelSettings( selection, theBars[selection]:GetQuickslotList() );
	-- 	elseif ( self.typeList:GetSelection() == HORSE1_TYPE ) then
	-- 		hte:GetNewHorsesSettings( selection, theBars[selection]:GetQuickslotList() );
	-- 	elseif ( self.typeList:GetSelection() == HORSE2_TYPE ) then
	-- 		hte:GetFesHorsesSettings( selection, theBars[selection]:GetQuickslotList() );
	-- 	elseif ( self.typeList:GetSelection() == PONY1_TYPE ) then
	-- 		hte:GetNewPoniesSettings( selection, theBars[selection]:GetQuickslotList() );
	-- 	elseif ( self.typeList:GetSelection() == PONY2_TYPE ) then
	-- 		hte:GetFesPoniesSettings( selection, theBars[selection]:GetQuickslotList() );
	-- 	elseif ( self.typeList:GetSelection() == INSTRUMENTS_TYPE ) then
	-- 		hte:GetNewMentorSettings( selection, theBars[selection]:GetQuickslotList() );
	-- 	elseif ( self.typeList:GetSelection() == MINI_DPS_TYPE ) then
	-- 		hte:GetNewMinstrelDpsSettings( selection, theBars[selection]:GetQuickslotList() );
	-- 	elseif ( self.typeList:GetSelection() == CAPTAIN_PETS_TYPE ) then
	-- 		hte:GetNewCaptainPetsSettings( selection, theBars[selection]:GetQuickslotList() );
	-- 	end
	end
	self.typeList:SetSelection( 0 );
end

function ExtensionGeneralPanel:EnableTriggers( enabled )
end
