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

ExtensionGeneralPanel = class();

function ExtensionGeneralPanel:Constructor( panel, mainMenu )
	self.barService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.BarService);
	self.settingsService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.SettingsService);

	menu = mainMenu;
	self.utils = Tonic.UI.MenuUtils();

	self.utils:AddLabelBox( panel, "", 50, selectionHeight );

	self.utils:AddCategoryBox(panel, LOCALESTRINGS.ExtensionsMenu["General"]);

	local box0 = self.utils:AddAutoListBox( panel, Turbine.UI.Orientation.Horizontal, 0, selectionHeight + 20, 0, 0 );

	self.utils:AddLabelBox( box0, LOCALESTRINGS.ExtensionsMenu["Name:"], 80, selectionHeight );

	self.barName = self.utils:AddTextBox(box0, "", selectionWidth, selectionHeight + 10 );

	local nameButton = Turbine.UI.Lotro.Button();
	nameButton:SetText( LOCALESTRINGS.ExtensionsMenu["Set"] );
	nameButton:SetSize( buttonWidth, selectionHeight );
	nameButton.MouseClick = function( sender, args )
		local selection = menu:GetSelection();
		local barSettings = self.settingsService:GetBarSettings( selection );
		if ( barSettings.barName ~= self.barName:GetText() and self.barService  ~= nil and self.barService:Alive( menu:GetSelection() )) then
			barSettings.barName = self.barName:GetText();
			self.settingsService:SetBarSettings( selection, barSettings );
			menu:Refresh();
		end
	end
	box0:AddItem( nameButton );

	panel:AddItem( box0 );

	self.utils:AddLabelBox( panel, LOCALESTRINGS.ExtensionsMenu["Orientation:"], selectionWidth + 100, selectionHeight + 5 );

	self.orientationList = Tonic.UI.ComboBox();
	self.orientationList:SetSize( 200, 20 );
	self.orientationList:SetParent( panel );
	self.orientationList:AddItem( LOCALESTRINGS.Orientation["Left"],  "Left" );
	self.orientationList:AddItem( LOCALESTRINGS.Orientation["Right"], "Right" );
	self.orientationList:AddItem( LOCALESTRINGS.Orientation["Up"],    "Up" );
	self.orientationList:AddItem( LOCALESTRINGS.Orientation["Down"],  "Down" );
	panel:AddItem( self.orientationList );

	self.utils:AddLabelBox( panel, LOCALESTRINGS.ExtensionsMenu["When attached quickslot is Moused Over:"], selectionWidth + 200, selectionHeight + 5 );

	self.mousedOverList = Tonic.UI.ComboBox();
	self.mousedOverList:SetSize( 200, 20 );
	self.mousedOverList:SetParent( panel );
	self.mousedOverList:AddItem( LOCALESTRINGS.ExtensionRule["Show Extension(s)"], SHOW_EXTENSIONS );
	self.mousedOverList:AddItem( LOCALESTRINGS.ExtensionRule["Show & Rollup Selection"], ROLL_UP_SELECTION );
	self.mousedOverList:AddItem( LOCALESTRINGS.ExtensionRule["Select Random Shortcut"], SELECT_RANDOM_SHORTCUT );
	self.mousedOverList:AddItem( LOCALESTRINGS.ExtensionRule["Cycle Shortcuts"], CYCLE_EXTENSIONS );
	panel:AddItem( self.mousedOverList );

	self.utils:AddLabelBox( panel, LOCALESTRINGS.ExtensionsMenu["Stop displaying extension when:"], selectionWidth + 200, selectionHeight + 5 );

	self.removalList = Tonic.UI.ComboBox();
	self.removalList:SetSize( 200, 20 );
	self.removalList:SetParent( panel );
	self.removalList:AddItem( LOCALESTRINGS.ExtensionRemoval["Mouse Leaves Bar"], 1 );
	self.removalList:AddItem( LOCALESTRINGS.ExtensionRemoval["Combat has ended"], 2 );
	panel:AddItem( self.removalList );

	self.utils:AddLabelBox( panel, "", 50, selectionHeight );

end

function ExtensionGeneralPanel:DisplaySettings()
	local localBarSettings = self.settingsService:GetBarSettings( menu:GetSelection() );

    self.orientationList.SelectedIndexChanged = function(sender, args)
		local barSettings = self.settingsService:GetBarSettings( menu:GetSelection() );
		barSettings.orientation = self.orientationList:GetSelection();
		if ( self.barService  ~= nil and self.barService:Alive( menu:GetSelection() ) ) then
			self.settingsService:SetBarSettings( menu:GetSelection(), barSettings );
		end
	end
	self.orientationList:SetSelection( localBarSettings.orientation );

    self.mousedOverList.SelectedIndexChanged = function(sender, args)
		local barSettings = self.settingsService:GetBarSettings( menu:GetSelection() );
		barSettings.onMouseOver = self.mousedOverList:GetSelection();
		if ( self.barService  ~= nil and self.barService:Alive( menu:GetSelection() ) ) then
			self.settingsService:SetBarSettings( menu:GetSelection(), barSettings );
		end
	end
	self.mousedOverList:SetSelection( localBarSettings.onMouseOver );

    self.removalList.SelectedIndexChanged = function(sender, args)
		local barSettings = self.settingsService:GetBarSettings( menu:GetSelection() );
		barSettings.barTermination = self.removalList:GetSelection();
		if ( self.barService  ~= nil and self.barService:Alive( menu:GetSelection() ) ) then
			self.settingsService:SetBarSettings( menu:GetSelection(), barSettings );
		end
	end
	self.removalList:SetSelection( localBarSettings.barTermination );

end

function ExtensionGeneralPanel:EnableTriggers( enabled )
end
