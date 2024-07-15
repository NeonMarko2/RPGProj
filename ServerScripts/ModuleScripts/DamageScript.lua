local DamageScript = {}


function DamageScript:DamageTarget(Causer:Model, Target:Model, damage)
	
	if not Target:FindFirstChild("Humanoid"):FindFirstChild("creator") then
		
		Target:FindFirstChild("Humanoid").Health -= damage

		local tag = Instance.new("ObjectValue", Target:FindFirstChild("Humanoid"))
		tag.Value = Causer
		tag.Name = "creator"
		
	else
		
		Target:FindFirstChild("Humanoid").Health -= damage
		Target:FindFirstChild("Humanoid"):FindFirstChild("creator").Value = Causer
		
	end
	
end


return DamageScript
