local module = {}
module.__index = module
local AbilityBase = require(game.ServerScriptService.ModuleScripts.AbilityObject)

setmetatable(module, AbilityBase)

function module:Initialize()
	
	local Ability = AbilityBase.NewAbility()
	setmetatable(Ability, module)
	
	Ability.Name = "None"
	Ability.Cooldown = 0
	Ability.Range = 0
	Ability.Icon = ""
	Ability.NeedTarget = false
	
	return Ability
	
end

return module
