local language = Turbine.Engine.GetLanguage();

_G.locale = (language == Turbine.Language.German and "de" or (language == Turbine.Language.French and "fr" or (language == Turbine.Language.Russian and "ru" or "en" )));
_G.L = {}

-- since English & German are supported at release, load their locale files directly
if (locale == "en" or locale == "de" or locale == "fr") then
  import ("MysticBars.Menus.Localization."..locale);
-- for all other languages, we now load the English locale file first, then load the language specific file (which may only override some values) only if it exists
else
  import ("MysticBars.Menus.Localization.en");
  pcall(import, ("MysticBars.Menus.Localization."..locale));
end