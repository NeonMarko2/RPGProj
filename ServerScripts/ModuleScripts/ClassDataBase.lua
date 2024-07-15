local DataBase = {}

local AbilityBase = require(script.Parent.AbilityBase)
local Abilities = AbilityBase:ReturnAbilities()



local Classes = {
	
	["Warrior"] = {

		Icon = "rbxassetid://8446659249",
		Abilities = {
			
			{
				["Ability"] = Abilities["Attack"],
				["LevelUnlock"] = 3
			},
			{
				["Ability"] = Abilities["Shadow Step"],
				["LevelUnlock"] = 2
			},
			{
				["Ability"] = Abilities["GainRage"],
				["LevelUnlock"] = 2
			},
			--{
			--	["Ability"] = Abilities.Drain,
			--	["LevelUnlock"] = 2
			--},			
			--{
			--	["Ability"] = Abilities.Attack,
			--	["LevelUnlock"] = 3
			--},			
			
		},
		StatsPerLevel = {
			
			[1] = {Health = 100, Strength = 13, Dexterity = 16, Armor = 32, Mana = 130},
			[2] = {Health = 100, Strength = 13, Dexterity = 16, Armor = 32, Mana = 130}
			
		}
		
	},
	
	["Other Warrior"] = {
		
		Icon = "rbxassetid://8446658800",
		Abilities = {			
			{
				["Ability"] = Abilities.None,
				["LevelUnlock"] = 1
			},	
			
			{
				["Ability"] = Abilities.GainRage,
				["LevelUnlock"] = 1
			},	
			
			{
				["Ability"] = Abilities.Heal,
				["LevelUnlock"] = 1
			},	
			
		},
		StatsPerLevel = {

			[1] = {Health = 100, Strength = 13, Dexterity = 16, Armor = 32, Mana = 130, Rage = 17, MaxRage = 25},
			[2] = {Health = 127, Strength = 13, Dexterity = 16, Armor = 32, Mana = 130, Rage = 17, MaxRage = 25}

		}
		
	}
	
}

return Classes
