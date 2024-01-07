
TitleTreeNode = class(MysticBars.Menus.Core.BaseTitleTreeNode);

function TitleTreeNode:Constructor(text, topPadding, addBarType, extension)
  MysticBars.Menus.Core.BaseTitleTreeNode.Constructor(self, text, topPadding, addBarType);

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
    self.add:SetBackground("MysticBars/Menus/Core/Resources/add_icon.tga");
    MysticBars.Menus.Core.UI.Tooltip(self.add, L["Bar Visibility"]);
    self.add.MouseDown = function(args)
      local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);

      self:SetExpanded(false);

      local barId = barService:Add(addBarType);
      barService:RefreshBars();

      SERVICE_CONTAINER:GetService(MysticBars.Services.MenuService):GetMenu():Refresh(true);
    end
  end

  if (extension ~= nil) then
    self.extensionShown = false;
    self.extension = Turbine.UI.Control();
    self.extension:SetParent(self);
    self.extension:SetSize(20, 20);
    self.extension:SetVisible(true);
    self.extension:SetPosition(164, 4);
    self.extension:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.extension:SetMouseVisible(true);
    self.extension:SetBackground("MysticBars/Menus/Core/Resources/button_extension_off.tga");
    MysticBars.Menus.Core.UI.Tooltip(self.extension, L["Extension Mode"]);
    self.extension.MouseDown = function(args)
      local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);

      if (not self.extensionShown) then
        self.extension:SetBackground("MysticBars/Menus/Core/Resources/button_extension_on.tga");
        settingsService.settings.barMode = EXTENSION_MODE;
      else
        self.extension:SetBackground("MysticBars/Menus/Core/Resources/button_extension_off.tga");
        settingsService.settings.barMode = NORMAL_MODE;
      end

      self.extensionShown = not self.extensionShown;
      self:SetExpanded(false);

      SERVICE_CONTAINER:GetService(MysticBars.Services.MenuService):GetMenu():Refresh(true);
    end
  end
end

function TitleTreeNode:Refresh(width)
  MysticBars.Menus.Core.BaseTitleTreeNode.Refresh(self, width);

  if (self.extension ~= nil) then
    local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
    if (settingsService.settings.barMode == NORMAL_MODE) then
      self.extensionShown = false;
      self.extension:SetBackground("MysticBars/Menus/Core/Resources/button_extension_off.tga");
    end
  end
end