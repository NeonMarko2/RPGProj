local module = {}
module.__index = module
local AbilityBase = require(game.ServerScriptService.ModuleScripts.AbilityObject)

setmetatable(module, AbilityBase)

function module:Initialize()
	
	local Ability = AbilityBase.NewAbility()
	setmetatable(Ability, module)
	
	Ability.Name = "Attack"
	Ability.Cooldown = 1
	Ability.Range = 5
	Ability.Icon = "rbxassetid://8402926671"
	Ability.NeedTarget = true
	
	return Ability
	
end

function module:Activate(user, target)
	print(user, target)
	
	if (user.HumanoidRootPart.Position - target.HumanoidRootPart.Position).Magnitude > self.Range then return end

	--user:FindFirstChild("Humanoid").Animator:LoadAnimation(thisAbility.Animation):Play()

	if target ~= nil then

		for i,v in pairs(target:GetDescendants()) do

			if v.ClassName == "Humanoid" then
				
				target:FindFirstChild("Humanoid").Health -= 20
				--DamageModule:DamageTarget(user, target, 20)

			end

		end

	end
	
end

return module
