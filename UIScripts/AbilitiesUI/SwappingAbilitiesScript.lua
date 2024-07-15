
local remotes = game.ReplicatedStorage.Remotes
local ClassDatabase = remotes.RemoteFunctions.ReturnClasses

local StoredAbilityIndex = nil

local localPlayer = game.Players.LocalPlayer



function InputSwap(hotbarindex, abilityindex)

	if StoredAbilityIndex then
		
		script.Parent.SelectedItem.ImageTransparency = 1
		print(1)
		remotes.RemoteEvents.AbilityRemote.Assign:FireServer(hotbarindex, StoredAbilityIndex)
		StoredAbilityIndex = nil
		--print("has been assigned nil")
		
	else
		
		if abilityindex == 0 then
			
			remotes.RemoteEvents.AbilityRemote.Assign:FireServer(hotbarindex, -1)			
			
			return
			
		end
		
		StoredAbilityIndex = abilityindex
		script.Parent.SelectedItem.ImageTransparency = 0
		
	end
	
	--print(StoredAbilityIndex)
	
end


script.Parent.Events.InputSwapAbility.Event:Connect(InputSwap)
