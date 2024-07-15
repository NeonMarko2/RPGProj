
local InventoryBase = require(script.Parent.ModuleScripts.InventoryBase)
local itemDatabase = require(script.Parent.ModuleScripts.ItemDatabase)

local serverChecks = script.ServerChecks

local Remotes = game.ReplicatedStorage.Remotes



Remotes.RemoteEvents.InventoryServer.SwapItems.OnServerEvent:Connect(function(player, index1, pack1, index2, pack2)
	
	if serverChecks.CanSwapCheck:Invoke(player, index1, pack1, index2, pack2) then
		
		InventoryBase:SwapItem(player, index1, pack1, index2, pack2)
		Remotes.RemoteEvents.UpdateInventory:FireClient(player)
	
	end
	
end)

Remotes.RemoteFunctions.ReturnInventory.OnServerInvoke = function(player)
	return InventoryBase:ReturnInventory(player)
end

Remotes.RemoteEvents.InventoryServer.AddItem.OnServerEvent:Connect(function(player, item)
	
	InventoryBase:AddItem(player, itemDatabase:ReturnItems()[item])
	Remotes.RemoteEvents.UpdateInventory:FireClient(player)
	
end)

Remotes.RemoteEvents.InventoryServer.DropItem.OnServerEvent:Connect(function(player, index, pack)
	
	InventoryBase:DropItem(player, index, pack)
	Remotes.RemoteEvents.UpdateInventory:FireClient(player)
	
end)

Remotes.RemoteEvents.InventoryServer.EquipItem.OnServerEvent:Connect(function(player, index)
	
	local EquipPlace = serverChecks.LocateEquipSlot:Invoke(player, index)
	
	InventoryBase:DequipItem(player, index, EquipPlace)
	InventoryBase:EquipItem(player, index, EquipPlace)
	Remotes.RemoteEvents.UpdateInventory:FireClient(player)
	
end)

Remotes.RemoteEvents.InventoryServer.DequipItem.OnServerEvent:Connect(function(player, index, equipslot)
	
	InventoryBase:DequipItem(player, index, equipslot)
	Remotes.RemoteEvents.UpdateInventory:FireClient(player)
	
end)

Remotes.RemoteFunctions.ReturnItemList.OnServerInvoke = function()
	
	return itemDatabase:ReturnItems()
	
end
