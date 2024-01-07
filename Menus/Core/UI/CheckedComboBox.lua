
CheckedComboBox = class(MysticBars.Menus.Core.UI.ComboBox);

function CheckedComboBox:Constructor()
    MysticBars.Menus.Core.UI.ComboBox.Constructor(self);

    self.utils = MysticBars.Menus.Core.UI.MenuUtils();
end

-- function CheckedComboBox:ItemSelected(index)
--     if (self.selection ~= -1) then
--         local old = self.listBox:GetItem(self.selection);
--     end
    
--     local item = self.listBox:GetItem(index);
--     self.selection = index;
--     self.label:SetText("ITEMS CHECKED");
    
--     self:CloseDropDown();
-- end

function CheckedComboBox:AddItem(text, value)
    local width, height = self.listBox:GetSize();

    local listItem = Turbine.UI.Lotro.CheckBox();
    listItem:SetSize(width, 20);
    listItem:SetText(text);

    listItem.CheckedChanged = function(sender, args)
        self:ItemSelected(self.listBox:GetSelectedIndex());
        self:FireEvent();
    end

	listItem.value = value;
    listItem:SetChecked(false);
    self.listBox:AddItem(listItem);
end

function CheckedComboBox:ItemSelected(index)
    if (self.selection ~= -1) then
        local old = self.listBox:GetItem(self.selection);
    end

	if (index > 0) then
	    local item = self.listBox:GetItem(index);
    	self.selection = index;

    	self.label:SetText(item:GetText());
	end
end

function CheckedComboBox:ClearChecks()
	for i = 1, self.listBox:GetItemCount() do
		local item = self.listBox:GetItem(i);
		item:SetChecked( false );
	end	
end

function CheckedComboBox:AnySelected()
	local found = false;
	for i = 1, self.listBox:GetItemCount() do
		local item = self.listBox:GetItem(i);
		if (item:IsChecked() == true) then
			found = true;
		end
	end
	return found;
end

function CheckedComboBox:SetSelections( valueTable, useValue )
	if ( valueTable == nil ) then
		self.selection = -1;
		self.label:SetText("");
	else
		for inputKey, inputValue in  opairs( valueTable ) do
			for i = 1, self.listBox:GetItemCount() do
				local item = self.listBox:GetItem(i);

				local found = false;
				local val = item.value;

				for key=1, #val, 1 do
					if ( key == #val ) then
						if (val[key] == inputKey) then
							found = true;
						end
					end
				end

				if (item:GetText() == inputKey or ( useValue ~= nil and found ) ) then
					item:SetChecked( true );
					self:ItemSelected(i);
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
			if ( item:IsChecked() == true ) then
				count = count + 1;
				items[count] = item.value;
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

function CheckedComboBox:SetNumberOfVisibleOptions(numberOfOptions)
	self.numberOfVisibleOptions = numberOfOptions;
end