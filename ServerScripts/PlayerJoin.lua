
game.Players.PlayerAdded:Connect(function(player)
	
	player.CharacterAdded:Connect(function(character)
		
		local folder = Instance.new("Folder", character)
		folder.Name = "Stats"
		local Level = Instance.new("IntValue", folder)
		Level.Name = "Level"
		Level.Value = 2
		local Xp = Instance.new("IntValue", folder)
		Xp.Name = "Xp"
		local BaseStrength = Instance.new("IntValue", folder)
		BaseStrength.Name = "BaseStrength"
		local BaseDexterity = Instance.new("IntValue", folder)
		BaseDexterity.Name = "BaseDexterity"
		local BaseArmor = Instance.new("IntValue", folder)
		BaseArmor.Name = "BaseArmor"
		local MaxMana = Instance.new("IntValue", folder)
		MaxMana.Name = "MaxMana"

		local Race = Instance.new("StringValue", folder)
		Race.Name = "Race"

		local Class = Instance.new("StringValue", folder)
		Class.Name = "Class"
		
	end)
	
end)
