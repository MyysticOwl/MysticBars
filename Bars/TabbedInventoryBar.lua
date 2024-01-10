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

TabbedInventoryBar.Log = MysticBars.Utils.Logging.LogManager.GetLogger( "TabbedInventoryBar" );

function TabbedInventoryBar:Constructor( barSettings )
	self.Log:Debug("Constructor");

	MysticBars.Bars.Core.InventoryBaseBar.Constructor( self, barSettings );
end

function TabbedInventoryBar:Create()
	MysticBars.Bars.Core.InventoryBaseBar.Create( self );

	self.Log:Debug("Create");

	local title = self.barSettings.barName;
	if ( self.barSettings.barName == nil or self.barSettings.barName == "" ) then
		title = "Bar:" .. self.id;
	end
	self.tab = MysticBars.Bars.Core.Tab( self, title );
end

function TabbedInventoryBar:PositionChanged( sender, args )
	self.Log:Debug("PositionChanged");

	local settings = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):GetSettings();
	if ( settings.barMode ~= NORMAL_MODE or ( self.DragBar ~= nil and self.DragBar:IsHUDVisible() == true ) ) then
		SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.id, function(barSettings)
			local x, y = self:GetPosition();

			barSettings.relationalX = x / DISPLAYWIDTH;
			barSettings.relationalY = y / DISPLAYHEIGHT;

			barSettings.x = math.floor(barSettings.relationalX * DISPLAYWIDTH);
			barSettings.y = math.floor(barSettings.relationalY * DISPLAYHEIGHT);
			return barSettings;
		end, function(barSettings)
			self:SetPosition( barSettings.x, barSettings.y );
			self.tab:Refresh();
		end);
	end
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

	MysticBars.Bars.Core.InventoryBaseBar.Refresh( self, "TabbedInventoryBar:Refresh" );
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