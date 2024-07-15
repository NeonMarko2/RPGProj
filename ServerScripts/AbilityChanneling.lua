
local RunService = game:GetService("RunService")

local CurrentChanneling = {} -- should be character models, not players

function AddToChanneling(CharacterModel, Ability, ChannelAmount, Target)
	
	CurrentChanneling[CharacterModel] = {Ability, ChannelAmount, Target}
	
	print(CurrentChanneling)
	
	if game.Players:GetPlayerFromCharacter(CharacterModel) ~= nil then
		
		game.ReplicatedStorage.Remotes.RemoteEvents.UpdateChanneling:FireClient(game.Players:GetPlayerFromCharacter(CharacterModel), ChannelAmount)
		
	end
	
end

function ProgressChannels(DeltaTime)
	
	for i,v in pairs(CurrentChanneling) do
		
		CurrentChanneling[i][2] -= DeltaTime
		
		if CurrentChanneling[i][2] <= 0 then
			
			script.ChannelFinished:Fire(i, CurrentChanneling[i][1], CurrentChanneling[i][3])
			CurrentChanneling[i] = nil
			
		end
		
	end
	
end

function IsChanneling(character)
	
	if CurrentChanneling[character] then
		
		return true
		
	else
		
		return false
		
	end
	
end

function RemoveChannel(character)
	
	CurrentChanneling[character] = nil
	
end

RunService.Heartbeat:Connect(ProgressChannels)

script.StartChannel.Event:Connect(AddToChanneling)

script.RemoveChannel.Event:Connect(RemoveChannel)

script.IsCharacterChanneling.OnInvoke = IsChanneling
