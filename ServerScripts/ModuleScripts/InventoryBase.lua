local Inventory = {}

local PlayerInventory = {}

local ItemDatabase = require(script.Parent.ItemDatabase)
local ItemList = ItemDatabase:ReturnItems()

function Inventory:ReturnInventory(player)

	if PlayerInventory[player] == nil then
		print("made")
		local InventoryPack = {Name = "Backpack", Contents = table.create(24, ItemList.none)}

		--local Equipment = table.create(10, ItemList.none)

		local Equipment = {Name = "Equipment", Contents = 
			{
				["Head"] = ItemList.none,
				["Chest"] = ItemList.none,
				["Leggings"] = ItemList.none,
				["Weapon"] = ItemList.none
			}
		}

		--[[ equipments basically broken down to
		
			1-Head
			2-Chest
			3-Belt
			4-Leggings
			5-Feet
			6-Gloves
			7-Accessory:1
			8-Accessory:2
			9-PrimaryWeapon
			10-SecondaryWeapon
			
			this is the IDEA MARKO, for the long term
			right now only implement what is needed/// note from future self 1/7/2023 past marko be nicer to future marko like recent past marko
		
		]]
		local playerInventory = {InventoryPack, Equipment}

		PlayerInventory[player] = playerInventory

	end

	return PlayerInventory[player]

end


function Inventory:AddItem(player, item)
	
	local PlrInv = Inventory:ReturnInventory(player)
	
	for i,v in pairs(PlrInv[1].Contents) do
		
		if v == ItemList.none then
			--print(item)
			--print(PlrInv[1].Contents[i])
			--PlrInv[1].Contents[i] = nil
			PlrInv[1].Contents[i] = item
			return
			
		end
		
	end
	
end

function Inventory:EquipItem(player, index, EquipSlot)
	
	local playerslocalInventory = PlayerInventory[player]
	
	local item = playerslocalInventory[1].Contents[index]
	
	playerslocalInventory[2].Contents[EquipSlot] = item
	
	playerslocalInventory[1].Contents[index] = ItemList.none
	
end

function Inventory:DequipItem(player, index, EquipSlot)
	
	local playerslocalInventory = PlayerInventory[player]

	local item = playerslocalInventory[2].Contents[EquipSlot]
	
	Inventory:AddItem(player, item)

	playerslocalInventory[2].Contents[EquipSlot] = ItemList.none
	
	--print(playerslocalInventory[2].Contents)
	
end

function Inventory:DropItem(player, index, pack)
	
	local playersinv = PlayerInventory[player]
	playersinv[pack].Contents[index] = ItemList.none
	
end

function Inventory:SwapItem(player, index1, pack1, index2, pack2)
	
	--print(index1, pack1, index2, pack2)
	local PlrInv = Inventory:ReturnInventory(player)
	
	local item1 = PlrInv[pack1].Contents[index1]
	
	local item2 = PlrInv[pack2].Contents[index2]
	
	PlrInv[pack1].Contents[index1] = item2
	PlrInv[pack2].Contents[index2] = item1
	
	--print(index1)
	--print(index2)
	--print(PlrInv[1].Contents[index1])
	--print(PlrInv[1].Contents[index2])
	
end

return Inventory
