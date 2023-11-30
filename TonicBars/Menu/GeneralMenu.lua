-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "Tonic.Utils.Class";
import "Tonic.UI.CheckBox";
import "Tonic.UI.ComboBox";
import "Tonic.UI.AutoListBox";
import "Tonic.UI.MenuUtils";

buttonWidth = 90;
selectionWidth = 160;
selectionHeight = 20;
insideBoxXOffset = selectionWidth + 5;
insideBoxYOffset = startFromTop + 200;

GeneralMenu = class( Tonic.UI.AutoListBox );

function GeneralMenu:Constructor()
	Tonic.UI.AutoListBox.Constructor( self );

	self.settingsService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.SettingsService);

	self.utils = Tonic.UI.MenuUtils();

	self.settingsBox = self.utils:AddAutoListBox( self, Turbine.UI.Orientation.Vertical, 0, 0, 0, 0 );


	self:AddItem( self.settingsBox );
end

function GeneralMenu:AddSettings()
	self.utils:AddLabelBox( self.settingsBox, "", 0, 15 );
	self.utils:AddCategoryBox(self.settingsBox, LOCALESTRINGS.GeneralMenu["Copy Profiles"]);

	self.utils:AddLabelBox( self.settingsBox, LOCALESTRINGS.GeneralMenu["Profiles"], selectionWidth + 200, selectionHeight + 25 );

	self.profileList = Tonic.UI.ComboBox();
	self.profileList:SetSize( 200, 20 );
	self.profileList:SetParent( self.settingsBox );
	self.settingsBox:AddItem( self.profileList );

	self.utils:AddLabelBox( self.settingsBox, "", 0, 15 );
	self.utils:AddLabelBox( self.settingsBox, LOCALESTRINGS.GeneralMenu["Take"], selectionWidth + 200, selectionHeight );

	self.theirBarList = Tonic.UI.ComboBox();
	self.theirBarList:SetSize( 200, 20 );
	self.theirBarList:SetParent( self.settingsBox );
	self.settingsBox:AddItem( self.theirBarList );

	self.utils:AddLabelBox( self.settingsBox, LOCALESTRINGS.GeneralMenu["Give"], selectionWidth + 200, selectionHeight );
	self.myBarList = Tonic.UI.ComboBox();
	self.myBarList:SetSize( 200, 20 );
	self.myBarList:SetParent( self.settingsBox );
	self.settingsBox:AddItem( self.myBarList );

	local box1 = self.utils:AddAutoListBox( self.settingsBox, Turbine.UI.Orientation.Horizontal );	
	local noShortcutButton = Turbine.UI.Lotro.Button();
	noShortcutButton:SetText( LOCALESTRINGS.GeneralMenu["Without Icons"] );
	noShortcutButton:SetSize( buttonWidth + 75, selectionHeight );
	noShortcutButton.MouseClick = function( sender, args )
		local profile = self.profileList:GetSelection();
		local theirBar = self.theirBarList:GetSelection();
		local myBar = self.myBarList:GetSelection();
		if ( profile ~= nil and theirBar ~= nil and theirBar ~= "" ) then
			self.settingsService:CopyProfile( profile, self.settingsService.PARTIAL, theirBar, false );
		elseif ( profile ~= nil and myBar ~= nil and myBar ~= "" ) then
			self.utils:AddLabelBox( self.settingsBox, "", 0, 15 );
			self.settingsService:CopyProfile( profile, self.settingsService.PARTIAL, myBar, true );
		end
	end
	box1:AddItem( noShortcutButton );

	local shortcutButton = Turbine.UI.Lotro.Button();
	shortcutButton:SetText( LOCALESTRINGS.GeneralMenu["With Icons"] );
	shortcutButton:SetSize( buttonWidth + 75, selectionHeight );
	shortcutButton.MouseClick = function( sender, args )
		local profile = self.profileList:GetSelection();
		local theirBar = self.theirBarList:GetSelection();
		local myBar = self.myBarList:GetSelection();
		if ( profile ~= nil and theirBar ~= nil and theirBar ~= "" ) then
			self.settingsService:CopyProfile( profile, self.settingsService.ALL, theirBar, false );
		elseif ( profile ~= nil and myBar ~= nil and myBar ~= "" ) then
			self.settingsService:CopyProfile( profile, self.settingsService.ALL, myBar, true );
		end
	end
	box1:AddItem( shortcutButton );
	self.settingsBox:AddItem( box1 );

	self.utils:AddLabelBox( self.settingsBox, "", 200, 200 );
end

function GeneralMenu:AddCommandsBar()
end

function GeneralMenu:DisplaySettings( showQuickslots )
	self.settingsBox:SetVisible( showQuickslots );

	self.profileList.SelectedIndexChanged = function(sender, args)
		self:RefreshTheirProfileBars();
		self:ChangeProfileVisibilty();
	end
	self.myBarList.SelectedIndexChanged = function(sender, args)
		if ( self.myBarList:GetSelection() == "" ) then
			self:RefreshTheirProfileBars();
		else
			self.theirBarList:Clear();
		end
	end
	self.theirBarList.SelectedIndexChanged = function(sender, args)
		if ( self.theirBarList:GetSelection() == "" ) then
			self:RefreshMyProfileBars();
		else
			self.myBarList:Clear();
		end
	end
end

function GeneralMenu:GetSelection()
	return nil;
end

function GeneralMenu:ChangeProfileVisibilty()
	if ( self.profileList:GetSelection() == nil or self.profileList:GetSelection() == "" ) then
		self.myBarList:SetVisible( false );
		self.theirBarList:SetVisible( false );		
	else
		self.myBarList:SetVisible( true );
		self.theirBarList:SetVisible( true );
	end
end

function GeneralMenu:RefreshComboBox()
	self.profileList:Clear();
	for key, value in opairs (self.settingsService:GetProfiles() ) do
		local found = false;
		if ( player:GetName() == key ) then
			found = true;
		end
		for i = 1, self.profileList:GetItemCount() do
			if ( self.profileList:GetItem(i) == key ) then
				found = true;
			end
		end
		if ( found == false ) then
			self.profileList:AddItem( key, key );
		end
	end
	self:RefreshMyProfileBars();
end

function GeneralMenu:RefreshTheirProfileBars()
	self.theirBarList:Clear();
	self.theirBarList:AddItem( "", "" );
	for key, value in opairs (self.settingsService:GetProfileBars(self.profileList:GetSelection()) ) do
		local found = false;
		if ( player:GetName() == key ) then
			found = true;
		end
		for i = 1, self.theirBarList:GetItemCount() do
			if ( self.theirBarList:GetItem(i) == key ) then
				found = true;
			end
		end
		if ( found == false ) then
			if ( value.barName ~= nil and value.barName ~= "" ) then
				self.theirBarList:AddItem( self:AppendBarType( value.barType, value.barName ) , key );
			else
				self.theirBarList:AddItem( self:AppendBarType( value.barType, key ), key );
			end
		end
	end
end

function GeneralMenu:RefreshMyProfileBars()
	self.myBarList:Clear();
	self.myBarList:AddItem( "", "" );
	for key, value in opairs (self.settingsService:GetBars() ) do
		local found = false;
		if ( player:GetName() == key ) then
			found = true;
		end
		for i = 1, self.myBarList:GetItemCount() do
			if ( self.myBarList:GetItem(i) == key ) then
				found = true;
			end
		end
		if ( found == false ) then
			if ( value.barName ~= nil and value.barName ~= "" ) then
				self.myBarList:AddItem( self:AppendBarType( value.barType, value.barName ) , key );
			else
				self.myBarList:AddItem( self:AppendBarType( value.barType, key ), key );
			end
		end
	end
end

function GeneralMenu:AppendBarType( type, value )
	local name;
	if ( type == QUICKSLOTBAR) then
		name = value .. " (Quick)"
	elseif ( type == EXTENSIONBAR) then
		name = value .. " (Ext)"
	else
		name = value .. " (Inv)"
	end
	return name
end
