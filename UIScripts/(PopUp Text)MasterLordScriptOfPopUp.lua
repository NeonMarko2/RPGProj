
local player = game.Players.LocalPlayer
local popUpText = game.ReplicatedStorage["Pop Up Text"].TextFrame

local TS = game:GetService("TweenService")

function ShowText(text, Time, Color, size)

	local TextToShow = popUpText:Clone()
	TextToShow.Parent = script.Parent
	TextToShow.TextLabel.Text = text
	TextToShow.TextLabel.TextColor3 = Color
	TextToShow.TextLabel.TextSize = size
	
	local TweenUpwards = TS:Create(TextToShow, TweenInfo.new(Time), {Position = UDim2.new(0.5, 0, 0.2 - .1, 0)})
	
	TweenUpwards.Completed:Connect(function()
		
		TS:Create(TextToShow, TweenInfo.new(1), {Position = UDim2.new(0.5, 0, 0.2 - .15, 0)}):Play()
		local TweenToInvisible = TS:Create(TextToShow.TextLabel, TweenInfo.new(1), {TextTransparency = 1})

		TweenToInvisible.Completed:Connect(function()

			TextToShow:Destroy()

		end)

		TweenToInvisible:Play()
		
	end)
	
	TweenUpwards:Play()
	
end

game.ReplicatedStorage.Bindables.PopUpText.Event:Connect(ShowText)
