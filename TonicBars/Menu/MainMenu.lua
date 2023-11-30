-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: TonicBars@gmail.com
--
-- RESPECT!

import "Turbine";
import "Turbine.UI";
import "Turbine.UI.Lotro";
import "Tonic.Utils.Class";
import "Tonic.Utils.Table";
import "Tonic.UI.CheckBox";
import "Tonic.UI.ComboBox";
import "Tonic.UI.AutoListBox";
import "Tonic.UI.MenuUtils";
import "Tonic.TonicBars.Menu.InventoryMenu";
import "Tonic.TonicBars.Menu.AboutMenu";
import "Tonic.TonicBars.Menu.Items.MainMenuItems";
import "Tonic.TonicBars.Menu.Items.EasyBarMenuItems";
import "Tonic.TonicBars.Menu.Items.ManageBarsMenuItems";
import "Tonic.TonicBars.Menu.Panels.Menus.EasyBarMenuPanel";
import "Tonic.TonicBars.Menu.Panels.Menus.ManageBarsMenuPanel";
import "Tonic.TonicBars.Menu.Panels.Menus.ExtensionsMenuPanel";
import "Tonic.TonicBars.Menu.Panels.Menus.GeneralMenuPanel";

windowWidth = 800;
windowHeight = 2000;

SCREENWIDTH = Turbine.UI.Display.GetWidth();
SCREENHEIGHT = Turbine.UI.Display.GetHeight();

MainMenu = class( Turbine.UI.ListBox );

MainMenu.utils = Tonic.UI.MenuUtils();

MainMenu.navigationWidth = 200;
MainMenu.tree = nil;
MainMenu.menuItems = Tonic.TonicBars.Menu.Items.MainMenuItems();

MainMenu.menus = { };
MainMenu.menuSize = 0;
MainMenu.expandedMenus = nil;

function MainMenu:Constructor()
	Turbine.UI.ListBox.Constructor(self);

	self.barService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.BarService);
	self.settingsService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.SettingsService);
	
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
	editButton:SetText( LOCALESTRINGS.MainButtons["Edit Mode"] );
	editButton:SetSize( width, selectionHeight + 50 );
	editButton.MouseClick = function( sender, args )
		local settings = self.settingsService:GetSettings();
		if ( settings.barMode == NORMAL_MODE and self.priorBarMode == nil ) then
			settings.barMode = EASYBAR_MODE;
		elseif ( settings.barMode == NORMAL_MODE and self.priorBarMode ~= nil ) then
			settings.barMode = self.priorBarMode;
		else
			self.priorBarMode = settings.barMode;
			settings.barMode = NORMAL_MODE;
		end
		self.barService:RefreshBars();

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

	self:AddMenuOption(Tonic.TonicBars.Menu.Panels.Menus.EasyBarMenuPanel, Tonic.TonicBars.Menu.Items.EasyBarMenuItems, {["width"] = self.navigationWidth}, "Easy Bars", RootNode)
	self:AddMenuOption(Tonic.TonicBars.Menu.Panels.Menus.ManageBarsMenuPanel, Tonic.TonicBars.Menu.Items.ManageBarsMenuItems, {["width"] = self.navigationWidth}, "Manage Bars", RootNode)

	local context = {["width"] = self.navigationWidth};

	self.inventoryMenuItem = self.utils:AddExpandTreeViewItem(RootNode, "Inventory Bars", context);
	self:AddMenuOption(Tonic.TonicBars.Menu.Panels.Menus.GeneralMenuPanel, nil, {["width"] = self.navigationWidth}, "General", RootNode)
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
	return self.settingsService:GetSettings().selectedBar;
end

function MainMenu:EnableTriggers( enabled )

end