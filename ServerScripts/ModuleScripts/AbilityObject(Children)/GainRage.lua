local module = {}
module.__index = module
local AbilityBase = require(game.ServerScriptService.ModuleScripts.AbilityObject)

setmetatable(module, AbilityBase)

function module:Initialize()
	
	local Ability = AbilityBase.NewAbility()
	setmetatable(Ability, module)
	
	Ability.Name = "GainRage"
	Ability.Cooldown = 10
	Ability.Range = 0
	Ability.Icon = "rbxassetid://8402926671"
	Ability.NeedTarget = false
	
	return Ability
	
end

function module:Activate(user, target)

	script.Parent.Parent.Parent.StatusEffectsScript.AddStatusEffect:Fire(user, script.Parent.Parent.StatusEffectsSystem.MasterStatusEffect.IncreaseRage, 5)
	
end

return module
