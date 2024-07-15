local AbilityBase = {}

local PlayersAbilities = {}

local DamageModule = require(script.Parent.DamageScript)




local function CheckDistance(target1, target2)

	local distance = (target1 - target2).Magnitude

	return distance

end

local Abilities = {}

for i,v in pairs(script.Parent.AbilityObject:GetChildren()) do
	
	--print(v)
	local ability = require(v).Initialize()
	--print(ability)
	ability.Index = i
	Abilities[ability.Name] = ability
	--print(Abilities[ability.Name])
	
end

--[["https://www.roblox.com/library/10246123032/Ability-Attack" or]]
function Printsom()
	
	print(151)
	
end

function AbilityBase:ReturnPlayerAbilities(player)
	
	if PlayersAbilities[player] == nil then
		
		local abilities = table.create(8, Abilities[1])
		PlayersAbilities[player] = abilities
		
	end
	
	return PlayersAbilities[player]
	
end

function AbilityBase:AsignAbility(player, index, ability)
	
	local playerAbilities = PlayersAbilities[player]	
	playerAbilities[index] = ability
	
end
		
function AbilityBase:ReturnAbilities()
	
	return Abilities
	
end

return AbilityBase
