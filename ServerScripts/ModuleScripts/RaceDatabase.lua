local DataBase = {}

local AbilityBase = require(script.Parent.AbilityBase)
local Abilities = AbilityBase:ReturnAbilities()

local Races = {
	
	["Human"] = {
		
		Name = "Human",
		Icon = "rbxassetid://8446754985",
		Id = 1,
		SkinColor = Color3.fromRGB(227, 227, 227),
		
		Abilities = {			
			{
				["Ability"] = Abilities.None,
				["LevelUnlock"] = 1
			},	

			{
				["Ability"] = Abilities.GainRage,
				["LevelUnlock"] = 1
			},	

		},
		StatsPerLevel = {

			[1] = {Rage = 17, MaxRage = 25},
			[2] = {Rage = 17, MaxRage = 25}

		}
		
	},
	
	["TreeMan"] = {
		
		Name = "TreeMan",
		Icon = "rbxassetid://8446754821",
		Id = 2,
		SkinColor = Color3.fromRGB(122, 65, 0),
		
		Abilities = {			
			{
				["Ability"] = Abilities.None,
				["LevelUnlock"] = 1
			},	

			{
				["Ability"] = Abilities.GainRage,
				["LevelUnlock"] = 1
			},	

		},
		StatsPerLevel = {

			[1] = {Black = 17, MaxBlack = 25},

		}
		
	}
	
}

return Races
