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

GeneralPanel = class();

function GeneralPanel:Constructor( panel )
	self.barService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.BarService);
	self.settingsService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.SettingsService);

	self.utils = Tonic.UI.MenuUtils();

	local box0 = self.utils:AddAutoListBox( panel, Turbine.UI.Orientation.Horizontal, 0, 0, 0, 0 );

		self.utils:AddLabelBox( box0, LOCALESTRINGS.QuickslotsMenu["Name:"], 80, selectionHeight );

		self.barName = self.utils:AddTextBox(box0, "", selectionWidth, selectionHeight + 10 );

		local nameButton = Turbine.UI.Lotro.Button();
		nameButton:SetText( LOCALESTRINGS.QuickslotsMenu["Set"] );
		nameButton:SetSize( buttonWidth, selectionHeight );
		nameButton.MouseClick = function( sender, args )
			local barSettings = self.settingsService:GetBarSettings( menu:GetSelection() );
			barSettings.barName = self.barName:GetText();
			if ( self.barService  ~= nil and self.barService:Alive( menu:GetSelection() ) ) then
				self.settingsService:SetBarSettings( menu:GetSelection(), barSettings );
			end
			menu:Refresh();
		end
		box0:AddItem( nameButton );

	panel:AddItem( box0 );

	self.utils:AddCategoryBox(panel, LOCALESTRINGS.QuickslotsMenu["General"]);

	self.barLockedCheckBox = self.utils:AddCheckBox( panel, LOCALESTRINGS.QuickslotsMenu["Locked"], selectionWidth, selectionHeight );
	self.utils:CreateCheckBoxCallback( self.barLockedCheckBox, { "locked" } );

	self.utils:AddLabelBox( panel, LOCALESTRINGS.QuickslotsMenu["Bar Visibility?"], 120, selectionHeight );
	self.visibilityList = Tonic.UI.ComboBox();
	self.visibilityList:SetSize( 200, 20 );
	self.visibilityList:SetParent( panel );
	self.visibilityList:AddItem( LOCALESTRINGS.QuickslotVisibility["Always"], 1 );
	self.visibilityList:AddItem( LOCALESTRINGS.QuickslotVisibility["Triggered"], 2 );
	
	panel:AddItem( self.visibilityList );
end

function GeneralPanel:DisplaySettings()
	local localBarSettings = self.settingsService:GetBarSettings( menu:GetSelection() );
	self.barName.FocusLost = function(sender, args)
		local barSettings = self.settingsService:GetBarSettings( menu:GetSelection() );
		barSettings.barName = self.barName:GetText();
		if ( self.barService  ~= nil and self.barService:Alive( menu:GetSelection() ) ) then
			self.settingsService:SetBarSettings( menu:GetSelection(), barSettings );
		end
	end
	self.barName:SetText( localBarSettings.barName );

    self.visibilityList.SelectedIndexChanged = function(sender, args)
		local barSettings = self.settingsService:GetBarSettings( menu:GetSelection() );
		if ( self.visibilityList:GetSelection() == 1 ) then
			barSettings.visible = true;
		else
			barSettings.visible = false;
		end
		if ( self.barService  ~= nil and self.barService:Alive( menu:GetSelection() ) ) then
			self.settingsService:SetBarSettings( menu:GetSelection(), barSettings );
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
