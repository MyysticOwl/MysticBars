-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

LocalizationService = class( MyysticBars.Utils.Service );

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
	local settingsService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.SettingsService);

	local settings = settingsService:GetSettings();
	if ( settings.menuLanguage == nil ) then
		self.language = Turbine.Engine:GetLocale();
	else
		self.language = settings.menuLanguage;
	end
	if ( self.language == "de" ) then
		-- ADD CLASS EFFECT REGIRATIONS HERE!!
		import "MyysticBars.TonicBars.Localization.German.MenuStrings";
		import "MyysticBars.TonicBars.Localization.German.EffectCategories"
		import "MyysticBars.TonicBars.Localization.German.Brawler"
		import "MyysticBars.TonicBars.Localization.German.Burglar"
		import "MyysticBars.TonicBars.Localization.German.LoreMaster"
		import "MyysticBars.TonicBars.Localization.German.Warden"
		import "MyysticBars.TonicBars.Localization.German.Captain"
		import "MyysticBars.TonicBars.Localization.German.Hunter"
		import "MyysticBars.TonicBars.Localization.German.Champion"
		import "MyysticBars.TonicBars.Localization.German.Guardian"
		import "MyysticBars.TonicBars.Localization.German.RuneKeeper"
		import "MyysticBars.TonicBars.Localization.German.Minstrel"
	elseif( self.language == "fr" ) then
		-- ADD CLASS EFFECT REGIRATIONS HERE!!
		import "MyysticBars.TonicBars.Localization.French.MenuStrings";
		import "MyysticBars.TonicBars.Localization.French.EffectCategories"
		import "MyysticBars.TonicBars.Localization.French.Brawler"
		import "MyysticBars.TonicBars.Localization.French.Burglar"
		import "MyysticBars.TonicBars.Localization.French.LoreMaster"
		import "MyysticBars.TonicBars.Localization.French.Warden"
		import "MyysticBars.TonicBars.Localization.French.Captain"
		import "MyysticBars.TonicBars.Localization.French.Hunter"
		import "MyysticBars.TonicBars.Localization.French.Champion"
		import "MyysticBars.TonicBars.Localization.French.Guardian"
		import "MyysticBars.TonicBars.Localization.French.RuneKeeper"
		import "MyysticBars.TonicBars.Localization.French.Minstrel"
	else
		-- ADD CLASS EFFECT REGIRATIONS HERE!!
		import "MyysticBars.TonicBars.Localization.English.MenuStrings";
		import "MyysticBars.TonicBars.Localization.English.EffectCategories"
		import "MyysticBars.TonicBars.Localization.English.Brawler"
		import "MyysticBars.TonicBars.Localization.English.Burglar"
		import "MyysticBars.TonicBars.Localization.English.LoreMaster"
		import "MyysticBars.TonicBars.Localization.English.Warden"
		import "MyysticBars.TonicBars.Localization.English.Captain"
		import "MyysticBars.TonicBars.Localization.English.Hunter"
		import "MyysticBars.TonicBars.Localization.English.Champion"
		import "MyysticBars.TonicBars.Localization.English.Guardian"
		import "MyysticBars.TonicBars.Localization.English.RuneKeeper"
		import "MyysticBars.TonicBars.Localization.English.Minstrel"
	end
end

function LocalizationService:GetLanguage()
	return self.language;
end