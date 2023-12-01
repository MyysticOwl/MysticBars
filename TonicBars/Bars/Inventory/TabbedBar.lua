-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

import "MyysticBars.Utils.Class";
import "MyysticBars.UI.Window";
import "MyysticBars.TonicBars.Bars.Inventory.InventoryBaseBar";
import "MyysticBars.TonicBars.Bars.Decorator.Tab"

TabbedBar = class( MyysticBars.TonicBars.Bars.Inventory.InventoryBaseBar );

function TabbedBar:Constructor( barid )
	local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);

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

	MyysticBars.TonicBars.Bars.Inventory.InventoryBaseBar.Constructor( self );
end

function TabbedBar:Create()
	MyysticBars.TonicBars.Bars.Inventory.InventoryBaseBar.Create( self );
	
	local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings( self.id );

	local title = barSettings.barName;
	if ( barSettings.barName == nil or barSettings.barName == "" ) then
		title = "Bar:" .. self.id;
	end
	self.tab = MyysticBars.TonicBars.Bars.Decorator.Tab( self, title );
	--self.quickslotList:SetPosition(0, 0 );
end

function TabbedBar:Remove()
	if ( self.tab ~= nil ) then
		self.tab:SetHidden( true );
		self.tab = nil;
	end
end

function TabbedBar:SetBGColor( color )
	self:SetBackColor( color );
	if ( self.tab ~= nil ) then
		self.tab:SetBackColor( color );
	end
end

function TabbedBar:Refresh()
	MyysticBars.TonicBars.Bars.Inventory.InventoryBaseBar.Refresh( self );
	if ( self.tab ~= nil ) then
		self.tab:Refresh();
	end
end

function TabbedBar:SetMenuBackColor( selected )
	MyysticBars.TonicBars.Bars.BaseBar.SetMenuBackColor( self, selected, INVENTORY_MODE );
	self:SetBackColor( Turbine.UI.Color(1,1,1,1) );
	if ( self.tab ~= nil ) then
		self.tab:SetBackColor( Turbine.UI.Color(1,1,1,1) );
	end
end