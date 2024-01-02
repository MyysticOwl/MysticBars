/////**********************************************/////
/////**********************************************/////
/////**********************************************/////
MAKE SURE TO BACKUP AND DELETE THE OLD /TONIC directory before re-installing... When you reinstall you'll be replacing the /tonic directory with the NEW one... DO NOT COPY OVER THE OLD DIRECTORY
/////**********************************************/////
/////**********************************************/////
/////**********************************************/////

**********************************************************************
When you copy this into the "C:\Users\<username>\Documents\The Lord of the Rings Online\Plugins" directory, only copy the Tonic folder and everything contained within. Do not copy this .txt file into that directory.
**********************************************************************


**********************************
How To Use:
**********************************
When you first load up TonicBar you ll get an icon that resembles an Goblet with a green ozing luqid that appears in the upper left of the screen. You can freely move that anywhere you want. When you click it, the MainMenu screen will be displayed. Once displayed, you can Add Standard quickslot bars, Add Extension Bars (bars that are only displayed when you mouse over their connecting quickslot), modify generic options such as coping Bars from another character on the same server, and more.
Once you have added a standard bar, and the MainMenu is currently visible, you can move that bar anywhere you want using the Tab that is sticking out over top the bar. This Tab is green and easily identifiable.
From here, you can layout your bars and use the MainMenu to setup the bar settings, such as, is the bar LOCKED, how many quickslots, how many columns, is it a combat bar, show when ALT is pressed or Control or Shift, Opacity, etc.
Once you Close that MainMenu it locks down the bars. They can not be moved, pressed, etc. You can still add skills to it, but the bar can t be moved. Opening up the MainMenu again will allow you to configure their locations.
Adding extension bars can greatly unclutter your interface. Use these bars to hide hunters/wardens ports, stances, horses, pets, and more. An extension bar can do a lot of things. The idea though is that you select a quickslot on your main bar you want to extend. You then indicate which direction you want this bar to extend into. 
You can then select how you want the extension to work and what you want to show up on it. There is a list of predefined configurations such as: Hunter Travel, Warden Travel, LM Combat Pets, LM Cosmetic Pets, and housing.
You can also indicate what to do when mousing over the extension. You can make it so when you mouse over the quickslot it will cycle through the quickslots on the extenion bar, or that it will choose a random entry. Lastly you can have the extension roll the last selection to the connected quickslot when you select something.


**********************************
Plugin doesn't work what happened?
**********************************
First and foremost make sure that we put the plugin in the right folder. It should be in: "/lord of the rings online/plugins/tonic/..." it can not have an extra directory in there like "/lord of the rings online/plugins/<tonicbars_v1.2>/tonic/..." that won't work. 

Try loading the plugin using: "/plugins load tonicbars" does this work? Do you get anything on the Console saying there is an error?
(you can unload this plugin using "/plugins unload tonicbars" )

If you load it and you don't see errors on the console window, look in the upper left of your window for an icon with a Green Goblet in it. You can move that anywhere on the window and click it to get the main menu, you are good to go.


************************************
CHANGE HISTORY
************************************
v3.1.0
-Complete redesign & rearchitecture of code.
-Services injected
-Major code cleanup
-For now, I have removed Internalinalization. English only for the moment.
-New Easy Bars pulled from your actual skills.
v2.9
-Added basic Mount Triggers - You can now specify that you want this bar to trigger when Not Mounted. That means that some of your skills that you used to have ALWAYS Visible you need to change to be Triggered based on NOT MOUNTED. That will produce a similar effect.
	-Mounted
	-Not Mounted
	-Combat Mounted
	-Not Combat Mounted
v2.8.4
- Fixed issue editing Inventory Bars
v2.8.3
- Fixed issues where Shortcuts were not being remembered.
- Fixed issues where bars movement was not preserved across loads.
- Fixed Visibility issues on General Menu.

v2.8.2
-Fixed issue with Bars showing up every login in edit mode.
-Bars should now remain in the same spots reguardless of resolution.
v2.8.1
-Removed dependency on Turbine Library
v2.8
-Pushed back in my Drag and drop code from a year+ ago and it works great now. That means:
	-Skills can be SWAPPED like the Turbine Bars... take a skill and drag and drop it over antoher one and they will swap instead of overwrite.
	-Skills between bars can now be Swapped.
-Migrated settings from my own SettingMenu to Turbines PluginManager
	-Removed the graphical launcher utility (the little goblet icon to launch settings)
	-To get to TonicBar Settings use: /tb or /tonicbars or use the PluginManager
	-Added "Edit Mode"
		-You can now Edit your bars when the Settings menu is NOT active.
		-When you go into settings now, the bars are not immediately highlighted. To see the highlighted bars, click "Edit Mode".
		-If you leave settings are the bars are still highlighted, you will have to go back into settings and click "Edit Mode" to turn that off.
	-This fixed many defects with Scrolling and displaying items
		-Removed Black Square when scrolling through QuickBars
		-Cleaned up code around menu panels etc.
-Should have fixed: \Plugins\Tonic\UI\MenuUtils.lua:192: attempt to compare string with number errors
-Should have fixed: \Plugins\Tonic\TonicBars\SettingsManager.lua:233: attempt to concatenate local 'barid' (a nil value)
-Fixed the extensions wrapping when horizonal and larger than 5 columns (hope I didn't re-introduce the original problem).
-When you click on a TAB at the top of a bar, it doesn't highlight the BAR in the settings anymore.
-Started using the new LUA Class structure.
v2.6.4
-Updated Text for Hunters and Loremasters
-Fixed Inventory Bar location issues (a bug created from Update 6)
-Fixed a few other small issues
v2.6.3
-Tried to address the dropping of Inventory Items in Inventory Bars
-Tried to address Extension problems when autoloading
-Added support for the LOTRO Plugin Compendium
v2.6.2
-Adds Inventory Bars / Backpack support back in!
v2.6.1
-Fixed Minstel EasyBars. (Might require you removing Tier2 & Tier3 bars manually the first time after the upgrade)
-Fixed Warden EasyBar issues.
v2.6
-Removed All Calls to BackPack. That means Inventory Bars are completely broken!
-Small miscelanous fixes
-Added EasyBars for Warden, LoreMasters and Hunters
v2.5.2
-Added the ability to select Bars by clicking on their Tab. When this is done, the main menu is re-directed to the correct page / bar.
-Fixed issues with Removing a bar with Extensions
-Fixed issue copying/reseting any type of bar
-Fixed issues with General Menu not allowing selection of all bars due to window cut-off. (more than 8 bars prevented copying)

v2.5.1 - Fixed Extensions as they were totally broken.
v2.5 - DragBars Support & Enhanced Profile Copies
------ Fixed issues with bars displaying after leveling up characters ---------
-Added the ability to integrate with the DragBars plugin located: http://www.lotrointerface.com/downloads/info367-ClassDragBarwithExamples.html
-Use standard ctrl-\ to edit bar locations when DragBar is installed.
-Added better Tabs including Bar Name
--Bar names change on the tab when they are changed
--Inventory Bars move correctly now
-Enhanced Coping bars between characters (you can now copy them per bar per character)
-- Push bars onto other characters
-- Pull other characters bars onto your current character
-Reworked the way Buffs are selected using a new improved CheckedCombo Box. :P

Beta_v2.4 - Inventory Bars introduction
v2.3.1 - Fixed issues with Hunter Class
v2.3
-Added default bars for Every class. This is a big change and they should pop-up and be added to the screen as you level.
-Added International support for the new Easy Bars (not all translated, but at least supported. Ready for Translation).
-Added EasyBars to the menus. This allows you to Add / Remove the default bars that TonicBars will now supply.
---- When you load this up for the first time, you should see bars specific to your class that help your class manage their skills. You can modify these bars as you see fit, as long as the bar name does not change. (todo, don't allow this to occur, but for now, it can).
-- If you remove a bar that was auto-generated, you should no longer see it. You can re-enable it through the EasyBar Main Menu.
-Added Fervor, Attunement and Focus Triggers.
-Changed Registrations for callbacks to play nice with other plugins.
-Fixed an issue with IDoME and Battle-hardened.
-Fixed Minstrel's War-Speech.
-Added More German Translations from our amazing translators. Thanks Daniel.

v2.2.2 -I really shouldn't start to fix something, walk away from it for two weeks and come back and make a version... 
I broke the dropdown list for extension orientation and I also broke the predefined extensions. These have been fixed.

v2.2.1
 Fixes issues creating Extension bars, adds monster play options.
v2.2 -
 Fixed issue where the launcher settings were not functioning correctly.
 Added the ability to specify a language for display
 Fixed bug with F12 not removing Tonicbars correctly.
 Added Right Click support for quickslots
 Prevented created extensions on extensions. Might support this at some time in the future but it was broken as is and I didn't want to take the time to fix it... I've got too much else going on.
 Fixed Fade issues with fading a bar.
v2.1.1- fixed critical bug.
v2.1
Re-worked the entire Main-Menu. It was noted to me the main menu had gotten very unusable and didn't function well. It was a mess. This cleans things up and brings them back to where they should be I think.

Fixed a few minor bugs with how cycling of extensions function. Bars are now Rows and Columns. and many more small changes.

v2.0.1 Fixes:
 Out Of Combat checkbox should now function
 Adjusted handling of data settings
 Removed dependency on Turbine.debug.
 Vevenalia Translated more Class Buff Events to French!!!!
Known Issues:
1) Plugin requires a restart after selecting your Class before class buffs register correctly, this will be fixed soon.

v2.0.1
 Fixed issue causing problems when starting the plugin with no data files loaded.
 Fixed issues with Health / Power defaulting to the old values. Also added a nil check on Power to address a user error.
 Added the Massive hack relating to invalid shortcuts back into the code.
 Fading on a bar stopped working when Events were added, this was a simple bug, and has been fixed.
 Addressed issues with Adding Bars. Hopefully this gets rid of all of the problems. It is working great for me.
 Made English the default language. If your locale is not english, german, or french, it'll default to english.
 Fixed issue with showing the power bar when too many options are shown on the trigger window.
 On the live servers, User selection of their class under General should now properly show Triggers under the Quickbars->Show Trigger Options.
v2.0
 MASSIVE changes. (In regard to the UNDERLYING CODE)
 Added changes to function with the new November Update for English LOTRO.
 Added Events. Events are ways to display main bars. Re-factored a lot of code and created an Event Manager to handle these events. This should make code run faster and require less overhead.
 It has been designed so that based on the class you have, bars can be triggered from Buff effects applied to the characters.
 Added code to Migrate old settings into the new Event settings.
 Drastically cleans up settings and provides a way to easily read when the bar should be visible.
 Added the ability to select a Class in the General Settings if the Client does not provide the option to get it directly.
 Added Default Buffs for all classes, needs to be filled out by the community.
 Got this functioning on both LIVE and Bullroarer. Bullroarer will NOT allow you to select a class, because it can determine it... live will ask for now.

TRANSLATIONS ARE NOT COMPLETE. EVENTS MIGHT NOT FUNCTION PROPERLY IN LANGUAGES OTHER THAN ENGLISH. You can refer to the Beta page on how to fix these. BETA PAGE As I don't speak other languages, I need your help to get these right. 

v1.5.2 - This is a hot fix and a COMPLETE HACK to work around a LUA API issue with France and Germany Clients.
v1.5.1 - Removed annoying debug messages. Sorry about that everyone!
v1.5
 Fixed extension issues where Extensions might not display consistantly.
 Added Ability to remove the Launcher and use commands to get to the main menus. (There is a checkbox in the Generic Settings).
 Brought all required libraries into the plugin (This is no longer dependent on the Turbine Libraries.)
 Added support to make bars visible when: Poisoned, Feared, Diseased, or Wounded. Also when your Health or Power drop below a specified %. All of these types of things are now called Triggers
 Refactored Menu code to display Triggers and Color options in a much better way. Making menus much easier to navigate.
 pgmatg provided me with additional Pre-sets for Extension Bars these include: Reputation Travel, Captain Pets, Horses, Horses (rep horses), Ponies, Ponies (rep ponies), Instruments, Mini DPS.
 There was a request to Cycle an extension on click. It appears at this time, I can't accomidate this request. When you click on the extension I can make it progress, but you don't activate the skill, so it's kind of pointless.

v1.4 -
Command line arguments for loading the main menu. Just type "/tonicbars"
Hide bars when F12 is pressed.
Optimized code to prevent performance issues at the start of combat.
Optimized the loading process there should be no more 15+ writes to disk on load.
Made it so that every mouse click (up AND down) does not refresh EVERY bar.
Many small fixes... the most important: When adding an extension, the main menu will refresh correctly.
Fixes for mouse over bugs
Moved Menu Classes for extendability
Many other smaller fixes.
v1.3 - Added some cool features requested by the community.
*When mousing over an extension: show the extension and roll up the selected value to the front.
*When mousing over an extension: select a random shortcut and move it to the front.
*When mousing over an extension: cycle through the shortcuts.
*Select preconfigured extensions such as: Hunter Travel, Warden Travel, LM Combat Pets, LM Cosmetic Pets, and housing. (Requests to add more predefined sets can be made to TonicBars@gmail.com)
v1.2.1 - Fixed an issue with a grayed out skill on the bar causing issues.
v1.2 - Problem loading bars after adding an extension and then deleting the main bar. Causes the plugin to not load at all. This has been fixed.
v1.1 Introduces
*Fixed Bugs related to upgrades from pre-v1.0. All characters bars should be migrated to v1.0 correctly now.
*Fixed bug when removing an extension slot and then adding a new one causes the removed extension slot to be treated like a base quickslot.
*Other Misc bug fixes such as captioning Extension Orientaition, minor MainMenu improvements
*Fixed bar Copy operation and Reset operation... The only caveat is that it requires a restart of the plugin to kick in. Will be tackling why that is soon.
*Added Bar Background Colors & Opacity
*Shortcut Opacity
*You can select between two options when to close an Extension, when the mouse leaves the bar or when combat is ended (this has the least amount of testing, so use at your own will)
*Enjoy!

v1.0.3 - Removes a line of debug.
v1.0.2 - Fixes visibility problem with bars being displayed
v1.0.1 - Fixes external dependency problem with combobox.
v1.0 -
*A complete redesign of the main menu. This leverages some of what the community has developed. What it yields is a much more intuitive and straight forward approach to managing your bars. 
*A new logo. I figured it was time for a new look and a new improved logo. Let me know what you all think!!
*A new feature called Extension Slots. This is the basic concept that you have a slot that has similar items and don't want to take up a LOT of room to display them all on your main bars. Extensions allows for a lot of flexibility. Hunters can hide their travel options and when moused over, all of them are at your disposal. Same with Horses, Port / Maps, Skill chains, Lore Masters Pets, etc.
*A cleanup of code to allow for more extensible solutions going forward. 
*Profile Support. Setup your bars on one character and copy the setup to all of your characters.
*Named Bar support. You can now name your bars and keep track of them that way.
