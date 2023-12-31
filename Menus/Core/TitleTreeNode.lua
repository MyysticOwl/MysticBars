
TitleTreeNode = class(MyysticUI.Menus.Core.BaseTitleTreeNode);

function TitleTreeNode:Constructor(text, topPadding, addBarType)
  MyysticUI.Menus.Core.BaseTitleTreeNode.Constructor(self, text, topPadding, addBarType);

  self.title = Turbine.UI.Label();
  self.title:SetParent(self);
  self.title:SetMouseVisible(false);
  self.title:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
  self.title:SetMultiline(false);
  self.title:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
  self.title:SetFontStyle(Turbine.UI.FontStyle.Outline);
  self.title:SetText(text);
  self.title:SetWidth(self:GetWidth() - self.plus:GetWidth() - 5);
  self.title:SetLeft(self.plus:GetLeft() + self.plus:GetWidth() + 5);
  self.title:SetTop(-10);

  if (addBarType ~= nil) then
    self.add = Turbine.UI.Control();
    self.add:SetParent(self);
    self.add:SetSize(15, 15);
    self.add:SetVisible(true);
    self.add:SetPosition(140, 6);
    self.add:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.add:SetMouseVisible(true);
    self.add:SetBackground("MyysticUI/Menus/Core/Resources/add_icon.tga");
    self.add.MouseDown = function(args)
      local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);

      self:SetExpanded(false);

      local barId = barService:Add(addBarType);
      barService:RefreshBars();

      SERVICE_CONTAINER:GetService(MyysticUI.Services.MenuService):GetMenu():Refresh(true);
    end
  end
end
