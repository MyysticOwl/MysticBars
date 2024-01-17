-- Created by MyysticOwl
-- If reusing this code, please keep the name of the original author listed
-- in respect for borrowing said authors code.
-- RESPECT!

BarService = class( MysticBars.Utils.Service );

BarService.Log = MysticBars.Utils.Logging.LogManager.GetLogger( "BarService" );

function BarService:Constructor()
	self.Log:Debug("constructor");

	self.working = false;
	RegisteredBars = { };

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	self:Construct( settingsService:GetBars() );
end

function BarService:RefreshBars( drawShortcuts )
	self.Log:Debug("RefreshBars");

	for key, value in pairs (RegisteredBars) do
		value:Refresh( drawShortcuts );
	end
end

function BarService:Add( barType )
	self.Log:Debug("Add");

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local barSettings = settingsService:NewBar();

	if (barType == QUICKSLOTBAR) then
		barSettings.barType = QUICKSLOTBAR;
		return self:AddQuickslotBar(barSettings);
	elseif (barType == INVENTORY_BAR) then
		barSettings.barType = INVENTORY_BAR;
		return self:AddInventoryBar(barSettings);
	end

	return nil;
end

function BarService:AddQuickslotBar( barSettings )
	self.Log:Debug("AddQuickslotBar id:" .. barSettings.id);

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	settingsService:SetBarSettings( barSettings );

	local bar = MysticBars.Bars.QuickslotBar( barSettings );
	RegisteredBars[ barSettings.id ] = bar;

	return barSettings, bar;
end

function BarService:AddExtensionBar( newBarSettings, connectingBarId, connectingSlotNumber )
	self.Log:Debug("AddExtensionBar " .. connectingBarId);

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local barSettings = settingsService:GetBarSettings( connectingBarId );

	local bar = nil;
	if ( barSettings.barType == QUICKSLOTBAR ) then
		newBarSettings.locked = true;
		newBarSettings.orientation = "Right";
		newBarSettings.barTermination = 1;

		local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
		settingsService:SetBarSettings( newBarSettings );

		bar = MysticBars.Bars.ExtensionBar( newBarSettings );
		RegisteredBars[connectingBarId]:RegisterBarExtension( bar, connectingSlotNumber, newBarSettings.id );

	else
		Turbine.Shell.WriteLine( "You can not add an extension to an extension." );
	end

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	settingsService:SetBarSettings( barSettings );

	return barSettings, bar;
end

function BarService:AddInventoryBar( barSettings )
	self.Log:Debug("AddInventoryBar");

	barSettings.quickslotRows = 1;
	barSettings.quickslotColumns = 4;
	barSettings.quickslotCount = 12;
	barSettings.visible = true;

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	settingsService:SetBarSettings( barSettings );

	local bar = MysticBars.Bars.InventoryBar( barSettings );
	RegisteredBars[ barSettings.id ] = bar;

	return barSettings, bar;
end

function BarService:Remove( barid )
	self.Log:Debug("Remove");

	local eventService = SERVICE_CONTAINER:GetService(MysticBars.Services.EventService);
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

	if ( barid ~= nil and RegisteredBars[barid] ~= nil ) then
		eventService:UnregisterForEvents( barid );

		RegisteredBars[barid]:ClearQuickslots( true );
		if ( RegisteredBars[barid].Remove ~= nil ) then
			RegisteredBars[barid]:Remove()
		end
		RegisteredBars[barid]:SetParent( nil );
		RegisteredBars[barid]:SetVisible( false );
		RegisteredBars[barid]:SetBackColor( Turbine.UI.Color( 0, 0, 0, 0) );
		RegisteredBars[barid] = nil;

		settingsService:ClearBarSettings( barid);

		collectgarbage();

		local menuService = SERVICE_CONTAINER:GetService(MysticBars.Services.MenuService)
		if (menuService ~= nil) then
			menuService:GetMenu():Refresh(true);
		end
	end
end

function BarService:Copy( barid, bartype )
	self.Log:Debug("Copy");

	local playerService = SERVICE_CONTAINER:GetService(MysticBars.Services.PlayerService);
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

	if ( barid ~= nil and self.working == false ) then
		self.working = true;
		settingsService:CopyBars( playerService.player:GetName(), self.PARTIAL, barid, true );
		settingsService:ResetAllBars();
	else
		return nil;
	end
end

function BarService:Reset( barid )
	self.Log:Debug("Reset");

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

	if ( barid ~= nil and self.working == false ) then
		self.working = true;	
		local barsettings = settingsService:GetBarSettings( barid );
		local tempType = barsettings.barType;
		settingsService:ClearBarSettings( barid );
		barsettings = settingsService:GetBarSettings( barid );
		barsettings.barType = tempType;
		settingsService:SetBarSettings( barsettings );
		self.working = false;
	else
		return nil;
	end
end

function BarService:Construct( storedBars, second )
	self.Log:Debug("Construct");

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

	for key, value in pairs (storedBars) do
		if (value.id == nil) then
			value.id = tonumber(key);
		end
		if ( value.barType == QUICKSLOTBAR and value ~= nil) then
			local bar = MysticBars.Bars.QuickslotBar( value );
			RegisteredBars[tonumber(key)] = bar;
		end
		if ( value.barType == INVENTORY_BAR ) then
			local bar = MysticBars.Bars.InventoryBar( value );
			RegisteredBars[tonumber(key)] = bar;
		end
	end

	for key, value in pairs (storedBars) do
		if ( value.barType == EXTENSIONBAR ) then
			local bar = MysticBars.Bars.ExtensionBar( value );
			local thebar = RegisteredBars[value.connectionBarID];
			if ( thebar ~= nil ) then
				thebar:RegisterBarExtension( bar, value.connectionQuickslotID, key );
				RegisteredBars[tonumber(key)] = bar;
				thebar:UpdateBarExtensions();
			else
				settingsService:ClearBarSettings( key);
				Turbine.Shell.WriteLine( "We found extension bar without a main bar. Deleting. Thank the community for the fix." );
			end
		end
	end
end

function BarService:GetBars()
	self.Log:Debug("GetBars");

	return RegisteredBars;
end

function BarService:GetBar( barId )
	self.Log:Debug("GetBar");

	return RegisteredBars[ barId ];
end

function BarService:ExtensionMousedOver()
end

function BarService:ExtensionMousedLeft()
end