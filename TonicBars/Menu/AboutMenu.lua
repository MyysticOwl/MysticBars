-- Created by MyysticOwl
-- If reusing this code, please keep the name of the original author listed
-- in respect for borrowing said authors code.
-- RESPECT!

import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "Tonic.Utils.Class";
import "Tonic.UI.CheckBox";
import "Tonic.UI.ComboBox";
import "Tonic.UI.AutoListBox";
import "Tonic.UI.MenuUtils";

AboutMenu = class( Tonic.UI.AutoListBox );

function AboutMenu:Constructor()
	Tonic.UI.AutoListBox.Constructor( self );

	self.utils = Tonic.UI.MenuUtils();

	self.text = self.utils:AddLabelBox( self, LOCALESTRINGS.AboutMenu["Thank you everyone for trying TonicBars. This enjoyable experience is brought to you by MyysticOwl!"], 390, 25 );
	self.text = self.utils:AddLabelBox( self, LOCALESTRINGS.AboutMenu["I hope you appreciate the many hours that went into this plugin, enjoy!"], 390, 25 );
	self.text = self.utils:AddLabelBox( self, LOCALESTRINGS.AboutMenu["This is version "] .. THEVERSION .. LOCALESTRINGS.AboutMenu[" of TonicBars!"], 390, 25 );
end

function AboutMenu:DisplaySettings( showQuickslots )
end

function AboutMenu:GetSelection()
	return nil;
end