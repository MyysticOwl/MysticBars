import "MysticBars.Bag.BagCategories"

ManagedBagBar = class(MysticBars.Bars.Core.BaseBar);

ManagedBagBar.Log = MysticBars.Utils.Logging.LogManager.GetLogger( "ManagedBagBar" );
ManagedBagBar.columns = 4;
ManagedBagBar.categorizedItems = {};

function ManagedBagBar:Constructor( barSettings )
    self.Log:Error("Constructor");

    self:GatherCategories();

    -- for name, value in pairs(self.categorizedItems) do
    --     for index, item in pairs(value.items) do
    --         self.Log:Error("Category: " .. name .. " " .. item:GetItemInfo():GetName());
    --     end
    -- end
end

function ManagedBagBar:GatherCategories()
    local playerService = SERVICE_CONTAINER:GetService(MysticBars.Services.PlayerService);
    local backpack = playerService.player:GetBackpack();

    for i = 1, backpack:GetSize() do
        local item = backpack:GetItem(i);
        if (item ~= nil) then
           -- self.Log:Error("AddCategory " .. item:GetName());
            self:AddCategoryItem(item);
        end
    end
end

function ManagedBagBar:AddCategoryItem(item)
    self.Log:Debug("FindCategory");

    for name, categories in pairs(BagCategories) do
        for category in pairs(categories) do
            if (item:GetCategory() == category) then
                if (self.categorizedItems[name] == nil) then
                    self.categorizedItems[name] = {items={}, count=0};
                end
                local index = self.categorizedItems[name].count + 1;
                self.categorizedItems[name].count = index;
                self.categorizedItems[name].items[index] = item;
            end
        end
    end
    return nil;
end