local module = {}
module.__index = module
local AbilityBase = require(game.ServerScriptService.ModuleScripts.AbilityObject)

setmetatable(module, AbilityBase)

function module:Initialize()
	
	local Ability = AbilityBase.NewAbility()
	setmetatable(Ability, module)
	
	Ability.Name = "Shadow Step"
	Ability.Cooldown = 10
	Ability.Range = 0
	Ability.Icon = "rbxassetid://8402926671"
	Ability.NeedTarget = false
	
	return Ability
	
end

function module:Activate(user, target)
	
	local humanoid = user.Humanoid
	humanoid.BodyDepthScale.Value = .35
	humanoid.BodyWidthScale.Value = .35
	humanoid.BodyHeightScale.Value = .35
	humanoid.HeadScale.Value = .35

	local effect = game.ReplicatedStorage.VFX.Abilities.Part:Clone()
	local weld = Instance.new("WeldConstraint", workspace)

	effect.Position = user.PrimaryPart.Position

	user.Humanoid.WalkSpeed = 32

	effect.Parent = workspace
	weld.Part0 = effect
	weld.Part1 = user.PrimaryPart
	effect.HoldOnAttatchment.HoldParticles.Enabled = true
	effect.FallOffAttatchment.FallOffParticles.Enabled = true

	script.Parent.Parent.Parent.StatusEffectsScript.AddStatusEffect:Fire(user, script.Parent.Parent.StatusEffectsSystem.MasterStatusEffect.StatusEffect1, 10)

	coroutine.wrap(function()

		wait(3.5)

		effect.FallOffAttatchment.FallOffParticles.Enabled = false
		effect.HoldOnAttatchment.HoldParticles.Enabled = false

		user.Humanoid.WalkSpeed = 16
		humanoid.BodyDepthScale.Value = 1
		humanoid.BodyWidthScale.Value = 1
		humanoid.BodyHeightScale.Value = 1
		humanoid.HeadScale.Value = 1

		wait(2)

		effect:Destroy()
		weld:Destroy()

	end)()

	print(user.Humanoid.HeadScale)
	
end

return module
