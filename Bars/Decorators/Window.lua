
Window = class( Turbine.UI.Lotro.GoldWindow );

function Window:Constructor( barSettings )
	Turbine.UI.Lotro.GoldWindow.Constructor( self );

	self.barSettings = barSettings;

	local title = self.barSettings.barName;
	if ( self.barSettings.barName == nil or self.barSettings.barName == "" ) then
		title = "Bar:" .. self.barSettings.id;
	end
	self:SetText(title);
	self:SetMinimumHeight(72);
    self:SetMinimumWidth(50);
    self:SetVisible(false);

    -- top left corner
    self.topLeft = Turbine.UI.Control();
    self.topLeft:SetParent(self);
    self.topLeft:SetSize(36, 36);
    self.topLeft:SetMouseVisible(false);
    self.topLeft:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.topLeft:SetBackground("MysticBars/Menus/Core/Resources/box_silver_top_left.tga");

    -- topRight
    self.topRight = Turbine.UI.Control();
    self.topRight:SetParent(self);
    self.topRight:SetSize(36, 36);
    self.topRight:SetMouseVisible(false);
    self.topRight:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.topRight:SetBackground("MysticBars/Menus/Core/Resources/box_silver_top_right.tga");

    self:SetZOrder(10);

    -- bottomLeft
    self.bottomLeft = Turbine.UI.Control();
    self.bottomLeft:SetParent(self);
    self.bottomLeft:SetSize(36, 36);
    self.bottomLeft:SetMouseVisible(false);
    self.bottomLeft:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.bottomLeft:SetBackground("MysticBars/Menus/Core/Resources/box_silver_bottom_left.tga");

    -- bottomRight
    self.bottomRight = Turbine.UI.Control();
    self.bottomRight:SetParent(self);
    self.bottomRight:SetSize(36, 36);
    self.bottomRight:SetMouseVisible(false);
    self.bottomRight:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.bottomRight:SetBackground("MysticBars/Menus/Core/Resources/box_silver_bottom_right.tga");

    if (self.barSettings.barType == INVENTORY_BAR) then
        -- right side
        self.right = Turbine.UI.Control();
        self.right:SetParent(self);
        self.right:SetSize(36,36);
        self.right:SetMouseVisible(true);
        self.right:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
        self.right:SetBackground("MysticBars/Menus/Core/Resources/drag_bar.tga");
    end

    -- close button
    self.close = Turbine.UI.Control();
    self.close:SetParent(self);
    self.close:SetSize(16, 16);
    self.close:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.close:SetBackground("MysticBars/Menus/Core/Resources/titlebar_X_2.tga");
    self.close.pressed = false;
    self.close.MouseEnter = function(sender, args)
        self.close:SetBackground("MysticBars/Menus/Core/Resources/titlebar_X_2_"..(self.close.pressed and "pressed" or "mouseover")..".tga");
    end
    self.close.MouseLeave = function(sender, args)
        self.close:SetBackground("MysticBars/Menus/Core/Resources/titlebar_X_2"..(self.close.pressed and "_mouseover" or "")..".tga");
    end
    self.close.MouseDown = function(sender, args)
        self.close.pressed = true;
        self.close:SetBackground("MysticBars/Menus/Core/Resources/titlebar_X_2_pressed.tga");
    end
    self.close.MouseUp = function(sender, args)
        self.close.pressed = false;
        self.close:SetBackground("MysticBars/Menus/Core/Resources/titlebar_X_2.tga");
    end
    self.close.MouseClick = function(sender, args)
        self:Close();
    end

	self:SetOpacity( 1 );
end

function Window:SetVisible( value )
	Turbine.UI.Lotro.GoldWindow.SetVisible( self, value );
end

function Window:SetSize(width, height)
    Turbine.UI.Window.SetSize(self, width, height);
	local offset = 16;
	self.topLeft:SetPosition(0, offset);
    self.topRight:SetPosition(self:GetWidth() - 36, offset);

    self.bottomLeft:SetPosition(0, height - 36 - 2);
    self.bottomRight:SetPosition(width - 36, height - 36 - 2);

    if (self.barSettings.barType == INVENTORY_BAR) then
        self.right:SetPosition(width - 6, height / 2 - 15);
        self.right:SetHeight(46);
        self.right:SetWidth(10);
    end
	self.close:SetPosition(self:GetWidth() - 26, 10);
end