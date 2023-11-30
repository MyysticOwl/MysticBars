-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "Tonic.UI.AutoListBox";
import "Tonic.UI.MenuUtils";
import "Tonic.TonicBars.Menu.Panels.Controls.TriggersPanel";
import "Tonic.TonicBars.Menu.Panels.Controls.InventoryPanel";
import "Tonic.TonicBars.Menu.Panels.Controls.ColorPanel";

InventoryMenu = class( Tonic.UI.AutoListBox );

buttonWidth = 90;
selectionWidth = 160;
selectionHeight = 20;

function InventoryMenu:Constructor()
	Tonic.UI.AutoListBox.Constructor( self );

	self.barService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.BarService);
	self.settingsService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.SettingsService);
	
	self:SetOrientation( Turbine.UI.Orientation.Vertical );

	self.utils = Tonic.UI.MenuUtils();
	
	-- Quickslots Menu
	self.utils:AddCategoryBox(self, LOCALESTRINGS.InventoryMenu["Inventory Bars"]);

	self.utils:AddLabelBox( self, LOCALESTRINGS.InventoryMenu["Click Add Bar to start using tonic bars or select an Windowed Bar to edit."], selectionWidth + 250, selectionHeight + 20 );

	self.utils:AddLabelBox( self, LOCALESTRINGS.QuickslotsMenu["Editing Settings for Bar:"], selectionWidth + 100, selectionHeight );

	self.barList = Tonic.UI.ComboBox();
	self.barList:SetSize( 200, 20 );
	self.barList:SetParent( self );
    self.barList.SelectedIndexChanged = function(sender, args)
		local settings = self.settingsService:GetSettings();
		settings.selectedBar = tonumber(args.selection);
		self.barService:RefreshBars();
	end
	self:AddItem( self.barList );
	
	self:AddSettings();

	self:EnableTriggers( false );

	self:AddCommandsBar();

	self:AddItem( self.settingsBox );

	self.settingsBox:SetVisible( false );	
end

function InventoryMenu:AddSettings()
	self.settingsBox = self.utils:AddAutoListBox( self, Turbine.UI.Orientation.Vertical );

	self.SizeChanged = function( sender, args )
		self.settingsBox:SetSize(self:GetWidth(), self:GetHeight());
	end

	self.utils:AddLabelBox( self.settingsBox, "", 50, selectionHeight );

	-----------------------   GENERAL  0000000000000000000000000000
	self.generalPanel = Tonic.TonicBars.Menu.Panels.Controls.GeneralPanel( self.settingsBox );

	-----------------------   INVENTORY  0000000000000000000000000000
	self.inventoryPanel = Tonic.TonicBars.Menu.Panels.Controls.InventoryPanel( self.settingsBox );

	-----------------------   TRIGGERS  0000000000000000000000000000
	self.tp = Tonic.TonicBars.Menu.Panels.Controls.TriggersPanel( self.settingsBox );

	-----------------------   CLASS BUFF TRIGGERS  0000000000000000000000000000
	self.slotsPanel = Tonic.TonicBars.Menu.Panels.Controls.SlotsPanel( self.settingsBox, true );

	-----------------------   COLOR TRIGGERS  0000000000000000000000000000
	self.colorPanel = Tonic.TonicBars.Menu.Panels.Controls.ColorPanel( self.settingsBox );
end

function InventoryMenu:DisplaySettings( showQuickslots )
	self.settingsBox:SetVisible( showQuickslots );
	
	local localBarSettings = self.settingsService:GetBarSettings( self.barList:GetSelection() );
	if ( localBarSettings.events == nil ) then
		localBarSettings.events = { };
	end

	self.tp:DisplaySettings();
	self.inventoryPanel:DisplaySettings();
	self.slotsPanel:DisplaySettings();
	self.generalPanel:DisplaySettings();
	self.colorPanel:DisplaySettings();
end

function InventoryMenu:SetColors( barSettings )
	theColor = Turbine.UI.Color( barSettings.opacity, barSettings.backgroundColorRed, barSettings.backgroundColorGreen, barSettings.backgroundColorBlue )
end

function InventoryMenu:AddCommandsBar()
	self.qsCommandsBox = Tonic.UI.AutoListBox();
	self.qsCommandsBox:SetParent( self );
	self.qsCommandsBox:SetBackColor( unselectedColor );
	self.qsCommandsBox:SetOrientation( Turbine.UI.Orientation.Vertical );
	self.qsCommandsBox:SetVisible( true );

	self.addbox = self.utils:AddAutoListBox( self.qsCommandsBox, Turbine.UI.Orientation.Horizontal, 0, 0, 0, 0 );
	local addButton = Turbine.UI.Lotro.Button();
	addButton:SetText( LOCALESTRINGS.InventoryMenu["Add Tabbed Bar"] );
	addButton:SetSize( buttonWidth + 50, selectionHeight );
	addButton.MouseClick = function( sender, args )
		local barid = self.barService:Add( TABBED_INV_BAR );
		self:RefreshComboBox( barid );
	end
	self.addbox:AddItem( addButton );

--	local addButton = Turbine.UI.Lotro.Button();
--	addButton:SetText( LOCALESTRINGS.InventoryMenu["Add Windowed Bar"] );
--	addButton:SetSize( buttonWidth + 60, selectionHeight );
--	addButton.MouseClick = function( sender, args )
--		local barid = self.barService:Add( WINDOW_INV_BAR );
--		self:RefreshComboBox( barid );
--	end
--	self.addbox:AddItem( addButton );

	self.otherbox = self.utils:AddAutoListBox( self.qsCommandsBox, Turbine.UI.Orientation.Horizontal, 0, 0, 0, 0 );
	local removeButton = Turbine.UI.Lotro.Button();
	removeButton:SetText( LOCALESTRINGS.QuickslotsMenu["Remove"] );
	removeButton:SetSize( buttonWidth, selectionHeight );

	removeButton.MouseClick = function( sender, args )
		self.barService:Remove( tonumber( self.barList:GetSelection() ) );
		self.barList:RemoveItem( self.barList:GetSelection() );
	end
	self.otherbox:AddItem( removeButton );
	
	local copyButton = Turbine.UI.Lotro.Button();
	copyButton:SetText( LOCALESTRINGS.QuickslotsMenu["Copy"] );
	copyButton:SetSize( buttonWidth, selectionHeight );
	copyButton.MouseClick = function( sender, args )
		local barSettings = self.settingsService:GetBarSettings( tonumber( self.barList:GetSelection()) );
		local barid = self.barService:Copy( tonumber( self.barList:GetSelection()), barSettings.barType );
		self.barList:AddItem( barid, barid );
	end
	self.otherbox:AddItem( copyButton );

	local resetButton = Turbine.UI.Lotro.Button();
	resetButton:SetText( LOCALESTRINGS.QuickslotsMenu["Reset"] );
	resetButton:SetSize( buttonWidth + 10, selectionHeight );
	resetButton.MouseClick = function( sender, args )
		self.barService:Reset( tonumber( self.barList:GetSelection() ) );
	end
	self.otherbox:AddItem( resetButton );
	
	self.qsCommandsBox:AddItem( self.addbox );
	self.qsCommandsBox:AddItem( self.otherbox );
	self:AddItem( self.qsCommandsBox );
end

function InventoryMenu:GetSelection()
	return self.barList:GetSelection();
end

function InventoryMenu:ClearSelection()
	local settings = self.settingsService:GetSettings();
	settings.selectedBar = 0;
	self.settingsBox:SetVisible( false );
	self.barList:SetSelection();
end

function InventoryMenu:EnableTriggers( enabled )
	self.tp:EnableTriggers( enabled );
end

function InventoryMenu:RefreshComboBox( barid )
	self.barList:Clear();
	for key, value in opairs (self.settingsService:GetBars( TABBED_INV_BAR )) do
		local found = false;
		for i = 1, self.barList:GetItemCount() do
			if ( self.barList:GetItem(i) == key) then
				found = true;
			end
		end
		if ( found == false ) then
			local text = key;
			local barSettings = self.settingsService:GetBarSettings( key );
			if ( barSettings.barName ~= nil ) then
				text = barSettings.barName;
			end
			self.barList:AddItem( text, key );
		end
	end
	for key, value in opairs (self.settingsService:GetBars( WINDOW_INV_BAR )) do
		local found = false;
		for i = 1, self.barList:GetItemCount() do
			if ( self.barList:GetItem(i) == key) then
				found = true;
			end
		end
		if ( found == false ) then
			local text = key;
			local barSettings = self.settingsService:GetBarSettings( key );
			if ( barSettings.barName ~= nil ) then
				text = barSettings.barName;
			end
			self.barList:AddItem( text, key );
		end
	end
	if ( barid ~= nil ) then
		self.barList:SetSelection( barid );
	end
end