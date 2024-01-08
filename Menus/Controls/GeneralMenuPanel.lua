-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

buttonWidth = 90;

GeneralMenuPanel = class( MysticBars.Menus.Controls.BasePanel );

GeneralMenuPanel.utils = MysticBars.Menus.Core.UI.MenuUtils();

function GeneralMenuPanel:Constructor( barId, barValue )
	MysticBars.Menus.Controls.BasePanel.Constructor(self, barId, barValue);

	self:SetHeight(210);

    self.utils:AddLabelBox( self.panelBackground, L["Copy Profiles:"], 120, selectionHeight, nil, 5, 5 );
    self.profileList = self.utils:AddComboBox(self.panelBackground, 7, 200, 20, 120, 5);

    self.utils:AddLabelBox( self.panelBackground, L["Take:"], 120, selectionHeight, nil, 5, 30 );
    self.theirBarList = self.utils:AddComboBox(self.panelBackground, 7, 200, 20, 120, 30);

    self.utils:AddLabelBox( self.panelBackground, L["Give:"], 120, selectionHeight, nil, 5, 60 );
    self.myBarList = self.utils:AddComboBox(self.panelBackground, 6, 200, 20, 120, 60);

    self.utils:AddButton( self.panelBackground, L["Without Icons"], 120, selectionHeight, function(sender, args)
		local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

		local profile = self.profileList:GetSelection();
		local theirBar = self.theirBarList:GetSelection();
		local myBar = self.myBarList:GetSelection();
		if ( profile ~= nil and theirBar ~= nil and theirBar ~= "" ) then
			settingsService:CopyProfile( profile, settingsService.PARTIAL, theirBar, false );
		elseif ( profile ~= nil and myBar ~= nil and myBar ~= "" ) then
			self.utils:AddLabelBox( self.panelBackground, "", 0, 15 );
			settingsService:CopyProfile( profile, settingsService.PARTIAL, myBar, true );
		end
	end, 330, 20);

    self.utils:AddButton( self.panelBackground, L["With Icons"], 120, selectionHeight, function(sender, args)
		local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

		local profile = self.profileList:GetSelection();
		local theirBar = self.theirBarList:GetSelection();
		local myBar = self.myBarList:GetSelection();
		if ( profile ~= nil and theirBar ~= nil and theirBar ~= "" ) then
			settingsService:CopyProfile( profile, settingsService.ALL, theirBar, false );
		elseif ( profile ~= nil and myBar ~= nil and myBar ~= "" ) then
			settingsService:CopyProfile( profile, settingsService.ALL, myBar, true );
		end
	end, 330, 50);

    -- self.utils:AddLabelBox( self.panelBackground, L["Language:"], 120, selectionHeight, nil, 5, 120 );
    -- self.languageList = self.utils:AddComboBox(self.panelBackground, 10, 200, 20, 120, 120);
	-- self.languageList:AddItem( L["English"], "en" );
	-- self.languageList:AddItem( L["German"], "de" );
-- 	self.languageList:AddItem( "French", "fr" );

    -- local playerService = SERVICE_CONTAINER:GetService(MysticBars.Services.PlayerService);
    -- if ( playerService.realClassSet == nil ) then
	-- 	self.utils:AddLabelBox( self.panelBackground, L["Could not determine class:"], selectionWidth + 200, selectionHeight + 10, nil, 5, 150 );
    --     self.classList = self.utils:AddComboBox(self.panelBackground, 6, 200, 20, 200, 150);
	-- 	self.classList:AddItem( "Beorning", 	Turbine.Gameplay.Class.Beorning );
	-- 	self.classList:AddItem( "Brawler", 		215 );
	-- 	self.classList:AddItem( "Burglar", 		Turbine.Gameplay.Class.Burglar );
    --     self.classList:AddItem( "Captain", 		Turbine.Gameplay.Class.Captain );
    --     self.classList:AddItem( "Champion", 	Turbine.Gameplay.Class.Champion );
    --     self.classList:AddItem( "Guardian", 	Turbine.Gameplay.Class.Guardian );
    --     self.classList:AddItem( "Hunter", 		Turbine.Gameplay.Class.Hunter );
	-- 	self.classList:AddItem( "Lore Master", 	Turbine.Gameplay.Class.LoreMaster );
    --     self.classList:AddItem( "Mariner", 		216 );
    --     self.classList:AddItem( "Minstrel", 	Turbine.Gameplay.Class.Minstrel );
	-- 	self.classList:AddItem( "Rune Keeper", 	Turbine.Gameplay.Class.RuneKeeper );
	-- 	self.classList:AddItem( "Warden", 		Turbine.Gameplay.Class.Warden );
	-- end

    self:DisplaySettings();
    self:ChangeProfileVisibilty();
    self:RefreshComboBox();
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
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

	self.profileList:Clear();
	for key, value in opairs (settingsService:GetProfiles() ) do
		local found = false;
		local playerService = SERVICE_CONTAINER:GetService(MysticBars.Services.PlayerService);
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
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

	self.theirBarList:Clear();
	self.theirBarList:AddItem( "", "" );
	for key, value in opairs (settingsService:GetProfileBars(self.profileList:GetSelection()) ) do
		local found = false;
		local playerService = SERVICE_CONTAINER:GetService(MysticBars.Services.PlayerService);
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
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

	self.myBarList:Clear();
	self.myBarList:AddItem( "", "" );
	for key, value in opairs (settingsService:GetBars() ) do
		local found = false;
		local playerService = SERVICE_CONTAINER:GetService(MysticBars.Services.PlayerService);
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