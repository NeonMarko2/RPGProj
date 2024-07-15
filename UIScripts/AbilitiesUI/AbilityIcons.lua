
local remotes = game.ReplicatedStorage.Remotes
local AbilityBase = remotes.RemoteFunctions.ReturnAbilityList:InvokeServer()
local rs = game:GetService("RunService")

local Abilities = remotes.RemoteFunctions.ReturnPlayerAbilities:InvokeServer()
--local Abilities = AbilityBase:ReturnPlayerAbilities(game.Players.LocalPlayer)

local icons = script.Parent.IconUIs:GetChildren()
table.remove(icons, 1)

local cooldowns = {
	
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
}

local function InitializeIcons()
	
	for i,v in pairs(Abilities) do
		
		local icon = icons[i]:Clone()
		icon.Parent = icons[i].Parent
		
		icons[i]:Destroy()
		
		icon:FindFirstChild("ImageButton").Image = Abilities[i].Icon
		icon.ImageButton.MouseButton1Click:Connect(function()
			
			script.Parent.Events.InputSwapAbility:Fire(i, 0)
			
		end)
		
	end
	
	icons = script.Parent.IconUIs:GetChildren()
	table.remove(icons, 1)
	
	--for i,v in pairs(icons) do
	--	print(i)
	--	v:FindFirstChild("ImageLabel").Image = Abilities[i].Icon

	--end

	
end

function SetLocalCooldowns(localCooldowns)
	
	cooldowns = localCooldowns
	
end

InitializeIcons()

rs.RenderStepped:Connect(function(dt)
	
	for i,v in pairs(Abilities) do
		
		if cooldowns[i] <= 0 then
			
			cooldowns[i] = 0
			
		elseif cooldowns[i] > 0 then
			
			cooldowns[i] -= dt
			
		end
		
		icons[i]:FindFirstChild("CooldownFrame").Size = UDim2.new(1, 0, cooldowns[i] / Abilities[i].Cooldown, 0)

	end
	
end)

function UpdateAbilities(abilities)
	
	Abilities = abilities
	InitializeIcons()
	
end

remotes.RemoteEvents.UpdateAbilities.OnClientEvent:Connect(UpdateAbilities)

remotes.RemoteEvents.UpdateCooldownIcons.OnClientEvent:Connect(SetLocalCooldowns)
