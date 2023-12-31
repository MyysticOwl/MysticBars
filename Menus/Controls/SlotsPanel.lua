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

SlotsPanel = class(MyysticUI.Menus.Controls.BasePanel);

function SlotsPanel:Constructor( barId, barValue, isExtension )
	MyysticUI.Menus.Controls.BasePanel.Constructor(self, barId, barValue);

	self:SetHeight(80);

	if (isExtension == nil) then
		isExtension = false;
	end

	self.isExtension = isExtension;

	if ( self.isExtension == false ) then
		self.sb = self.utils:AddScrollBar( self.panelBackground, 1, 1, 100, 200, selectionHeight + 20, nil, "Rows:", 5, 5, 5 );
		self.sb2 = self.utils:AddScrollBar( self.panelBackground, 1, 1, 50, 200, selectionHeight + 20, nil, "Columns:", 200, 5, 30 );
	else
		self.extSb = self.utils:AddScrollBar( self.panelBackground, 1, 1, 50, 200, selectionHeight + 20, nil, "Count:", 5, 5, 20 );
		self.utils:CreateScrollBarCallback( self.extSb, barId, { "quickslotCount" }, nil, nil, function(sender,args)
			SERVICE_CONTAINER:GetService(MyysticUI.Services.InventoryService):NotifyClients();
		end );
	end
	self.spacingSB = self.utils:AddScrollBar( self.panelBackground, 1, 0, 50, 200, selectionHeight + 20, nil, "Spacing:", 5, 40, 20 );
	self.utils:CreateScrollBarCallback( self.spacingSB, barId, { "quickslotSpacing" } );

	self.sizeSB = self.utils:AddScrollBar( self.panelBackground, 36, 0, 99, 200, selectionHeight + 20, nil, "Size:", 200, 40, 5 );
	self.utils:CreateScrollBarCallback( self.sizeSB, barId, { "quickslotSize" }, nil, nil, function(sender,args)
		local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);

		barService:RefreshBars();
	end );

	self:DisplaySettings();
end

function SlotsPanel:DisplaySettings()
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
	local localBarSettings = settingsService:GetBarSettings( self.barId );

	if ( self.isExtension == false ) then
		self.sb.ValueChanged = function( sender, args )
			SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService):UpdateBarSettings(self.barId, function(barSettings)
				barSettings.quickslotRows = self.sb:GetValue();
				barSettings.quickslotCount = barSettings.quickslotRows * barSettings.quickslotColumns;
				return barSettings;
			end, function()
				SERVICE_CONTAINER:GetService(MyysticUI.Services.InventoryService):NotifyClients();
			end);
		end
		self.sb:SetValue( localBarSettings.quickslotRows );
		self.sb2.ValueChanged = function( sender, args )
			SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService):UpdateBarSettings(self.barId, function(barSettings)
				barSettings.quickslotColumns = self.sb2:GetValue();
				barSettings.quickslotCount = barSettings.quickslotRows * barSettings.quickslotColumns;
				return barSettings;
			end, function()
				SERVICE_CONTAINER:GetService(MyysticUI.Services.InventoryService):NotifyClients();
			end);
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
