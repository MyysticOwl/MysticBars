-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "MyysticUI.Menus.Core.UI.AutoListBox";
import "MyysticUI.Menus.Core.UI.MenuUtils";

BasePanel = class(Turbine.UI.TreeNode);

BasePanel.utils = MyysticUI.Menus.Core.UI.MenuUtils();

function BasePanel:Constructor(barId, barValue)
	Turbine.UI.TreeNode.Constructor(self);

	self.barId = barId;
	self.barValues = barValue;

	self.panel = Turbine.UI.Control();
	self.panel:SetParent(self);
	self.panel:SetPosition(0, 0);
	self.panel:SetSize(self:GetWidth() - 2, self:GetHeight() - 2);
	self.panel:SetBackColor(Turbine.UI.Color(0.42, 0.3, 0.3));
	self.panel:SetMouseVisible(false);

	self.panelBackground = Turbine.UI.Control();
	self.panelBackground:SetParent(self.panel);
	self.panelBackground:SetPosition(1, 1);
	self.panelBackground:SetSize(self:GetWidth() - 4, self:GetHeight() - 4);
	self.panelBackground:SetBackColor(Turbine.UI.Color(0.925, 0, 0, 0));
	self.panelBackground:SetMouseVisible(false);
end

function BasePanel:DisplaySettings()
end

function BasePanel:Refresh(width)
	local w = width or self:GetWidth();

	self:SetWidth(w);
	self.panel:SetSize(self:GetWidth() - 2, self:GetHeight() - 2);
	self.panelBackground:SetSize(self:GetWidth() - 4, self:GetHeight() - 4);
end
