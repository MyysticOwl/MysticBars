-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "MyysticUI.Utils.Class";
import "MyysticUI.UI.ComboBox";
import "MyysticUI.UI.AutoListBox";
import "MyysticUI.UI.MenuUtils";

MainMenuItems = class();

MainMenuItems.utils = MyysticUI.UI.MenuUtils();

function MainMenuItems:CreateNewBarItem(parent, mainMenu)
	local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);

	local context = { ["parent"] = parent, ["width"] = parent:GetWidth() };
	self.utils:AddCheckedTreeViewItem(parent, "Add New Bar", context, false);
	self:SetCheckedIcon(context, false);

	context["icon"].MouseClick = function(sender,args)
		local barId = barService:Add( QUICKSLOTBAR );
		self:SetSelected({["id"] = barId});
		barService:RefreshBars();

		if (mainMenu ~= nil) then
			mainMenu:Refresh();
		end
	end
end

function MainMenuItems:CreateNewTabInventoryBarItem(parent, mainMenu)
	local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);

	local context = { ["parent"] = parent, ["width"] = parent:GetWidth() };
	self.utils:AddCheckedTreeViewItem(parent, "Add Tabbed Bar", context, false);
	self:SetCheckedIcon(context, false);

	context["icon"].MouseClick = function(sender,args)
		local barId = barService:Add( TABBED_INV_BAR );
		self:SetSelected({["id"] = barId});
		barService:RefreshBars();

		if (mainMenu ~= nil) then
			mainMenu:Refresh();
		end
	end
end

function MainMenuItems:CreateNewWindowInventoryBarItem(parent, mainMenu)
	local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);

	local context = { ["parent"] = parent, ["width"] = parent:GetWidth() };
	self.utils:AddCheckedTreeViewItem(parent, "Add Windowed Bar", context, false);
	self:SetCheckedIcon(context, false);

	context["icon"].MouseClick = function(sender,args)
		local barId = barService:Add( WINDOW_INV_BAR );
		self:SetSelected({["id"] = barId});
		barService:RefreshBars();

		if (mainMenu ~= nil) then
			mainMenu:Refresh();
		end
	end
end


function MainMenuItems:CreateNewExtensionItem(parent, panel)
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);

	local context = { ["parent"] = parent, ["width"] = parent:GetWidth() };
	self.utils:AddCheckedTreeViewItem(parent, "Extensions Mode?", context, false);

	local settings = settingsService:GetSettings();
	if (settings.barMode ~= EXTENSION_MODE) then
		self:SetCheckedIcon(context, false);
	else
		self:SetCheckedIcon(context, true);
	end

	context["icon"].MouseClick = function(sender,args)
		self:EditExtensionsClicked(context, panel, settings);
	end

	context["node"].MouseClick = function(sender,args)
		self:EditExtensionsClicked(context, panel, settings);
	end

	panel.Draw();
end

function MainMenuItems:EditExtensionsClicked(context, panel, settings)
	if (context["icon"]:GetBackground() == self.utils.ICONCHECKED) then
		self:SetCheckedIcon(context, false);

		if ( settings.barMode == NORMAL_MODE and self.priorBarMode == nil ) then
			settings.barMode = EASYBAR_MODE;
		elseif ( settings.barMode == NORMAL_MODE and self.priorBarMode ~= nil ) then
			settings.barMode = self.priorBarMode;
		else
			self.priorBarMode = settings.barMode;
			settings.barMode = NORMAL_MODE;
		end
	else
		self:SetCheckedIcon(context, true);

		if ( settings.barMode ~= NORMAL_MODE ) then
			settings.barMode = EXTENSION_MODE;
		else
			settings.priorBarMode = EXTENSION_MODE;
		end
	end

	panel.Draw();
end

function MainMenuItems:CreateIfExistsCheckedBarItem(parent, mainMenu, panel, barId, value)
	if (self:Exists(self:NewContext(parent, barId, self:GetBarName(barId, value), 0 ))) then
		return self:CreateCheckedBarItem(parent, mainMenu, panel, barId, value)
	end
end

function MainMenuItems:CreateCheckedBarItem(parent, mainMenu, panel, barId, value)
	local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);

	local context = self:NewContext(parent, barId, self:GetBarName(barId, value), parent:GetWidth() );
	local node = self.utils:AddCheckedTreeViewItem(parent, context["barName"], context, false);

	self:Exists(context);
	self:SetCheckedIcon(context, context["exists"]);

	context["icon"].MouseClick = function(sender,args)
		local id, actualBar = self:GetBarMatch(context);
		if ( actualBar == nil ) then
			value.callback( self, true );

			local configurationService = SERVICE_CONTAINER:GetService(MyysticUI.Services.ConfigurationService);
			configurationService:Save();
			barService:LoadQuickslots();
			barService:RefreshBars();

			local inventoryService = SERVICE_CONTAINER:GetService(MyysticUI.Services.InventoryService);
			inventoryService:NotifyClients();
		end

		self:Exists(context);
		self:SetCheckedIcon(context, context["exists"]);

		if (context["exists"]) then
			self:SetSelected(context);
			panel.Draw(panel, context);
		else
			mainMenu.contentBox:ClearItems();
		end

		barService:RefreshBars();

		if (mainMenu ~= nil) then
			mainMenu:Refresh();
		end
	end

	node.MouseClick = function(sender,args)
		if (context["exists"]) then
			self:SetSelected(context);
			panel.Draw(panel, context);
		end
	end

	self:Exists(context);

	return context;
end

function MainMenuItems:CreateExpandedBarItem(parent, mainMenu, panel, barId, value)
	local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);

	local context = self:NewContext(parent, barId, self:GetBarName(barId, value), parent:GetWidth());
	local node = self.utils:AddExpandTreeViewItem(parent, context["barName"], context, panel);

	self:Exists(context);
	self:SetExpandedIcon(context);

	context["icon"].MouseClick = function(sender,args)
		self:Exists(context);
		self:SetExpandedIcon(context);

		if (context["exists"]) then
			self:SetSelected(context);
			panel.Draw(panel, context);
		else
			mainMenu.contentBox:ClearItems();
		end

		barService:RefreshBars();

		if (mainMenu ~= nil) then
			mainMenu:Refresh();
		end
	end

	node.MouseClick = function(sender,args)
		self:SetExpandedIcon(context);
		if (node:IsExpanded() == true and context["exists"]) then
			self:SetSelected(context);
			panel.Draw(panel, context);
		else
			mainMenu.contentBox:ClearItems();
		end
	end

	return context;
end

function MainMenuItems:Exists(context)
	local id, actualBar = self:GetBarMatch(context);
	if ( actualBar ~= nil ) then
		context["exists"] = true;
	else
		context["exists"] = false;
	end
	return context["exists"];
end

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

function MainMenuItems:SetCheckedIcon(context, checked)
	if (checked) then
		context["icon"]:SetBackground(self.utils.ICONCHECKED);
	else
		context["icon"]:SetBackground(self.utils.ICONCHECKEDEMPTY);
	end
end

function MainMenuItems:SetExpandedIcon(context)
	local childNodes = context["node"]:GetChildNodes();
	if context["node"]:IsExpanded() == true then
		context["icon"]:SetBackground(self.utils.ICONCOLLAPSE);
		if (childNodes:GetCount() > 0) then
			for i=1, childNodes:GetCount(), 1 do
				local node = context["node"]:GetChildNodes():Get(i);
				node:SetExpanded(true);
			end
		end
	else
		context["icon"]:SetBackground(self.utils.ICONEXPAND);
		if (childNodes:GetCount() > 0) then
			for i=1, childNodes:GetCount(), 1 do
				local node = context["node"]:GetChildNodes():Get(i);
				node:SetExpanded(false);
			end
		end
	end
end

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