-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

import "Turbine.UI";
import "Turbine.UI.Lotro";

Tab = class( Turbine.UI.Window );

tabSize = 14;

function Tab:Constructor( window )
	Turbine.UI.Window.Constructor( self );

	self.targetWindow = window;
	self.hidden = false;

	self:SetSize( self.targetWindow:GetWidth(), tabSize );
	self:SetPosition( math.max( self.targetWindow:GetLeft(), 0 ), math.max( self.targetWindow:GetTop() - tabSize, 0 ) );
	self:SetBackColor( Turbine.UI.Color(1,1,1,1)  );

	self.Label = Turbine.UI.Label();
	self.Label:SetParent( self );
	self.Label:SetForeColor( Turbine.UI.Color( 1, 1, 1, 1 ) );
	self.Label:SetFontStyle( Turbine.UI.FontStyle.Outline );
	self.Label:SetOutlineColor( Turbine.UI.Color( 1, 0, 0, 0 ) );
	self.Label:SetFont( Turbine.UI.Lotro.Font.Verdana12 );
	self.Label:SetTextAlignment( Turbine.UI.ContentAlignment.TopCenter );
	self.Label:SetMouseVisible(false);
	self.Label:SetSize( self:GetWidth(), tabSize );
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
	if ( hide ~= self.hidden ) then
		self.hidden = hide;
		self:Refresh();
	end
end

function Tab:Refresh()
	local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);
	local settings = settingsService:GetSettings();	

	if ( settings.barMode == NORMAL_MODE or self.hidden == true ) then
		self:SetVisible( false );
	else
		self:SetVisible( true );
	end
	local barSettings = settingsService:GetBarSettings( self.targetWindow.id );
	local title = barSettings.barName;
	if ( barSettings.barName == nil or barSettings.barName == "" ) then
		title = "Bar:" .. self.targetWindow.id;
	end
	self.Label:SetText( title );
	self:SetSize( self.targetWindow:GetWidth(), tabSize );
	self.Label:SetSize( self:GetWidth(), tabSize );
	self:SetPosition( math.max( self.targetWindow:GetLeft(), 0 ), math.max( self.targetWindow:GetTop() - tabSize, 0 ) );
	self:SetOpacity( math.max( self.targetWindow:GetOpacity(), 0.4 ) );
	--self:SetOpacity( 0.4 );
end