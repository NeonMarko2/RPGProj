local module = {}
module.__index = module
local AbilityBase = require(game.ServerScriptService.ModuleScripts.AbilityObject)

setmetatable(module, AbilityBase)

function module:Initialize()
	
	local Ability = AbilityBase.NewAbility()
	setmetatable(Ability, module)
	
	Ability.Name = "Drain"
	Ability.Cooldown = 10
	Ability.Range = 25
	Ability.Icon = "rbxassetid://8402926671"
	Ability.NeedTarget = true
	
	return Ability
	
end

function module:Activate(user, target)
	print(user, target)
	
	if (user.HumanoidRootPart.Position - target.HumanoidRootPart.Position).Magnitude > self.Range then return end

	--user:FindFirstChild("Humanoid").Animator:LoadAnimation(thisAbility.Animation):Play()

	if target ~= nil then

		local bendy = Instance.new("Beam", workspace)

	local attatchment1 = Instance.new("Attachment", user.HumanoidRootPart)
	local attatchment2 = Instance.new("Attachment", target.HumanoidRootPart)

	bendy.Attachment0 = attatchment1
	bendy.Attachment1 = attatchment2

	coroutine.wrap(function()

		for i=1, 7 do

			wait(.15)

			for i,v in pairs(target:GetDescendants()) do

				if v.ClassName == "Humanoid" then

						target:FindFirstChild("Humanoid").Health -= 5

				end

			end

			wait(.5)

		end

		bendy:Destroy()
		attatchment1:Destroy()
		attatchment2:Destroy()

	end)()

	end

end

return module
