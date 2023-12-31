-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "MysticBars.Utils.Class";
import "MysticBars.Menus.Core.UI.Window";
import "MysticBars.Bars.Core.InventoryBaseBar";
import "MysticBars.Bars.Core.Tab"

TabbedInventoryBar = class( MysticBars.Bars.Core.InventoryBaseBar );

TabbedInventoryBar.Log = MysticBars.Utils.Logging.LogManager.GetLogger( "TabbedInventoryBar", false );

function TabbedInventoryBar:Constructor( barid )
	self.Log:Debug("Constructor");

	SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(barid, function(barSettings)
		if (barSettings.barType ~= TABBED_INV_BAR) then
			barSettings.barType = TABBED_INV_BAR;
			barSettings.quickslotRows = 1;
			barSettings.quickslotColumns = 4;
			barSettings.quickslotCount = 12;
			barSettings.visible = true;
		end
		return barSettings;
	end, nil, true);

	MysticBars.Bars.Core.InventoryBaseBar.Constructor( self, barid );
end

function TabbedInventoryBar:Create()
	MysticBars.Bars.Core.InventoryBaseBar.Create( self );

	self.Log:Debug("Create");

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings( self.id );

	local title = barSettings.barName;
	if ( barSettings.barName == nil or barSettings.barName == "" ) then
		title = "Bar:" .. self.id;
	end
	self.tab = MysticBars.Bars.Core.Tab( self, title );
	--self.quickslotList:SetPosition(0, 0 );
end

function TabbedInventoryBar:Remove()
	self.Log:Debug("Remove");

	if ( self.tab ~= nil ) then
		self.tab:SetHidden( true );
		self.tab = nil;
	end
end

function TabbedInventoryBar:SetBGColor( color )
	self.Log:Debug("SetBGColor");

	self:SetBackColor( color );
	if ( self.tab ~= nil ) then
		self.tab:SetBackColor( color );
	end
end

function TabbedInventoryBar:Refresh()
	self.Log:Debug("Refresh");

	MysticBars.Bars.Core.InventoryBaseBar.Refresh( self );
	if ( self.tab ~= nil ) then
		self.tab:Refresh();
	end
end

function TabbedInventoryBar:SetMenuBackColor( selected )
	self.Log:Debug("SetMenuBackColor");

	MysticBars.Bars.Core.BaseBar.SetMenuBackColor( self, selected, INVENTORY_MODE );
	self:SetBackColor( Turbine.UI.Color(1,1,1,1) );
	if ( self.tab ~= nil ) then
		self.tab:SetBackColor( Turbine.UI.Color(1,1,1,1) );
	end
end