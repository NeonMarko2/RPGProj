
game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable

game.Workspace.CurrentCamera.CFrame = game.Workspace.CharacterSelectCamera.CFrame

for i,v in pairs(game.Players.LocalPlayer:GetDescendants()) do
	
	if v.ClassName == "ScreenGui" then
			
		if v.Name == "CharacterSelectUI" then
			
			v.Enabled = true
			
		elseif v.Name == "Chooser" then
			
			v.Enabled = true
			
		elseif v.Name == "PopUp Text" then
			
			v.Enabled = true
			
		else
			
			v.Enabled = false
			
		end
		
	end
	
end
