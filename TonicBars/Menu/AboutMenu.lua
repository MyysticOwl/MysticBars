-- Created by MyysticOwl
-- If reusing this code, please keep the name of the original author listed
-- in respect for borrowing said authors code.
-- RESPECT!

import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "MyysticBars.Utils.Class";
import "MyysticBars.UI.CheckBox";
import "MyysticBars.UI.ComboBox";
import "MyysticBars.UI.AutoListBox";
import "MyysticBars.UI.MenuUtils";

AboutMenu = class( MyysticBars.UI.AutoListBox );

function AboutMenu:Constructor()
	MyysticBars.UI.AutoListBox.Constructor( self );

	self.utils = MyysticBars.UI.MenuUtils();

	self.text = self.utils:AddLabelBox( self, LOCALESTRINGS.AboutMenu["Thank you everyone for trying TonicBars. This enjoyable experience is brought to you by MyysticOwl!"], 390, 25 );
	self.text = self.utils:AddLabelBox( self, LOCALESTRINGS.AboutMenu["I hope you appreciate the many hours that went into this plugin, enjoy!"], 390, 25 );
	self.text = self.utils:AddLabelBox( self, LOCALESTRINGS.AboutMenu["This is version "] .. THEVERSION .. LOCALESTRINGS.AboutMenu[" of TonicBars!"], 390, 25 );
end

function AboutMenu:DisplaySettings( showQuickslots )
end

function AboutMenu:GetSelection()
	return nil;
end