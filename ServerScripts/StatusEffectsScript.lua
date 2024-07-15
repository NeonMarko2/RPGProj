
local StatusEffectsSystem = require(script.Parent.ModuleScripts.StatusEffectsSystem)
local RunService = game:GetService("RunService")


game.ReplicatedStorage.Remotes.RemoteFunctions.ReturnStatusEffects.OnServerInvoke = function(player)
	
	return StatusEffectsSystem:ReturnPlayersStatusEffects(player)
	
end

script.AddStatusEffect.Event:Connect(function(player, statuseffect, duration)
	
	local isPlayer = false
	
	if player.ClassName == "Model" then
		
		if game.Players:GetPlayerFromCharacter(player) then
			
			isPlayer = true
			player = game.Players:GetPlayerFromCharacter(player)
			
		end
		
	end

	StatusEffectsSystem:AddStatusEffect(player, statuseffect, duration)
	
	if isPlayer then
		
		game.ReplicatedStorage.Remotes.RemoteEvents.UpdateStatusEffects:FireClient(player, StatusEffectsSystem:ReturnPlayersStatusEffects(player))
		
	end
	
end)

RunService.Heartbeat:Connect(function(DeltaTime)
	
	local AllActiveStatusEffects = StatusEffectsSystem:ReturnAllActiveStatusEffects()
	
	--print(AllActiveStatusEffects)
	
	for i,_ in pairs(AllActiveStatusEffects) do

		for j,_ in pairs(AllActiveStatusEffects[i]) do
			--print(AllActiveStatusEffects[i][j])
			if AllActiveStatusEffects[i][j][2] > 0 then
				
				AllActiveStatusEffects[i][j][2] -= DeltaTime
				
			else
				
				AllActiveStatusEffects[i][j][1]:onEnded()
				
				table.remove(AllActiveStatusEffects[i], j)
				
			end
			
		end
		
	end

end)
