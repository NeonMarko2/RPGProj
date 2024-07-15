
local uis = game:GetService("UserInputService")

local ItemButton = game.ReplicatedStorage.Inventory.ItemButton

local remotes = game.ReplicatedStorage.Remotes
local ItemDatabase = remotes.RemoteFunctions.ReturnItemList:InvokeServer()
local Inventory = remotes.RemoteFunctions.ReturnInventory:InvokeServer()



function UpdateInventory()

	Inventory = remotes.RemoteFunctions.ReturnInventory:InvokeServer()

end

function HasTag(index, pack, tag)
	
	local tags = Inventory[pack].Contents[index].Tags
	
	for i,v in pairs(tags) do
		
		if v == tag then
					
			return true
					
		end
		
	end
	
	return false
	
end

function EquipGear(index)
	
	--local equipindex = ""
	
	--if HasTag(index, 1, "Weapon") then
		
	--	equipindex = "Weapon"
		
	--elseif HasTag(index, 1, "Head") then
		
	--	equipindex = "Head"
		
	--elseif HasTag(index, 1, "Chest") then

	--	equipindex = "Chest"
		
	--elseif HasTag(index, 1, "Leggings") then

	--	equipindex = "Leggings"
		
	--end
	
	remotes.RemoteEvents.InventoryServer.EquipItem:FireServer(index)
	
end

function DequipGear(index, equipslot)
	
	remotes.RemoteEvents.InventoryServer.DequipItem:FireServer(index, equipslot)
	
end

function DisableItemShowcase()
	
	script.Parent.ItemShowcase.Visible = false
	
end

function ActivateItemShowcase(index, pack)
	
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
	
	button.Activated:Connect(function()
		
		remotes.RemoteEvents.InventoryServer.DropItem:FireServer(index, pack)
		DisableItemShowcase()
		
		
	end)
	
	ItemShowcase.ItemName.Text = Inventory[pack].Contents[index].Name
	ItemShowcase.TextBlock.Text = Inventory[pack].Contents[index].Description	

	if HasTag(index, pack, "Weapon") or HasTag(index, pack, "Armor") then
		
		local OptionsButton = ItemButton:Clone()
		OptionsButton.Parent = ItemShowcase.List
		
		if pack == 2 then
			
			OptionsButton.Text = "Dequip"
			OptionsButton.Activated:Connect(function()
				
				print(index)
				DequipGear(index, index)
				DisableItemShowcase()
				
			end)
			
		else
			
			OptionsButton.Text = "Equip"
			OptionsButton.Activated:Connect(function()

				EquipGear(index)
				DisableItemShowcase()

			end)
			
		end
			
	end
	
end

script.Parent.ActivateItem.Event:Connect(ActivateItemShowcase)
remotes.RemoteEvents.UpdateInventory.OnClientEvent:Connect(UpdateInventory)
script.Parent.DisableItemShowcase.Event:Connect(DisableItemShowcase)
