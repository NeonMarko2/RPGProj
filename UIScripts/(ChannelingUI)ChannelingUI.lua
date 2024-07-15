
local Remotes = game.ReplicatedStorage.Remotes
local RunService = game:GetService("RunService")

local ChannelCounter

local ChannelMax

local ShouldBeChanneling = false

function SetChanneling(AmountToChannel)
	
	print("punk")
	ChannelCounter = 0
	ChannelMax = AmountToChannel
	script.Parent.Bar.Visible = true
	ShouldBeChanneling = true
	
end

RunService.Heartbeat:Connect(function(DeltaTime)
	
	if not ShouldBeChanneling then return end
	
	ChannelCounter += DeltaTime
	
	local Calculation = 1 - (ChannelCounter / ChannelMax)
	
	script.Parent.Bar.ActiveBar.Size = UDim2.new(Calculation, 0, 1, 0)
	
	if ChannelCounter >= ChannelMax then
		
		ShouldBeChanneling = false
		script.Parent.Bar.Visible = false
		
	end
	
end)

Remotes.RemoteEvents.UpdateChanneling.OnClientEvent:Connect(SetChanneling)
