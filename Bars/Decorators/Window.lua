
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

    -- top
	self.top = Turbine.UI.Control();
	self.top:SetParent(self);
	self.top:SetSize(36,36);
	self.top:SetZOrder(-10);
	self.top:SetMouseVisible(false);
	self.top:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
	self.top:SetBackground("MysticBars/Menus/Core/Resources/box_silver_upper.tga");

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

	 -- resize button
    self.resize = Turbine.UI.Control();
    self.resize:SetParent(self);
    self.resize:SetSize(22, 22);
    self.resize:SetBlendMode(Turbine.UI.BlendMode.AlphaBlend);
    self.resize:SetBackground("MysticBars/Menus/Core/Resources/resize2.tga");
    self.resize.pressed = false;
	self.resize.MouseDown = function( sender, args )
		sender.dragStartX = args.X;
		sender.dragStartY = args.Y;
		self.resize.pressed = true;
	end
	self.resize.MouseMove = function( sender, args )
		local width, height = self:GetSize();

		if ( self.resize.pressed ) then
		    local newwidth = width + (args.X - sender.dragStartX);
			local newheight = height + (args.Y - sender.dragStartY);
			self:SetSize(newwidth, newheight);
			sender:SetPosition( self:GetWidth() - sender:GetWidth(), self:GetHeight() - sender:GetHeight() );
			self:SizeChanged(self, nil);
		end
	end
	self.resize.MouseUp = function( sender, args )
		self.resize.pressed = false;
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
    self.top:SetPosition(36, offset);
    self.topRight:SetPosition(self:GetWidth() - 36, offset);

    self.top:SetWidth(width - 72);

    self.bottomLeft:SetPosition(0, self:GetHeight() - 36 - 2);
    self.bottomRight:SetPosition(self:GetWidth() - 36, self:GetHeight() - 36 - 2);
	self.resize:SetPosition( self:GetWidth() - self.resize:GetWidth(), self:GetHeight() - self.resize:GetHeight() - 2 );
	self.close:SetPosition(self:GetWidth() - 26, 10);
end