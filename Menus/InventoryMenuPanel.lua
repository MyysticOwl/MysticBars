-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

InventoryMenuPanel = class();

InventoryMenuPanel.utils = MysticBars.Menus.Core.UI.MenuUtils();

function InventoryMenuPanel:Draw(parentNode, barId, barValue)

	-- -----------------------   DECORATOR  0000000000000000000000000000
	parentNode:GetChildNodes():Add(MysticBars.Menus.Controls.DecoratorPanel(barId, barValue));

	-- -----------------------   TRIGGERS  0000000000000000000000000000
	parentNode:GetChildNodes():Add(MysticBars.Menus.Controls.InventoryPanel(barId, barValue));

	-- -----------------------   TRIGGERS  0000000000000000000000000000
	parentNode:GetChildNodes():Add(MysticBars.Menus.Controls.TriggersPanel(parentNode, barId, barValue));

	-- -----------------------   SLOTS	  0000000000000000000000000000
	parentNode:GetChildNodes():Add(MysticBars.Menus.Controls.SlotsPanel(barId, barValue));

	-- -----------------------   COLOR  0000000000000000000000000000
	parentNode:GetChildNodes():Add(MysticBars.Menus.Controls.ColorPanel(barId, barValue));
end