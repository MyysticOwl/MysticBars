-- Created by MyysticOwl
-- If reusing this code, please keep the name of the original author listed
-- in respect for borrowing said authors code.
-- RESPECT!

import "Turbine";
import "Turbine.UI";
import "MyysticUI.Utils.Class";
import "MyysticUI.Utils.Service";
import "MyysticUI.Bars.Core.BaseBar";
import "MyysticUI.Bars.QuickslotBar";
import "MyysticUI.Bars.ExtensionBar";
import "MyysticUI.Bars.TabbedInventoryBar";
import "MyysticUI.Bars.WindowInventoryBar";

BarService = class( MyysticUI.Utils.Service );

function BarService:Constructor()
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
	
	self.working = false;
	RegisteredBars = { };

	self:Construct( settingsService:GetBars() );
end

function BarService:RefreshBars()
	for key, value in pairs (RegisteredBars) do
		value:Refresh();
	end
end

function BarService:Add( barType, cBarID, cQuickslotID )
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
	
	local bar = nil;
	if ( self.working == false ) then
		self.working = true;
		local settings = settingsService:GetSettings();
		local added = settings.nextBarId;
		if ( cBarID ~= nil and barType ~= EXTENSIONBAR ) then
			added = cBarID;
		end

		if ( barType == QUICKSLOTBAR ) then
			bar = MyysticUI.Bars.QuickslotBar( added );
		elseif ( barType == EXTENSIONBAR ) then
			local barSettings = settingsService:GetBarSettings( cBarID );
			added = settings.nextBarId;
			if ( barSettings.barType == QUICKSLOTBAR ) then
				bar = MyysticUI.Bars.ExtensionBar( added );
				RegisteredBars[cBarID]:RegisterBarExtension( bar, cQuickslotID, added );
			else
				Turbine.Shell.WriteLine( "You can not add an extension to an extension." );
			end
		elseif ( barType == TABBED_INV_BAR ) then
			bar = MyysticUI.Bars.TabbedInventoryBar( added );
		elseif ( barType == WINDOW_INV_BAR ) then
			bar = MyysticUI.Bars.WindowInventoryBar( added );
		end
		if ( bar ~= nil ) then
			RegisteredBars[added] = bar;
			if ( added == settings.nextBarId ) then
				settingsService:IncrementNextId();
			end
			local barSettings = settingsService:GetBarSettings( added );
			settingsService:SetBarSettings( added, barSettings );
			self.working = false;
			return added;
		else
			self.working = false;
			return nil;
		end
	else
		Turbine.Shell.WriteLine( "Your actions are occuring too quickly, please slow down." );
		return nil;
	end
end

function BarService:Remove( barid, removeSettingsWhenNil )
	local eventService = SERVICE_CONTAINER:GetService(MyysticUI.Services.EventService);
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);

	if ( barid ~= nil and RegisteredBars[barid] ~= nil ) then
		eventService:UnregisterForEvents( barid );

		RegisteredBars[barid]:SetVisible( false );
		RegisteredBars[barid]:SetParent( nil );
		if ( removeSettingsWhenNil == nil ) then
			RegisteredBars[barid]:ClearQuickslots( true );
		else
			RegisteredBars[barid]:ClearQuickslots();
		end
		if ( RegisteredBars[barid].Remove ~= nil ) then
			RegisteredBars[barid]:Remove()
		end
		RegisteredBars[barid]:SetVisible( false );
		RegisteredBars[barid]:SetBackColor( Turbine.UI.Color( 0, 0, 0, 0) );
		RegisteredBars[barid] = nil;

		-- Turbine.Shell.WriteLine( "Removing:" .. barid );

		if ( removeSettingsWhenNil == nil ) then
			settingsService:SetBarSettings( barid, nil);
		end
	end
end

function BarService:Copy( barid, bartype )
	local playerService = SERVICE_CONTAINER:GetService(MyysticUI.Services.PlayerService);
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);

	if ( barid ~= nil and self.working == false ) then
		self.working = true;
		settingsService:CopyBars( playerService.player:GetName(), self.PARTIAL, barid, true );
		settingsService:ResetAllBars();
	else
		return nil;
	end
end

function BarService:Reset( barid )
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);

	if ( barid ~= nil and self.working == false ) then
		self.working = true;	
		local barsettings = settingsService:GetBarSettings( barid );
		local tempType = barsettings.barType;
		settingsService:SetBarSettings( barid, nil, false );
		barsettings = settingsService:GetBarSettings( barid );
		barsettings.barType = tempType;
		settingsService:SetBarSettings( barid, barsettings );
		self.working = false;
	else
		return nil;
	end
end

function BarService:Construct( storedBars, second )
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);

	for key, value in pairs (storedBars) do
		if ( value.barType == QUICKSLOTBAR ) then
			local bar = MyysticUI.Bars.QuickslotBar( tonumber(key) );
			RegisteredBars[tonumber(key)] = bar;
		end
		if ( value.barType == TABBED_INV_BAR ) then
			local bar = MyysticUI.Bars.TabbedInventoryBar( tonumber(key) );
			RegisteredBars[tonumber(key)] = bar;
		end
		if ( value.barType == WINDOW_INV_BAR ) then
			local bar = MyysticUI.Bars.WindowInventoryBar( tonumber(key) );
			RegisteredBars[tonumber(key)] = bar;
		end
	end

	for key, value in pairs (storedBars) do
		if ( value.barType == EXTENSIONBAR ) then
			local bar = MyysticUI.Bars.ExtensionBar( key );
			local attachedbarSettings = settingsService:GetBarSettings( key );
			local thebar = RegisteredBars[attachedbarSettings.connectionBarID];
			if ( thebar ~= nil ) then
				thebar:RegisterBarExtension( bar, attachedbarSettings.connectionQuickslotID, key );
				RegisteredBars[tonumber(key)] = bar;
			else
				settingsService:SetBarSettings( key, nil);
				Turbine.Shell.WriteLine( "We found extension bar without a main bar. Deleting. Thank the community for the fix." );
			end
		end
	end
end

function BarService:GetBars()
	return RegisteredBars;
end

function BarService:ShowExtensionBarMenu( barid )
	RegisteredBars[ barid ]:ShowBarMenu();
end

function BarService:UpdateBarExtensions()
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);

	for key, value in pairs (RegisteredBars) do
		local barsettings = settingsService:GetBarSettings( key );
		if ( barsettings.barType == QUICKSLOTBAR and value ~= nil ) then
			RegisteredBars[ key ]:UpdateBarExtensions();
		end
	end
end

function BarService:Alive( barid )
	if ( RegisteredBars[barid] == nil ) then
		return false;
	else
		return true;
	end
end

function BarService:LoadQuickslots()
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);

	for key, value in pairs (RegisteredBars) do
		local bSettings = settingsService:GetBarSettings( key );
		if ( bSettings.barType == QUICKSLOTBAR or bSettings.barType == EXTENSIONBAR ) then
			settingsService:LoadQuickslots( bSettings, RegisteredBars[ key ]:GetQuickslotList().quickslots );
		end
	end
end

function BarService:ExtensionMousedOver()
end

function BarService:ExtensionMousedLeft()
end