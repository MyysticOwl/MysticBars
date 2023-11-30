-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

import "Tonic.Utils.Class";
import "Tonic.UI.Window";
import "Tonic.TonicBars.Bars.Inventory.InventoryBaseBar";
import "Tonic.TonicBars.Bars.Decorator.Tab"

TabbedBar = class( Tonic.TonicBars.Bars.Inventory.InventoryBaseBar );

function TabbedBar:Constructor( barid )
	self.settingsService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.SettingsService);

	self.id = barid;

	local thebarSettings = self.settingsService:GetBarSettings( self.id );
	if ( thebarSettings.barType ~= TABBED_INV_BAR ) then
		thebarSettings.barType = TABBED_INV_BAR;
		thebarSettings.quickslotRows = 1;
		thebarSettings.quickslotColumns = 4;
		thebarSettings.quickslotCount = 12;
		thebarSettings.visible = true;
		self.settingsService:SetBarSettings( self.id, thebarSettings );
	end

	Tonic.TonicBars.Bars.Inventory.InventoryBaseBar.Constructor( self );
end

function TabbedBar:Create()
	Tonic.TonicBars.Bars.Inventory.InventoryBaseBar.Create( self );
	
	local barSettings = self.settingsService:GetBarSettings( self.id );
	local title = barSettings.barName;
	if ( barSettings.barName == nil or barSettings.barName == "" ) then
		title = "Bar:" .. self.id;
	end
	self.tab = Tonic.TonicBars.Bars.Decorator.Tab( self, title );
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
	Tonic.TonicBars.Bars.Inventory.InventoryBaseBar.Refresh( self );
	if ( self.tab ~= nil ) then
		self.tab:Refresh();
	end
end

function TabbedBar:SetMenuBackColor( selected )
	Tonic.TonicBars.Bars.BaseBar.SetMenuBackColor( self, selected, INVENTORY_MODE );
	self:SetBackColor( Turbine.UI.Color(1,1,1,1) );
	if ( self.tab ~= nil ) then
		self.tab:SetBackColor( Turbine.UI.Color(1,1,1,1) );
	end
end