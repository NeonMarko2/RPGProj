
--local Characters = game.Workspace.Scripts.Scripts.DataStore.ReturnCharacter:InvokeServer()


function CharacterLoaded()
	
	game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom

	for i,v in pairs(game.Players.LocalPlayer:GetDescendants()) do

		if v.Name == "CharacterSelectUI" then

			v.Enabled = false

		elseif v.Name == "Chooser" then

			v.Enabled = false

		elseif v.Name == "Creator" then

			v.Enabled = false
			
		elseif v.Name == "Loading" then

			v.Enabled = false

		elseif v.Name == "AbilitiesUI" then

			v.Enabled = true

		elseif v.Name == "ProfileUI" then

			v.Enabled = true

		elseif v.Name == "StatusEffects" then

			v.Enabled = true

		elseif v.Name == "ChannelingUI" then

			v.Enabled = true

		end

	end
	
end





game.ReplicatedStorage.Remotes.RemoteEvents.DataStore.CharacterLoaded.OnClientEvent:Connect(CharacterLoaded)
