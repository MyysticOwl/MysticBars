-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "MyysticUI.Menus.Core.UI.AutoListBox";
import "MyysticUI.Menus.Core.UI.MenuUtils";
import "MyysticUI.Menus.Core.UI.CheckedComboBox";

InventoryPanel = class();

function InventoryPanel:Constructor( panel )
	self.utils = MyysticUI.Menus.Core.UI.MenuUtils();

	self.utils:AddCategoryBox(panel, "Inventory Options");

--	local box = self.utils:AddAutoListBox( panel, Turbine.UI.Orientation.Vertical, 0, 0, 0, 0 );

	self.utils:AddLabelBox( panel, "Category Based:", 120, selectionHeight );
	self.visibilityList = MyysticUI.Menus.Core.UI.CheckedComboBox();
	self.visibilityList:SetSize( 300, 20 );
	self.visibilityList:SetParent( panel );
	for key, value in opairs( Turbine.Gameplay.ItemCategory ) do
		self.visibilityList:AddItem( key, value );		
	end
	panel:AddItem( self.visibilityList );

	self.utils:AddLabelBox( panel, "", 120, selectionHeight / 2 );

	self.utils:AddLabelBox( panel, "Name Based:", 120, selectionHeight );
	self.nameList = MyysticUI.Menus.Core.UI.CheckedComboBox();
	self.nameList:SetSize( 300, 20 );
	self.nameList:SetParent( panel );
	panel:AddItem( self.nameList );

	self.utils:AddLabelBox( panel, "Add Name Filter:", 120, selectionHeight );

	self.submitBox = self.utils:AddAutoListBox( panel, Turbine.UI.Orientation.Horizontal, 0, 0, 0, 0 );
	self.filterName = self.utils:AddTextBox(self.submitBox, "", selectionWidth, selectionHeight + 10 );

	local filterButton = Turbine.UI.Lotro.Button();
	filterButton:SetText( "Add" );
	filterButton:SetSize( buttonWidth, selectionHeight );
	filterButton.MouseClick = function( sender, args )
		local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);
		local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
		local barSettings = settingsService:GetBarSettings( menu:GetSelection() );

		if ( barSettings.events.inventory.nameFilters == nil ) then
			barSettings.events.inventory.nameFilters = { };
		end
		if ( self.filterName:GetText() ~= "" ) then
			if ( barSettings.events.inventory.nameFilters[self.filterName:GetText()] == nil ) then
				self.nameList:AddItem( self.filterName:GetText() );
			end
			barSettings.events.inventory.nameFilters[self.filterName:GetText()] = true;

			self.filterName:SetText("");
			if ( barService  ~= nil and barService:Alive( menu:GetSelection() ) ) then
				settingsService:SetBarSettings( menu:GetSelection(), barSettings );
			end
			self:DisplaySettings();
		end
	end
	self.submitBox:AddItem( filterButton );
	panel:AddItem( self.submitBox );

	self.utils:AddLabelBox( panel, "", 120, selectionHeight / 2 );

	self.countCheckBox = self.utils:AddCheckBox(panel, "Quantity Based:", selectionWidth + 100, selectionHeight );
	self.utils:CreateCheckBoxCallback( self.countCheckBox, { "events", "inventory", "useCount" }, function(sender,args)
		local inventoryService = SERVICE_CONTAINER:GetService(MyysticUI.Services.InventoryService);
		inventoryService:NotifyClients();
	end );

	self.countSB = self.utils:AddScrollBar(panel, 0, 1, 100, 200, selectionHeight + 20, nil, "" );
	self.utils:CreateScrollBarCallback( self.countSB, { "events", "inventory", "quantity" }, nil, nil, function(sender,args)
		local inventoryService = SERVICE_CONTAINER:GetService(MyysticUI.Services.InventoryService);
		inventoryService:NotifyClients();
	end );
end

function InventoryPanel:DisplaySettings()
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
	local localBarSettings = settingsService:GetBarSettings( menu:GetSelection() );

	if ( localBarSettings.events == nil ) then
		localBarSettings.events = { };
	end
	if ( localBarSettings.events.inventory == nil ) then
		localBarSettings.events.inventory = { };
	end

    self.nameList.SelectedIndexChanged = function(sender, args)
		local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);
		local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
		local barSettings = settingsService:GetBarSettings( menu:GetSelection() );

		local selections = self.nameList:GetSelections();
		if ( selections ~= nil ) then
			-- ALWAYS RESET THE nameFilters
			barSettings.events.inventory.nameFilters = { };
			for key, value in pairs( selections ) do
				if ( barSettings.events.inventory.nameFilters[value] == nil ) then
					barSettings.events.inventory.nameFilters[value] = true;
				end
			end
			if ( barService  ~= nil and barService:Alive( menu:GetSelection() ) ) then
				settingsService:SetBarSettings( menu:GetSelection(), barSettings );
			end
			local inventoryService = SERVICE_CONTAINER:GetService(MyysticUI.Services.InventoryService);
			inventoryService:NotifyClients();
		end
	end

	self.nameList:Clear();

	if ( localBarSettings.events ~= nil and localBarSettings.events.inventory ~= nil and localBarSettings.events.inventory.nameFilters ~= nil ) then
		for key, value in opairs( localBarSettings.events.inventory.nameFilters ) do
			self.nameList:AddItem( key, key );
		end
	end
	self.nameList:SetSelections( localBarSettings.events.inventory.nameFilters );

	self.visibilityList:Clear();

	for key, value in opairs( Turbine.Gameplay.ItemCategory ) do
		self.visibilityList:AddItem( key, value );		
	end

    self.visibilityList.SelectedIndexChanged = function(sender, args)
		local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);
		local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
		local barSettings = settingsService:GetBarSettings( menu:GetSelection() );

		local selections = self.visibilityList:GetSelections();
		if ( selections ~= nil ) then
			-- ALWAYS RESET THE CATEGORIES
			barSettings.events.inventory.categories = { };
			for key, value in pairs( selections ) do
				if ( barSettings.events.inventory.categories[value] == nil ) then
					barSettings.events.inventory.categories[value] = true;
				end
			end
			if ( barService  ~= nil and barService:Alive( menu:GetSelection() ) ) then
				settingsService:SetBarSettings( menu:GetSelection(), barSettings );
			end
			local inventoryService = SERVICE_CONTAINER:GetService(MyysticUI.Services.InventoryService);
			inventoryService:NotifyClients();
		end
	end
	self.visibilityList:SetSelections( localBarSettings.events.inventory.categories );

	self.countCheckBox:SetChecked( localBarSettings.events.inventory.useCount );
	if ( localBarSettings.events.inventory.quantity ~= nil ) then
		self.countSB:SetValue( localBarSettings.events.inventory.quantity );
	end
end

function InventoryPanel:EnableTriggers( enabled )
end
