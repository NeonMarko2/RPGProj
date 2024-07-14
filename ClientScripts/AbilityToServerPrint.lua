
local uis = game:GetService("UserInputService")

--local cooldowns = workspace.Scripts.RemoteFunctions.ReturnCooldowns:InvokeServer()

uis.InputBegan:Connect(function(key)
		
	if key.KeyCode == Enum.KeyCode.LeftBracket then
			
		workspace.poopie:FireServer()
		
	elseif key.KeyCode == Enum.KeyCode.P then
		
		game.Players.LocalPlayer.Events["Text PopUp"]:Fire("Fubar", 2, Color3.new(0.380392, 0.254902, 0.254902), 25)
		--print(cooldowns)
		
	elseif key.KeyCode == Enum.KeyCode.N then
		
		local inv = game.ReplicatedStorage.Remotes.RemoteFunctions.ReturnInventory:InvokeServer()
		print(inv)
		
	elseif key.KeyCode == Enum.KeyCode.M then
		
		local se = game.ReplicatedStorage.Remotes.RemoteFunctions.ReturnStatusEffects:InvokeServer()
		print(se)
		
	end
	
end)
