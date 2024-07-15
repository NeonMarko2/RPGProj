
local rs = game:GetService("RunService")
local character = game.Players.LocalPlayer.Character
local ResourceBar = game.ReplicatedStorage.ProfileUI.ResourceBarBorder

local ResourceBarsToCalculate = {}

function CreateResourceBars()
	
	for i,v in pairs(character.Stats:GetChildren()) do
		
		--print(v:GetAttribute("BarColor") ~= nil)
		if(v:GetAttribute("BarColor")) ~= nil then
			
			local ResourceBarClone = ResourceBar:Clone()
			ResourceBarClone.Parent = script.Parent.Profile.SpecialBars
			ResourceBarClone.BackgroundColor3 = v:GetAttribute("BarColor")
			ResourceBarClone.ResourceBarActive.BackgroundColor3 = v:GetAttribute("ActiveColor")
			ResourceBarClone.Name = v.Name
			
			local ValueMax = character.Stats:FindFirstChild("Max" ..v.Name)
			
			ResourceBarsToCalculate[i] = v.Name
			--print(ResourceBarsToCalculate)
			
		end
		
	end
	
end

game.ReplicatedStorage.Remotes.RemoteEvents.UpdateResourceBars.OnClientEvent:Connect(CreateResourceBars)

rs.RenderStepped:Connect(function()
	
	local calculation = (character.Humanoid.Health / character.Humanoid.MaxHealth)
	script.Parent.Profile.HealthFrameBorder.HealthFrameActive.Size = UDim2.new(calculation, 0, 1, 0)
	
	for i,v in pairs(ResourceBarsToCalculate) do
		
		--print(character.Stats:FindFirstChild("Max" ..v).Value)
		
		local ResourceCalculation = (character.Stats:FindFirstChild(v).Value / character.Stats:FindFirstChild("Max" ..v).Value)
		script.Parent.Profile.SpecialBars:FindFirstChild(v).ResourceBarActive.Size = UDim2.new(ResourceCalculation, 0, 1, 0)
		
	end
	
end)
