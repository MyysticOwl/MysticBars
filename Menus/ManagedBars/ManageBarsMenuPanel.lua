-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine";
import "MyysticUI.Utils.Class";
import "MyysticUI.Menus.Core.UI.MenuUtils";

ManageBarsMenuPanel = class();

ManageBarsMenuPanel.utils = MyysticUI.Menus.Core.UI.MenuUtils();

function ManageBarsMenuPanel:Draw(parentNode, barId, barValue)

	-- self.panel = Turbine.UI.Control();
	-- self.panel:SetParent(self);
	-- self.panel:SetPosition(self.panelPadding,self.panelPadding-self.nodePadding);
	-- self.panel:SetSize(width-2*self.panelPadding,height-2*self.panelPadding+self.nodePadding);
	-- self.panel:SetBackColor(Turbine.UI.Color(0.42,0.3,0.3));
	-- self.panel:SetMouseVisible(false);
	
	-- self.panelBackground = Turbine.UI.Control();
	-- self.panelBackground:SetParent(self.panel);
	-- self.panelBackground:SetPosition(1,1);
	-- self.panelBackground:SetSize(width-2*self.panelPadding-2,height-2*self.panelPadding-2+self.nodePadding);
	-- self.panelBackground:SetBackColor(Turbine.UI.Color(0.925,0,0,0));
	-- self.panelBackground:SetMouseVisible(false);

	---------------------   GENERAL  0000000000000000000000000000
--	local panelNode = MyysticUI.Menus.Core.TitleTreeNode("General", 1);
--	panelNode:SetExpanded(true);
--	parentNode:GetChildNodes():Add(panelNode);
	parentNode:GetChildNodes():Add(MyysticUI.Menus.Controls.BasePanel(barId, barValue));
	parentNode:GetChildNodes():Add(MyysticUI.Menus.Controls.TriggersPanel(barId, barValue));

	-- -----------------------   SLOTS	  0000000000000000000000000000
	-- local panelNode2 = MyysticUI.Menus.Core.TitleTreeNode("QuickSlots", 1);
	-- parentNode:GetChildNodes():Add(panelNode2);

	-- self.contentBox2 = self.utils:AddAutoListBox( self, Turbine.UI.Orientation.Vertical );
	-- self.slotsPanel = MyysticUI.Menus.Controls.SlotsPanel( self.contentBox2, true );
	-- panelNode2:GetChildNodes():Add(self.contentBox2);

	-- -----------------------   COLOR  0000000000000000000000000000
	-- local panelNode3 = MyysticUI.Menus.Core.TitleTreeNode("Color", 1);
	-- parentNode:GetChildNodes():Add(panelNode3);

	-- self.contentBox3 = self.utils:AddAutoListBox( self, Turbine.UI.Orientation.Vertical );
	-- self.colorPanel = MyysticUI.Menus.Controls.ColorPanel( self.contentBox3 );
	-- panelNode3:GetChildNodes():Add(self.contentBox3);

	-- -----------------------   TRIGGERS  0000000000000000000000000000
	-- local panelNode4 = MyysticUI.Menus.Core.TitleTreeNode("Triggers", 1);
	-- parentNode:GetChildNodes():Add(panelNode4);

	-- self.contentBox4 = self.utils:AddAutoListBox( self, Turbine.UI.Orientation.Vertical );
	-- self.tp = MyysticUI.Menus.Controls.TriggersPanel( self.contentBox4 );
	-- panelNode4:GetChildNodes():Add(self.contentBox4);

	-- -----------------------   CLASS BUFF TRIGGERS  0000000000000000000000000000
	-- local panelNode5 = MyysticUI.Menus.Core.TitleTreeNode("Class Buffs", 1);
	-- parentNode:GetChildNodes():Add(panelNode5);

	-- self.contentBox5 = self.utils:AddAutoListBox( self, Turbine.UI.Orientation.Vertical );
	-- self.classBuffPanel = MyysticUI.Menus.Controls.ClassBuffPanel( self.contentBox5 );
	-- panelNode5:GetChildNodes():Add(self.contentBox5);

	self:DisplaySettings();
end

function ManageBarsMenuPanel:DisplaySettings()
	-- local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
	-- local localBarSettings = settingsService:GetBarSettings( menu:GetSelection() );
	-- if ( localBarSettings.events == nil ) then
	-- 	localBarSettings.events = { };
	-- end

	-- self.tp:DisplaySettings();
	-- self.classBuffPanel:DisplaySettings();
	-- self.slotsPanel:DisplaySettings();
	-- self.generalPanel:DisplaySettings();
	-- self.colorPanel:DisplaySettings();
end