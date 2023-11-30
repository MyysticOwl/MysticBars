-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!
	local localizationService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.LocalizationService);
	
	-- Main Menu
	localizationService:Register( "MainButtons", "Edit Mode", 			"Edit Mode" );

	localizationService:Register( "MainButtons", "Easy Bars", 			"Easy Bars" );
	localizationService:Register( "MainButtons", "Quick Slots", 		"Quick Slots" );
	localizationService:Register( "MainButtons", "Extensions Bars", 	"Extensions Bars" );
	localizationService:Register( "MainButtons", "General Settings", 	"General Settings" );
	localizationService:Register( "MainButtons", "About TonicBars", 	"About TonicBars" );
	localizationService:Register( "MainButtons", "Inventory Bars", 	"Inventory Bars" );
	
	-- About
	localizationService:Register( "AboutMenu", "Thank you everyone for trying TonicBars. This enjoyable experience is brought to you by MyysticOwl!", "Thank you everyone for trying TonicBars. This enjoyable experience is brought to you by MyysticOwl!" );
	localizationService:Register( "AboutMenu", "A special thanks to Farothhen for his German Translations and Daniel Diehl for the French Translations.", "A special thanks to Farothhen for his German Translations and Daniel Diehl for the French Translations." );
	localizationService:Register( "AboutMenu", "I hope you appreciate the many hours that went into this plugin, enjoy!", "I hope you appreciate the many hours that went into this plugin, enjoy!" );
	localizationService:Register( "AboutMenu", "This is version ", "This is version " );
	localizationService:Register( "AboutMenu", " of TonicBars!", " of TonicBars!" );
	
	-- Easy Bars
	localizationService:Register( "EasyBarMenu", "Create Bars Quickly", "Create Bars Quickly" );
	localizationService:Register( "EasyBarMenu", "This menu is used to create complicated bars, very easily. Often getting everything setup on your bar takes a lot of time. Hopefully this helps you get where you want to go easier.", "This menu is used to create complicated bars, very easily. Often getting everything setup on your bar takes a lot of time. Hopefully this helps you get where you want to go easier." );
	localizationService:Register( "EasyBarMenu", "Class Based Bars", "Class Based Bars" );
	localizationService:Register( "EasyBarMenu", "Remove", "Remove" );

	-- Extensions
	localizationService:Register( "ExtensionsMenu", "Extensions", "Extensions" );
	localizationService:Register( "ExtensionsMenu", "General", "General" );
	localizationService:Register( "ExtensionsMenu", "Quick Slots", "Quick Slots" );
	localizationService:Register( "ExtensionsMenu", "Predefined Extensions", "Predefined Extensions" );
	
	localizationService:Register( "ExtensionsMenu", "Extensions work different than QuickBars. To add an Extension, just right click on the quickslot to extend. Then select the orientation.", "Extensions work different than QuickBars. To add an Extension, just right click on the quickslot to extend. Then select the orientation." );
	localizationService:Register( "ExtensionsMenu", "Editing Settings for Bar:", "Editing Settings for Bar:" );
	localizationService:Register( "ExtensionsMenu", "Name:", "Name:" );
	localizationService:Register( "ExtensionsMenu", "Set", "Set" );
	localizationService:Register( "ExtensionsMenu", "This will change shortcuts on the current bar perminately!!!!", "This will change shortcuts on the current bar perminately!!!!" );
	localizationService:Register( "ExtensionsMenu", "Orientation:", "Orientation:" );
	localizationService:Register( "ExtensionsMenu", "When attached quickslot is Moused Over:", "When attached quickslot is Moused Over:" );
	localizationService:Register( "ExtensionsMenu", "Stop displaying extension when:", "Stop displaying extension when:" );
	localizationService:Register( "ExtensionsMenu", "Count:", "Count:" );
	localizationService:Register( "ExtensionsMenu", "Opacity:", "Opacity:" );
	localizationService:Register( "ExtensionsMenu", "Spacing:", "Spacing:" );
	localizationService:Register( "ExtensionsMenu", "Size:", "Size:" );
	localizationService:Register( "ExtensionsMenu", "Remove", "Remove" );
	
	localizationService:Register( "ExtensionTypes", "Hunters Travel", "Hunters Travel" );
	localizationService:Register( "ExtensionTypes", "Wardens Travel", "Wardens Travel" );
	localizationService:Register( "ExtensionTypes", "Reputation Travel", "Reputation Travel" );
	localizationService:Register( "ExtensionTypes", "Housing Travel", "Housing Travel" );
	localizationService:Register( "ExtensionTypes", "LM Combat Pets", "LM Combat Pets" );
	localizationService:Register( "ExtensionTypes", "LM Cosmetic Pets", "LM Cosmetic Pets" );
	localizationService:Register( "ExtensionTypes", "Captain Pets", "Captain Pets" );
	localizationService:Register( "ExtensionTypes", "Horses", "Horses" );
	localizationService:Register( "ExtensionTypes", "Horses (more)", "Horses (more)" );
	localizationService:Register( "ExtensionTypes", "Ponies", "Ponies" );
	localizationService:Register( "ExtensionTypes", "Ponies (more)", "Ponies (more)" );
	localizationService:Register( "ExtensionTypes", "Instruments", "Instruments" );
	localizationService:Register( "ExtensionTypes", "Mini DPS", "Mini DPS" );
	
	localizationService:Register( "Orientation", "Left", "Left" );
	localizationService:Register( "Orientation", "Right", "Right" );
	localizationService:Register( "Orientation", "Up", "Up" );
	localizationService:Register( "Orientation", "Down", "Down" );
	
	localizationService:Register( "ExtensionRule", "Show Extension(s)", "Show Extension(s)" );
	localizationService:Register( "ExtensionRule", "Show & Rollup Selection", "Show & Rollup Selection" );
	localizationService:Register( "ExtensionRule", "Select Random Shortcut", "Select Random Shortcut" );
	localizationService:Register( "ExtensionRule", "Cycle Shortcuts", "Cycle Shortcuts" );
	localizationService:Register( "ExtensionRule", "On Click Cycle Shortcuts", "On Click Cycle Shortcuts" );
	
	localizationService:Register( "ExtensionRemoval", "Mouse Leaves Bar", "Mouse Leaves Bar" );
	localizationService:Register( "ExtensionRemoval", "Combat has ended", "Combat has ended" );
	
	-- General Menu
	localizationService:Register( "GeneralMenu", "General Settings", "General Settings" );
	localizationService:Register( "GeneralMenu", "Copy Profiles", "Copy Profiles" );
	localizationService:Register( "GeneralMenu", "Display Launcher?", "Display Launcher?" );
	localizationService:Register( "GeneralMenu", "Plugin can't determine your class, please select the correct one:", "Plugin can't determine your class, please select the correct one:" );
	localizationService:Register( "GeneralMenu", "Profiles", "Profiles - Select a profile and then which bar you want to Take or Give. Make sure to select one or the other, you are not allowed to select both." );
	localizationService:Register( "GeneralMenu", "Without Icons", "Copy Without Icons" );
	localizationService:Register( "GeneralMenu", "With Icons", "Copy With Icons" );
	localizationService:Register( "GeneralMenu", "Yes", "Yes" );
	localizationService:Register( "GeneralMenu", "Languages", "Languages" );
	localizationService:Register( "GeneralMenu", "English", "English" );
	localizationService:Register( "GeneralMenu", "German", "German" );
	localizationService:Register( "GeneralMenu", "French", "French" );
	
	localizationService:Register( "GeneralMenu", "Take", "-->Take their bar on this character:" );
	localizationService:Register( "GeneralMenu", "Give", "-->Give my bar to them:" );
	localizationService:Register( "GeneralMenu", "If you want to copy your bar locations from another character on this server you can perform that by selecting the characters name from the dropdown and selecting 'Copy Profile'.", "If you want to copy your bar locations from another character on this server you can perform that by selecting the characters name from the dropdown and selecting 'Copy Profile'." );
	
	localizationService:Register( "ClassNames", "Guardian", "Guardian" );
	localizationService:Register( "ClassNames", "Captain", "Captain" );
	localizationService:Register( "ClassNames", "Minstrel", "Minstrel" );
	localizationService:Register( "ClassNames", "Burglar", "Burglar" );
	localizationService:Register( "ClassNames", "Hunter", "Hunter" );
	localizationService:Register( "ClassNames", "Champion", "Champion" );
	localizationService:Register( "ClassNames", "Lore Master", "Lore Master" );
	localizationService:Register( "ClassNames", "Rune Keeper", "Rune Keeper" );
	localizationService:Register( "ClassNames", "Warden", "Warden" );
	
	-- Quickslots Menu
	localizationService:Register( "QuickslotsMenu", "Quick Bars", "Quick Bars" );
	localizationService:Register( "QuickslotsMenu", "General", "General" );
	localizationService:Register( "QuickslotsMenu", "Bar Visibility?", "Bar Visibility?" );
	localizationService:Register( "QuickslotsMenu", "Class Triggers", "Class Triggers" );
	localizationService:Register( "QuickslotsMenu", "Quick Slots", "Quick Slots" );
	localizationService:Register( "QuickslotsMenu", "Background Colors", "Background Colors" );
	localizationService:Register( "QuickslotsMenu", "Miscellaneous", "Miscellaneous" );
	localizationService:Register( "QuickslotsMenu", "Add", "Add" );
	localizationService:Register( "QuickslotsMenu", "Editing Settings for Bar:", "Editing Settings for Bar:" );
	localizationService:Register( "QuickslotsMenu", "Health Drops Below this %:", "Health Drops Below this %:" );
	localizationService:Register( "QuickslotsMenu", "Power Drops Below this %:", "Power Drops Below this %:" );
	localizationService:Register( "QuickslotsMenu", "Use Background Color on Bar", "Use Background Color on Bar" );
	localizationService:Register( "QuickslotsMenu", "Red:", "Red:" );
	localizationService:Register( "QuickslotsMenu", "Green:", "Green:" );
	localizationService:Register( "QuickslotsMenu", "Blue:", "Blue:" );
	localizationService:Register( "QuickslotsMenu", "Opacity:", "Opacity:" );
	localizationService:Register( "QuickslotsMenu", "Remove opacity when moused over?", "Remove opacity when moused over?" );
	localizationService:Register( "QuickslotsMenu", "Name:", "Name:" );
	localizationService:Register( "QuickslotsMenu", "Set", "Set" );
	localizationService:Register( "QuickslotsMenu", "Visible", "Visible" );
	localizationService:Register( "QuickslotsMenu", "Locked", "Locked" );
	localizationService:Register( "QuickslotsMenu", "Rows:", "Rows:" );
	localizationService:Register( "QuickslotsMenu", "Columns:", "Columns:" );
	localizationService:Register( "QuickslotsMenu", "Spacing:", "Spacing:" );
	localizationService:Register( "QuickslotsMenu", "Size:", "Size:" );
	localizationService:Register( "QuickslotsMenu", "Triggers", "Triggers" );
	localizationService:Register( "QuickslotsMenu", "Remove", "Remove" );
	localizationService:Register( "QuickslotsMenu", "Copy", "Copy" );
	localizationService:Register( "QuickslotsMenu", "Reset", "Reset" );
	localizationService:Register( "QuickslotsMenu", "Fade Options", "Fade Options" );
	localizationService:Register( "QuickslotsMenu", "Shortcut Opacity:", "Shortcut Opacity:" );
	localizationService:Register( "QuickslotsMenu", "Min:", "Min:" );
	localizationService:Register( "QuickslotsMenu", "Max:", "Max:" );
	localizationService:Register( "QuickslotsMenu", "Buffs", "Buffs" );
	
	localizationService:Register( "InventoryPanel", "Inventory Options", "Inventory Options" );
	localizationService:Register( "InventoryPanel", "Category Based:", "Category Based:" );
	localizationService:Register( "InventoryPanel", "Name Based:", "Name Based:" );
	localizationService:Register( "InventoryPanel", "Add Name Filter:", "Add Name Filter:" );
	localizationService:Register( "InventoryPanel", "Add", "Add" );
	localizationService:Register( "InventoryPanel", "Quantity Based:", "Quantity Based:" );
	
	localizationService:Register( "QuickslotVisibility", "Always", "Always" );
	localizationService:Register( "QuickslotVisibility", "Triggered", "Triggered" );
	
	localizationService:Register( "ClassTriggerType", "Triggered When:", "Triggered When:" );
	localizationService:Register( "ClassTriggerType", "Buffs Active", "Buffs Active" );
	localizationService:Register( "ClassTriggerType", "Buffs Not Active", "Buffs Not Active" );
	
	localizationService:Register( "ClassTriggers", "Crit Tier1", 	"Crit Tier1" );
	localizationService:Register( "ClassTriggers", "Crit Tier2", 	"Crit Tier2" );
	localizationService:Register( "ClassTriggers", "Crit Tier3", 	"Crit Tier3" );
	localizationService:Register( "ClassTriggers", "Fervor between:", 		"Fervor between:" );
	localizationService:Register( "ClassTriggers", "Attunement between:", 	"Attunement between:" );
	localizationService:Register( "ClassTriggers", "Charged", 		"Charged" );
	localizationService:Register( "ClassTriggers", "Focus between:", 		"Focus between:" );
	
	localizationService:Register( "QuickslotsDisplay", "In Combat", "In Combat" );
	localizationService:Register( "QuickslotsDisplay", "Out of Combat", "Out of Combat" );
	localizationService:Register( "QuickslotsDisplay", "Mounted", "Mounted" );
	localizationService:Register( "QuickslotsDisplay", "Not Mounted", "Not Mounted" );
	localizationService:Register( "QuickslotsDisplay", "Combat Mounted", "Combat Mounted" );
	localizationService:Register( "QuickslotsDisplay", "Not Combat Mounted", "Not Combat Mounted" );	
	localizationService:Register( "QuickslotsDisplay", "Alt Pressed", "Alt Pressed" );
	localizationService:Register( "QuickslotsDisplay", "Ctrl Pressed", "Ctrl Pressed" );
	localizationService:Register( "QuickslotsDisplay", "Shift Pressed", "Shift Pressed" );
	
	localizationService:Register( "InventoryMenu", "Inventory Bars", "Inventory Bars" );
	localizationService:Register( "InventoryMenu", "Click Add Bar to start using tonic bars or select an Windowed Bar to edit.", "Click Add Bar to start using tonic bars or select an Windowed Bar to edit." );
	localizationService:Register( "InventoryMenu", "Add Tabbed Bar", "Add Tabbed Bar" );
	localizationService:Register( "InventoryMenu", "Add Windowed Bar", "Add Windowed Bar" );
	
	localizationService:Register( "ClassBars", "Tier1 Skills", 								"Tier1 Skills" );
	localizationService:Register( "ClassBars", "Tier2 Skills", 								"Tier2 Skills" );
	localizationService:Register( "ClassBars", "Tier3 Skills", 								"Tier3 Skills" );
	localizationService:Register( "ClassBars", "Tier4 Skills", 								"Tier4 Skills" );
	localizationService:Register( "ClassBars", "Tier5 Skills", 								"Tier5 Skills" );
	localizationService:Register( "ClassBars", "Tricks", 										"Tricks" );
	localizationService:Register( "ClassBars", "Trick Removals", 								"Trick Removals" );
	localizationService:Register( "ClassBars", "Mischief Skills", 								"Mischief Skills" );
	localizationService:Register( "ClassBars", "Knockdown Skills", 							"Knockdown Skills" );
	localizationService:Register( "ClassBars", "Heralds", 										"Heralds" );
	localizationService:Register( "ClassBars", "Marks", 										"Marks" );
	localizationService:Register( "ClassBars", "Tactics", 										"Tactics" );
	localizationService:Register( "ClassBars", "Defeat Skills", 								"Defeat Skills" );
	localizationService:Register( "ClassBars", "Stances", 										"Stances" );
	localizationService:Register( "ClassBars", "Coda", 										"Coda" );
	localizationService:Register( "ClassBars", "Overpower Skills", 							"Overpower Skills" );
	localizationService:Register( "ClassBars", "Parry Skills", 								"Parry Skills" );
	localizationService:Register( "ClassBars", "Block Skills", 								"Block Skills" );
	localizationService:Register( "ClassBars", "Focus >= 3 Skills", 							"Focus >= 3 Skills" );
	localizationService:Register( "ClassBars", "Focus >= 6 Skills", 							"Focus >= 6 Skills" );
	localizationService:Register( "ClassBars", "Find The Path", 								"Find The Path" );	
	localizationService:Register( "ClassBars", "War-Speech Skills", 							"War-Speech Skills" );
	localizationService:Register( "ClassBars", "Scribe Stance Skills", 						"Scribe Stance Skills" );
	localizationService:Register( "ClassBars", "Warding", 										"Warding" );
	localizationService:Register( "ClassBars", "Lore", 										"Lore" );
	localizationService:Register( "ClassBars", "Sign of the Wild", 							"Sign of the Wild" );
	localizationService:Register( "ClassBars", "Sign of Power", 								"Sign of Power" );
	localizationService:Register( "ClassBars", "Anthem Skills", 								"Anthem Skills" );

	localizationService:Register( "ClassBars", "Travel", 										"Travel" );
	localizationService:Register( "ClassBars", "Javelins", 									"Javelins" );
	localizationService:Register( "ClassBars", "Recovery", 									"Recovery" );
	localizationService:Register( "ClassBars", "March", 										"March" );
	localizationService:Register( "ClassBars", "Charge", 										"Charge" );
	
	localizationService:Register( "ClassBars", "Restoration Skill", 							"Restoration Skill" );
	localizationService:Register( "ClassBars", "DPS Attonement Skill", 						"DPS Attonement Skill" );
	localizationService:Register( "ClassBars", "Healing Attonement Skill", 					"Healing Attonement Skill" );
	localizationService:Register( "ClassBars", "3 DPS Attonement, Skills", 					"3 DPS Attonement, Skills" );
	localizationService:Register( "ClassBars", "6 DPS Attonement, Skills", 					"6 DPS Attonement, Skills" );
	localizationService:Register( "ClassBars", "Full DPS Attonement, Skills", 					"Full DPS Attonement, Skills" );
	localizationService:Register( "ClassBars", "3 Heal Attonement Skills", 					"3 Heal Attonement Skills" );
	localizationService:Register( "ClassBars", "6 Heal Attonement Skills", 					"6 Heal Attonement Skills" );
	localizationService:Register( "ClassBars", "Full Heal Attonement Skills", 					"Full Heal Attonement Skills" );
	-- Other ClassBars
	localizationService:Register( "ClassBars", "Skirmishes", 									"Skirmishes" );
	localizationService:Register( "ClassBars", "Athelas", 										"Athelas" );
	localizationService:Register( "ClassBars", "Celebrant", 									"Celebrant" );
	localizationService:Register( "ClassBars", "Draughts/Salves", 								"Draughts/Salves" );
