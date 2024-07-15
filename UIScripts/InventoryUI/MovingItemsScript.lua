
local remotes = game.ReplicatedStorage.Remotes
local Inventory = remotes.RemoteFunctions.ReturnInventory:InvokeServer()
local EventMoveItem = script.Parent.EventMoveItem
local ItemToSwap = nil
local ItemToSwapPack = nil



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

function CanSwap(index, pack)
	
	local reason
	
	if pack == 1 then
		
		if Inventory[pack].Contents[index].Name == "None" then
			return true
		end
		
		if pack == 1 and ItemToSwapPack == 1 then
			return true
		end
		
		if HasTag(ItemToSwap, ItemToSwapPack, "Weapon") and HasTag(index, pack, "Weapon") then
			return true
		else
			reason = "You can only put Weapons into this slot!"
		end
		
		if HasTag(ItemToSwap, ItemToSwapPack, "Armor") and HasTag(index, pack, "Armor") then
			return true
		else
			reason = "You can only put Armomr into this slot!"
		end
		
		return false, reason
		
	end
	
	if HasTag(ItemToSwap, ItemToSwapPack, "Weapon") or HasTag(ItemToSwap, ItemToSwapPack, "Armor") then
		
		local frameCheck = script.Parent.InventoryUI.Equipment:FindFirstChild(index)
		
		if index == frameCheck.Name and HasTag(ItemToSwap, ItemToSwapPack, index) then
			
			return true
			
		else
			
			reason = "Not the right spot"
			
		end
		
	else
		
		reason = "This isnt an equippable item!"
		
	end
	
	
	return false, reason
	
end

function ActivateMoveItem(transparency, image)

	script.Parent.SelectedItem.ImageTransparency = transparency
	script.Parent.SelectedItem.Image = image

end

function ItemSwapInput(index, pack)
	
	script.Parent.DisableItemShowcase:Fire()
	script.Parent.ResetActiveFrame:Fire()
	
	if ItemToSwap == nil and Inventory[pack].Contents[index].Name ~= "None" then
		
		--print(i)
		
		--print("choose another one to swap")
		
		ItemToSwap = index
		ItemToSwapPack = pack
		
		ActivateMoveItem(0, Inventory[pack].Contents[index].Icon)

	elseif ItemToSwap ~= nil then
		
		local canswap, reason = CanSwap(index, pack)
		
		--print("should have swapped")
		
		if canswap then
		
			remotes.RemoteEvents.InventoryServer.SwapItems:FireServer(ItemToSwap, ItemToSwapPack, index, pack)
			script.Parent.ResetActiveFrame:Fire()
			
			
		else
			
			print("Cant Swap!")
			game.ReplicatedStorage.Bindables.PopUpText:Fire(reason, 2, Color3.new(0.635294, 0.262745, 0), 25)
			
		end
			
		ItemToSwap = nil
		ItemToSwapPack = nil
		
		ActivateMoveItem(1, "")
	elseif ItemToSwap == nil and Inventory[pack].Contents[index].Name == "None" then
		
		print("No item")
		
	end
	
end

EventMoveItem.Event:Connect(ItemSwapInput)
remotes.RemoteEvents.UpdateInventory.OnClientEvent:Connect(UpdateInventory)
