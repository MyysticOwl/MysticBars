-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "MyysticUI.Utils.Class";
import "MyysticUI.Menus.Core.UI.ComboBox";
import "MyysticUI.Menus.Core.UI.AutoListBox";
import "MyysticUI.Menus.Core.UI.MenuUtils";

MainMenuItems = class();

MainMenuItems.utils = MyysticUI.Menus.Core.UI.MenuUtils();

function MainMenuItems:CreateNewBarItem(parent, mainMenu)
	local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);

	local treeNode = MyysticUI.Menus.Core.TitleTreeNode("Add New Bar", 1);

	if (parent ~= nil and parent.Add ~= nil) then
		parent:Add(treeNode);
	else
		parent:GetChildNodes():Add(treeNode);
	end

	treeNode.MouseClick = function(sender,args)
		local barId = barService:Add( QUICKSLOTBAR );
		barService:RefreshBars();

		if (mainMenu ~= nil) then
			mainMenu:Refresh();
		end
	end
end

function MainMenuItems:CreateNewTabInventoryBarItem(parent, mainMenu)
	local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);

	local context = { ["parent"] = parent, ["width"] = parent:GetWidth() };
	local treeNode = MyysticUI.Menus.Core.TitleTreeNode("Add Tabbed Bar", 1);

	if (parent ~= nil and parent.Add ~= nil) then
		parent:Add(treeNode);
	else
		parent:GetChildNodes():Add(treeNode);
	end

--	self:SetCheckedIcon(context, false);

	-- context["icon"].MouseClick = function(sender,args)
	-- 	local barId = barService:Add( TABBED_INV_BAR );
	-- 	self:SetSelected({["id"] = barId});
	-- 	barService:RefreshBars();

	-- 	if (mainMenu ~= nil) then
	-- 		mainMenu:Refresh();
	-- 	end
	-- end
end

function MainMenuItems:CreateNewWindowInventoryBarItem(parent, mainMenu)
	local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);

	local context = { ["parent"] = parent, ["width"] = parent:GetWidth() };
	local treeNode = MyysticUI.Menus.Core.TitleTreeNode("Add Windowed Bar", 1);

	if (parent ~= nil and parent.Add ~= nil) then
		parent:Add(treeNode);
	else
		parent:GetChildNodes():Add(treeNode);
	end

--	self:SetCheckedIcon(context, false);

	-- context["icon"].MouseClick = function(sender,args)
	-- 	local barId = barService:Add( WINDOW_INV_BAR );
	-- 	self:SetSelected({["id"] = barId});
	-- 	barService:RefreshBars();

	-- 	if (mainMenu ~= nil) then
	-- 		mainMenu:Refresh();
	-- 	end
	-- end
end


function MainMenuItems:CreateNewExtensionItem(parent, panel)
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);

	local context = { ["parent"] = parent, ["width"] = parent:GetWidth() };
	local treeNode = MyysticUI.Menus.Core.TitleTreeNode("Extensions Mode?", 1);

	if (parent ~= nil and parent.Add ~= nil) then
		parent:Add(treeNode);
	else
		parent:GetChildNodes():Add(treeNode);
	end

	-- local settings = settingsService:GetSettings();
	-- if (settings.barMode ~= EXTENSION_MODE) then
	-- 	self:SetCheckedIcon(context, false);
	-- else
	-- 	self:SetCheckedIcon(context, true);
	-- end

	-- context["icon"].MouseClick = function(sender,args)
	-- 	self:EditExtensionsClicked(context, panel, settings);
	-- end

	-- context["node"].MouseClick = function(sender,args)
	-- 	self:EditExtensionsClicked(context, panel, settings);
	-- end

	panel.Draw();
end

function MainMenuItems:EditExtensionsClicked(context, panel, settings)
	-- if (context["icon"]:GetBackground() == self.utils.ICONCHECKED) then
	-- 	self:SetCheckedIcon(context, false);

	-- 	if ( settings.barMode == NORMAL_MODE and self.priorBarMode == nil ) then
	-- 		settings.barMode = EASYBAR_MODE;
	-- 	elseif ( settings.barMode == NORMAL_MODE and self.priorBarMode ~= nil ) then
	-- 		settings.barMode = self.priorBarMode;
	-- 	else
	-- 		self.priorBarMode = settings.barMode;
	-- 		settings.barMode = NORMAL_MODE;
	-- 	end
	-- else
	-- 	self:SetCheckedIcon(context, true);

	-- 	if ( settings.barMode ~= NORMAL_MODE ) then
	-- 		settings.barMode = EXTENSION_MODE;
	-- 	else
	-- 		settings.priorBarMode = EXTENSION_MODE;
	-- 	end
	-- end

	panel.Draw();
end

function MainMenuItems:CreateBarNode(parent, barId, bar)
	local node = MyysticUI.Menus.Core.TitleTreeNode(self:GetBarName(barId, bar), 1);

	parent:GetChildNodes():Add(node);
	return node;
end

-- function MainMenuItems:CreateExpandedBarItem(parent, mainMenu, panel, barId, value)
-- 	local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);

-- 	local context = self:NewContext(parent, barId, self:GetBarName(barId, value), parent:GetWidth());
-- 	local treeNode = MyysticUI.Menus.Core.TitleTreeNode(context["barName"], 1);

-- 	if (parent ~= nil and parent.Add ~= nil) then
-- 		parent:Add(treeNode);
-- 	else
-- 		parent:GetChildNodes():Add(treeNode);
-- 	end

-- 	self:Exists(context);
-- 	self:SetExpandedIcon(context);

-- 	context["icon"].MouseClick = function(sender,args)
-- 		self:Exists(context);
-- 		self:SetExpandedIcon(context);

-- 		if (context["exists"]) then
-- 			self:SetSelected(context);
-- 			panel.Draw(panel, context);
-- 		else
-- 			mainMenu.contentBox:ClearItems();
-- 		end

-- 		barService:RefreshBars();

-- 		if (mainMenu ~= nil) then
-- 			mainMenu:Refresh();
-- 		end
-- 	end

-- 	node.MouseClick = function(sender,args)
-- 		self:SetExpandedIcon(context);
-- 		if (node:IsExpanded() == true and context["exists"]) then
-- 			self:SetSelected(context);
-- 			panel.Draw(panel, context);
-- 		else
-- 			mainMenu.contentBox:ClearItems();
-- 		end
-- 	end

-- 	return context;
-- end

-- function MainMenuItems:Exists(context)
-- 	local id, actualBar = self:GetBarMatch(context);
-- 	if ( actualBar ~= nil ) then
-- 		context["exists"] = true;
-- 	else
-- 		context["exists"] = false;
-- 	end
-- 	return context["exists"];
-- end

function MainMenuItems:SetSelected(context)
	local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);

	if (context ~= nil and context["id"] ~= nil) then
--		Turbine.Shell.WriteLine("Setting Selected: " .. context["id"])
		local settings = settingsService:GetSettings();
		settings.selectedBar = context["id"];
		barService:RefreshBars();
	else
		local id, bar = self:GetBarMatch(context);
		local settings = settingsService:GetSettings();
--		Turbine.Shell.WriteLine("Setting Selected2: " .. tostring(id));
		settings.selectedBar = id;
		barService:RefreshBars();
	end
end

-- function MainMenuItems:SetCheckedIcon(context, checked)
-- 	context["icon"]:SetBackground(checked and self.utils.ICONCHECKED or self.utils.ICONCHECKEDEMPTY);
-- end

-- function MainMenuItems:SetExpandedIcon(context)
-- 	local childNodes = context["node"]:GetChildNodes();
-- 	if context["node"]:IsExpanded() == true then
-- 		context["icon"]:SetBackground(self.utils.ICONCOLLAPSE);
-- 		if (childNodes:GetCount() > 0) then
-- 			for i=1, childNodes:GetCount(), 1 do
-- 				local node = context["node"]:GetChildNodes():Get(i);
-- 				node:SetExpanded(true);
-- 			end
-- 		end
-- 	else
-- 		context["icon"]:SetBackground(self.utils.ICONEXPAND);
-- 		if (childNodes:GetCount() > 0) then
-- 			for i=1, childNodes:GetCount(), 1 do
-- 				local node = context["node"]:GetChildNodes():Get(i);
-- 				node:SetExpanded(false);
-- 			end
-- 		end
-- 	end
-- end

function MainMenuItems:NewContext(parent, barId, barName, width)
	return {
		["parent"] = parent,
		["id"] = tonumber(barId),
		["barName"] = barName,
		["width"] = width
	};
end

function MainMenuItems:GetBarName(barId, bar)
	if (bar == nil) then
		return ""
	end

	local text = bar.barName;
	if (text == nil) then
		if (bar.barname ~= nil) then
			text = bar.barname;
		elseif (bar.barType ~= nil and bar.barType == 1) then
			text = "Bar: " .. barId;
		else
			text = "Ext Bar: " .. barId;
		end
	end
	return text;
end

function MainMenuItems:GetBarMatch(context)
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);

	for key, value in opairs (settingsService:GetBars()) do
		if (value.barName == context["barName"] and value.barName ~=nil) then
			return key, value;
		end
		if (key == context["id"]) then
			return key, value;
		end
	end
end