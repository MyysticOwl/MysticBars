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

SlotsPanel = class();

function SlotsPanel:Constructor( panel, RowColumnBased, sizeOption, mainMenu )
	menu = mainMenu;
	self.RowColumnBased = RowColumnBased;
	self.utils = MyysticUI.UI.MenuUtils();

	self.utils:AddCategoryBox(panel, "Quick Slots");

	local box2a = self.utils:AddAutoListBox( panel, Turbine.UI.Orientation.Vertical );
	local box2b = self.utils:AddAutoListBox( box2a, Turbine.UI.Orientation.Horizontal );

	if ( self.RowColumnBased == true ) then
		self.sb = self.utils:AddScrollBar( box2b, 1, 1, 50, 200, selectionHeight + 20, nil, "Rows:" );
	
		box2a:AddItem( box2b );
		panel:AddItem( box2a );
		local box3a = self.utils:AddAutoListBox( panel, Turbine.UI.Orientation.Vertical );
		local box3b = self.utils:AddAutoListBox( box3a, Turbine.UI.Orientation.Horizontal );
	
		self.sb2 = self.utils:AddScrollBar( box3b, 1, 1, 50, 200, selectionHeight + 20, nil, "Columns:" );
	
		box3a:AddItem( box3b );
		panel:AddItem( box3a );
	else
		self.extSb = self.utils:AddScrollBar( box2b, 1, 1, 50, 200, selectionHeight + 20, nil, "Count:" );
		self.utils:CreateScrollBarCallback( self.extSb, { "quickslotCount" }, nil, nil, function(sender,args)
			local inventoryService = SERVICE_CONTAINER:GetService(MyysticUI.Services.InventoryService);
			inventoryService:NotifyClients();
		end );
		box2a:AddItem( box2b );
		panel:AddItem( box2a );
	end
	local box5a = self.utils:AddAutoListBox( panel, Turbine.UI.Orientation.Vertical );
	local box5b = self.utils:AddAutoListBox( box5a, Turbine.UI.Orientation.Horizontal );
	self.spacingSB = self.utils:AddScrollBar( box5b, 1, 0, 50, 200, selectionHeight + 20, nil, "Spacing:" );
	self.utils:CreateScrollBarCallback( self.spacingSB, { "quickslotSpacing" } );

	box5a:AddItem( box5b );
	panel:AddItem( box5a );
	local box6a = self.utils:AddAutoListBox( panel, Turbine.UI.Orientation.Vertical );
	local box6b = self.utils:AddAutoListBox( box6a, Turbine.UI.Orientation.Horizontal );

	self.sizeSB = self.utils:AddScrollBar( box6b, 36, 0, 99, 200, selectionHeight + 20, nil, "Size:" );

	self.utils:CreateScrollBarCallback( self.sizeSB, { "quickslotSize" }, nil, nil, function(sender,args)
		local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);

		barService:RefreshBars();
	end );

	box6a:AddItem( box6b );
	panel:AddItem( box6a );
end

function SlotsPanel:DisplaySettings()
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
	local localBarSettings = settingsService:GetBarSettings( menu:GetSelection() );

	if ( self.RowColumnBased == true ) then
		self.sb.ValueChanged = function( sender, args )
			local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);
			local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
			local barSettings = settingsService:GetBarSettings( menu:GetSelection() );

			barSettings.quickslotRows = self.sb:GetValue();
			barSettings.quickslotCount = barSettings.quickslotRows * barSettings.quickslotColumns;
			if ( barService  ~= nil and barService:Alive( menu:GetSelection() ) ) then
				settingsService:SetBarSettings( menu:GetSelection(), barSettings );
			end
			local inventoryService = SERVICE_CONTAINER:GetService(MyysticUI.Services.InventoryService);
			inventoryService:NotifyClients();
		end
		self.sb:SetValue( localBarSettings.quickslotRows );
		self.sb2.ValueChanged = function( sender, args )
			local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);
			local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
			local barSettings = settingsService:GetBarSettings( menu:GetSelection() );

			barSettings.quickslotColumns = self.sb2:GetValue();
			barSettings.quickslotCount = barSettings.quickslotRows * barSettings.quickslotColumns;
			if ( barService  ~= nil and barService:Alive( menu:GetSelection() ) ) then
				settingsService:SetBarSettings( menu:GetSelection(), barSettings );
			end
			local inventoryService = SERVICE_CONTAINER:GetService(MyysticUI.Services.InventoryService);
			inventoryService:NotifyClients();
		end	
		self.sb2:SetValue( localBarSettings.quickslotColumns );
	else
		self.extSb:SetValue( localBarSettings.quickslotCount );
	end
	self.spacingSB:SetValue( localBarSettings.quickslotSpacing );
	self.sizeSB:SetValue( localBarSettings.quickslotSize );
end

function SlotsPanel:EnableTriggers( enabled )
end
