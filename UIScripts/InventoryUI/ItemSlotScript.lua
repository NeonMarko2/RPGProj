
local remotes = game.ReplicatedStorage.Remotes
local Inventory = remotes.RemoteFunctions.ReturnInventory:InvokeServer()
local ItemDatabase = remotes.RemoteFunctions.ReturnItemList:InvokeServer()

local ActivateItem = script.Parent.ActivateItem
local EventMoveItem = script.Parent.EventMoveItem
local Backpack = script.Parent.InventoryUI.Backpack
local Equipment = script.Parent.InventoryUI.Equipment

local ItemSlot = game.ReplicatedStorage.Inventory.ItemSLot



function UpdateInventory()

	Inventory = remotes.RemoteFunctions.ReturnInventory:InvokeServer()

end

function ResetActiveFrame()

	for i,v in pairs(script.Parent.InventoryUI.Backpack:GetChildren()) do

		if v.ClassName == "Frame" then

			v.Active = false

		end

	end
	
	for i,v in pairs(script.Parent.InventoryUI.Equipment:GetChildren()) do
		
		v.Active = false
		
	end

end

function InitializeSlots()
	
	for i,v in pairs(Inventory[1].Contents) do

		local itemslot = ItemSlot:Clone()
		itemslot.Parent = Backpack

		itemslot.ImageButton.Image = v.Icon

		itemslot.ImageButton.MouseButton2Click:Connect(function()

			if Inventory[1].Contents[i].Name == "None" then
				
				ResetActiveFrame()
				script.Parent.ItemShowcase.Visible = false
				
			else
				
				if itemslot.Active then

					script.Parent.ItemShowcase.Visible = false
					itemslot.Active = false

				else

					ResetActiveFrame()
					ActivateItem:Fire(i, 1)
					itemslot.Active = true

				end
				
			end

		end)

		itemslot.ImageButton.Activated:Connect(function()
			
			--print(script.Parent.ActivateMoveItem)
			EventMoveItem:Fire(i, 1)
			--script.Parent.ActivateMoveItem:Fire()
			--ActivateMoveItem:Fire(i, 1)
			
		end)

	end

	for i,v in pairs(Equipment:GetChildren()) do
		
		local equipmentslotClone = v:Clone()
		equipmentslotClone.Parent = v.Parent
		
		v:Destroy()
		equipmentslotClone.ImageButton.Image = Inventory[2].Contents[equipmentslotClone.Name].Icon
		
		equipmentslotClone.ImageButton.MouseButton2Click:Connect(function()
			
			if Inventory[2].Contents[equipmentslotClone.Name].Name == "None" then
				
				ResetActiveFrame()
				script.Parent.ItemShowcase.Visible = false				
				
			else
				
				if(equipmentslotClone.Active) then

					script.Parent.ItemShowcase.Visible = false
					equipmentslotClone.Active = false
					
				else
					
					ResetActiveFrame()
					ActivateItem:Fire(equipmentslotClone.Name, 2)
					--ResetActiveFrame()
					equipmentslotClone.Active = true

				end
				
			end

		end)
		
		equipmentslotClone.ImageButton.Activated:Connect(function()
			
			EventMoveItem:Fire(equipmentslotClone.Name, 2)
			
		end)
		
	end
	
end

script.Parent.ResetActiveFrame.Event:Connect(ResetActiveFrame)
script.Parent.InitializeSlots.Event:Connect(InitializeSlots)
remotes.RemoteEvents.UpdateInventory.OnClientEvent:Connect(UpdateInventory)
