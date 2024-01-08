-- Created by MyysticOwl
-- The use of this code requires the permission of the author.
-- Permission can be atained by contacting MyysticOwl at: MyysticOwl@gmail.com
--
-- RESPECT!

_G.control2LightColor = Turbine.UI.Color(0.95,0.85,0.55);  -- light gold, somewhat white
_G.controlDisabledColor = Turbine.UI.Color(0.42,0.42,0.4); -- dark grey

SCREENWIDTH = Turbine.UI.Display.GetWidth();
SCREENHEIGHT = Turbine.UI.Display.GetHeight();

windowHeight = SCREENHEIGHT - 200;
selectionWidth = 160;
selectionHeight = 20;


MainMenu = class( Turbine.UI.Control );

MainMenu.utils = MysticBars.Menus.Core.UI.MenuUtils();

MainMenu.navigationWidth = 200;
MainMenu.tree = nil;
MainMenu.menuItems = MysticBars.Menus.MainMenuItems();

MainMenu.menus = { };
MainMenu.menuSize = 0;
MainMenu.expandedMenus = nil;

function MainMenu:Constructor()
	Turbine.UI.Control.Constructor(self);

	self:SetHeight(windowHeight);

	self.editButton = Turbine.UI.Lotro.Button();
	self.editButton:SetParent(self);
	self.editButton:SetText( L["Edit Mode"] );
	self.editButton:SetSize( 100, 30 );
	self.editButton:SetMultiline(true);
	self.editButton:SetPosition(2, 20);

	self.tree = Turbine.UI.TreeView();
    self.tree:SetParent(self);
    self.tree:SetPosition(10, 50);
    self.tree:SetIndentationWidth(30);

	-- Give the tree view a scroll bar.
	self.scrollBar = Turbine.UI.Lotro.ScrollBar();
	self.scrollBar:SetOrientation(Turbine.UI.Orientation.Vertical);
	self.scrollBar:SetParent(self);
	self.scrollBar:SetPosition(0, 50);
	self.scrollBar:SetSize(10, windowHeight);

	self.tree:SetVerticalScrollBar(self.scrollBar);

	local treeRoot = self.tree:GetNodes();

	self.easyBars = MysticBars.Menus.Core.TitleTreeNode(L["Easy Bars"], 1);
	treeRoot:Add(self.easyBars);

	self.managedBars = MysticBars.Menus.Core.TitleTreeNode(L["Quickslot Bars"], 1, QUICKSLOTBAR, true);
	treeRoot:Add(self.managedBars);

	self.inventoryBars = MysticBars.Menus.Core.TitleTreeNode(L["Inventory Bars"], 1, TABBED_INV_BAR);
	treeRoot:Add(self.inventoryBars);

	self.generalSettings = MysticBars.Menus.Core.TitleTreeNode(L["General Settings"], 1);
	treeRoot:Add(self.generalSettings);

	MysticBars.Menus.EasyBarMenuItems(self, self.easyBars);
	MysticBars.Menus.ManageBarsMenuItems(self, self.managedBars);
	MysticBars.Menus.InventoryBarsMenuItems(self, self.inventoryBars);
	MysticBars.Menus.GeneralMenuItems(self, self.generalSettings);

	self.editButton.MouseClick = function( sender, args )
		local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
		local settings = settingsService:GetSettings();

		if ( settings.barMode == NORMAL_MODE and self.priorBarMode == nil ) then
			settings.barMode = EASYBAR_MODE;
		elseif ( settings.barMode == NORMAL_MODE and self.priorBarMode ~= nil ) then
			settings.barMode = self.priorBarMode;
		else
			self.priorBarMode = settings.barMode;
			settings.barMode = NORMAL_MODE;
		end

		local barService = SERVICE_CONTAINER:GetService(MysticBars.Services.BarService);
		barService:RefreshBars();

		self:Refresh();
	end

	self:Refresh();
end

function MainMenu:SizeChanged(args)
		self:Refresh();
end

function MainMenu:Refresh(destroy)
	local w,h = self:GetSize();

	if (destroy ~= nil) then
		self.easyBars:GetChildNodes():Clear();
		self.managedBars:GetChildNodes():Clear();
		self.inventoryBars:GetChildNodes():Clear();
		self.generalSettings:GetChildNodes():Clear();

		MysticBars.Menus.EasyBarMenuItems(self, self.easyBars);
		MysticBars.Menus.ManageBarsMenuItems(self, self.managedBars);
		MysticBars.Menus.InventoryBarsMenuItems(self, self.inventoryBars);
		MysticBars.Menus.GeneralMenuItems(self, self.generalSettings);

		self.easyBars:SetExpanded(not self.easyBars:IsExpanded());
		self.easyBars:SetExpanded(not self.easyBars:IsExpanded());

		self.managedBars:SetExpanded(not self.managedBars:IsExpanded());
		self.managedBars:SetExpanded(not self.managedBars:IsExpanded());

		self.inventoryBars:SetExpanded(not self.inventoryBars:IsExpanded());
		self.inventoryBars:SetExpanded(not self.inventoryBars:IsExpanded());

		self.generalSettings:SetExpanded(not self.generalSettings:IsExpanded());
		self.generalSettings:SetExpanded(not self.generalSettings:IsExpanded());
	end

	if (self.tree) then
		self.tree:SetSize(w - 40, windowHeight - 50);
		self.scrollBar:SetHeight(windowHeight - 50);

		local root = self.tree:GetNodes();
		for i=1,self.tree:GetNodes():GetCount() do
			local node = root:Get(i);

			self:RefreshChildren(node, w - 50);
		end
	end
end

function MainMenu:RefreshChildren(node, w)
	if (node:GetChildNodes():GetCount() > 0) then
		for i=1,node:GetChildNodes():GetCount() do
			local childNode = node:GetChildNodes():Get(i);

			self:RefreshChildren(childNode, w - 50);
			node:Refresh(w - 50);
		end
	else
		node:Refresh(w);
	end
end

function MainMenu:GetSelection()
	local settingsService = SERVICE_CONTAINER:GetService(MysticBars.Services.SettingsService);
	return settingsService:GetSettings().selectedBar;
end

function MainMenu:EnableTriggers( enabled )

end

function MainMenu:Destroy(sender)
	self.editButton:SetParent(nil);
	self.editButton.MouseClick = nil;
	self.editButton:SetVisible(false);
	self.editButton = nil;

	self.tree:SetParent(nil);
	self.tree:SetVisible(false);
	self.tree = nil;

	self.scrollBar:SetParent(nil);
	self.scrollBar:SetVisible(false);
	self.scrollBar = nil;

	self.SizeChanged = nil;
	self:SetParent(nil);
	self:SetVisible(false);
	self = nil;
end