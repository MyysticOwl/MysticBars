
Window = class( Turbine.UI.Window );

Window.TitleColor = Turbine.UI.Color(245/255, 222/255, 147/255);
Window.Log = MysticBars.Utils.Logging.LogManager.GetLogger( "Window" );

function Window:Constructor( barSettings )
	Turbine.UI.Window.Constructor( self );

	self.barSettings = barSettings;

	local title = self.barSettings.barName;
	if ( self.barSettings.barName == nil or self.barSettings.barName == "" ) then
		title = "Bar:" .. self.barSettings.id;
	end

    self.titleWidth = 450;

	self:SetMinimumHeight(72);
    self:SetMinimumWidth(50);
    self:SetVisible(false);

	-- title label
	self.title = Turbine.UI.Label();
	self.title:SetParent(self);
	self.title:SetPosition(0,0);
	self.title:SetSize(0,12);
	self.title:SetZOrder(-1);
	self.title:SetOutlineColor(Turbine.UI.Color(0.71,0.09,0.09,0.09));
	self.title:SetFontStyle(Turbine.UI.FontStyle.Outline);
	self.title:SetFont(Turbine.UI.Lotro.Font.Verdana12);
    self.title:SetBackColor(Turbine.UI.Color(0.22,0,1));
	self.title:SetForeColor(Window.TitleColor);
	self.title:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
	self.title:SetMouseVisible(true);
    self.title:SetVisible(false);

  	-- content label
    self.center = Turbine.UI.Control();
    self.center:SetParent(self);
    self.center:SetZOrder(-5);
    self.center:SetMouseVisible(false);
    self.center:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.center:SetBackColor(Turbine.UI.Color(1, 0, 0, 0));

  self.title.MouseDown = function(sender, args)
    if (args.Button == Turbine.UI.MouseButton.Left) then
        self.dragStartX = args.X;
        self.dragStartY = args.Y;
        self.dragging = true;
        self.dragged = false;
    end
end
self.title.MouseMove = function(sender, args)
    local left, top = self:GetPosition();
    if (self.dragging) then
        self.dragged = true;
        self:SetPosition(left + (args.X - self.dragStartX), top + (args.Y - self.dragStartY));
    end
end
self.title.MouseUp = function(sender, args)
    if (args.Button == Turbine.UI.MouseButton.Left) then
        self.dragging = false;
        if (self.dragged) then
            local x, y = self:GetPosition();
            if (x < 0) then
                x = 0;
            end

            if (y < 0) then
                y = 0;
            end
            if (x + self:GetWidth() > Turbine.UI.Display.GetWidth()) then
                x = Turbine.UI.Display.GetWidth() - self:GetWidth();
            end
            if (y + self:GetHeight() > Turbine.UI.Display.GetHeight()) then
                y = Turbine.UI.Display.GetHeight() - self:GetHeight();
            end

            self:SetPosition(x, y);
        end
    end
end


  	-- title left
	self.titleLeft = Turbine.UI.Control();
	self.titleLeft:SetParent(self);
	self.titleLeft:SetSize(35,42);
	self.titleLeft:SetZOrder(1);
	self.titleLeft:SetMouseVisible(false);
	self.titleLeft:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
	self.titleLeft:SetBackground("MysticBars/Menus/Core/Resources/base_box_titlebar_left_mb.tga");
  self.titleLeft:SetVisible(false);

	-- title mid
	self.titleMid = Turbine.UI.Control();
	self.titleMid:SetParent(self);
	self.titleMid:SetSize(20,42);
	self.titleMid:SetZOrder(1);
	self.titleMid:SetMouseVisible(false);
	self.titleMid:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
	self.titleMid:SetBackground("MysticBars/Menus/Core/Resources/base_box_titlebar_top_mb.tga");
  self.titleMid:SetVisible(false);
	
	-- title right
	self.titleRight = Turbine.UI.Control();
	self.titleRight:SetParent(self);
	self.titleRight:SetSize(35,42);
	self.titleRight:SetZOrder(1);
	self.titleRight:SetMouseVisible(false);
	self.titleRight:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
	self.titleRight:SetBackground("MysticBars/Menus/Core/Resources/base_box_titlebar_right_mb.tga");
  self.titleRight:SetVisible(false);

  self:SetText(title);

	-- top side
	self.top = Turbine.UI.Control();
	self.top:SetParent(self);
	self.top:SetSize(36,36);
	self.top:SetZOrder(-5);
	self.top:SetMouseVisible(false);
	self.top:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
	self.top:SetBackground("MysticBars/Menus/Core/Resources/box_silver_top.tga");

    
	-- left side
	self.left = Turbine.UI.Control();
	self.left:SetParent(self);
	self.left:SetSize(36,36);
	self.left:SetZOrder(-1);
	self.left:SetMouseVisible(false);
	self.left:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
	self.left:SetBackground("MysticBars/Menus/Core/Resources/box_silver_left.tga");

	-- right side
	self.right = Turbine.UI.Control();
	self.right:SetParent(self);
	self.right:SetSize(36,36);
	self.right:SetZOrder(-1);
	self.right:SetMouseVisible(false);
	self.right:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
	self.right:SetBackground("MysticBars/Menus/Core/Resources/box_silver_right.tga");
	
	-- bottom side
	self.bottom = Turbine.UI.Control();
	self.bottom:SetParent(self);
	self.bottom:SetSize(36,36);
	self.bottom:SetZOrder(-1);
	self.bottom:SetMouseVisible(false);
	self.bottom:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
	self.bottom:SetBackground("MysticBars/Menus/Core/Resources/box_silver_bottom.tga");

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
        self.right:SetMouseVisible(true);

        -- right side
        self.rightGrab = Turbine.UI.Control();
        self.rightGrab:SetParent(self);
        self.rightGrab:SetSize(36,36);
        self.rightGrab:SetZOrder(6);
        self.rightGrab:SetMouseVisible(true);
        self.rightGrab:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
        self.rightGrab:SetBackground("MysticBars/Menus/Core/Resources/drag_bar.tga");
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

function Window:SetText(text)
	self.title:SetText(text);
  self.title:SetVisible(text ~= nil and text ~= "");
  self.titleLeft:SetVisible(text ~= nil and text ~= "");
  self.titleMid:SetVisible(text ~= nil and text ~= "");
  self.titleRight:SetVisible(text ~= nil and text ~= "");
end

function Window:SetVisible( value )
	Turbine.UI.Lotro.GoldWindow.SetVisible( self, value );
end

function Window:SetSize(width, height)
    Turbine.UI.Window.SetSize(self, width, height);
	local offset = 16;

	local titleWidth = math.min(self.titleWidth, width - 72);
	local spacer = (width - titleWidth) / 2;
	self.titleLeft:SetPosition(spacer, -7);
	self.titleMid:SetPosition(spacer + 35, -7);
	self.titleMid:SetWidth(titleWidth - 70);
	self.titleRight:SetPosition(width - spacer - 35, -7);
	self.title:SetPosition(spacer + 17, 12);
	self.title:SetWidth(titleWidth - 33);

	self.top:SetPosition(36, offset);
	self.bottom:SetPosition(36, height - 36);
	self.left:SetPosition(0, 36 + offset);
	self.right:SetPosition(width - 36, 36 + offset);
	self.top:SetWidth(width - 72);
	self.bottom:SetWidth(width - 72);
	self.left:SetHeight(height - 72 - offset);
	self.right:SetHeight(height - 72 - offset);

    self.topLeft:SetPosition(0, offset);
    self.topRight:SetPosition(self:GetWidth() - 36, offset);
    self.bottomLeft:SetPosition(0, height - 36 - 2);
    self.bottomRight:SetPosition(width - 36, height - 36 - 2);

	self.center:SetPosition(3, 5 + offset);
	self.center:SetSize(width - 4, height - 11 - offset)

    if (self.barSettings.barType == INVENTORY_BAR) then
        self.rightGrab:SetPosition(width - 7, height / 2 - 52/2);
        self.rightGrab:SetHeight(52);
        self.rightGrab:SetWidth(10);
    end
	self.close:SetPosition(self:GetWidth() - 26, 10);
end