
local ClassDataBase = game.ReplicatedStorage.Remotes.RemoteFunctions.ReturnClasses:InvokeServer()

local RaceDataBase = game.ReplicatedStorage.Remotes.RemoteFunctions.ReturnRaces:InvokeServer()

local CharacterChanger = game.Workspace.CharacterChanger

local ClassButtons = script.Parent.Classes:GetChildren()
local RaceButtons = script.Parent.Races:GetChildren()
table.remove(ClassButtons, 1)
table.remove(RaceButtons, 1)

local DataToStore = {
	
	["Name"] = nil,
	["Class"] = nil,
	["Race"] = nil
	
}

function Printall()
	
	print(tostring(DataToStore["Class"]) .." ".. tostring(DataToStore["Race"]) .." ".. tostring(DataToStore["Name"]))
	
end

function ReturnToCharacterSelect()

	script.Parent.Enabled = false

	script.Parent.Parent.Chooser.Enabled = true

end

function OpenConfirmationWindow()

	script.Parent.Parent.ConfirmationWindow.Enabled = true
	script.Parent.Parent.ConfirmationWindow:SetAttribute("Mode", "Create")

end

function CreateCharacter()
	
	DataToStore.Name = script.Parent.NameBox.text
	
	script.Parent.Enabled = false

	script.Parent.Parent.Loading.Enabled = true
	
	script.Parent.Parent.ConfirmationWindow.Enabled = false
	
	print(DataToStore)
	
	game.ReplicatedStorage.Remotes.RemoteEvents.DataStore.CreateCharacter:FireServer(DataToStore["Class"], DataToStore["Race"], DataToStore["Name"])

end


--/////// Classes

for i,v in pairs(ClassButtons) do
	print(2)
	v.Image = ClassDataBase[v:GetAttribute("ClassName")].Icon
	
	v.Activated:Connect(function()
		print(ClassDataBase[v:GetAttribute("ClassName")])
		DataToStore["Class"] = v:GetAttribute("ClassName")
		Printall()
		
	end)
	
end

--/////// Classes

--/////// Races

for i,v in pairs(RaceButtons) do
	print(2)
	v.Image = RaceDataBase[v:GetAttribute("RaceName")].Icon
	
	v.Activated:Connect(function()
		print(RaceDataBase[v:GetAttribute("RaceName")])
		DataToStore["Race"] = v:GetAttribute("RaceName")
		
		for _,k in pairs(CharacterChanger:GetChildren()) do
			
			if k.ClassName == "Part" or k.ClassName == "MeshPart" then
				
				print(RaceDataBase[v:GetAttribute("RaceName")])
				k.Color = RaceDataBase[v:GetAttribute("RaceName")].SkinColor
				
			end
			
		end
		
		Printall()
		
	end)
	
end

--/////// Races

script.Parent.Parent.ConfirmationWindow.Frame.No.Activated:Connect(function()
	if script.Parent.Parent.ConfirmationWindow:GetAttribute("Mode") == "Create" then
		script.Parent.Parent.ConfirmationWindow.Enabled = false 
	end
end)

script.Parent.Parent.ConfirmationWindow.Frame.Yes.Activated:Connect(function()
	if script.Parent.Parent.ConfirmationWindow:GetAttribute("Mode") == "Create" then
		CreateCharacter()
	end
end)

script.Parent.Return.Activated:Connect(ReturnToCharacterSelect)

script.Parent.Next.Activated:Connect(function()
	
	OpenConfirmationWindow()
	
end)

