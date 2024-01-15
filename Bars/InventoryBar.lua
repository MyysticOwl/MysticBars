-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

InventoryBar = class( MysticBars.Bars.Core.BaseBar );

InventoryBar.Log = MysticBars.Utils.Logging.LogManager.GetLogger( "InventoryBar" );

function InventoryBar:Constructor( barSettings )
	self.Log:Debug("Constructor");

	MysticBars.Bars.Core.BaseBar.Constructor( self, barSettings );

	self.isVisible = true;

	SERVICE_CONTAINER:GetService(MysticBars.Services.EventService):RegisterForEvents( self, self.id );
	SERVICE_CONTAINER:GetService(MysticBars.Services.InventoryService):RegisterForEvents( self, self.id );
end

function InventoryBar:Create()
	self.Log:Debug("Create");

	self.quickslotList = MysticBars.Bars.Core.ItemList( self.id );
	self.quickslotList:SetParent( self );

	MysticBars.Bars.Core.BaseBar.Create( self );

	self:Refresh("Create");
end

function InventoryBar:Refresh( count )
	self.Log:Debug("Refresh");

	MysticBars.Bars.Core.BaseBar.Refresh( self );

	SERVICE_CONTAINER:GetService(MysticBars.Services.EventService):NotifyClients();
end

function InventoryBar:EditModeRefresh( barSettings )
	self.Log:Debug("NormalModeRefresh");

	self:SetBackColor(Turbine.UI.Color(0.8,0.63,0.4));
	self:SetVisible( true );
	
	MysticBars.Bars.Core.BaseBar.EditModeRefresh( self, barSettings );
end

function InventoryBar:ClearQuickslots()
	self.Log:Debug("ClearQuickslots");

	self.quickslotList:ClearQuickslots();
end

-- This function should ONLY be called by the Event Manager. Doing so in any other copacity
-- can and will cause issues with the visibility of the bars.
--
-- It is recommended to call: "eventService:NotifyClients();" if needed.
function InventoryBar:DetermineVisiblity( eventValue, force )
	self.Log:Debug("DetermineVisiblity");

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local settings = settingsService:GetSettings();
	local barSettings = settingsService:GetBarSettings( self.id );

	if ( settings.barMode == NORMAL_MODE ) then
		local visible = false;
		if ( eventValue ~= nil and eventValue ) then
			visible = true;
		end
		if ( visible == false and self.isVisible == true ) then
			visible = barSettings.visible;
		end
		if ( self.f12HideBar ) then
			visible = false;
		end
		self:SetVisible( visible );

		self:IsSelected();
	end
end