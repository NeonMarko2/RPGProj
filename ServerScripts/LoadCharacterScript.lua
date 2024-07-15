
local RaceDataBase = require(script.Parent.ModuleScripts.RaceDataBase)
local DataStore = game:GetService("DataStoreService")
local PlayersCharacters = DataStore:GetDataStore("PlayerCharacters")
local abilitybase = require(script.Parent.ModuleScripts.AbilityBase)
local Abilities = abilitybase:ReturnAbilities()

function LoadCharacter(player, characterId)
	print(2)
	local Characters = PlayersCharacters:GetAsync(player)
	for _,k in pairs(player.Character:GetChildren()) do

		if k.ClassName == "Part" or k.ClassName == "MeshPart" then
			k.Color = RaceDataBase[Characters[characterId]["Race"]].SkinColor

		end

	end
	
	player.Character.Stats:FindFirstChild("Class").Value = Characters[characterId]["Class"]
	player.Character.Stats:FindFirstChild("Race").Value = Characters[characterId]["Race"]
	
	for i=1, 8, 1 do
		
		abilitybase:AsignAbility(player, i, Abilities.None)
		
	end
	
	abilitybase:AsignAbility(player, 3, Abilities.Attack)
	
	game.ReplicatedStorage.Remotes.RemoteEvents.UpdateInventory:FireClient(player)
	game.ReplicatedStorage.Remotes.RemoteEvents.UpdateAbilities:FireClient(player, abilitybase:ReturnPlayerAbilities(player))
	game.ReplicatedStorage.Remotes.RemoteEvents.UpdateCooldownIcons:FireClient(player, script.Parent["Cooldown Script"].ReturnServerCooldowns:Invoke(player))
	
	script.Parent.StatsSystem.ApplyCharacterStats:Fire(player.Character)
	
	game.ReplicatedStorage.Remotes.RemoteEvents.UpdateResourceBars:FireClient(player)
	
	game.ReplicatedStorage.Remotes.RemoteEvents.DataStore.CharacterLoaded:FireClient(player)
	
end

script.Event.Event:Connect(LoadCharacter)

game.ReplicatedStorage.Remotes.RemoteEvents.DataStore.LoadCharacter.OnServerEvent:Connect(LoadCharacter)
