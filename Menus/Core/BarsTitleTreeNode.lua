
BarsTitleTreeNode = class(Turbine.UI.TreeNode);

BarsTitleTreeNode.Log = MysticBars.Utils.Logging.LogManager.GetLogger( "BarsTitleTreeNode" );
BarsTitleTreeNode.utils = MysticBars.Menus.Core.UI.MenuUtils();

function BarsTitleTreeNode:Constructor(text, topPadding, barId, showVisibility)
	Turbine.UI.TreeNode.Constructor(self);

  self.listeners = {}

  self.barId = barId;
  self.showVisibility = showVisibility;

  self.height = 29;
  self.padding = topPadding;

	self:SetHeight(self.height);
  self:SetWidth(400);
  self:SetBackColor(Turbine.UI.Color(0.925,0,0,0));

  self.plus = Turbine.UI.Control();
  self.plus:SetParent(self);
  self.plus:SetTop(3+(self.height-topPadding-15-6)/2);
  self.plus:SetLeft(6);
  self.plus:SetSize(15,15);
  self.plus:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
  self.plus:SetBackground(0x41007E27);
  self.plus:SetMouseVisible(false);
  MysticBars.Menus.Core.UI.Tooltip(self.plus, L["Add Bar"]);

  self.barName = self.utils:AddTextBox(self, text, selectionWidth, selectionHeight, nil, self.plus:GetLeft() + self.plus:GetWidth() + 5, 4 );
  self.barName.TextChanged = function( sender, args )
    SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barId, function(barSettings)
      barSettings.barName = self.barName:GetText();
      return barSettings;
    end);
  end

  if (showVisibility ~= nil) then 
    self.visible = Turbine.UI.Control();
    self.visible:SetParent(self);
    self.visible:SetSize(20,20);
    self.visible:SetPosition(200,4);
    self.visible:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.visible:SetMouseVisible(true);
    MysticBars.Menus.Core.UI.Tooltip(self.visible, L["Bar Visibility"]);
    self.visible.MouseDown = function(args)
          SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barId, function(barSettings)
        barSettings.visible = not barSettings.visible;
        return barSettings;
      end, function(barSettings)
        self:SetExpanded(not self:IsExpanded());
        self:Refresh();
      end);
    end
    self.visible.Hide = function()
      self.visible:SetBackground("MysticBars/Menus/Core/Resources/button_notvisible.tga");
    end
  end

  self.lock = Turbine.UI.Control();
  self.lock:SetParent(self);
  self.lock:SetSize(20,20);
  self.lock:SetPosition(230,4);
  self.lock:SetBackground("MysticBars/Menus/Core/Resources/button_unlocked.tga");
  self.lock:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
  self.lock:SetMouseVisible(true);
  MysticBars.Menus.Core.UI.Tooltip(self.lock, L["Lock Bar"]);
  self.lock.MouseDown = function(args)
    SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.barId, function(barSettings)
      barSettings.locked = not barSettings.locked;
      return barSettings;
    end, function(barSettings)
      self:SetExpanded(not self:IsExpanded());
      self:Refresh();
    end);
  end

  self.delete = Turbine.UI.Control();
  self.delete:SetParent(self);
  self.delete:SetSize(16,16);
  self.delete:SetPosition(self:GetWidth() - 22,20);
  self.delete:SetBackground("MysticBars/Menus/Core/Resources/titlebar_X_2_sepia.tga");
  self.delete:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
  self.delete:SetMouseVisible(true);
  MysticBars.Menus.Core.UI.Tooltip(self.delete, L["Remove Bar"]);
  self.delete.MouseDown = function(args)
    local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
    self:SetExpanded(not self:IsExpanded());

    barService:Remove( self.barId );
  end

  self.tl = Turbine.UI.Control();
  self.tl:SetParent(self);
  self.tl:SetPosition(0,0);
  self.tl:SetSize(3,3);
  self.tl:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
  self.tl:SetMouseVisible(false);

  self.t = Turbine.UI.Control();
  self.t:SetParent(self);
  self.t:SetPosition(3,0);
  self.t:SetHeight(3);
  self.t:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
  self.t:SetMouseVisible(false);

  self.tr = Turbine.UI.Control();
  self.tr:SetParent(self);
  self.tr:SetTop(0);
  self.tr:SetSize(3,3);
  self.tr:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
  self.tr:SetMouseVisible(false);

  self.l = Turbine.UI.Control();
  self.l:SetParent(self);
  self.l:SetPosition(0,3);
  self.l:SetSize(3,self.height-6-topPadding);
  self.l:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
  self.l:SetMouseVisible(false);

  self.c = Turbine.UI.Control();
  self.c:SetParent(self);
  self.c:SetPosition(3,3);
  self.c:SetHeight(self.height-6-topPadding);
  self.c:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
  self.c:SetMouseVisible(false);
  self.c:SetBackColorBlendMode(Turbine.UI.BlendMode.AlphaBlend);

  self.r = Turbine.UI.Control();
  self.r:SetParent(self);
  self.r:SetTop(3);
  self.r:SetSize(3,self.height-6-topPadding);
  self.r:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
  self.r:SetMouseVisible(false);

  self.bl = Turbine.UI.Control();
  self.bl:SetParent(self);
  self.bl:SetPosition(0,self.height-3-topPadding);
  self.bl:SetSize(3,3);
  self.bl:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
  self.bl:SetMouseVisible(false);

  self.b = Turbine.UI.Control();
  self.b:SetParent(self);
  self.b:SetPosition(3,self.height-3-topPadding);
  self.b:SetHeight(3);
  self.b:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
  self.b:SetMouseVisible(false);

  self.br = Turbine.UI.Control();
  self.br:SetParent(self);
  self.br:SetTop(self.height-3-topPadding);
  self.br:SetSize(3,3);
  self.br:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
  self.br:SetMouseVisible(false);

  self:SetSelected(false);

  self:Refresh();
end

function BarsTitleTreeNode:SizeChanged(args)
  self:Refresh();
end

function BarsTitleTreeNode:Refresh(width)
  local w = width or self:GetWidth();

  self:SetWidth(w);

  if (self.delete ~= nil) then
    self.delete:SetPosition(self:GetWidth() - 22,4);

    self.t:SetWidth(w-6);
    self.tr:SetLeft(w-3);
    self.c:SetWidth(w-6);
    self.r:SetLeft(w-3);
    self.b:SetWidth(w-6);
    self.br:SetLeft(w-3);

    local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
    local barSettings = settingsService:GetBarSettings( self.barId );

    if (barSettings ~= nil) then
      if (self.showVisibility ~= nil) then
        self.visible:SetBackground(barSettings.visible and "MysticBars/Menus/Core/Resources/button_visible.tga" or "MysticBars/Menus/Core/Resources/button_notvisible.tga");
      end
      self.lock:SetBackground(barSettings.locked and "MysticBars/Menus/Core/Resources/button_locked.tga" or "MysticBars/Menus/Core/Resources/button_unlocked.tga");
    end
  end
end

function BarsTitleTreeNode:SetSelected(selected)
  self.Log:Debug("BarsTitleTreeNode:SetSelected " .. self.barId);

  local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
  local bar = barService:GetBar(self.barId);
  if (bar ~= nil) then
    bar.selected = selected;
    bar:Refresh();
  end

  self.tl:SetBackground("MysticBars/Menus/Core/Resources/social_panel_list_elements_"..(selected and "highlight" or "normal").."_top_left.tga");
  self.t:SetBackground("MysticBars/Menus/Core/Resources/social_panel_list_elements_"..(selected and "highlight" or "normal").."_top_center.tga");
  self.tr:SetBackground("MysticBars/Menus/Core/Resources/social_panel_list_elements_"..(selected and "highlight" or "normal").."_top_right.tga");
  self.l:SetBackground("MysticBars/Menus/Core/Resources/social_panel_list_elements_"..(selected and "highlight" or "normal").."_middle_left.tga");
  self.r:SetBackground("MysticBars/Menus/Core/Resources/social_panel_list_elements_"..(selected and "highlight" or "normal").."_middle_right.tga");
  self.bl:SetBackground("MysticBars/Menus/Core/Resources/social_panel_list_elements_"..(selected and "highlight" or "normal").."_bottom_left.tga");
  self.b:SetBackground("MysticBars/Menus/Core/Resources/social_panel_list_elements_"..(selected and "highlight" or "normal").."_bottom_center.tga");
  self.br:SetBackground("MysticBars/Menus/Core/Resources/social_panel_list_elements_"..(selected and "highlight" or "normal").."_lower_right.tga");
end

function BarsTitleTreeNode:MouseEnter(args)
  self:SetSelected(true);
end

function BarsTitleTreeNode:MouseLeave(args)
  self:SetSelected(false);
end

function BarsTitleTreeNode:MouseClick(args)
  self.plus:SetBackground(self:IsExpanded() and 0x41007E26 or 0x41007E27);
end