-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "MyysticUI.Core.UI.AutoListBox";
import "MyysticUI.Core.UI.MenuUtils";

ExtensionGeneralPanel = class();

function ExtensionGeneralPanel:Constructor( panel, mainMenu )
	menu = mainMenu;
	self.utils = MyysticUI.Core.UI.MenuUtils();

	self.utils:AddLabelBox( panel, "", 50, selectionHeight );

	self.utils:AddCategoryBox(panel, "General");

	local box0 = self.utils:AddAutoListBox( panel, Turbine.UI.Orientation.Horizontal, 0, selectionHeight + 20, 0, 0 );

	self.utils:AddLabelBox( box0, "Name:", 80, selectionHeight );

	self.barName = self.utils:AddTextBox(box0, "", selectionWidth, selectionHeight + 10 );

	local nameButton = Turbine.UI.Lotro.Button();
	nameButton:SetText( "Set" );
	nameButton:SetSize( buttonWidth, selectionHeight );
	nameButton.MouseClick = function( sender, args )
		local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);
		local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);

		local selection = menu:GetSelection();
		local barSettings = settingsService:GetBarSettings( selection );
		if ( barSettings.barName ~= self.barName:GetText() and barService  ~= nil and barService:Alive( menu:GetSelection() )) then
			barSettings.barName = self.barName:GetText();
			settingsService:SetBarSettings( selection, barSettings );
			menu:Refresh();
		end
	end
	box0:AddItem( nameButton );

	panel:AddItem( box0 );

	self.utils:AddLabelBox( panel, "Orientation:", selectionWidth + 100, selectionHeight + 5 );

	self.orientationList = MyysticUI.Core.UI.ComboBox();
	self.orientationList:SetSize( 200, 20 );
	self.orientationList:SetParent( panel );
	self.orientationList:AddItem( "Left",  "Left" );
	self.orientationList:AddItem( "Right", "Right" );
	self.orientationList:AddItem( "Up",    "Up" );
	self.orientationList:AddItem( "Down",  "Down" );
	panel:AddItem( self.orientationList );

	self.utils:AddLabelBox( panel, "When attached quickslot is Moused Over:", selectionWidth + 200, selectionHeight + 5 );

	self.mousedOverList = MyysticUI.Core.UI.ComboBox();
	self.mousedOverList:SetSize( 200, 20 );
	self.mousedOverList:SetParent( panel );
	self.mousedOverList:AddItem( "Show Extension(s)", SHOW_EXTENSIONS );
	self.mousedOverList:AddItem( "Show & Rollup Selection", ROLL_UP_SELECTION );
	self.mousedOverList:AddItem( "Select Random Shortcut", SELECT_RANDOM_SHORTCUT );
	self.mousedOverList:AddItem( "Cycle Shortcuts", CYCLE_EXTENSIONS );
	panel:AddItem( self.mousedOverList );

	self.utils:AddLabelBox( panel, "Stop displaying extension when:", selectionWidth + 200, selectionHeight + 5 );

	self.removalList = MyysticUI.Core.UI.ComboBox();
	self.removalList:SetSize( 200, 20 );
	self.removalList:SetParent( panel );
	self.removalList:AddItem( "Mouse Leaves Bar", 1 );
	self.removalList:AddItem( "Combat has ended", 2 );
	panel:AddItem( self.removalList );

	self.utils:AddLabelBox( panel, "", 50, selectionHeight );

end

function ExtensionGeneralPanel:DisplaySettings()
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
	local localBarSettings = settingsService:GetBarSettings( menu:GetSelection() );

    self.orientationList.SelectedIndexChanged = function(sender, args)
		local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);
		local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
		local barSettings = settingsService:GetBarSettings( menu:GetSelection() );
	
		barSettings.orientation = self.orientationList:GetSelection();
		if ( barService  ~= nil and barService:Alive( menu:GetSelection() ) ) then
			settingsService:SetBarSettings( menu:GetSelection(), barSettings );
		end
	end
	self.orientationList:SetSelection( localBarSettings.orientation );

    self.mousedOverList.SelectedIndexChanged = function(sender, args)
		local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);
		local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
		local barSettings = settingsService:GetBarSettings( menu:GetSelection() );

		barSettings.onMouseOver = self.mousedOverList:GetSelection();
		if ( barService  ~= nil and barService:Alive( menu:GetSelection() ) ) then
			settingsService:SetBarSettings( menu:GetSelection(), barSettings );
		end
	end
	self.mousedOverList:SetSelection( localBarSettings.onMouseOver );

    self.removalList.SelectedIndexChanged = function(sender, args)
		local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);
		local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
		local barSettings = settingsService:GetBarSettings( menu:GetSelection() );

		barSettings.barTermination = self.removalList:GetSelection();
		if ( barService  ~= nil and barService:Alive( menu:GetSelection() ) ) then
			settingsService:SetBarSettings( menu:GetSelection(), barSettings );
		end
	end
	self.removalList:SetSelection( localBarSettings.barTermination );

end

function ExtensionGeneralPanel:EnableTriggers( enabled )
end
