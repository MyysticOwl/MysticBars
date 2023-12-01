-- Created by MyysticOwl
-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!
	local localizationService = SERVICE_CONTAINER:GetService(MyysticBars.TonicBars.Services.LocalizationService);
	-- Main Menu
	localizationService:Register( "MainButtons", "Easy Bars", 			"Barres Rapides" );
	localizationService:Register( "MainButtons", "Quick Slots", 		"Slots Rapides" );
	localizationService:Register( "MainButtons", "Extensions Bars", 	"Extensions des Barres" );
	localizationService:Register( "MainButtons", "General Settings", 	"Paramètres Généraux" );
	localizationService:Register( "MainButtons", "About TonicBars", 	"A Propos de TonicBars" );
	localizationService:Register( "MainButtons", "Inventory Bars", 	"Inventory Barres" );

	-- About
	localizationService:Register( "AboutMenu", "Thank you everyone for trying TonicBars. This enjoyable experience is brought to you by MyysticOwl!", "Merci à tous d'essayer TonicBars. Cette agréable expérience vous est proposée par MyysticOwl!" );
	localizationService:Register( "AboutMenu", "A special thanks to Farothhen for his German Translations and Daniel Diehl for the French Translations.", "A special thanks to Farothhen for his German Translations and Daniel Diehl for the French Translations." );
	localizationService:Register( "AboutMenu", "I hope you appreciate the many hours that went into this plugin, enjoy!", "J'espère que vous apprécierez les nombres heures passées à créer ce plugin, amusez vous bien !" );
	localizationService:Register( "AboutMenu", "This is version ", 							"Ceci est la version " );
	localizationService:Register( "AboutMenu", " of TonicBars!", 								" de TonicBars!" );
	
	-- Easy Bars
	localizationService:Register( "EasyBarMenu", "Create Bars Quickly", "Bars créer rapidement" );
	localizationService:Register( "EasyBarMenu", "This menu is used to create complicated bars, very easily. Often getting everything setup on your bar takes a lot of time. Hopefully this helps you get where you want to go easier.", "Ce menu est utilisé pour créer des barres de compliqué, très facilement. Souvent obtenir tout est configuré sur votre barre prend beaucoup de temps. Espérons que cela vous aide à obtenir où vous voulez aller plus facile." );
	localizationService:Register( "EasyBarMenu", "Class Based Bars", "Sur la base de classe Bars" );
	localizationService:Register( "EasyBarMenu", "Remove", "Remove" );

	-- Extensions
	localizationService:Register( "ExtensionsMenu", "Extensions", "Extensions" );
	localizationService:Register( "ExtensionsMenu", "General", "Généraux" );
	localizationService:Register( "ExtensionsMenu", "Quick Slots", "Slots Rapides" );
	localizationService:Register( "ExtensionsMenu", "Predefined Extensions", "Extensions Prédéfinies" );
	
	localizationService:Register( "ExtensionsMenu", "Extensions work different than QuickBars. To add an Extension, just right click on the quickslot to extend. Then select the orientation.", "Les Extensions fonctionnent différement des Barres. Pour ajouter une Extension, faites un Clic droit sur la case souhaitée. Choisir l'orientation pour la barre étendue et elle sera créée." );
	localizationService:Register( "ExtensionsMenu", "Editing Settings for Bar:", 				"Editer les paramètres pour la Barre:" );
	localizationService:Register( "ExtensionsMenu", "Name:", 									"Nom:" );
	localizationService:Register( "ExtensionsMenu", "Set", 									"Changer" );
	localizationService:Register( "ExtensionsMenu", "This will change shortcuts on the current bar perminately!!!!", "Ceci change les raccourcis. Une fois modifié, vous pouvez changer les paramètres comme vous le souhaitez." );
	localizationService:Register( "ExtensionsMenu", "Orientation:", 							"Orientation:" );
	localizationService:Register( "ExtensionsMenu", "When attached quickslot is Moused Over:", "Lorsque la souris passe sur un Raccourci:" );
	localizationService:Register( "ExtensionsMenu", "Stop displaying extension when:", 		"Arrêter d'afficher les Extensions quand:" );
	localizationService:Register( "ExtensionsMenu", "Count:", 									"Compter:" );
	localizationService:Register( "ExtensionsMenu", "Opacity:", 								"Opacité:" );
	localizationService:Register( "ExtensionsMenu", "Spacing:", 								"Espacement:" );
	localizationService:Register( "ExtensionsMenu", "Size:", 									"Taille:" );
	localizationService:Register( "ExtensionsMenu", "Remove", 									"Supprimer" );
	
	localizationService:Register( "ExtensionTypes", "Hunters Travel", 							"Voyages Chasseur" );
	localizationService:Register( "ExtensionTypes", "Wardens Travel", 							"Voyages Sentinelle" );
	localizationService:Register( "ExtensionTypes", "Reputation Travel", 						"Voyages de Reputation" );
	localizationService:Register( "ExtensionTypes", "Housing Travel", 							"Voyage Domicile" );
	localizationService:Register( "ExtensionTypes", "LM Combat Pets", 							"MdS Pets de Combat" );
	localizationService:Register( "ExtensionTypes", "LM Cosmetic Pets", 						"MdS Pets Cosmetiques" );
	localizationService:Register( "ExtensionTypes", "Captain Pets", 							"Pets du Capitaine" );
	localizationService:Register( "ExtensionTypes", "Horses", 									"Chevaux" );
	localizationService:Register( "ExtensionTypes", "Horses (more)", 							"Chevaux (plus)" );
	localizationService:Register( "ExtensionTypes", "Ponies", 									"Poneys" );
	localizationService:Register( "ExtensionTypes", "Ponies (more)", 							"Poneys (plus)" );
	localizationService:Register( "ExtensionTypes", "Instruments", 							"Instruments" );
	localizationService:Register( "ExtensionTypes", "Mini DPS", 								"Mini DPS" );
	
	localizationService:Register( "Orientation", "Left", 										"Gauche" );
	localizationService:Register( "Orientation", "Right", 										"Droite" );
	localizationService:Register( "Orientation", "Up", 										"Haut" );
	localizationService:Register( "Orientation", "Down", 										"Bas" );
	
	localizationService:Register( "ExtensionRule", "Show Extension(s)", 						"Montrer le(s) Extension(s)" );
	localizationService:Register( "ExtensionRule", "Show & Rollup Selection", 					"Montrer & Enrouler le(s) Extension(s)" );
	localizationService:Register( "ExtensionRule", "Select Random Shortcut", 					"Selection Raccourci au hasard" );
	localizationService:Register( "ExtensionRule", "Cycle Shortcuts", 							"Cycle Raccourcis" );
	
	localizationService:Register( "ExtensionRemoval", "Mouse Leaves Bar", 						"Souris sort de la Barre" );
	localizationService:Register( "ExtensionRemoval", "Combat has ended", 						"Le Combat est fini" );
	
	-- General Menu
	localizationService:Register( "GeneralMenu", "General Settings", 							"Paramètres Généraux" );
	localizationService:Register( "GeneralMenu", "Copy Profiles", 								"Copier un profil:" );
	localizationService:Register( "GeneralMenu", "Display Launcher?", 							"Afficher Launcher?" );
	localizationService:Register( "GeneralMenu", "Plugin can't determine your class, please select the correct one:", "Le Plugin ne peut déterminer votre classe. Merci de sélectionner votre classe:" );
	localizationService:Register( "GeneralMenu", "Profiles", 									"Profiles - Select a profile and then which bar you want to Take or Give. Make sure to select one or the other, you are not allowed to select both." );
	localizationService:Register( "GeneralMenu", "Without Icons", 								"Sans Raccourcis" );
	localizationService:Register( "GeneralMenu", "With Icons", 								"Avec les Raccourcis" );
	localizationService:Register( "GeneralMenu", "Yes", 										"Oui" );
	localizationService:Register( "GeneralMenu", "Languages", 									"Langues" );
	localizationService:Register( "GeneralMenu", "English", 									"Anglais" );
	localizationService:Register( "GeneralMenu", "German", 									"Allemand" );
	localizationService:Register( "GeneralMenu", "French", 									"Français" );
	
	localizationService:Register( "GeneralMenu", "Take", "-->Take their bar on this character:" );
	localizationService:Register( "GeneralMenu", "Give", "-->Give my bar to them:" );
	localizationService:Register( "GeneralMenu", "If you want to copy your bar locations from another character on this server you can perform that by selecting the characters name from the dropdown and selecting 'Copy Profile'.", "If you want to copy your bar locations from another character on this server you can perform that by selecting the characters name from the dropdown and selecting 'Copy Profile'." );
	
	localizationService:Register( "ClassNames", "Guardian", 									"Gardien" );
	localizationService:Register( "ClassNames", "Captain", 									"Capitaine" );
	localizationService:Register( "ClassNames", "Minstrel", 									"Menestrel" );
	localizationService:Register( "ClassNames", "Burglar", 									"Cambrioleur" );
	localizationService:Register( "ClassNames", "Hunter", 										"Chasseur" );
	localizationService:Register( "ClassNames", "Champion", 									"Champion" );
	localizationService:Register( "ClassNames", "Lore Master", 								"Maitre du savoir" );
	localizationService:Register( "ClassNames", "Rune Keeper", 								"Gardien des runes" );
	localizationService:Register( "ClassNames", "Warden", 										"Sentinelle" );
	
	-- Quickslots Menu
	localizationService:Register( "QuickslotsMenu", "Quick Bars", 								"Barres Rapides" );
	localizationService:Register( "QuickslotsMenu", "General", 								"Généraux" );
	localizationService:Register( "QuickslotsMenu", "Bar Visibility?", 						"Bar visibilité?" );
	localizationService:Register( "QuickslotsMenu", "Class Triggers", 							"Classe Déclencheurs" );
	localizationService:Register( "QuickslotsMenu", "Quick Slots", 							"Slots Rapides" );
	localizationService:Register( "QuickslotsMenu", "Background Colors", 						"Les couleurs de fond" );
	localizationService:Register( "QuickslotsMenu", "Miscellaneous", 							"Varié" );
	localizationService:Register( "QuickslotsMenu", "Add", 									"Ajouter" );
	localizationService:Register( "QuickslotsMenu", "Editing Settings for Bar:", 				"Editer les Paramètres de Barre:" );
	localizationService:Register( "QuickslotsMenu", "Health Drops Below this %:", 				"Vie en dessous de ce %:" );
	localizationService:Register( "QuickslotsMenu", "Power Drops Below this %:", 				"Puissance en dessous de ce %:" );
	localizationService:Register( "QuickslotsMenu", "Use Background Color on Bar", 			"Utiliser la couleur de fond" );
	localizationService:Register( "QuickslotsMenu", "Red:", 									"Rouge:" );
	localizationService:Register( "QuickslotsMenu", "Green:", 									"Vert:" );
	localizationService:Register( "QuickslotsMenu", "Blue:", 									"Bleu:" );
	localizationService:Register( "QuickslotsMenu", "Opacity:", 								"Opacité:" );
	localizationService:Register( "QuickslotsMenu", "Remove opacity when moused over?", 		"Retirer l'opacité si la souris passe?" );
	localizationService:Register( "QuickslotsMenu", "Name:", 									"Nom:" );
	localizationService:Register( "QuickslotsMenu", "Set", 									"Changer" );
	localizationService:Register( "QuickslotsMenu", "Visible",  								"Visible" );
	localizationService:Register( "QuickslotsMenu", "Locked", 									"Verrouillée" );
	localizationService:Register( "QuickslotsMenu", "Rows:", 									"Rangées:" );
	localizationService:Register( "QuickslotsMenu", "Columns:", 								"Colonnes:" );
	localizationService:Register( "QuickslotsMenu", "Spacing:", 								"Espacement:" );
	localizationService:Register( "QuickslotsMenu", "Size:", 									"Taille:" );
	localizationService:Register( "QuickslotsMenu", "Triggers", 								"Déclencheurs" );
	localizationService:Register( "QuickslotsMenu", "Remove", 									"Supprimer" );
	localizationService:Register( "QuickslotsMenu", "Copy", 									"Copier" );
	localizationService:Register( "QuickslotsMenu", "Reset", 									"Reinitialiser" );
	localizationService:Register( "QuickslotsMenu", "Shortcut Opacity:", 						"Fade Opacité:" );
	
localizationService:Register( "InventoryPanel", "Inventory Options", 						"Inventory Options" );
localizationService:Register( "InventoryPanel", "Category Based:", 						"Category Based:" );
localizationService:Register( "InventoryPanel", "Name Based:", 							"Name Based:" );
localizationService:Register( "InventoryPanel", "Add Name Filter:", 						"Add Name Filter:" );
localizationService:Register( "InventoryPanel", "Add", 									"Add" );
localizationService:Register( "InventoryPanel", "Quantity Based:", 						"Quantity Based:" );
	
	localizationService:Register( "QuickslotVisibility", "Always", 							"Toujours" );
	localizationService:Register( "QuickslotVisibility", "Triggered", 							"Si Effets" );
	
	localizationService:Register( "ClassTriggerType", "Triggered When:", 						"Déclenché lorsque:" );
	localizationService:Register( "ClassTriggerType", "Buffs Active", 							"Buff actiF" );
	localizationService:Register( "ClassTriggerType", "Buffs Not Active", 						"Buff non actiF" );
	
localizationService:Register( "ClassTriggers", "Crit Tier1", 								"Crit Tier1" );
localizationService:Register( "ClassTriggers", "Crit Tier2", 								"Crit Tier2" );
localizationService:Register( "ClassTriggers", "Crit Tier3", 								"Crit Tier3" );
localizationService:Register( "ClassTriggers", "Fervor between:", 							"Fervor between:" );
localizationService:Register( "ClassTriggers", "Attunement between:", 						"Attunement between:" );
localizationService:Register( "ClassTriggers", "Charged", 									"Charged" );
localizationService:Register( "ClassTriggers", "Focus between:", 							"Focus between:" );
	
	localizationService:Register( "QuickslotsDisplay", "In Combat", 							"En Combat" );
	localizationService:Register( "QuickslotsDisplay", "Out of Combat", 						"Hors Combat" );
	localizationService:Register( "QuickslotsDisplay", "Mounted", 								"Mounted" );
	localizationService:Register( "QuickslotsDisplay", "Not Mounted", 							"Not Mounted" );
	localizationService:Register( "QuickslotsDisplay", "Combat Mounted", 						"Combat Mounted" );
	localizationService:Register( "QuickslotsDisplay", "Not Combat Mounted", 					"Not Combat Mounted" );	
	localizationService:Register( "QuickslotsDisplay", "Alt Pressed", 							"Alt Appuyé" );
	localizationService:Register( "QuickslotsDisplay", "Ctrl Pressed", 						"Ctrl Appuyé" );
	localizationService:Register( "QuickslotsDisplay", "Shift Pressed", 						"Shift Appuyé" );
	
localizationService:Register( "InventoryMenu", "Click Add Bar to start using tonic bars or select an Windowed Bar to edit.", "Click Add Bar to start using tonic bars or select an Windowed Bar to edit." );
localizationService:Register( "InventoryMenu", "Add Bar", "Add Bar" );
localizationService:Register( "InventoryMenu", "Editing Settings for Bar:", "Editing Settings for Bar:" );
	
	localizationService:Register( "ClassBars", "Tier1 Skills", "Des compétences de niveau 1" );
	localizationService:Register( "ClassBars", "Tier2 Skills", "Des compétences de niveau 2" );
	localizationService:Register( "ClassBars", "Tier3 Skills", "Des compétences de niveau 3" );
	localizationService:Register( "ClassBars", "Tier4 Skills", "Des compétences de niveau 4" );
	localizationService:Register( "ClassBars", "Tier5 Skills", "Des compétences de niveau 5" );
	localizationService:Register( "ClassBars", "Tricks", 			"Ruses" );
	localizationService:Register( "ClassBars", "Trick Removals", 	"Déménagements Trick" );
	localizationService:Register( "ClassBars", "Mischief Skills", 	"Mischief compétences" );
	localizationService:Register( "ClassBars", "Knockdown Skills", "Knock-down compétences" );
	localizationService:Register( "ClassBars", "Heralds", "Hérauts" );
	localizationService:Register( "ClassBars", "Marks", "Résultats" );
	localizationService:Register( "ClassBars", "Tactics", "Tactique" );
	localizationService:Register( "ClassBars", "Defeat Skills", "Défaite des compétences" );
	localizationService:Register( "ClassBars", "Stances", "Relais" );
	localizationService:Register( "ClassBars", "Overpower Skills", "Fulgurance des compétences" );
	localizationService:Register( "ClassBars", "Parry Skills", "Parry compétences" );
	localizationService:Register( "ClassBars", "Block Skills", "Block compétences" );
	localizationService:Register( "ClassBars", "Focus >= 3 Skills", "Foyer >= 3 compétences" );
	localizationService:Register( "ClassBars", "Focus >= 6 Skills", "Foyer >= 6 compétences" );
	localizationService:Register( "ClassBars", "Find The Path", "Find The Path" );	
	localizationService:Register( "ClassBars", "War-Speech Skills", "Discours de guerre compétences" );
	localizationService:Register( "ClassBars", "Scribe Stance Skills", "Scribe Relais compétences" );
	localizationService:Register( "ClassBars", "Warding", 	"Warding" );
	localizationService:Register( "ClassBars", "Lore", 										"Lore" );
	localizationService:Register( "ClassBars", "Sign of the Wild", 							"Sign of the Wild" );
	localizationService:Register( "ClassBars", "Sign of Power", 								"Sign of Power" );
	localizationService:Register( "ClassBars", "Anthem Skills", 								"Anthem Skills" );

	localizationService:Register( "ClassBars", "Restoration Skill", "Rétablissement Attonement" );
	localizationService:Register( "ClassBars", "DPS Attonement Skill", "DPS Attonement" );
	localizationService:Register( "ClassBars", "Healing Attonement Skill", "Guérison Attonement" );
	localizationService:Register( "ClassBars", "3 DPS Attonement, Skills", "3 DPS Attonement" );
	localizationService:Register( "ClassBars", "6 DPS Attonement, Skills", "6 DPS Attonement" );
	localizationService:Register( "ClassBars", "Full DPS Attonement, Skills", "Full DPS Attonement" );
	localizationService:Register( "ClassBars", "3 Heal Attonement Skills", "3 Guérison Attonement" );
	localizationService:Register( "ClassBars", "6 Heal Attonement Skills", "6 Guérison Attonement" );
	localizationService:Register( "ClassBars", "Full Heal Attonement Skills", "Entier Guérison Attonement" );