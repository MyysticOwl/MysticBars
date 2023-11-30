import "Turbine.UI"
import "Tonic.UI.ComboBox";
import "Tonic.UI.MenuUtils";

CheckedComboBox = class(Tonic.UI.ComboBox);

function CheckedComboBox:Constructor()
    Tonic.UI.ComboBox.Constructor(self);

	self.settingsService = SERVICE_CONTAINER:GetService(Tonic.TonicBars.Services.SettingsService);

    self.utils = Tonic.UI.MenuUtils();

    self.SelectedIndexChanged = function(sender, args)
		local barSettings = self.settingsService:GetBarSettings( menu:GetSelection() );
		for i = 1, self.listBox:GetItemCount() do
			local item = self.listBox:GetItem(i);
			if ( item.IsChecked == true ) then
				self.utils:BuildItemFromCommandTable( barSettings, item.value, true );
			else
				self.utils:BuildItemFromCommandTable( barSettings, item.value, nil );
			end
			self.settingsService:SetBarSettings( menu:GetSelection(), barSettings );
		end
	end
end

function CheckedComboBox:ItemSelected(index)
    if (self.selection ~= -1) then
        local old = self.listBox:GetItem(self.selection);
    end
    
    local item = self.listBox:GetItem(index);
    self.selection = index;
    self.label:SetText("ITEMS CHECKED");
    
    self:CloseDropDown();
end

function CheckedComboBox:AddItem(text, value)
    local width, height = self.listBox:GetSize();

    local listItem = Tonic.UI.CheckBox();
    listItem:SetSize(width, 20);
    listItem:SetText(text);

    listItem.CheckedCallback = function(sender, args)
        self:ItemSelected(self.listBox:GetSelectedIndex());
        self:FireEvent();
    end
    listItem.value = value;
    listItem.IsChecked = false;
    self.listBox:AddItem(listItem);
end

function CheckedComboBox:ItemSelected(index)
    if (self.selection ~= -1) then
        local old = self.listBox:GetItem(self.selection);
    end
    
    local item = self.listBox:GetItem(index);
    self.selection = index;

    self.label:SetText(item:GetText());
end

function CheckedComboBox:ClearChecks()
	for i = 1, self.listBox:GetItemCount() do
		local item = self.listBox:GetItem(i);
		item.IsChecked = false;
		item:SetChecked( false );
	end	
end

function CheckedComboBox:SetSelections( valueTable, useValue )
	if ( valueTable == nil ) then
		self.selection = -1;
		self.label:SetText("");
	else
		for key, value in  opairs( valueTable ) do
			for i = 1, self.listBox:GetItemCount() do
				local item = self.listBox:GetItem(i);
				if (item:GetText() == key or item.value[#item.value] == key or ( useValue ~= nil and item.value[#item.value] == value ) ) then
					item:SetChecked( true );
					self:FireEvent();
					break;
				end
			end
		end
    end
end

function CheckedComboBox:GetSelections()
    if (self.selection == -1) then
        return nil;
    else
		local items = { };
		local count = 0;
		for i = 1, self.listBox:GetItemCount() do
			local item = self.listBox:GetItem(i);
			if ( item.IsChecked == true ) then
				count = count + 1;
				items[count] = item:GetText();
				--Turbine.Shell.WriteLine( "Checked - key:" .. count .. " value:" .. items[count] );
			end
		end
        return items;
    end
end

function CheckedComboBox:UpdateSelectionText(text)
    if (self.selection ~= -1) then
        self.label:SetText( "ITEMS CHECKED" );
    end
end

