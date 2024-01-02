
import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";

Window = class( Turbine.UI.Lotro.GoldWindow );

function Window:Constructor()
	Turbine.UI.Lotro.Window.Constructor( self );
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
	
	self:SetFadeSpeed( 0.2 );
	self:SetOpacity( 1 );
end

function Window:SetFadeSpeed( value )
	self.fadeSpeed = 1 / value;
end

function Window:SetVisible( value )
	if ( value == true ) then
		Turbine.UI.Lotro.GoldWindow.SetOpacity( self, 0 );
		Turbine.UI.Lotro.GoldWindow.SetVisible( self, true );
		self:SetOpacity( self.realOpacity );
	else
		self.hideOnClose = true;

		local savedOpacity = self.realOpacity
		self:SetOpacity( 0 );
		self.realOpacity = savedOpacity
	end
end

function Window:SetOpacity( value )
	self.realOpacity = value;
	self.currentTime = Turbine.Engine.GetGameTime();
	self.currentOpacity = Turbine.UI.Lotro.GoldWindow.GetOpacity( self );
	self.targetOpacity = value;
  
	if ( self.targetOpacity ~= self.currentOpacity ) then
		self:SetWantsUpdates( true );
	end
end

function Window:Update( sender, args )
	local newOpacity;

	local now = Turbine.Engine.GetGameTime();
	local delta = now - self.currentTime;
	self.currentTime = now;

	delta = delta * self.fadeSpeed;

	if ( self.currentOpacity < self.targetOpacity ) then
		newOpacity = self.currentOpacity + delta;

		if ( newOpacity > self.targetOpacity ) then
			self:SetWantsUpdates( false )
			newOpacity = self.targetOpacity
		end
	else
		newOpacity = self.currentOpacity - delta;

		if ( newOpacity < self.targetOpacity ) then
			self:SetWantsUpdates( false )
			newOpacity = self.targetOpacity
			
			if ( self.hideOnClose ) then
				Turbine.UI.Lotro.GoldWindow.SetVisible( self, false );
				self.hideOnClose = false
			end
		end
	end

	self.currentOpacity = newOpacity;
	Turbine.UI.Lotro.GoldWindow.SetOpacity( self, newOpacity );
end

function Window:SetSize(width, height)
    Turbine.UI.Window.SetSize(self, width, height);
	local offset = 16;
	self.topLeft:SetPosition(0, offset);
    self.topRight:SetPosition(self:GetWidth() - 36, offset);
    self.bottomLeft:SetPosition(0, self:GetHeight() - 36 - 2);
    self.bottomRight:SetPosition(self:GetWidth() - 36, self:GetHeight() - 36 - 2);
	self.resize:SetPosition( self:GetWidth() - self.resize:GetWidth(), self:GetHeight() - self.resize:GetHeight() - 2 );
	self.close:SetPosition(width - 22, offset + 5);
end