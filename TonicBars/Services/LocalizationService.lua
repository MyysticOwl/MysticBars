-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

LocalizationService = class( Tonic.Utils.Service );

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
	local settingsService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.SettingsService);

	local settings = settingsService:GetSettings();
	if ( settings.menuLanguage == nil ) then
		self.language = Turbine.Engine:GetLocale();
	else
		self.language = settings.menuLanguage;
	end
	if ( self.language == "de" ) then
		-- ADD CLASS EFFECT REGIRATIONS HERE!!
		import "Tonic.TonicBars.Localization.German.MenuStrings";
		import "Tonic.TonicBars.Localization.German.EffectCategories"
		import "Tonic.TonicBars.Localization.German.Brawler"
		import "Tonic.TonicBars.Localization.German.Burglar"
		import "Tonic.TonicBars.Localization.German.LoreMaster"
		import "Tonic.TonicBars.Localization.German.Warden"
		import "Tonic.TonicBars.Localization.German.Captain"
		import "Tonic.TonicBars.Localization.German.Hunter"
		import "Tonic.TonicBars.Localization.German.Champion"
		import "Tonic.TonicBars.Localization.German.Guardian"
		import "Tonic.TonicBars.Localization.German.RuneKeeper"
		import "Tonic.TonicBars.Localization.German.Minstrel"
	elseif( self.language == "fr" ) then
		-- ADD CLASS EFFECT REGIRATIONS HERE!!
		import "Tonic.TonicBars.Localization.French.MenuStrings";
		import "Tonic.TonicBars.Localization.French.EffectCategories"
		import "Tonic.TonicBars.Localization.French.Brawler"
		import "Tonic.TonicBars.Localization.French.Burglar"
		import "Tonic.TonicBars.Localization.French.LoreMaster"
		import "Tonic.TonicBars.Localization.French.Warden"
		import "Tonic.TonicBars.Localization.French.Captain"
		import "Tonic.TonicBars.Localization.French.Hunter"
		import "Tonic.TonicBars.Localization.French.Champion"
		import "Tonic.TonicBars.Localization.French.Guardian"
		import "Tonic.TonicBars.Localization.French.RuneKeeper"
		import "Tonic.TonicBars.Localization.French.Minstrel"
	else
		-- ADD CLASS EFFECT REGIRATIONS HERE!!
		import "Tonic.TonicBars.Localization.English.MenuStrings";
		import "Tonic.TonicBars.Localization.English.EffectCategories"
		import "Tonic.TonicBars.Localization.English.Brawler"
		import "Tonic.TonicBars.Localization.English.Burglar"
		import "Tonic.TonicBars.Localization.English.LoreMaster"
		import "Tonic.TonicBars.Localization.English.Warden"
		import "Tonic.TonicBars.Localization.English.Captain"
		import "Tonic.TonicBars.Localization.English.Hunter"
		import "Tonic.TonicBars.Localization.English.Champion"
		import "Tonic.TonicBars.Localization.English.Guardian"
		import "Tonic.TonicBars.Localization.English.RuneKeeper"
		import "Tonic.TonicBars.Localization.English.Minstrel"
	end
end

function LocalizationService:GetLanguage()
	return self.language;
end