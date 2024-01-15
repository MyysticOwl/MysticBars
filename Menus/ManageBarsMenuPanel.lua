-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

ManageBarsMenuPanel = class();

ManageBarsMenuPanel.utils = MysticBars.Menus.Core.UI.MenuUtils();

function ManageBarsMenuPanel:Draw(parentNode, barId, barValue, buffs)

	-- -----------------------   DECORATOR  0000000000000000000000000000
	parentNode:GetChildNodes():Add(MysticBars.Menus.Controls.DecoratorPanel(barId, barValue));

	-- -----------------------   SLOTS	  0000000000000000000000000000
	parentNode:GetChildNodes():Add(MysticBars.Menus.Controls.SlotsPanel(barId, barValue));

	-- -----------------------   TRIGGERS  0000000000000000000000000000
	parentNode:GetChildNodes():Add(MysticBars.Menus.Controls.TriggersPanel(parentNode, barId, barValue));

	-- -----------------------   CLASS BUFF TRIGGERS  0000000000000000000000000000
	parentNode:GetChildNodes():Add(MysticBars.Menus.Controls.ClassBuffPanel(parentNode, barId, barValue, buffs));
end