-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

import "Turbine";
import "Tonic.Utils.Class";
import "Tonic.UI.MenuUtils";
import "Tonic.TonicBars.Menu.Panels.Controls.GeneralPanel"
import "Tonic.TonicBars.Menu.Panels.Controls.SlotsPanel"
import "Tonic.TonicBars.Menu.Panels.Controls.ClassBuffPanel"

BarMenuPanel = class();

BarMenuPanel.utils = Tonic.UI.MenuUtils();

function BarMenuPanel:Draw(context)
	menu.contentBox:ClearItems();

	self.utils:AddCategoryBox(menu.contentBox, context.barName);

	-----------------------   GENERAL  0000000000000000000000000000
	self.generalPanel = Tonic.TonicBars.Menu.Panels.Controls.GeneralPanel( menu.contentBox );

	-----------------------   SLOTS	  0000000000000000000000000000
	self.slotsPanel = Tonic.TonicBars.Menu.Panels.Controls.SlotsPanel( menu.contentBox, true );

	-----------------------   COLOR  0000000000000000000000000000
	self.colorPanel = Tonic.TonicBars.Menu.Panels.Controls.ColorPanel( menu.contentBox );

	-----------------------   TRIGGERS  0000000000000000000000000000
	self.tp = Tonic.TonicBars.Menu.Panels.Controls.TriggersPanel( menu.contentBox );

	-----------------------   CLASS BUFF TRIGGERS  0000000000000000000000000000
	self.classBuffPanel = Tonic.TonicBars.Menu.Panels.Controls.ClassBuffPanel( menu.contentBox );

	self:DisplaySettings();
end

function BarMenuPanel:DisplaySettings()
	local settingsService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.SettingsService);
	local localBarSettings = settingsService:GetBarSettings( menu:GetSelection() );
	if ( localBarSettings.events == nil ) then
		localBarSettings.events = { };
	end

	self.tp:DisplaySettings();
	self.classBuffPanel:DisplaySettings();
	self.slotsPanel:DisplaySettings();
	self.generalPanel:DisplaySettings();
	self.colorPanel:DisplaySettings();
end