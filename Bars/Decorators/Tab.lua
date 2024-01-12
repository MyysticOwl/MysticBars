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

	self.MouseDown = function( sender, args )
		self.targetWindow:MouseDown(args);
	end
	self.MouseMove = function( sender, args )
		self.targetWindow:MouseMove(args);
	end
	self.MouseUp = function( sender, args )
		self.targetWindow:MouseUp(args);
	end
	self.PositionChanged = function(sender,args)
		self.targetWindow:PositionChanged(sender,args);
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
	else
		self:SetVisible( true );
	end

	local title = self.barSettings.barName;
	if ( self.barSettings.barName == nil or self.barSettings.barName == "" ) then
		title = "Bar:" .. self.barSettings.id;
	end
	self.Label:SetText( title );
	self:SetSize( self.targetWindow:GetWidth(), self.tabSize );
	self.Label:SetSize( self:GetWidth(), self.tabSize );
	self:SetPosition( math.max( self.targetWindow:GetLeft(), 0 ), math.max( self.targetWindow:GetTop() - self.tabSize, 0 ) );
	self:SetOpacity( math.max( self.targetWindow:GetOpacity(), 0.4 ) );
end