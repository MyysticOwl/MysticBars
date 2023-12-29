-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine";
import "MyysticUI.Utils.Class";
import "MyysticUI.Menus.Core.UI.MenuUtils";

EasyBarMenuPanel = class();

EasyBarMenuPanel.utils = MyysticUI.Menus.Core.UI.MenuUtils();

function EasyBarMenuPanel:Draw(parentNode)
	---------------------   GENERAL  0000000000000000000000000000
	local panelNode = MyysticUI.Menus.Core.TitleTreeNode("General", 1);
	parentNode:GetChildNodes():Add(panelNode);

	-- self.contentBox = self.utils:AddAutoListBox( self, Turbine.UI.Orientation.Vertical );
	-- self.generalPanel = MyysticUI.Menus.Controls.BasePanel( self.contentBox );
	-- panelNode:GetChildNodes():Add(self.contentBox);

	-----------------------   SLOTS	  0000000000000000000000000000
	local panelNode = MyysticUI.Menus.Core.TitleTreeNode("QuickSlots", 1);
	parentNode:GetChildNodes():Add(panelNode);

	self.contentBox2 = self.utils:AddAutoListBox( self, Turbine.UI.Orientation.Vertical );
	self.slotsPanel = MyysticUI.Menus.Controls.SlotsPanel( self.contentBox2, true );

	-----------------------   COLOR  0000000000000000000000000000
	local panelNode = MyysticUI.Menus.Core.TitleTreeNode("Color", 1);
	parentNode:GetChildNodes():Add(panelNode);

	self.contentBox = self.utils:AddAutoListBox( self, Turbine.UI.Orientation.Vertical );
	self.colorPanel = MyysticUI.Menus.Controls.ColorPanel( menu.contentBox );

	-----------------------   TRIGGERS  0000000000000000000000000000
	local panelNode = MyysticUI.Menus.Core.TitleTreeNode("Triggers", 1);
	parentNode:GetChildNodes():Add(panelNode);

	self.contentBox = self.utils:AddAutoListBox( self, Turbine.UI.Orientation.Vertical );
	self.tp = MyysticUI.Menus.Controls.TriggersPanel( menu.contentBox );

	-----------------------   CLASS BUFF TRIGGERS  0000000000000000000000000000
	local panelNode = MyysticUI.Menus.Core.TitleTreeNode("Class Buffs", 1);
	parentNode:GetChildNodes():Add(panelNode);

	self.contentBox = self.utils:AddAutoListBox( self, Turbine.UI.Orientation.Vertical );
	self.classBuffPanel = MyysticUI.Menus.Controls.ClassBuffPanel( menu.contentBox );

	self:DisplaySettings();
end

function EasyBarMenuPanel:DisplaySettings()
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
	local localBarSettings = settingsService:GetBarSettings( menu:GetSelection() );
	if ( localBarSettings.events == nil ) then
		localBarSettings.events = { };
	end

	self.tp:DisplaySettings();
	self.classBuffPanel:DisplaySettings();
	self.slotsPanel:DisplaySettings();
	self.colorPanel:DisplaySettings();
end