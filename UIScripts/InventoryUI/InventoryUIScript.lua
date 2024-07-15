
local uis = game:GetService("UserInputService")

local Backpack = script.Parent.InventoryUI.Backpack

local remotes = game.ReplicatedStorage.Remotes

local Inventory = remotes.RemoteFunctions.ReturnInventory:InvokeServer()
local ItemDatabase = remotes.RemoteFunctions.ReturnItemList:InvokeServer()

local ItemButton = game.ReplicatedStorage.Inventory.ItemButton

local rs = game:GetService("RunService")



local Camera = Instance.new("Camera")
Camera.Name = "Viewport Camera"
Camera.Parent = Backpack.Parent.CharacterPortrait

function CloseInventory()

	script.Parent.Enabled = false
	
end

function ActivateItem(index, pack)
	
	local ItemShowcase = script.Parent.ItemShowcase
	local MousePosition = uis:GetMouseLocation()
	
	for i,v in pairs (ItemShowcase.List:GetChildren()) do
		
		if v.ClassName == "TextButton" then
			
			v:Destroy()
			
		end
		
	end
	
	ItemShowcase.Visible = true

	ItemShowcase.Position = UDim2.new(0, MousePosition.X, 0, MousePosition.Y - 36)
	
	local button = ItemButton:Clone()
	button.Parent = ItemShowcase.List
	button.Text = "Drop Item"

	ItemShowcase.ItemName.Text = Inventory[pack].Contents[index].Name
	ItemShowcase.TextBlock.Text = Inventory[pack].Contents[index].Description
	
end

function HasTag(tag, item)
	
	local tags = ItemDatabase:ReturnCategories()
	
	for i,v in pairs(item.Tags) do
		
		--if
		
	end
	
end

function InitializeInventory()
	
	for i,v in pairs(Backpack:GetChildren()) do
		
		if v.ClassName == "Frame" then
			
			v:Destroy()
			
		end
		
	end
	
	script.Parent.InitializeSlots:Fire()
	
end


function OpenInventory()

	script.Parent.Enabled = true
	
	InitializeInventory()
	
end

function UpdateInventory()
	
	Inventory = remotes.RemoteFunctions.ReturnInventory:InvokeServer()
	InitializeInventory()
	
end

uis.InputBegan:Connect(function(input)

	if input.KeyCode == Enum.KeyCode.C then

		if script.Parent.Enabled == true then

			CloseInventory()
			
		else

			OpenInventory()
			
		end
		
	elseif input.KeyCode == Enum.KeyCode.F then
		
		remotes.RemoteEvents.InventoryServer.AddItem:FireServer("kuk")
		remotes.RemoteEvents.InventoryServer.AddItem:FireServer("Helm")
		remotes.RemoteEvents.InventoryServer.AddItem:FireServer("ChestPlate")
		remotes.RemoteEvents.InventoryServer.AddItem:FireServer("Leggings")
		
	end
	
end)

function DrawViewportFrame()
	
	Backpack.Parent.CharacterPortrait:ClearAllChildren()
	
	local character = game.Players.LocalPlayer.Character
	character.Archivable = true
	
	local CharacterClone = character:Clone()

	for i,v in pairs(CharacterClone:GetChildren()) do

		if v.ClassName == "LocalScript" then

			v:Destroy()

		end

	end
	
	Backpack.Parent.CharacterPortrait.CurrentCamera = Camera
	CharacterClone.Parent = Backpack.Parent.CharacterPortrait
	
	Camera.CFrame = CFrame.new(CharacterClone.HumanoidRootPart.Position + CharacterClone.HumanoidRootPart.CFrame.LookVector * 7, CharacterClone.HumanoidRootPart.Position)

end

rs.RenderStepped:Connect(function()
	
	local mousePosition = uis:GetMouseLocation()
	
	--if script.Parent.Enabled == true then
	
	--	DrawViewportFrame()
		
	--end
		
	script.Parent.SelectedItem.Position = UDim2.new(0, mousePosition.X, 0, mousePosition.Y - 36)	
	
end)

remotes.RemoteEvents.UpdateInventory.OnClientEvent:Connect(UpdateInventory)
