-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!
local localizationService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.LocalizationService);
-- Main Menu
localizationService:Register( "MainButtons", "Easy Bars", 									"Schnellstart" );
localizationService:Register( "MainButtons", "Quick Slots", 								"Leisten erstellen" );
localizationService:Register( "MainButtons", "Extensions Bars", 							"Erweiterungen" );
localizationService:Register( "MainButtons", "General Settings", 							"Einstellungen" );
localizationService:Register( "MainButtons", "About TonicBars", 							"Über TonicBars" );
localizationService:Register( "MainButtons", "Inventory Bars", 							"Inventarleisten" );

-- About
localizationService:Register( "AboutMenu", "Thank you everyone for trying TonicBars. This enjoyable experience is brought to you by MyysticOwl!", "Vielen Dank für die Benutzung von TonicBars. Dieses Plugin wurde von MyysticOwl entwickelt!" );
localizationService:Register( "AboutMenu", "A special thanks to Pengoros for their Dropdown lists. Another special thanks to Digital_Utopia for Window and other GUI components.", "Ein besonderer Dank geht an Pengoros für seine Dropdown Listen sowie an Digital_Utopia für die Fenster- und andere GUI-Komponenten." );
localizationService:Register( "AboutMenu", "I hope you appreciate the many hours that went into this plugin, enjoy!", "Ich hoffe ihr würdigt die vielen Stunden, die für das Plugin aufgewendet wurden. Viel Spaß!" );
localizationService:Register( "AboutMenu", "This is version ", 							"Das ist Version " );
localizationService:Register( "AboutMenu", " of TonicBars!", 								" von TonicBars!" );

-- Easy Bars
localizationService:Register( "EasyBarMenu", "Create Bars Quickly", 						"Schnellstartleisten" );
localizationService:Register( "EasyBarMenu", "This menu is used to create complicated bars, very easily. Often getting everything setup on your bar takes a lot of time. Hopefully this helps you get where you want to go easier.", "Dieses Menü vereinfacht das Erstellen von neuen Leisten. Die benötigte Zeit für das Einrichten von Verknüpfungen wird mit dieser Funktion minimiert." );
localizationService:Register( "EasyBarMenu", "Class Based Bars", 							"Klassenbasierte Leisten" );
localizationService:Register( "EasyBarMenu", "Remove", "Remove" );

-- Extensions
localizationService:Register( "ExtensionsMenu", "Extensions", 								"Erweiterungen" );
localizationService:Register( "ExtensionsMenu", "General", 								"Allgemeine Einstellungen" );
localizationService:Register( "ExtensionsMenu", "Quick Slots", 							"Felder" );
localizationService:Register( "ExtensionsMenu", "Predefined Extensions", 					"Vordefinierte Leisten" );

-- localizationService:Register( "ExtensionsMenu", 11, "Transparenz:" );
-- localizationService:Register( "ExtensionsMenu", 12, "Abstand zwischen Feldern:" );
-- localizationService:Register( "ExtensionsMenu", 13, "Größe der Felder:" );
-- localizationService:Register( "ExtensionsMenu", 14, "Entfernen" );

localizationService:Register( "ExtensionsMenu", "Extensions work different than QuickBars. To add an Extension, just right click on the quickslot to extend. Then select the orientation.", "Erweiterungen funktionieren anders als normale Leisten. Um eine Erweiterung einzufügen, mache einen Rechtsklick auf das entsprechende Feld und wähle die gewünschte Ausrichtung." );
localizationService:Register( "ExtensionsMenu", "Editing Settings for Bar:", 				"Folgende Leiste bearbeiten:" );
localizationService:Register( "ExtensionsMenu", "Name:", 									"Name:" );
localizationService:Register( "ExtensionsMenu", "Set", 									"Speichern" );
localizationService:Register( "ExtensionsMenu", "This will change shortcuts on the current bar perminately!!!!", "Diese Funktion ändert die Verknüpfungen der aktuellen Leiste!" );
localizationService:Register( "ExtensionsMenu", "Orientation:", 							"Ausrichtung:" );
localizationService:Register( "ExtensionsMenu", "When attached quickslot is Moused Over:", "Bei Mouseover:" );
localizationService:Register( "ExtensionsMenu", "Stop displaying extension when:", 		"Erweitungen verbergen wenn:" );
localizationService:Register( "ExtensionsMenu", "Count:", 									"Anzahl:" );
localizationService:Register( "ExtensionsMenu", "Opacity:", 								"Transparenz:" );
localizationService:Register( "ExtensionsMenu", "Spacing:", 								"Abstand:" );
localizationService:Register( "ExtensionsMenu", "Size:", 									"Größe:" );
localizationService:Register( "ExtensionsMenu", "Remove", 									"Entfernen" );

localizationService:Register( "ExtensionTypes", "Hunters Travel", 							"Jäger-Reisen" );
localizationService:Register( "ExtensionTypes", "Wardens Travel", 							"Hüter-Apelle" );
localizationService:Register( "ExtensionTypes", "Reputation Travel", 						"Ruf-Schnellreisen" );
localizationService:Register( "ExtensionTypes", "Housing Travel", 							"Haus-Schnellreisen" );
localizationService:Register( "ExtensionTypes", "LM Combat Pets", 							"Kampfbegleiter des Kundigen" );
localizationService:Register( "ExtensionTypes", "LM Cosmetic Pets", 						"Tiere des Kundigen" );
localizationService:Register( "ExtensionTypes", "Captain Pets", 							"Begleiter des Hauptmann" );
localizationService:Register( "ExtensionTypes", "Horses", 									"Pferde" );
localizationService:Register( "ExtensionTypes", "Horses (more)", 							"Pferde (mehr)" );
localizationService:Register( "ExtensionTypes", "Ponies", 									"Ponys" );
localizationService:Register( "ExtensionTypes", "Ponies (more)", 							"Ponys (mehr)" );
localizationService:Register( "ExtensionTypes", "Instruments", 							"Instrumente" );
localizationService:Register( "ExtensionTypes", "Mini DPS", 								"Mini DPS" );

localizationService:Register( "Orientation", "Left", 										"Links" );
localizationService:Register( "Orientation", "Right", 										"Rechts" );
localizationService:Register( "Orientation", "Up", 										"Hoch" );
localizationService:Register( "Orientation", "Down", 										"Runter" );

localizationService:Register( "ExtensionRule", "Show Extension(s)", 						"Erweiterung(en) anzeigen" );
localizationService:Register( "ExtensionRule", "Show & Rollup Selection", 					"Anzeigen & Aufrollen" )
localizationService:Register( "ExtensionRule", "Select Random Shortcut", 					"Zufällige Verknüpfung" );
localizationService:Register( "ExtensionRule", "Cycle Shortcuts", 							"Verknüpfungen wechseln" );
localizationService:Register( "ExtensionRule", "On Click Cycle Shortcuts", 				"Verknüpfungen nach Klick wechseln" );

localizationService:Register( "ExtensionRemoval", "Mouse Leaves Bar", 						"Mauszeiger weg ist" );
localizationService:Register( "ExtensionRemoval", "Combat has ended", 						"Kampf beendet wurde" );

-- General Menu
localizationService:Register( "GeneralMenu", "General Settings", 							"Einstellungen" );
localizationService:Register( "GeneralMenu", "Copy Profiles", 								"Profile kopieren" );
localizationService:Register( "GeneralMenu", "Display Launcher?", 							"TonicBars-Symbol anzeigen?" );
localizationService:Register( "GeneralMenu", "Plugin can't determine your class, please select the correct one:", "Deine Klasse konnte nicht richtig erkannt werden. Bitte wähle die richtige Klasse aus:" );
localizationService:Register( "GeneralMenu", "Profiles", 									"Profiles - Select a profile and then which bar you want to Take or Give. Make sure to select one or the other, you are not allowed to select both." );
localizationService:Register( "GeneralMenu", "Without Icons", 								"Ohne Verknüpfungen" );
localizationService:Register( "GeneralMenu", "With Icons", 								"Mit Verknüpfungen" );
localizationService:Register( "GeneralMenu", "Yes", 										"Ja" );
localizationService:Register( "GeneralMenu", "Languages", 									"Sprachen" );
localizationService:Register( "GeneralMenu", "English", 									"Englisch" );
localizationService:Register( "GeneralMenu", "German", 									"Deutsch" );
localizationService:Register( "GeneralMenu", "French", 									"Französisch" );
	
localizationService:Register( "GeneralMenu", "Take", "-->Take their bar on this character:" );
localizationService:Register( "GeneralMenu", "Give", "-->Give my bar to them:" );
localizationService:Register( "GeneralMenu", "If you want to copy your bar locations from another character on this server you can perform that by selecting the characters name from the dropdown and selecting 'Copy Profile'.", "If you want to copy your bar locations from another character on this server you can perform that by selecting the characters name from the dropdown and selecting 'Copy Profile'." );
	
localizationService:Register( "ClassNames", "Guardian", 									"Wächter" );
localizationService:Register( "ClassNames", "Captain", 									"Hauptmann" );
localizationService:Register( "ClassNames", "Minstrel", 									"Barde" );
localizationService:Register( "ClassNames", "Burglar", 									"Schurke" );
localizationService:Register( "ClassNames", "Hunter", 										"Jäger" );
localizationService:Register( "ClassNames", "Champion", 									"Waffenmeister" );
localizationService:Register( "ClassNames", "Lore Master", 								"Kundiger" );
localizationService:Register( "ClassNames", "Rune Keeper", 								"Runenbewahrer" );
localizationService:Register( "ClassNames", "Warden", 										"Hüter" );


-- localizationService:Register( "QuickslotsMenu", 1, "Klicke 'Hinzufügen' um das Plugin zu nutzen oder wähle eine Schnellstartleiste aus." );
-- localizationService:Register( "QuickslotsMenu", 2, "Hinzufügen" );
-- localizationService:Register( "QuickslotsMenu", 3, "Folgende Leiste bearbeiten:" );
-- localizationService:Register( "QuickslotsMenu", 4, "Anzeigen der Leiste:" );
-- localizationService:Register( "QuickslotsMenu", 5, "Leiste anzeigen, wenn klassenspezifische Buffs aktiviert werden:" );
-- localizationService:Register( "QuickslotsMenu", 6, "Leben sinkt unter %:" );
-- localizationService:Register( "QuickslotsMenu", 7, "Kraft sinkt unter %:" );
-- localizationService:Register( "QuickslotsMenu", 8, "Auslöser verbergen" );
-- localizationService:Register( "QuickslotsMenu", 9, "Hintergrundfarbe der Leiste" );
-- localizationService:Register( "QuickslotsMenu", 10, "Rot:" );
-- localizationService:Register( "QuickslotsMenu", 11, "Grün:" );
-- localizationService:Register( "QuickslotsMenu", 12, "Blau:" );
-- localizationService:Register( "QuickslotsMenu", 13, "Transparenz der Leiste:" );
-- localizationService:Register( "QuickslotsMenu", 14, "Transparenz der Verknüpfungen:" );
-- localizationService:Register( "QuickslotsMenu", 15, "Undurchsichtig bei Mouseover?" );
-- localizationService:Register( "QuickslotsMenu", 16, "Farboptionen verbergen" );
-- localizationService:Register( "QuickslotsMenu", 17, "Name:" );
-- localizationService:Register( "QuickslotsMenu", 18, "Name ändern" );
-- localizationService:Register( "QuickslotsMenu", 19, "" );
-- localizationService:Register( "QuickslotsMenu", 20, "Fixieren" );
-- localizationService:Register( "QuickslotsMenu", 21, "Maximale Felder:" );
-- localizationService:Register( "QuickslotsMenu", 22, "Anzahl der Spalten:" );
-- localizationService:Register( "QuickslotsMenu", 23, "Abstand zwischen Feldern:" );
-- localizationService:Register( "QuickslotsMenu", 24, "Größe der Felder:" );
-- localizationService:Register( "QuickslotsMenu", 25, "Auslöser anzeigen" );
-- localizationService:Register( "QuickslotsMenu", 26, "Farboptionen anzeigen" );
-- localizationService:Register( "QuickslotsMenu", 27, "Entfernen" );
-- localizationService:Register( "QuickslotsMenu", 28, "Kopieren" );
-- localizationService:Register( "QuickslotsMenu", 29, "Zurücksetzen" );
-- localizationService:Register( "QuickslotsMenu", 30, "Kopieren und Zurücksetzen erfordern einen Neustart" );
-- localizationService:Register( "QuickslotsMenu", 31, "des Plugins, bis der Fehler behoben ist." );

-- Quickslots Menu
localizationService:Register( "QuickslotsMenu", "Quick Bars", 								"Schnellstartleisten" );
localizationService:Register( "QuickslotsMenu", "General", 								"Allgemeine Einstellungen" );
localizationService:Register( "QuickslotsMenu", "Bar Visibility?", 						"Leiste sichtbar?" );
localizationService:Register( "QuickslotsMenu", "Class Triggers", 							"Klassen-Auslöser" );
localizationService:Register( "QuickslotsMenu", "Quick Slots", 							"Verknüpfungen" );
localizationService:Register( "QuickslotsMenu", "Background Colors", 						"Hintergrundfarbe" );
localizationService:Register( "QuickslotsMenu", "Miscellaneous", 							"Verschiedenes" );
localizationService:Register( "QuickslotsMenu", "Add", 									"Hinzufügen" );
localizationService:Register( "QuickslotsMenu", "Editing Settings for Bar:", 				"Folgende Leiste bearbeiten:" );
localizationService:Register( "QuickslotsMenu", "Health Drops Below this %:", 				"Leben sinkt unter %:" );
localizationService:Register( "QuickslotsMenu", "Power Drops Below this %:", 				"Kraft sinkt unter %:" );
localizationService:Register( "QuickslotsMenu", "Use Background Color on Bar", 			"Hintergrundfarbe anwenden?" );
localizationService:Register( "QuickslotsMenu", "Red:", 									"Rot:" );
localizationService:Register( "QuickslotsMenu", "Green:", 									"Grün:" );
localizationService:Register( "QuickslotsMenu", "Blue:", 									"Blau:" );
localizationService:Register( "QuickslotsMenu", "Opacity:", 								"Sichtbarkeit:" );
localizationService:Register( "QuickslotsMenu", "Remove opacity when moused over?", 		"Undurchsichtig bei Mouseover?" );
localizationService:Register( "QuickslotsMenu", "Name:", 									"Name:" );
localizationService:Register( "QuickslotsMenu", "Set", 									"Speichern" );
localizationService:Register( "QuickslotsMenu", "Visible",  								"Sichtbar" );
localizationService:Register( "QuickslotsMenu", "Locked", 									"Fest" );
localizationService:Register( "QuickslotsMenu", "Rows:", 									"Zeilen:" );
localizationService:Register( "QuickslotsMenu", "Columns:", 								"Spalten:" );
localizationService:Register( "QuickslotsMenu", "Spacing:", 								"Abstand:" );
localizationService:Register( "QuickslotsMenu", "Size:", 									"Größe:" );
localizationService:Register( "QuickslotsMenu", "Triggers", 								"Auslöser" );
localizationService:Register( "QuickslotsMenu", "Remove", 									"Entfernen" );
localizationService:Register( "QuickslotsMenu", "Copy", 									"Kopieren" );
localizationService:Register( "QuickslotsMenu", "Reset", 									"Zurücksetzen" );
localizationService:Register( "QuickslotsMenu", "Fade Opacity:", 							"Transparenz ausblenden:" );
localizationService:Register( "QuickslotsMenu", "Min:", 									"Min:" );
localizationService:Register( "QuickslotsMenu", "Max:", 									"Max:" );

	localizationService:Register( "InventoryPanel", "Inventory Options", "Inventory Options" );
	localizationService:Register( "InventoryPanel", "Category Based:", "Category Based:" );
	localizationService:Register( "InventoryPanel", "Name Based:", "Name Based:" );
	localizationService:Register( "InventoryPanel", "Add Name Filter:", "Add Name Filter:" );
	localizationService:Register( "InventoryPanel", "Add", "Add" );
	localizationService:Register( "InventoryPanel", "Quantity Based:", "Quantity Based:" );

localizationService:Register( "QuickslotVisibility", "Always", 							"Immer" );
localizationService:Register( "QuickslotVisibility", "Triggered", 							"Ausgelöst" );

localizationService:Register( "ClassTriggerType", "Triggered When:", 						"Ausgelöst, wenn" );
localizationService:Register( "ClassTriggerType", "Buffs Active", 							"Buff aktiviert" );
localizationService:Register( "ClassTriggerType", "Buffs Not Active", 						"Buff nicht aktiviert" );

localizationService:Register( "ClassTriggers", "Crit Tier1", 								"Crit Tier1" );
localizationService:Register( "ClassTriggers", "Crit Tier2", 								"Crit Tier2" );
localizationService:Register( "ClassTriggers", "Crit Tier3", 								"Crit Tier3" );
localizationService:Register( "ClassTriggers", "Fervor between:", 							"Leidenschaft zwischen:" );
localizationService:Register( "ClassTriggers", "Attunement between:", 						"Einstimmung zwischen:" );
localizationService:Register( "ClassTriggers", "Charged", 									"Geladen" );
localizationService:Register( "ClassTriggers", "Focus between:", 							"Fokus zwischen:" );
localizationService:Register( "QuickslotsDisplay", "In Combat", 							"Im Kampf" );
localizationService:Register( "QuickslotsDisplay", "Out of Combat", 						"Nicht im Kampf" );
localizationService:Register( "QuickslotsDisplay", "Mounted", 								"Mounted" );
localizationService:Register( "QuickslotsDisplay", "Not Mounted", 							"Not Mounted" );
localizationService:Register( "QuickslotsDisplay", "Combat Mounted", 						"Combat Mounted" );
localizationService:Register( "QuickslotsDisplay", "Not Combat Mounted", 					"Not Combat Mounted" );	
localizationService:Register( "QuickslotsDisplay", "Alt Pressed", 							"Alt gedrückt" );
localizationService:Register( "QuickslotsDisplay", "Ctrl Pressed", 						"Strg gedrückt" );
localizationService:Register( "QuickslotsDisplay", "Shift Pressed", 						"Shift gedrückt" );

localizationService:Register( "InventoryMenu", 1, "Click Add Bar to start using tonic bars or select an Inventory Bar to edit." );
localizationService:Register( "InventoryMenu", 2, "Add Bar" );
localizationService:Register( "InventoryMenu", 3, "Editing Settings for Bar:" );

localizationService:Register( "ClassBars", "Tier1 Skills", 								"Stufe-1-Fertigkeit" );
localizationService:Register( "ClassBars", "Tier2 Skills", 								"Stufe-2-Fertigkeit" );
localizationService:Register( "ClassBars", "Tier3 Skills", 								"Stufe-3-Fertigkeit" );
localizationService:Register( "ClassBars", "Tier4 Skills", 								"Stufe-4-Fertigkeit" );
localizationService:Register( "ClassBars", "Tier5 Skills", 								"Stufe-5-Fertigkeit" );
localizationService:Register( "ClassBars", "Tricks", 										"Tricks" );
localizationService:Register( "ClassBars", "Trick Removals", 								"Trick Umzug" );
localizationService:Register( "ClassBars", "Mischief Skills", 								"Schalk Fertigkeit" );
localizationService:Register( "ClassBars", "Knockdown Skills", 							"Knockdown Fertigkeit" );
localizationService:Register( "ClassBars", "Heralds", 										"Herolde" );
localizationService:Register( "ClassBars", "Marks", 										"Marks" );
localizationService:Register( "ClassBars", "Tactics", 										"Taktiken" );
localizationService:Register( "ClassBars", "Defeat Skills", 								"Besiegt Fertigkeit" );
localizationService:Register( "ClassBars", "Stances", 										"Haltungen" );
localizationService:Register( "ClassBars", "Overpower Skills", 							"Überwältigen Fertigkeiten" );
localizationService:Register( "ClassBars", "Parry Skills", 								"Parier-Fertigkeiten" );
localizationService:Register( "ClassBars", "Block Skills", 								"Block-Fertigkeiten" );
localizationService:Register( "ClassBars", "Focus >= 3 Skills", 							"Fokus >= 3 Fertigkeiten" );
localizationService:Register( "ClassBars", "Focus >= 6 Skills", 							"Fokus >= 6 Fertigkeiten" );
localizationService:Register( "ClassBars", "Find The Path", 								"Find The Path" );	
localizationService:Register( "ClassBars", "War-Speech Skills", 							"Kriegsrede Fertigkeiten" );
localizationService:Register( "ClassBars", "Scribe Stance Skills", 						"Haltung: Schreiber Fertigkeit" );
localizationService:Register( "ClassBars", "Warding", 										"Warding" );
localizationService:Register( "ClassBars", "Lore", 										"Lore" );
localizationService:Register( "ClassBars", "Sign of the Wild", 							"Sign of the Wild" );
localizationService:Register( "ClassBars", "Sign of Power", 								"Sign of Power" );
localizationService:Register( "ClassBars", "Anthem Skills", 								"Anthem Skills" );

localizationService:Register( "ClassBars", "Restoration Skill", 							"Rückgabe Fertigkeit" );
localizationService:Register( "ClassBars", "DPS Attonement Skill", 						"DPS Attonement Fertigkeit" );
localizationService:Register( "ClassBars", "Healing Attonement Skill", 					"Healing Attonement Fertigkeit" );
localizationService:Register( "ClassBars", "3 DPS Attonement, Skills", 					"3 DPS Attonement Fertigkeit" );
localizationService:Register( "ClassBars", "6 DPS Attonement, Skills", 					"6 DPS Attonement Fertigkeit" );
localizationService:Register( "ClassBars", "Full DPS Attonement, Skills", 					"Full DPS Attonement Fertigkeit" );
localizationService:Register( "ClassBars", "3 Heal Attonement Skills", 					"3 Heal Attonement Fertigkeit" );
localizationService:Register( "ClassBars", "6 Heal Attonement Skills", 					"6 Heal Attonement Fertigkeit" );
localizationService:Register( "ClassBars", "Full Heal Attonement Skills", 					"Full Heal Attonement Fertigkeit" );