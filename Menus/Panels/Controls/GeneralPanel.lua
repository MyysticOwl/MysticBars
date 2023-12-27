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

GeneralPanel = class();

function GeneralPanel:Constructor( panel )
	self.utils = MyysticUI.Core.UI.MenuUtils();

	local box0 = self.utils:AddAutoListBox( panel, Turbine.UI.Orientation.Horizontal, 0, 0, 0, 5 );

	self.utils:AddLabelBox( box0, "Name:", 80, selectionHeight );

	self.barName = self.utils:AddTextBox(box0, "", selectionWidth, selectionHeight + 10 );

	local nameButton = Turbine.UI.Lotro.Button();
	nameButton:SetText( "Set" );
	nameButton:SetSize( buttonWidth, selectionHeight );
	nameButton.MouseClick = function( sender, args )
		local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);
		local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
		local barSettings = settingsService:GetBarSettings( menu:GetSelection() );

		barSettings.barName = self.barName:GetText();
		if ( barService  ~= nil and barService:Alive( menu:GetSelection() ) ) then
			settingsService:SetBarSettings( menu:GetSelection(), barSettings );
		end
		menu:Refresh();
	end
	box0:AddItem( nameButton );

	panel:AddItem( box0 );

	local deleteButton = Turbine.UI.Lotro.Button();
	deleteButton:SetText( "Remove Bar" );
	deleteButton:SetSize( 200, selectionHeight );
	deleteButton.MouseClick = function( sender, args )
		local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);

		barService:Remove( menu:GetSelection() );
		menu.contentBox:ClearItems();
		menu:Refresh();
	end

	panel:AddItem( deleteButton );
	self.spacer = self.utils:AddLabelBox( panel, "", 20, selectionHeight );


	self.utils:AddCategoryBox(panel, "General");

	self.barLockedCheckBox = self.utils:AddCheckBox( panel, "Locked", selectionWidth, selectionHeight );
	self.utils:CreateCheckBoxCallback( self.barLockedCheckBox, { "locked" } );

	self.utils:AddLabelBox( panel, "Bar Visibility?", 120, selectionHeight );
	self.visibilityList = MyysticUI.Core.UI.ComboBox();
	self.visibilityList:SetSize( 200, 20 );
	self.visibilityList:SetParent( panel );
	self.visibilityList:AddItem( "Always", 1 );
	self.visibilityList:AddItem( "Triggered", 2 );
	
	panel:AddItem( self.visibilityList );

	self.spacer = self.utils:AddLabelBox( panel, "", 20, selectionHeight );
end

function GeneralPanel:DisplaySettings()
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
	local localBarSettings = settingsService:GetBarSettings( menu:GetSelection() );
	self.barName.FocusLost = function(sender, args)
		local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);
		local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
		local barSettings = settingsService:GetBarSettings( menu:GetSelection() );

		barSettings.barName = self.barName:GetText();
		if ( barService  ~= nil and barService:Alive( menu:GetSelection() ) ) then
			settingsService:SetBarSettings( menu:GetSelection(), barSettings );
		end
	end
	self.barName:SetText( localBarSettings.barName );

    self.visibilityList.SelectedIndexChanged = function(sender, args)
		local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);
		local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
		local barSettings = settingsService:GetBarSettings( menu:GetSelection() );

		if ( self.visibilityList:GetSelection() == 1 ) then
			barSettings.visible = true;
		else
			barSettings.visible = false;
		end
		if ( barService  ~= nil and barService:Alive( menu:GetSelection() ) ) then
			settingsService:SetBarSettings( menu:GetSelection(), barSettings );
		end

		menu:EnableTriggers( not barSettings.visible );
	end
	if ( localBarSettings.visible ) then
		self.visibilityList:SetSelection( 1 );
	else
		self.visibilityList:SetSelection( 2 );
	end
	self.barLockedCheckBox:SetChecked( localBarSettings.locked );
end

function GeneralPanel:EnableTriggers( enabled )
end
