-- Created by MyysticOwl
-- If reusing this code, please keep the name of the original author listed
-- in respect for borrowing said authors code.
-- RESPECT!

import "Turbine";
import "Turbine.UI";
import "Tonic.Utils.Class";
import "Tonic.Utils.Service";
import "Tonic.TonicBars.Bars.BaseBar";
import "Tonic.TonicBars.Bars.Quickslots.QuickslotBar";
import "Tonic.TonicBars.Bars.Extension.ExtensionBar";
import "Tonic.TonicBars.Bars.Inventory.TabbedBar";
import "Tonic.TonicBars.Bars.Inventory.WindowBar";

BarService = class( Tonic.Utils.Service );

function BarService:Constructor()
	self.eventService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.EventService);
	self.playerService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.PlayerService);
	self.settingsService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.SettingsService);
	
	self.working = false;
	RegisteredBars = { };

	self:Construct( self.settingsService:GetBars() );
end

function BarService:RefreshBars()
	for key, value in pairs (RegisteredBars) do
		value:Refresh();
	end
end

function BarService:Add( barType, cBarID, cQuickslotID )
	local tonic = nil;
	if ( self.working == false ) then
		self.working = true;
		local settings = self.settingsService:GetSettings();
		local added = settings.nextBarId;
		if ( cBarID ~= nil and barType ~= EXTENSIONBAR ) then
			added = cBarID;
		end

		if ( barType == QUICKSLOTBAR ) then
			tonic = Tonic.TonicBars.Bars.Quickslots.QuickslotBar( added );
		elseif ( barType == EXTENSIONBAR ) then
			local barSettings = self.settingsService:GetBarSettings( cBarID );
			added = settings.nextBarId;
			if ( barSettings.barType == QUICKSLOTBAR ) then
				tonic = Tonic.TonicBars.Bars.Extension.ExtensionBar( added );
				RegisteredBars[cBarID]:RegisterBarExtension( tonic, cQuickslotID, added );
			else
				Turbine.Shell.WriteLine( "You can not add an extension to an extension." );
			end
		elseif ( barType == TABBED_INV_BAR ) then
			tonic = Tonic.TonicBars.Bars.Inventory.TabbedBar( added );
		elseif ( barType == WINDOW_INV_BAR ) then
			tonic = Tonic.TonicBars.Bars.Inventory.WindowBar( added );
		end
		if ( tonic ~= nil ) then
			RegisteredBars[added] = tonic;
			if ( added == settings.nextBarId ) then
				self.settingsService:IncrementNextId();
			end
			local barSettings = self.settingsService:GetBarSettings( added );
			self.settingsService:SetBarSettings( added, barSettings );
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
	if ( barid ~= nil and RegisteredBars[barid] ~= nil ) then
		self.eventService:UnregisterForEvents( barid );

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
			self.settingsService:SetBarSettings( barid, nil);
		end
	end
end

function BarService:Copy( barid, bartype )
	if ( barid ~= nil and self.working == false ) then
		self.working = true;
		self.settingsService:CopyBars( self.playerService.player:GetName(), self.PARTIAL, barid, true );
		self.settingsService:ResetAllBars();
	else
		return nil;
	end
end

function BarService:Reset( barid )
	if ( barid ~= nil and self.working == false ) then
		self.working = true;	
		local barsettings = self.settingsService:GetBarSettings( barid );
		local tempType = barsettings.barType;
		self.settingsService:SetBarSettings( barid, nil, false );
		barsettings = self.settingsService:GetBarSettings( barid );
		barsettings.barType = tempType;
		self.settingsService:SetBarSettings( barid, barsettings );
		self.working = false;
	else
		return nil;
	end
end

function BarService:Construct( storedBars, second )
	for key, value in pairs (storedBars) do
		if ( value.barType == QUICKSLOTBAR ) then
			local tonic = Tonic.TonicBars.Bars.Quickslots.QuickslotBar( tonumber(key) );
			RegisteredBars[tonumber(key)] = tonic;
		end
		if ( value.barType == TABBED_INV_BAR ) then
			local tonic = Tonic.TonicBars.Bars.Inventory.TabbedBar( tonumber(key) );
			RegisteredBars[tonumber(key)] = tonic;
		end
		if ( value.barType == WINDOW_INV_BAR ) then
			local tonic = Tonic.TonicBars.Bars.Inventory.WindowBar( tonumber(key) );
			RegisteredBars[tonumber(key)] = tonic;
		end
	end

	for key, value in pairs (storedBars) do
		if ( value.barType == EXTENSIONBAR ) then
			local tonic = Tonic.TonicBars.Bars.Extension.ExtensionBar( key );
			local attachedbarSettings = self.settingsService:GetBarSettings( key );
			local thebar = RegisteredBars[attachedbarSettings.connectionBarID];
			if ( thebar ~= nil ) then
				thebar:RegisterBarExtension( tonic, attachedbarSettings.connectionQuickslotID, key );
				RegisteredBars[tonumber(key)] = tonic;
			else
				self.settingsService:SetBarSettings( key, nil);
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
	for key, value in pairs (RegisteredBars) do
		local barsettings = self.settingsService:GetBarSettings( key );
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
	for key, value in pairs (RegisteredBars) do
		local bSettings = self.settingsService:GetBarSettings( key );
		if ( bSettings.barType == QUICKSLOTBAR or bSettings.barType == EXTENSIONBAR ) then
			self.settingsService:LoadQuickslots( bSettings, RegisteredBars[ key ]:GetQuickslotList().quickslots );
		end
	end
end

function BarService:ExtensionMousedOver()
end

function BarService:ExtensionMousedLeft()
end