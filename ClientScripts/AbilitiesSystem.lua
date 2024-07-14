
local rs = game:GetService("RunService")
local uis = game:GetService("UserInputService")

local remotes = game.ReplicatedStorage.Remotes

local Player:Player? = game.Players.LocalPlayer
local Character = game.Players.LocalPlayer.Character

local ListOfAbilities = remotes.RemoteFunctions.ReturnAbilityList:InvokeServer()

local ChannelCount = 0
local ChannelNeeded = 1.5

Abilities = remotes.RemoteFunctions.ReturnPlayerAbilities:InvokeServer()

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

function ActivateAbility(index)
	
	print(ListOfAbilities)
	
	if Abilities[index].Index == ListOfAbilities.None.Index then return end
	
	local target = script.Parent.SelectionSystem.Target.Value
	
	if target == nil and Abilities[index].NeedTarget == true then 
		
		game.ReplicatedStorage.Bindables.PopUpText:Fire("No one targeted!", 2, Color3.new(0.462745, 0, 0), 25)
		
		return 
			
	end
	
	if Abilities[index] == ListOfAbilities.None then return end
	
	if Abilities[index].NeedTarget == true then
	
		local distance = (Character.HumanoidRootPart.Position - target.HumanoidRootPart.Position).magnitude
		
		if cooldowns[index] <= 0 and distance < Abilities[index].Range then
			
			Player.PlayerGui.ChannelingUI.Bar.Visible = false
			
			remotes.RemoteEvents.AbilityRemote.Activate:FireServer(target, index)
			
		elseif cooldowns[index] > 0 then

			game.ReplicatedStorage.Bindables.PopUpText:Fire("Ability on cooldown!", 2, Color3.new(0.462745, 0, 0), 25)
			
		elseif distance > Abilities[index].Range then
			
			game.ReplicatedStorage.Bindables.PopUpText:Fire("Too far away from Target!", 2, Color3.new(0.462745, 0, 0), 25)
			
		end
		
	else
		
		if cooldowns[index] <= 0 then
			
			Player.PlayerGui.ChannelingUI.Bar.Visible = false
			
			remotes.RemoteEvents.AbilityRemote.Activate:FireServer(target, index)
			
		else
			
			game.ReplicatedStorage.Bindables.PopUpText:Fire("Ability on cooldown!", 2, Color3.new(0.462745, 0, 0), 25)
			
		end
			
	end
		
end

function ReceiveCooldowns(LocalCooldowns)
	
	cooldowns = LocalCooldowns
	
end

uis.InputBegan:Connect(function(key)

	if key.KeyCode == Enum.KeyCode.One then
		
		ActivateAbility(1)
		
	elseif key.KeyCode == Enum.KeyCode.Two then

		ActivateAbility(2)
		
	elseif key.KeyCode == Enum.KeyCode.Three then

		ActivateAbility(3)
		
	elseif key.KeyCode == Enum.KeyCode.Four then

		ActivateAbility(4)
		
	elseif key.KeyCode == Enum.KeyCode.Five then

		ActivateAbility(5)

	end
	
end)

function UpdateAbilities(abilities)
	
	Abilities = abilities
	
end

rs.RenderStepped:Connect(function(dt)
	
	for i,v in pairs(cooldowns) do
		
		if cooldowns[i] <= 0 then
			
			cooldowns[i] = 0
			
		elseif cooldowns[i] > 0 then
			
			cooldowns[i] -= dt
			
		end
		
	end
	
end)

remotes.RemoteEvents.UpdateCooldownIcons.OnClientEvent:Connect(ReceiveCooldowns)
remotes.RemoteEvents.UpdateAbilities.OnClientEvent:Connect(UpdateAbilities)
