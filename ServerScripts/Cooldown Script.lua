
local RS = game:GetService("RunService")

local remotes = game.ReplicatedStorage.Remotes
local AB = require(script.Parent.ModuleScripts.AbilityBase)

local PlayersCooldowns = {}

function AddPlayerCooldowns(player)
	
	local CooldownsData = table.create(8, 1)
	
	PlayersCooldowns[player] = CooldownsData
	
end

function RemovePlayerCooldowns(player)
	
	PlayersCooldowns[player] = nil
	
end

function ReturnCooldowns(player)
	
	return PlayersCooldowns[player]

end

function AssignCooldown(player, index)
	
	local Abilities = AB:ReturnAbilities()
	local playersAbilities = AB:ReturnPlayerAbilities(player)
	
	local thisplayercooldowns = ReturnCooldowns(player)
	
	thisplayercooldowns[index] = playersAbilities[index].Cooldown
	
	remotes.RemoteEvents.UpdateCooldownIcons:FireClient(player, thisplayercooldowns)
	
end

function RefreshCooldowns(dt)
	
	for i,v in pairs(PlayersCooldowns) do
		
		local cooldowns = PlayersCooldowns[i]
		
		for k,l in pairs(cooldowns) do

			if cooldowns[k] <= 0 then
				
				cooldowns[k] = 0
				
			elseif cooldowns[k] > 0 then

				cooldowns[k] -= dt
	
			end
			
		end
			
	end
	
end

--for k,l in pairs(PlayersCooldowns[i]) do

--	if PlayersCooldowns[i][k] <= 0 then

	--	PlayersCooldowns[i][k] = 0

	--elseif PlayersCooldowns[i][k] > 0 then

	--	PlayersCooldowns[i][k] -= dt

	--end

--end

RS.Heartbeat:Connect(RefreshCooldowns)

game.Players.PlayerAdded:Connect(AddPlayerCooldowns)
game.Players.PlayerRemoving:Connect(RemovePlayerCooldowns)
--game.Workspace.poopie.OnServerEvent:Connect(function()
--	print("f")
--	print(PlayersCooldowns)
	
--end)

script["Assign Cooldown"].Event:Connect(AssignCooldown)

script.ReturnServerCooldowns.OnInvoke = ReturnCooldowns

game.ReplicatedStorage.Remotes.RemoteFunctions.ReturnCooldowns.OnServerInvoke = ReturnCooldowns
