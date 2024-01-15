-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

Tab = class( Turbine.UI.Window );

Tab.Log = MysticBars.Utils.Logging.LogManager.GetLogger( "Tab", false );

Tab.tabSize = 14;

function Tab:Constructor( window, barSettings )
	Turbine.UI.Window.Constructor( self );

	self.Log:Debug("Constructor");

	self.targetWindow = window;
	self.barSettings = barSettings;

	self:SetSize( self:GetWidth(), self.tabSize );
	self:SetPosition( math.max( self.targetWindow:GetLeft(), 0 ), math.max( self.targetWindow:GetTop() - self.tabSize, 0 ) );
	self:SetBackColor( Turbine.UI.Color(1,1,1,1)  );

	self.Label = Turbine.UI.Label();
	self.Label:SetParent( self );
	self.Label:SetForeColor( Turbine.UI.Color( 1, 1, 1, 1 ) );
	self.Label:SetFontStyle( Turbine.UI.FontStyle.Outline );
	--self.Label:SetOutlineColor( Turbine.UI.Color( 1, 0, 0, 0 ) );
	self.Label:SetFont( Turbine.UI.Lotro.Font.Verdana12 );
	self.Label:SetTextAlignment( Turbine.UI.ContentAlignment.TopCenter );
	self.Label:SetMouseVisible(false);
	self.Label:SetSize( self:GetWidth(), self.tabSize );
	self.Label:SetPosition( 0, 1 );
	self.Label:SetBackColor( Turbine.UI.Color( 0, 1, 1, 1 ) );
	self.Label:SetBackColorBlendMode( Turbine.UI.BlendMode.AlphaBlend );

	self.MouseDown = function(sender, args)
		if (args.Button == Turbine.UI.MouseButton.Left) then
			self.dragStartX = args.X;
			self.dragStartY = args.Y;
			self.dragging = true;
			self.dragged = false;
		end
	end
	self.MouseMove = function(sender, args)
		local left, top = self:GetPosition();
		local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
		local settings = settingsService:GetSettings();
		if (self.dragging) then
			self.dragged = true;
			self:SetPosition(left + (args.X - self.dragStartX), top + (args.Y - self.dragStartY));
		end
	end
	self.MouseUp = function(sender, args)
		if (args.Button == Turbine.UI.MouseButton.Left) then
			self.dragging = false;
			if (self.dragged) then
				local x, y = self:GetPosition();
				local validX = x;
				local validY = y;
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

	self:SetVisible( true );
end

function Tab:Refresh()
	self.Log:Debug("Refresh");

	local title = self.barSettings.barName;
	if ( self.barSettings.barName == nil or self.barSettings.barName == "" ) then
		title = "Bar:" .. self.barSettings.id;
	end

	self.Label:SetText( title );
	self.Label:SetSize( self:GetWidth() + 2, self.tabSize );
end