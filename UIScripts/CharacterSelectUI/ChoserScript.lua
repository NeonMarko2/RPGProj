
local RaceDataBase = game.ReplicatedStorage.Remotes.RemoteFunctions.ReturnRaces:InvokeServer()

local CreateCharacterButton = script.Parent.CreateCharacter
local CharacterChanger = game.Workspace.CharacterChanger
local DeleteButton = script.Parent.DeleteButton
local NextButton = script.Parent.NextButton

local remotes = game.ReplicatedStorage.Remotes
local CurrentCharacter = nil



function ClearCharacterItems()

	for i,v in pairs(script.Parent.Frame:GetChildren()) do

		if v.ClassName == "TextButton" then

			v:Destroy()

		end

	end

end

function DrawCharacterItems()
	
	ClearCharacterItems()
	
	local Characters = remotes.RemoteFunctions.ReturnCharacter:InvokeServer()
	
	if Characters ~= nil and Characters ~= 0 then

		for i,v in pairs(Characters) do

			if v ~= 0 then

				local characterButton = game.ReplicatedStorage.CharacterCreator.TextButton:Clone()
				characterButton.Parent = script.Parent.Frame
				characterButton.Text = v.Name.. "\n" ..v.Class.. "\n" ..v.Race

				characterButton.Activated:Connect(function()

					CurrentCharacter = i

					for _,k in pairs(CharacterChanger:GetChildren()) do

						if k.ClassName == "Part" or k.ClassName == "MeshPart" then

							print(RaceDataBase[v.Race])
							k.Color = RaceDataBase[v.Race].SkinColor

						end

					end

				end)


			end

		end

	end
	
end


DrawCharacterItems()


DeleteButton.Activated:Connect(function()

	script.Parent.Parent.ConfirmationWindow.Enabled = true
	script.Parent.Parent.ConfirmationWindow:SetAttribute("Mode", "Delete")

end)

NextButton.Activated:Connect(function()

	script.Parent.Parent.ConfirmationWindow.Enabled = true
	script.Parent.Parent.ConfirmationWindow:SetAttribute("Mode", "Choose")

end)

CreateCharacterButton.Activated:Connect(function()
	
	script.Parent.Parent.Creator.Enabled = true
	script.Parent.Parent.Chooser.Enabled = false
	
end)

script.Parent.Parent.ConfirmationWindow.Frame.Yes.Activated:Connect(function()
	
	if script.Parent.Parent.ConfirmationWindow:GetAttribute("Mode") == "Choose" then
		
		script.Parent.Enabled = false

		script.Parent.Parent.Loading.Enabled = true

		script.Parent.Parent.ConfirmationWindow.Enabled = false

		remotes.RemoteEvents.DataStore.LoadCharacter:FireServer(CurrentCharacter)
		
	elseif script.Parent.Parent.ConfirmationWindow:GetAttribute("Mode") == "Delete" then
		
		script.Parent.Parent.ConfirmationWindow.Enabled = false
		remotes.RemoteEvents.DataStore.DeleteCharacter:FireServer(CurrentCharacter)
		
	end
	
end)

script.Parent.Parent.ConfirmationWindow.Frame.No.Activated:Connect(function()
	
	if script.Parent.Parent.ConfirmationWindow:GetAttribute("Mode") == "Choose" then
		script.Parent.Parent.ConfirmationWindow.Enabled = false
		
	elseif script.Parent.Parent.ConfirmationWindow:GetAttribute("Mode") == "Delete" then
		script.Parent.Parent.ConfirmationWindow.Enabled = false
	end
	
end)

remotes.RemoteEvents.UpdateCharacterItems.OnClientEvent:Connect(DrawCharacterItems)
