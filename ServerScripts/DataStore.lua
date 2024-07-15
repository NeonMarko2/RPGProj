
local DataStore = game:GetService("DataStoreService")

local PlayersCharacters = DataStore:GetDataStore("PlayerCharacters")

local DataToStore = {

	["Name"] = nil,
	["Class"] = nil,
	["Race"] = nil

}

function CreateCharacter(player, class, race, name)
	
	local success, oldData = pcall(function()
		return PlayersCharacters:GetAsync(player)
	end)
	
	success = pcall(function()
		print("baby oh boy")
		PlayersCharacters:SetAsync(player, 0)

	end)
	
	if success then
		
		local CharacterId = 0
		
		if oldData == nil or oldData == 0 then
			
			local data = table.create(5, 0)
			
			DataToStore.Name = name
			DataToStore.Race = race
			DataToStore.Class = class

			data[1] = DataToStore
			
			success = pcall(function()
				return PlayersCharacters:SetAsync(player, data)
			end)
			print(success)
			print(data)
			
			CharacterId = 1
			
		elseif oldData ~= nil then
			
			for i,v in pairs(oldData) do
				
				if v == 0 then
					
					DataToStore.Name = name
					DataToStore.Race = race
					DataToStore.Class = class
					
					CharacterId = i
					oldData[i] = DataToStore
					break
					
				end
				
			end
			
			success = pcall(function()
				return PlayersCharacters:SetAsync(player, oldData)
			end)
			print(success)
			print(oldData)
			
		end
		
		script.Parent.LoadCharacterScript.Event:Fire(player, CharacterId)
		
	end
	
end



function ReturnCharacters(player)
	
	local Characters = PlayersCharacters:GetAsync(player)
	
	return Characters
	
end



function DeleteCharacter(player, index)
	
	local success, oldData = pcall(function()
		return PlayersCharacters:GetAsync(player)
	end)
	
	success = pcall(function()
		
		oldData[index] = 0
		
		PlayersCharacters:SetAsync(player, oldData)

	end)
	
	if success then
		
		game.ReplicatedStorage.Remotes.RemoteEvents.UpdateCharacterItems:FireClient(player)
		
	end	
	
end


game.ReplicatedStorage.Remotes.DeleteCharacters.OnServerEvent:Connect(function(player)
	
	local success, oldData = pcall(function()
		return PlayersCharacters:GetAsync(player)
	end)

	success = pcall(function()
		print("baby oh boy")
		PlayersCharacters:SetAsync(player, 0)

	end)
	
end)

game.ReplicatedStorage.Remotes.RemoteFunctions.ReturnCharacter.OnServerInvoke = ReturnCharacters

game.ReplicatedStorage.Remotes.RemoteEvents.DataStore.CreateCharacter.OnServerEvent:Connect(CreateCharacter)

game.ReplicatedStorage.Remotes.RemoteEvents.DataStore.DeleteCharacter.OnServerEvent:Connect(DeleteCharacter)
