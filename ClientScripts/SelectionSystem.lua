
local RS = game:GetService("RunService")
local uis = game:GetService("UserInputService")

local Target = nil

local Camera = workspace.CurrentCamera

uis.InputBegan:Connect(function(input)
	
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		
		local localtarget = script.SelectionBox.Adornee
		
		if localtarget ~= nil then
			
			localtarget = localtarget.Parent
			
		end
		
		script.CurrentSelected.Adornee = localtarget
		
		--if localtarget:FindFirstChild("Tags") == nil then
			
			Target = localtarget
			--print(Target)
			script.Target.Value = Target
			
		--elseif localtarget.Tags:FindFirstChild("UnTargetable") == nil then
			
		--	Target = localtarget
		--	--print(Target)
		--	script.Target.Value = Target
			
		--end
		
	end
	
end)

RS.RenderStepped:Connect(function()
	
	Camera = workspace.CurrentCamera
	local UnitRay = Camera:ViewportPointToRay(game.Players.LocalPlayer:GetMouse().X, game.Players.LocalPlayer:GetMouse().Y+36, 0)
	local RayParams = RaycastParams.new()
	RayParams.CollisionGroup = "Raycast"
	RayParams.FilterDescendantsInstances = game.Players.LocalPlayer.Character:GetDescendants()
	RayParams.FilterType = Enum.RaycastFilterType.Blacklist
	local raycast = game.Workspace:Raycast(UnitRay.Origin, UnitRay.Direction * 250, RayParams)

	if raycast then
		
		if not raycast.Instance.Parent:FindFirstChild("Tags") then
			
			script.SelectionBox.Adornee = raycast.Instance
			
		elseif not raycast.Instance.Parent:FindFirstChild("Tags"):FindFirstChild("UnTargetable") then
			
			script.SelectionBox.Adornee = raycast.Instance
			
		end
		
	else
		
		script.SelectionBox.Adornee = nil
		
	end
	
end)

game.ReplicatedStorage.Remotes.RemoteEvents.UpdateTagAddedToObject.OnClientEvent:Connect(function()
	
	if Target then
		
		if Target:FindFirstChild("Tags"):FindFirstChild("UnTargetable") then
			
			Target = nil
			script.CurrentSelected.Adornee = nil
			script.Target.Value = nil
			
		end
		
	end
	
end)
