
local RunService = game:GetService("RunService")

local StatusEffectFrame = game.ReplicatedStorage.StatusEffects.StatusEffectFrame

local CurrentStatusEffects = nil

function Refresh(StatusEffects)
	
	print(StatusEffects)
	
	CurrentStatusEffects = StatusEffects
	
	for i,v in pairs(script.Parent.List:GetChildren()) do
		
		if v.ClassName == "Frame" then
			
			v:Destroy()
			
		end
		
	end
	
	for i,v in pairs(StatusEffects) do
		
		if v ~= 0 then
		
			local StatusEffectFrameClone = StatusEffectFrame:Clone()
			StatusEffectFrameClone.Parent = script.Parent.List
			StatusEffectFrameClone.Name = i
			
		end
			
	end
	
end


function ProgressCooldowns(DeltaTime)
	
	if CurrentStatusEffects == nil then return end
	
	LowerCooldownText()
	
	for i,v in ipairs(CurrentStatusEffects) do
		
		CurrentStatusEffects[i][2] -= DeltaTime
		
		if CurrentStatusEffects[i][2] <= 0 then
			
			table.remove(CurrentStatusEffects, i)
			
			Refresh(CurrentStatusEffects)
			
			if #CurrentStatusEffects == 0 then
				
				CurrentStatusEffects = nil
				
			end
			
		end
		
	end
	
end


function LowerCooldownText()
	
	for i,v in ipairs(CurrentStatusEffects) do
		
		script.Parent.List:FindFirstChild(i).TimerText.Text = string.format("%.1f", v[2])
		
	end
	
end


RunService.Heartbeat:Connect(ProgressCooldowns)

game.ReplicatedStorage.Remotes.RemoteEvents.UpdateStatusEffects.OnClientEvent:Connect(Refresh)
