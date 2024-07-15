local module = {}
module.__index = module
local AbilityBase = require(game.ServerScriptService.ModuleScripts.AbilityObject)

setmetatable(module, AbilityBase)

function module:Initialize()
	
	local Ability = AbilityBase.NewAbility()
	setmetatable(Ability, module)
	
	Ability.Name = "Heal"
	Ability.Cooldown = 7
	Ability.Range = 100
	Ability.Icon = "rbxassetid://8402926671"
	Ability.NeedTarget = true
	Ability.ChannelAmount = 1
	
	return Ability
	
end

function module:Activate(user, target)
	
	target.Humanoid.Health -= 50
	
end

return module
