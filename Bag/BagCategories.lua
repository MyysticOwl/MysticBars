local itemCategories = Turbine.Gameplay.ItemCategory;

local BagCategories_armour = {
    head = itemCategories.Head,
    legs = itemCategories.Legs,
    feet = itemCategories.Feet,
    chest = itemCategories.Chest,
    shoulders = itemCategories.Shoulders,
    shield = itemCategories.Shield,
    hands = itemCategories.Hands,
    armor = itemCategories.Armor,
    back = itemCategories.Back
}
local BagCategories_barter = {
    itemCategories.Barter
}
local BagCategories_class = {
    itemCategories.Hunter,
    itemCategories.Guardian,
    itemCategories.Loremaster,
    itemCategories.Champion,
    itemCategories.Minstrel,
    itemCategories.Burglar,
    itemCategories.Runekeeper,
    itemCategories.Captain,
    288
}
local BagCategories_classItems = {
    itemCategories.GuardianBelt,
    itemCategories.Warden,
    itemCategories.LoremasterFood,
    itemCategories.Shieldspike,
    itemCategories.Horn,
    itemCategories.MinstrelBook,
    itemCategories.Oil
}
local BagCategories_consumable = {
    itemCategories.Potion,
    itemCategories.Food,
    itemCategories.Scroll,
    itemCategories.Perk,
    itemCategories.Tome
}
local BagCategories_cosmetic = {
    itemCategories.CosmeticClass,
    itemCategories.CosmeticHead,
    itemCategories.CosmeticLegs,
    itemCategories.CosmeticFeet,
    itemCategories.CosmeticChest,
    itemCategories.CosmeticHands,
    itemCategories.CosmeticHeld,
    itemCategories.CosmeticShoulders,
    itemCategories.CosmeticBack,
    253
}
local BagCategories_crafting = {
    itemCategories.Resource,
    itemCategories.Ingredient,
    itemCategories.OptionalIngredient,
    itemCategories.Crafting,
    itemCategories.Tool
}
local BagCategories_deconstructable = {
    itemCategories.Deconstructable
}
local BagCategories_decoration = {
    itemCategories.YardDecoration,
    itemCategories.FloorDecoration,
    itemCategories.Decoration,
    itemCategories.WallDecoration,
    itemCategories.FurnitureDecoration,
    itemCategories.SpecialDecoration,
    itemCategories.SurfacePaintDecoration,
    itemCategories.CeilingDecoration,
    itemCategories.MusicDecoration,
    itemCategories.TrophyDecoration,
    285,
    291
}
local BagCategories_dye = {
    itemCategories.Dye
}
local BagCategories_essences = {
    235
}
local BagCategories_festival = {
    itemCategories.Festival
}
local BagCategories_fishing = {
    itemCategories.FishingBait,
    itemCategories.FishingOther,
    itemCategories.Fish,
    itemCategories.FishingPole
}
local BagCategories_health = {
    itemCategories.Healing,
    292
}
local BagCategories_instrument = {
    itemCategories.Instrument
}
local BagCategories_jewelry = {
    itemCategories.Jewelry,
    itemCategories.Pennant,
}
local BagCategories_kinship = {
    itemCategories.KinshipCharter
}
local BagCategories_li = {
    itemCategories.LegendaryWeaponUnslotRelics,
    itemCategories.LegendaryWeaponReset,
    itemCategories.LegendaryWeaponIncreaseItemLevel,
    itemCategories.LegendaryWeaponReplaceLegacy,
    itemCategories.LegendaryWeaponUpgradeLegacy,
    itemCategories.LegendaryWeaponAddLegacy,
    itemCategories.LegendaryWeaponExperience,
    itemCategories.LegendaryWeaponLegacyReveal,
    itemCategories.LegendaryWeaponIncreaseMaxLevel,
    itemCategories.Relic,
    233
}
local BagCategories_lootbox = {
    251
}
local BagCategories_miscellaneous = {
    itemCategories.Key,
    itemCategories.Book,
    itemCategories.Implement,
    itemCategories.NonInventory,
    itemCategories.Treasure,
    itemCategories.Orb,
    itemCategories.Misc,
    279
}
local BagCategories_quest = {
    itemCategories.Quest
}
local BagCategories_reputation = {
    itemCategories.Reputation
}
local BagCategories_scrolls = {
    itemCategories.Scroll,
	itemCategories.ApprenticeTailorScroll,
	itemCategories.ApprenticeJewellerScroll,
	itemCategories.ApprenticeProspectingScroll,
	itemCategories.ApprenticeFarmerScroll,
	itemCategories.ApprenticeScholarScroll,
	itemCategories.ApprenticeForestryScroll,
	itemCategories.ApprenticeMetalworkScroll,
	itemCategories.ApprenticeCookScroll,
	itemCategories.ApprenticeWeaponsmithScroll,
	itemCategories.ApprenticeWoodworkScroll,
    itemCategories.JourneymanCookScroll,
	itemCategories.ExpertCookScroll,
	itemCategories.ArtisanCookScroll,
	itemCategories.MasterCookScroll,
	itemCategories.SupremeCookScroll,
	itemCategories.MasterWoodworkScroll,
	itemCategories.MasterWeaponsmithScroll,
	itemCategories.ArtisanTailorScroll,
	itemCategories.ExpertFarmerScroll,
	itemCategories.JourneymanForestryScroll,
	itemCategories.SupremeWoodworkScroll,
	itemCategories.SupremeWeaponsmithScroll,
	itemCategories.MasterTailorScroll,
	itemCategories.ArtisanFarmerScroll,
	itemCategories.ExpertForestryScroll,
	itemCategories.SupremeTailorScroll,
	itemCategories.MasterFarmerScroll,
	itemCategories.ArtisanForestryScroll,
	itemCategories.SupremeFarmerScroll,
	itemCategories.MasterForestryScroll,
	itemCategories.SupremeForestryScroll,
	itemCategories.JourneymanProspectingScroll,
	itemCategories.ExpertProspectingScroll,
	itemCategories.ArtisanProspectingScroll,
	itemCategories.MasterProspectingScroll,
	itemCategories.SupremeProspectingScroll,
	itemCategories.JourneymanScholarScroll,
	itemCategories.ExpertScholarScroll,
	itemCategories.JourneymanMetalworkScroll,
	itemCategories.ArtisanScholarScroll,
	itemCategories.JourneymanJewellerScroll,
	itemCategories.ExpertMetalworkScroll,
	itemCategories.MasterScholarScroll,
	itemCategories.ExpertJewellerScroll,
	itemCategories.JourneymanWoodworkScroll,
	itemCategories.JourneymanWeaponsmithScroll,
	itemCategories.ArtisanMetalworkScroll,
	itemCategories.SupremeScholarScroll,
	itemCategories.ArtisanJewellerScroll,
	itemCategories.ExpertWoodworkScroll,
	itemCategories.ExpertWeaponsmithScroll,
	itemCategories.MasterMetalworkScroll,
	itemCategories.JourneymanTailorScroll,
	itemCategories.MasterJewellerScroll,
	itemCategories.ArtisanWoodworkScroll,
	itemCategories.ArtisanWeaponsmithScroll,
	itemCategories.SupremeMetalworkScroll,
	itemCategories.ExpertTailorScroll,
	itemCategories.SupremeJewellerScroll,
	itemCategories.JourneymanFarmerScroll,
	itemCategories.WestfoldMetalworkScroll,
	itemCategories.WestfoldJewellerScroll,
	itemCategories.WestfoldWoodworkScroll,
	itemCategories.WestfoldWeaponsmithScroll,
	itemCategories.WestfoldTailorScroll,
	itemCategories.WestfoldFarmerScroll,
	itemCategories.WestfoldForestryScroll,
	itemCategories.WestfoldProspectingScroll,
	itemCategories.WestfoldCookScroll,
	itemCategories.WestfoldScholarScroll,
}
local BagCategories_skirmish = {
    itemCategories.Skirmish
}
local BagCategories_social = {
    itemCategories.Social,
    itemCategories.Special,
    itemCategories.Clothing
}
local BagCategories_task = {
    207
}
local BagCategories_travel = {
    itemCategories.Travel,
    itemCategories.Map,
    186
}
local BagCategories_trophy = {
    itemCategories.SpecialTrophy,
    itemCategories.CraftingTrophy,
    itemCategories.Trophy,
    287
}
local BagCategories_weapon = {
    itemCategories.Spear,
    itemCategories.Mace,
    itemCategories.Axe,
    itemCategories.Halberd,
    itemCategories.Crossbow,
    itemCategories.Weapon,
    itemCategories.Sword,
    itemCategories.Javelin,
    itemCategories.Hammer,
    itemCategories.Staff,
    itemCategories.Bow,
    itemCategories.Club,
    itemCategories.Dagger,
    itemCategories.Thrown,
    290
}
local BagCategories_undefined = {
    itemCategories.Undefined
}
local BagCategories_useables = {
    itemCategories.Component,
    itemCategories.Device,
    itemCategories.Effect,
    itemCategories.Trap,
    itemCategories.Mounts
}

BagCategories = {
    Armor = BagCategories_armour,
    Barter = BagCategories_barter,
    Class = BagCategories_class,
    ["Class Items"] = BagCategories_classItems,
    Consumable = BagCategories_consumable,
    Cosmetic = BagCategories_cosmetic,
    Crafting = BagCategories_crafting,
    Deconstructable = BagCategories_deconstructable,
    Decoration = BagCategories_decoration,
    Dye = BagCategories_dye,
    Essences = BagCategories_essences,
    Festival = BagCategories_festival,
    Fishing = BagCategories_fishing,
    Health = BagCategories_health,
    Instrument = BagCategories_instrument,
    Jewelry = BagCategories_jewelry,
    Kinship = BagCategories_kinship,
    LI = BagCategories_li,
    Lootbox = BagCategories_lootbox,
    Misc = BagCategories_miscellaneous,
    Quest = BagCategories_quest,
    Repuration = BagCategories_reputation,
    Scrolls = BagCategories_scrolls,
    Skirmish = BagCategories_skirmish,
    Social = BagCategories_social,
    Task = BagCategories_task,
    Travel = BagCategories_travel,
    Trophy = BagCategories_trophy,
    Weapon = BagCategories_weapon,
    Undefined = BagCategories_undefined,
    Usebles = BagCategories_useables
}