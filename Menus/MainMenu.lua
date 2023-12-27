-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "MyysticUI.Utils.Class";
import "MyysticUI.Utils.Table";
import "MyysticUI.UI.ComboBox";
import "MyysticUI.UI.AutoListBox";
import "MyysticUI.UI.MenuUtils";
import "MyysticUI.Menus.Items.MainMenuItems";
import "MyysticUI.Menus.Items.EasyBarMenuItems";
import "MyysticUI.Menus.Items.ManageBarsMenuItems";
import "MyysticUI.Menus.Items.InventoryBarsMenuItems";
import "MyysticUI.Menus.Panels.Menus.EasyBarMenuPanel";
import "MyysticUI.Menus.Panels.Menus.ManageBarsMenuPanel";
import "MyysticUI.Menus.Panels.Menus.InventoryBarMenuPanel";
import "MyysticUI.Menus.Panels.Menus.ExtensionsMenuPanel";
import "MyysticUI.Menus.Panels.Menus.GeneralMenuPanel";

windowWidth = 800;
windowHeight = 2000;

selectionWidth = 160;
selectionHeight = 20;

SCREENWIDTH = Turbine.UI.Display.GetWidth();
SCREENHEIGHT = Turbine.UI.Display.GetHeight();

MainMenu = class( Turbine.UI.ListBox );

MainMenu.utils = MyysticUI.UI.MenuUtils();

MainMenu.navigationWidth = 200;
MainMenu.tree = nil;
MainMenu.menuItems = MyysticUI.Menus.Items.MainMenuItems();

MainMenu.menus = { };
MainMenu.menuSize = 0;
MainMenu.expandedMenus = nil;

function MainMenu:Constructor()
	Turbine.UI.ListBox.Constructor(self);
	
	self:SetWidth( windowWidth );
	self:SetHeight( windowHeight );
	self:SetVisible( true );
	self:SetOrientation(Turbine.UI.Orientation.Horizontal);

	self:AddSelectionTypes(self.navigationWidth);

	self:Refresh();
end

function MainMenu:AddSelectionTypes(width)
	self.menuBox = self.utils:AddAutoListBox( self, Turbine.UI.Orientation.Vertical );
	self.menuBox:SetWidth(width);
	self.menuBox:SetHeight( windowHeight );

	local editButton = Turbine.UI.Lotro.Button();
	editButton:SetParent(self.menuBox);
	editButton:SetText( "Edit Mode" );
	editButton:SetSize( width, selectionHeight + 100 );
	editButton.MouseClick = function( sender, args )
		local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
		local settings = settingsService:GetSettings();

		if ( settings.barMode == NORMAL_MODE and self.priorBarMode == nil ) then
			settings.barMode = EASYBAR_MODE;
		elseif ( settings.barMode == NORMAL_MODE and self.priorBarMode ~= nil ) then
			settings.barMode = self.priorBarMode;
		else
			self.priorBarMode = settings.barMode;
			settings.barMode = NORMAL_MODE;
		end

		local barService = SERVICE_CONTAINER:GetService(MyysticUI.Services.BarService);
		barService:RefreshBars();

	end
	self.menuBox:AddItem( editButton );

	self.navigationBox = self.utils:AddAutoListBox( self, Turbine.UI.Orientation.Vertical );
	self.navigationBox:SetWidth(width);
	self.navigationBox:SetHeight( windowHeight );

	self.menuBox:AddItem( self.navigationBox );

	self:AddItem( self.menuBox );

	self.contentBox = self.utils:AddAutoListBox( self, Turbine.UI.Orientation.Vertical );
	self.contentBox:SetHeight( windowHeight );

	self:AddItem( self.contentBox );
end

function MainMenu:Refresh()
	self:SaveExpandedItems();

	self.navigationBox:ClearItems();

	self.tree = Turbine.UI.TreeView();
    self.tree:SetParent(self.navigationBox);
    self.tree:SetPosition(5,60);
    self.tree:SetSize(200,windowHeight);
    self.tree:SetIndentationWidth(30);

	local RootNode = self.tree:GetNodes();

	self:AddMenuOption(MyysticUI.Menus.Panels.Menus.EasyBarMenuPanel, MyysticUI.Menus.Items.EasyBarMenuItems, {["width"] = self.navigationWidth}, "Easy Bars", RootNode);
	self:AddMenuOption(MyysticUI.Menus.Panels.Menus.ManageBarsMenuPanel, MyysticUI.Menus.Items.ManageBarsMenuItems, {["width"] = self.navigationWidth}, "Manage Bars", RootNode);
	self:AddMenuOption(MyysticUI.Menus.Panels.Menus.InventoryBarMenuPanel, MyysticUI.Menus.Items.InventoryBarsMenuItems, {["width"] = self.navigationWidth}, "Inventory Bars", RootNode);

	local context = {["width"] = self.navigationWidth};

	self:AddMenuOption(MyysticUI.Menus.Panels.Menus.GeneralMenuPanel, nil, {["width"] = self.navigationWidth}, "General", RootNode)
	self.aboutMenuItem = self.utils:AddTreeViewItem(RootNode, "About", context);

	self:LoadExpandedItems();

	self.navigationBox:AddItem(self.tree);
end

function MainMenu:AddMenuOption(menuPanelObj, itemPanelObj, context, text, treeRoot)
	local menuPanel = menuPanelObj();
	local menuItem = self.utils:AddExpandTreeViewItem(treeRoot, text, context, menuPanel, menuPanel.Draw, menuPanel.Draw);
	self.menus[text] = {
		["panel"] = menuPanel,
		["context"] = context,
		["node"] = menuItem
	}
	self.menuSize = self.menuSize + 1;

	-- Draw Children Menu Items!
	if (itemPanelObj ~= nil) then
		itemPanelObj(self, menuItem);
	end
end

function MainMenu:SaveExpandedItems()
	if (self.menuSize > 0 and self.expandedMenus == nil) then
		self.expandedMenus = { };
		for key, menu in opairs(self.menus) do
			self.expandedMenus[key] = menu["node"]:IsExpanded();
		end
	end
end
function MainMenu:LoadExpandedItems()
	if (self.menuSize > 0 and self.expandedMenus ~= nil) then
		for key, expanded in opairs(self.expandedMenus) do
			self.menus[key]["node"]:SetExpanded(expanded);
			self.menuItems:SetExpandedIcon(self.menus[key]["context"]);
		end
	end
	self.expandedMenus = nil;
end

function MainMenu:GetSelection()
	local settingsService = SERVICE_CONTAINER:GetService(MyysticUI.Services.SettingsService);
	return settingsService:GetSettings().selectedBar;
end

function MainMenu:EnableTriggers( enabled )

end