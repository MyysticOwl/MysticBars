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
	self.hidden = false;

	self:SetSize( self.targetWindow:GetWidth(), self.tabSize );
	self:SetPosition( math.max( self.targetWindow:GetLeft(), 0 ), math.max( self.targetWindow:GetTop() - self.tabSize, 0 ) );
	self:SetBackColor( Turbine.UI.Color(1,1,1,1)  );

	self.Label = Turbine.UI.Label();
	self.Label:SetParent( self );
	self.Label:SetForeColor( Turbine.UI.Color( 1, 1, 1, 1 ) );
	self.Label:SetFontStyle( Turbine.UI.FontStyle.Outline );
	self.Label:SetOutlineColor( Turbine.UI.Color( 1, 0, 0, 0 ) );
	self.Label:SetFont( Turbine.UI.Lotro.Font.Verdana12 );
	self.Label:SetTextAlignment( Turbine.UI.ContentAlignment.TopCenter );
	self.Label:SetMouseVisible(false);
	self.Label:SetSize( self:GetWidth(), self.tabSize );
	self.Label:SetPosition( 0, 1 );
	self.Label:SetBackColor( Turbine.UI.Color( 0, 1, 1, 1 ) );
	self.Label:SetBackColorBlendMode( Turbine.UI.BlendMode.AlphaBlend );

	self.MouseLeave = function(sender, args)
		local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
		local barSettings = settingsService:GetBarSettings(self.id);
		local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);

		if (barService:Alive(self.id) and barSettings.useFading == true) then
			self.faded = true;
			self:Refresh("Tab:MouseLeave");
		end
	end
	self.MouseDown = function(sender, args)
		local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
		local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);

		--if (barService:Alive(self.id) == true) then
			local settings = settingsService:GetSettings();
			if (settings.barMode ~= NORMAL_MODE) then
				if (args.Button == Turbine.UI.MouseButton.Left) then
					self.dragStartX = args.X;
					self.dragStartY = args.Y;
					self.dragging = true;
					self.dragged = false;
					-- local barSettings = settingsService:GetBarSettings( self.id );
					-- Turbine.Shell.WriteLine("MouseDown: " .. self.id )
				end
			end
		--end
	end
	self.MouseMove = function(sender, args)
		local left, top = self:GetPosition();
		local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
		local settings = settingsService:GetSettings();
		--Turbine.Shell.WriteLine("MouseMove: " );
		if (settings.barMode ~= NORMAL_MODE and self.dragging) then
			--Turbine.Shell.WriteLine("MouseMove: " .. self.barSettings.id );
			self.dragged = true;
			self:SetPosition(left + (args.X - self.dragStartX), top + (args.Y - self.dragStartY));
		end
	end
	self.MouseUp = function(sender, args)
		local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
		--Turbine.Shell.WriteLine("MouseMove: " );
		if (args.Button == Turbine.UI.MouseButton.Left) then
			self.dragging = false;
			--Turbine.Shell.WriteLine("MouseMove: " .. self.barSettings.id );
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

function Tab:SetHidden( hide )
	self.Log:Debug("SetHidden");

	if ( hide ~= self.hidden ) then
		self.hidden = hide;
		self:Refresh();
	end
end

function Tab:Refresh()
	self.Log:Debug("Refresh");

	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	local settings = settingsService:GetSettings();	

	if ( settings.barMode == NORMAL_MODE or self.hidden == true ) then
		self:SetVisible( false );
		self.Label:SetVisible(false);
	else
		self:SetVisible( true );
		self.Label:SetVisible(true);
	end

	local title = self.barSettings.barName;
	if ( self.barSettings.barName == nil or self.barSettings.barName == "" ) then
		title = "Bar:" .. self.barSettings.id;
	end
	self.Label:SetText( title );
	self:SetSize( self.targetWindow:GetWidth() + 2, self.targetWindow:GetHeight() + self.tabSize + 2);
	self.Label:SetSize( self:GetWidth() + 2, self.tabSize );
	self:SetOpacity( math.max( self.targetWindow:GetOpacity(), 0.4 ) );
end