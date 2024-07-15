
local abilitybase = require(script.Parent.ModuleScripts.AbilityBase)
local ClassDatabase = require(script.Parent.ModuleScripts.ClassDataBase)
local remotes = game.ReplicatedStorage.Remotes
local abilities = abilitybase:ReturnAbilities()
local AbilityChanneling = script.Parent.AbilityChanneling


function IsWithinDistance(player, target, range)
	
	local bool = false
	
	local distance = (player.Character:FindFirstChild("HumanoidRootPart").Position - target:FindFirstChild("HumanoidRootPart").Position).magnitude
	
	if distance < range then
		
		bool = true
		
	end
	
	return bool

end

function ActivatePlayerAbility(player, target, index)
	
	print("RemoteActivation")
	
	local playersAbilities = abilitybase:ReturnPlayerAbilities(player)
	
	local AbilityUsed = abilities[playersAbilities[index].Name]
	
	local cooldowns = game.ServerScriptService["Cooldown Script"].ReturnServerCooldowns:Invoke(player)
	--local isCloseEnough = IsWithinDistance(player, target, abilities[playersAbilities[index].Name].Range)
	
	if cooldowns[index] > 0 then return end
		
	if AbilityUsed.NeedTarget == true and target:FindFirstChild("Tags") and target:FindFirstChild("Tags"):FindFirstChild("UnTargetable") then
		return	
	end
	
	game.ServerScriptService["Cooldown Script"]["Assign Cooldown"]:Fire(player, index)
	
	ActivateAbility(player.Character, AbilityUsed, target)
	
end

function ActivateAbility(User, Ability, Target)
	
	if AbilityChanneling.IsCharacterChanneling:Invoke(User) then
		
		AbilityChanneling.RemoveChannel:Fire(User)
		
	end
	
	if Ability.NeedTarget == true and Target:FindFirstChild("Tags") and Target:FindFirstChild("Tags"):FindFirstChild("UnTargetable") then
		return	
	end
	
	if Ability.ChannelAmount > 0 then

		print("this ability needs to be channeled")
		script.Parent.AbilityChanneling.StartChannel:Fire(
			User, 
			Ability, 
			Ability.ChannelAmount,
			Target
		)

	else

		Ability:Activate(User, Target)

	end
	
end


function ActivateAbilityAfterChannel(User, Ability, Target)
	
	if Ability.NeedTarget == true and Target:FindFirstChild("Tags") and Target:FindFirstChild("Tags"):FindFirstChild("UnTargetable") then
		return	
	end
	
	abilities[Ability.Name]:Activate(User, Target)
	
end

function AssignAbility(player, index, abilityIndex)

	if abilityIndex == -1 then
		
		abilitybase:AsignAbility(player, index, abilitybase:ReturnAbilities().None)
		remotes.RemoteEvents.UpdateAbilities:FireClient(player, abilitybase:ReturnPlayerAbilities(player))
		return
		
	end
	
	local Ability = ClassDatabase[player.Character.Stats.Class.Value].Abilities[abilityIndex].Ability
	--print(Ability)
	
	if player.Character.Stats.Level.Value >= ClassDatabase[player.Character.Stats.Class.Value].Abilities[abilityIndex].LevelUnlock then
		
		abilitybase:AsignAbility(player, index, Ability)
		remotes.RemoteEvents.UpdateAbilities:FireClient(player, abilitybase:ReturnPlayerAbilities(player))
		
	else
		
		print("Not high enough level")
		
	end
		
end

function ReturnPlayerAbilities(player)
	
	return abilitybase:ReturnPlayerAbilities(player)
	
end

function ReturnAbilityList(player)
	
	return abilitybase:ReturnAbilities()
	
end

remotes.RemoteEvents.AbilityRemote.Activate.OnServerEvent:Connect(ActivatePlayerAbility)

remotes.RemoteEvents.AbilityRemote.Assign.OnServerEvent:Connect(AssignAbility)

script.Parent.AbilityChanneling.ChannelFinished.Event:Connect(ActivateAbilityAfterChannel)

script.ActivateAbility.Event:Connect(ActivateAbility)

remotes.RemoteFunctions.ReturnPlayerAbilities.OnServerInvoke = ReturnPlayerAbilities

remotes.RemoteFunctions.ReturnAbilityList.OnServerInvoke = ReturnAbilityList
