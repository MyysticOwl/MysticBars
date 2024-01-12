-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

TabbedBarDecorator = class( );

TabbedBarDecorator.Log = MysticBars.Utils.Logging.LogManager.GetLogger( "TabbedBarDecorator" );

function TabbedBarDecorator:Constructor( parentWindow, barSettings )
	self.Log:Debug("Constructor");

	self.parentWindow = parentWindow;
	self.barSettings = barSettings;
end

function TabbedBarDecorator:Create()
	self.Log:Debug("Create");

	self.tab = MysticBars.Bars.Decorators.Tab( self.parentWindow, self.barSettings );
end

function TabbedBarDecorator:PositionChanged( sender, args )
	self.Log:Debug("PositionChanged");
	local settings = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):GetSettings();
	if ( settings.barMode ~= NORMAL_MODE or ( self.DragBar ~= nil and self.DragBar:IsHUDVisible() == true ) ) then
		SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService):UpdateBarSettings(self.id, function(barSettings)
			local x, y = self:GetPosition();

			barSettings.relationalX = x / DISPLAYWIDTH;
			barSettings.relationalY = y / DISPLAYHEIGHT;

			barSettings.x = math.floor(barSettings.relationalX * DISPLAYWIDTH);
			barSettings.y = math.floor(barSettings.relationalY * DISPLAYHEIGHT);
			return barSettings;
		end, function(barSettings)
			self:SetPosition( barSettings.x, barSettings.y );
		end);
	end
end

function TabbedBarDecorator:Remove()
	self.Log:Debug("Remove");

	self.tab:SetHidden( true );
	self.tab = nil;
end

function TabbedBarDecorator:SetBackColor( color )
	self.Log:Debug("SetBackColor");

	self.tab:SetBackColor( color );
end

function TabbedBarDecorator:Refresh()
	self.Log:Debug("Refresh");

	self.tab:Refresh();
end

function TabbedBarDecorator:SetBGColor(color)
	self.Log:Debug("SetBGColor");

	self:SetBackColor(color);
end
