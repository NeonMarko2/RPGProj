local Database = {}

local Tags = {
		
	["Armor"] = "Armor",

		["Head"]    = "Head",
		["Chest"] 	  = "Chest",
		--["Gauntlets"] = "Gauntlets",
		--["Belts"] 	  = "Belts",
		["Leggings"]  = "Leggings",
		--["Shoes"] 	  = "Shoes",
		--["Accessory"] = "Accessory",

	["Weapon"] = "Weapon",

		["Sword"] = "Sword",
		["Staff"] = "Staff",
		["Bow"] = "Bow",
	
	--["Sellable"] = "Sellable",
	["Resource"] = "Resource",
	--["KeyItem"] = "KeyItem",
	--["QuestItem"] = "QuestItem"
	
}

local Items = {
	
	none = {
		["Name"] = "None",
		["Description"] = "",
		["Icon"] = "",
		["Tags"] = {},
		["Function"] = nil
	},
	
	Coin = {
		["Name"] = "Coin",
		["Description"] = "Tolberiyens negotiable currency",
		["Icon"] = "",
		["Tags"] = {Tags.Resource},
		["Function"] = nil
	},
	
	kuk = {
		["Name"] = "Sword",
		["Description"] = "It could be used for attacking foes",
		["Icon"] = "rbxassetid://8402926671",
		["Tags"] = {Tags.Weapon, Tags.Sword},
		["Function"] = nil
	},
	
	ChestPlate = {
		["Name"] = "ChestPlate",
		["Description"] = "Put on chest bro!",
		["Icon"] = "rbxassetid://10221430244",
		["Tags"] = {Tags.Armor, Tags.Chest},
		["Function"] = nil
	},
	
	Helm = {
		["Name"] = "Steel Helmet",
		["Description"] = "Forged by the dwarven kind that kill god knows what i dont know",
		["Icon"] = "rbxassetid://10221409335",
		["Tags"] = {Tags.Armor, Tags.Head},
		["Function"] = nil
	},
	
	Leggings = {
		["Name"] = "Pants",
		["Description"] = "Some nicer pantr",
		["Icon"] = "rbxassetid://10221457476",
		["Tags"] = {Tags.Armor, Tags.Leggings},
		["Function"] = nil
	}
	
}

function Database:ReturnItems()
	
	return Items
	
end

function Database:ReturnCategories()
	
	return Tags
	
end

return Database
