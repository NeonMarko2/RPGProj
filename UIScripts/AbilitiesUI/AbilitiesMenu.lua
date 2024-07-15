
local remotes = game.ReplicatedStorage.Remotes

local ClassDatabase = remotes.RemoteFunctions.ReturnClasses:InvokeServer()
print("Awbibibatatatata")
local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")

local AbilityButton = game.ReplicatedStorage.AbilitiesMenu.AbilityInMenu

local Player = game.Players.LocalPlayer
local class



function InitializeAbilitiesMenu ()
	
	local iconlist = script.Parent.Frame.Frame:GetChildren()
	table.remove(iconlist, 2)
	table.remove(iconlist, 1)
	
	for i,v in pairs(iconlist) do
		iconlist[i]:Destroy()
	end
	
	class = Player.Character.Stats:FindFirstChild("Class").Value
	--print(ClassDatabase[class].Abilities)
	
	for i,v in pairs(ClassDatabase[class].Abilities) do
		
		local button = AbilityButton:Clone()
		button.Parent = script.Parent.Frame.Frame
		button.Image = ClassDatabase[class].Abilities[i].Ability.Icon
		
		if Player.Character.Stats.Level.Value < ClassDatabase[class].Abilities[i].LevelUnlock then
			
			local shadowFrame = Instance.new("TextLabel", button)
			shadowFrame.Size = UDim2.new(1,0,1,0)
			shadowFrame.BackgroundColor3 = Color3.new(0, 0, 0)
			shadowFrame.BackgroundTransparency = .25
			shadowFrame.TextColor3 = Color3.new(1, 1, 1)
			shadowFrame.Text = "Level: ".. ClassDatabase[class].Abilities[i].LevelUnlock
			button.AutoButtonColor = false
			button.Active = false
			
		else			
			
			button.MouseButton1Click:Connect(function()

				script.Parent.Events.InputSwapAbility:Fire(0, i)

			end)
			
		end
		
	end

end
--print(3)
uis.InputBegan:Connect(function(key)
	--print(key)
	if key.KeyCode == Enum.KeyCode.B then
		
		if script.Parent.Frame.Visible == false then
		--print("fer")
			InitializeAbilitiesMenu()
			script.Parent.Frame.Visible = true
			
		else
			
			script.Parent.Frame.Visible = false
			
		end
			
	end
	
end)

rs.RenderStepped:Connect(function()
	
	local mousePosition = uis:GetMouseLocation()
	
	script.Parent.SelectedItem.Position = UDim2.new(0, mousePosition.X, 0, mousePosition.Y-36)
	
end)
