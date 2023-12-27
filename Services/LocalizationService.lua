-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

LocalizationService = class( MyysticUI.Utils.Service );

function LocalizationService:Constructor()
	STRING = { };
end

function LocalizationService:Register( path, location, value )
	if ( STRING[path] == nil ) then
		STRING[path] = { };
	end
	STRING[path][location] = value;
end

function LocalizationService:GetStrings()
	return STRING;
end

function LocalizationService:LoadLocalizedEvents()
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);

	local settings = settingsService:GetSettings();
	if ( settings.menuLanguage == nil ) then
		self.language = Turbine.Engine:GetLocale();
	else
		self.language = settings.menuLanguage;
	end
	if ( self.language == "de" ) then
		-- ADD CLASS EFFECT REGIRATIONS HERE!!
		import "MyysticUI.Core.Localization.German.MenuStrings";
		import "MyysticUI.Core.Localization.German.EffectCategories"
		import "MyysticUI.Core.Localization.German.Brawler"
		import "MyysticUI.Core.Localization.German.Burglar"
		import "MyysticUI.Core.Localization.German.LoreMaster"
		import "MyysticUI.Core.Localization.German.Warden"
		import "MyysticUI.Core.Localization.German.Captain"
		import "MyysticUI.Core.Localization.German.Hunter"
		import "MyysticUI.Core.Localization.German.Champion"
		import "MyysticUI.Core.Localization.German.Guardian"
		import "MyysticUI.Core.Localization.German.RuneKeeper"
		import "MyysticUI.Core.Localization.German.Minstrel"
	elseif( self.language == "fr" ) then
		-- ADD CLASS EFFECT REGIRATIONS HERE!!
		import "MyysticUI.Core.Localization.French.MenuStrings";
		import "MyysticUI.Core.Localization.French.EffectCategories"
		import "MyysticUI.Core.Localization.French.Brawler"
		import "MyysticUI.Core.Localization.French.Burglar"
		import "MyysticUI.Core.Localization.French.LoreMaster"
		import "MyysticUI.Core.Localization.French.Warden"
		import "MyysticUI.Core.Localization.French.Captain"
		import "MyysticUI.Core.Localization.French.Hunter"
		import "MyysticUI.Core.Localization.French.Champion"
		import "MyysticUI.Core.Localization.French.Guardian"
		import "MyysticUI.Core.Localization.French.RuneKeeper"
		import "MyysticUI.Core.Localization.French.Minstrel"
	else
		-- ADD CLASS EFFECT REGIRATIONS HERE!!
		import "MyysticUI.Core.Localization.English.MenuStrings";
		import "MyysticUI.Core.Localization.English.EffectCategories"
		import "MyysticUI.Core.Localization.English.Brawler"
		import "MyysticUI.Core.Localization.English.Burglar"
		import "MyysticUI.Core.Localization.English.LoreMaster"
		import "MyysticUI.Core.Localization.English.Warden"
		import "MyysticUI.Core.Localization.English.Captain"
		import "MyysticUI.Core.Localization.English.Hunter"
		import "MyysticUI.Core.Localization.English.Champion"
		import "MyysticUI.Core.Localization.English.Guardian"
		import "MyysticUI.Core.Localization.English.RuneKeeper"
		import "MyysticUI.Core.Localization.English.Minstrel"
	end
end

function LocalizationService:GetLanguage()
	return self.language;
end