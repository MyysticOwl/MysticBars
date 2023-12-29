-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "MyysticUI.Utils.Class";
import "MyysticUI.Menus.Core.UI.Window";
import "MyysticUI.Bars.Core.InventoryBaseBar";
import "MyysticUI.Bars.Core.Tab"

TabbedInventoryBar = class( MyysticUI.Bars.Core.InventoryBaseBar );

function TabbedInventoryBar:Constructor( barid )
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);

	self.id = barid;

	local thebarSettings = settingsService:GetBarSettings( self.id );
	if ( thebarSettings.barType ~= TABBED_INV_BAR ) then
		thebarSettings.barType = TABBED_INV_BAR;
		thebarSettings.quickslotRows = 1;
		thebarSettings.quickslotColumns = 4;
		thebarSettings.quickslotCount = 12;
		thebarSettings.visible = true;
		settingsService:SetBarSettings( self.id, thebarSettings );
	end

	MyysticUI.Bars.Core.InventoryBaseBar.Constructor( self );
end

function TabbedInventoryBar:Create()
	MyysticUI.Bars.Core.InventoryBaseBar.Create( self );
	
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings( self.id );

	local title = barSettings.barName;
	if ( barSettings.barName == nil or barSettings.barName == "" ) then
		title = "Bar:" .. self.id;
	end
	self.tab = MyysticUI.Bars.Core.Tab( self, title );
	--self.quickslotList:SetPosition(0, 0 );
end

function TabbedInventoryBar:Remove()
	if ( self.tab ~= nil ) then
		self.tab:SetHidden( true );
		self.tab = nil;
	end
end

function TabbedInventoryBar:SetBGColor( color )
	self:SetBackColor( color );
	if ( self.tab ~= nil ) then
		self.tab:SetBackColor( color );
	end
end

function TabbedInventoryBar:Refresh()
	MyysticUI.Bars.Core.InventoryBaseBar.Refresh( self );
	if ( self.tab ~= nil ) then
		self.tab:Refresh();
	end
end

function TabbedInventoryBar:SetMenuBackColor( selected )
	MyysticUI.Bars.Core.BaseBar.SetMenuBackColor( self, selected, INVENTORY_MODE );
	self:SetBackColor( Turbine.UI.Color(1,1,1,1) );
	if ( self.tab ~= nil ) then
		self.tab:SetBackColor( Turbine.UI.Color(1,1,1,1) );
	end
end