-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine";
import "MyysticUI.Utils.Class";
import "MyysticUI.UI.MenuUtils";

buttonWidth = 90;
selectionWidth = 160;
selectionHeight = 20;

GeneralMenuPanel = class( Turbine.Object );

GeneralMenuPanel.utils = MyysticUI.UI.MenuUtils();

function GeneralMenuPanel:Draw(context)
	menu.contentBox:ClearItems();
	
	local settingsBox = MyysticUI.UI.AutoListBox();

	self.utils:AddCategoryBox(settingsBox, "General Settings");

	if ( realClassSet == nil ) then
		self.utils:AddLabelBox( settingsBox, "Plugin can't determine your class, please select the correct one:", selectionWidth + 200, selectionHeight + 10 );

		self.classList = MyysticUI.UI.ComboBox();
		self.classList:SetSize( 200, 20 );
		self.classList:SetParent( settingsBox );
		self.classList:AddItem( "Guardian", 		23 );
		self.classList:AddItem( "Captain", 		24 );
		self.classList:AddItem( "Minstrel", 		31 );
		self.classList:AddItem( "Burglar", 		40 );
		self.classList:AddItem( "Hunter", 		162 );
		self.classList:AddItem( "Champion", 		172 );
		self.classList:AddItem( "Lore Master", 	185 );
		self.classList:AddItem( "Rune Keeper", 	193 );
		self.classList:AddItem( "Warden", 		194 );
		self.classList:AddItem( "Beorning", 		214 );
		self.classList:AddItem( "Brawler", 		215 );
		self.classList:AddItem( "Mariner", 		216 );
		settingsBox:AddItem( self.classList );
	end

	self.utils:AddLabelBox(settingsBox, "If you want to copy your bar locations from another character on this server you can perform that by selecting the characters name from the dropdown and selecting 'Copy Profile'.", selectionWidth + 250, selectionHeight + 40 );

	self.utils:AddCategoryBox(settingsBox, "Languages");

	self.languageList = MyysticUI.UI.ComboBox();
	self.languageList:SetSize( 200, 20 );
	self.languageList:SetParent( settingsBox );
	self.languageList:AddItem( "English", "en" );
	self.languageList:AddItem( "German", "de" );
	self.languageList:AddItem( "French", "fr" );
	settingsBox:AddItem( self.languageList );

	self:AddSettings(settingsBox);
	self:AddCommandsBar(settingsBox);

	menu.contentBox:AddItem( settingsBox );

	self:DisplaySettings();
	self:RefreshComboBox();
end

function GeneralMenuPanel:AddSettings(settingsBox)
	self.utils:AddLabelBox( settingsBox, "", 0, 15 );
	self.utils:AddCategoryBox(settingsBox, "Copy Profiles");

	self.utils:AddLabelBox( settingsBox, "Profiles", selectionWidth + 200, selectionHeight + 25 );

	self.profileList = MyysticUI.UI.ComboBox();
	self.profileList:SetSize( 200, 20 );
	self.profileList:SetParent( settingsBox );
	settingsBox:AddItem( self.profileList );

	self.utils:AddLabelBox( settingsBox, "", 0, 15 );
	self.utils:AddLabelBox( settingsBox, "Take", selectionWidth + 200, selectionHeight );

	self.theirBarList = MyysticUI.UI.ComboBox();
	self.theirBarList:SetSize( 200, 20 );
	self.theirBarList:SetParent( settingsBox );
	settingsBox:AddItem( self.theirBarList );

	self.utils:AddLabelBox( settingsBox, "Give", selectionWidth + 200, selectionHeight );
	self.myBarList = MyysticUI.UI.ComboBox();
	self.myBarList:SetSize( 200, 20 );
	self.myBarList:SetParent( settingsBox );
	settingsBox:AddItem( self.myBarList );

	local box1 = self.utils:AddAutoListBox( settingsBox, Turbine.UI.Orientation.Horizontal );	
	local noShortcutButton = Turbine.UI.Lotro.Button();
	noShortcutButton:SetText( "Without Icons" );
	noShortcutButton:SetSize( buttonWidth + 75, selectionHeight );
	noShortcutButton.MouseClick = function( sender, args )
		local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);

		local profile = self.profileList:GetSelection();
		local theirBar = self.theirBarList:GetSelection();
		local myBar = self.myBarList:GetSelection();
		if ( profile ~= nil and theirBar ~= nil and theirBar ~= "" ) then
			settingsService:CopyProfile( profile, settingsService.PARTIAL, theirBar, false );
		elseif ( profile ~= nil and myBar ~= nil and myBar ~= "" ) then
			self.utils:AddLabelBox( settingsBox, "", 0, 15 );
			settingsService:CopyProfile( profile, settingsService.PARTIAL, myBar, true );
		end
	end
	box1:AddItem( noShortcutButton );

	local shortcutButton = Turbine.UI.Lotro.Button();
	shortcutButton:SetText( "With Icons" );
	shortcutButton:SetSize( buttonWidth + 75, selectionHeight );
	shortcutButton.MouseClick = function( sender, args )
		local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);

		local profile = self.profileList:GetSelection();
		local theirBar = self.theirBarList:GetSelection();
		local myBar = self.myBarList:GetSelection();
		if ( profile ~= nil and theirBar ~= nil and theirBar ~= "" ) then
			settingsService:CopyProfile( profile, settingsService.ALL, theirBar, false );
		elseif ( profile ~= nil and myBar ~= nil and myBar ~= "" ) then
			settingsService:CopyProfile( profile, settingsService.ALL, myBar, true );
		end
	end
	box1:AddItem( shortcutButton );
	settingsBox:AddItem( box1 );

	self.utils:AddLabelBox( settingsBox, "", 200, 200 );
end

function GeneralMenuPanel:AddCommandsBar(settingsBox)
end

function GeneralMenuPanel:DisplaySettings()
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

function GeneralMenuPanel:GetSelection()
	return nil;
end

function GeneralMenuPanel:ChangeProfileVisibilty()
	if ( self.profileList:GetSelection() == nil or self.profileList:GetSelection() == "" ) then
		self.myBarList:SetVisible( false );
		self.theirBarList:SetVisible( false );		
	else
		self.myBarList:SetVisible( true );
		self.theirBarList:SetVisible( true );
	end
end

function GeneralMenuPanel:RefreshComboBox()
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);

	self.profileList:Clear();
	for key, value in opairs (settingsService:GetProfiles() ) do
		local found = false;
		local playerService = SERVICE_CONTAINER:GetService(MyysticUI.Services.PlayerService);
		if ( playerService:GetName() == key ) then
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

function GeneralMenuPanel:RefreshTheirProfileBars()
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);

	self.theirBarList:Clear();
	self.theirBarList:AddItem( "", "" );
	for key, value in opairs (settingsService:GetProfileBars(self.profileList:GetSelection()) ) do
		local found = false;
		local playerService = SERVICE_CONTAINER:GetService(MyysticUI.Services.PlayerService);
		if ( playerService:GetName() == key ) then
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

function GeneralMenuPanel:RefreshMyProfileBars()
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);

	self.myBarList:Clear();
	self.myBarList:AddItem( "", "" );
	for key, value in opairs (settingsService:GetBars() ) do
		local found = false;
		local playerService = SERVICE_CONTAINER:GetService(MyysticUI.Services.PlayerService);
		if ( playerService:GetName() == key ) then
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

function GeneralMenuPanel:AppendBarType( type, value )
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