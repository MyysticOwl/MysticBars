BaseTitleTreeNode = class(Turbine.UI.TreeNode);

function BaseTitleTreeNode:Constructor(text, topPadding, addBarType)
  Turbine.UI.TreeNode.Constructor(self);

  self.listeners = {}

  self.height = 29;
  self.padding = topPadding;

  self:SetHeight(self.height);
  self:SetWidth(400);
  self:SetBackColor(Turbine.UI.Color(0.925, 0, 0, 0));

  self.plus = Turbine.UI.Control();
  self.plus:SetParent(self);
  self.plus:SetTop(3 + (self.height - topPadding - 15 - 6) / 2);
  self.plus:SetLeft(6);
  self.plus:SetSize(15, 15);
  self.plus:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
  self.plus:SetBackground(0x41007E27);
  self.plus:SetMouseVisible(false);

  self.tl = Turbine.UI.Control();
  self.tl:SetParent(self);
  self.tl:SetPosition(0, 0);
  self.tl:SetSize(3, 3);
  self.tl:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
  self.tl:SetMouseVisible(false);

  self.t = Turbine.UI.Control();
  self.t:SetParent(self);
  self.t:SetPosition(3, 0);
  self.t:SetHeight(3);
  self.t:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
  self.t:SetMouseVisible(false);

  self.tr = Turbine.UI.Control();
  self.tr:SetParent(self);
  self.tr:SetTop(0);
  self.tr:SetSize(3, 3);
  self.tr:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
  self.tr:SetMouseVisible(false);

  self.l = Turbine.UI.Control();
  self.l:SetParent(self);
  self.l:SetPosition(0, 3);
  self.l:SetSize(3, self.height - 6 - topPadding);
  self.l:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
  self.l:SetMouseVisible(false);

  self.c = Turbine.UI.Control();
  self.c:SetParent(self);
  self.c:SetPosition(3, 3);
  self.c:SetHeight(self.height - 6 - topPadding);
  self.c:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
  self.c:SetMouseVisible(false);
  self.c:SetBackColorBlendMode(Turbine.UI.BlendMode.AlphaBlend);

  self.r = Turbine.UI.Control();
  self.r:SetParent(self);
  self.r:SetTop(3);
  self.r:SetSize(3, self.height - 6 - topPadding);
  self.r:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
  self.r:SetMouseVisible(false);

  self.bl = Turbine.UI.Control();
  self.bl:SetParent(self);
  self.bl:SetPosition(0, self.height - 3 - topPadding);
  self.bl:SetSize(3, 3);
  self.bl:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
  self.bl:SetMouseVisible(false);

  self.b = Turbine.UI.Control();
  self.b:SetParent(self);
  self.b:SetPosition(3, self.height - 3 - topPadding);
  self.b:SetHeight(3);
  self.b:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
  self.b:SetMouseVisible(false);

  self.br = Turbine.UI.Control();
  self.br:SetParent(self);
  self.br:SetTop(self.height - 3 - topPadding);
  self.br:SetSize(3, 3);
  self.br:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
  self.br:SetMouseVisible(false);

  self:SetSelected(false);

  self:Refresh();
end

function BaseTitleTreeNode:SizeChanged(args)
  self:Refresh();
end

function BaseTitleTreeNode:Refresh(width)
  local w = width or self:GetWidth();

  self:SetWidth(w);

  self.t:SetWidth(w - 6);
  self.tr:SetLeft(w - 3);
  self.c:SetWidth(w - 6);
  self.r:SetLeft(w - 3);
  self.b:SetWidth(w - 6);
  self.br:SetLeft(w - 3);
end

function BaseTitleTreeNode:SetSelected(selected)
  self.tl:SetBackground("MyysticUI/Menus/Core/Resources/social_panel_list_elements_" ..
  (selected and "highlight" or "normal") .. "_top_left.tga");
  self.t:SetBackground("MyysticUI/Menus/Core/Resources/social_panel_list_elements_" ..
  (selected and "highlight" or "normal") .. "_top_center.tga");
  self.tr:SetBackground("MyysticUI/Menus/Core/Resources/social_panel_list_elements_" ..
  (selected and "highlight" or "normal") .. "_top_right.tga");
  self.l:SetBackground("MyysticUI/Menus/Core/Resources/social_panel_list_elements_" ..
  (selected and "highlight" or "normal") .. "_middle_left.tga");
  self.r:SetBackground("MyysticUI/Menus/Core/Resources/social_panel_list_elements_" ..
  (selected and "highlight" or "normal") .. "_middle_right.tga");
  self.bl:SetBackground("MyysticUI/Menus/Core/Resources/social_panel_list_elements_" ..
  (selected and "highlight" or "normal") .. "_bottom_left.tga");
  self.b:SetBackground("MyysticUI/Menus/Core/Resources/social_panel_list_elements_" ..
  (selected and "highlight" or "normal") .. "_bottom_center.tga");
  self.br:SetBackground("MyysticUI/Menus/Core/Resources/social_panel_list_elements_" ..
  (selected and "highlight" or "normal") .. "_lower_right.tga");
end

function BaseTitleTreeNode:MouseEnter(args)
  self:SetSelected(true);
end

function BaseTitleTreeNode:MouseLeave(args)
  self:SetSelected(false);
end

function BaseTitleTreeNode:MouseClick(args)
  self.plus:SetBackground(self:IsExpanded() and 0x41007E26 or 0x41007E27);
end