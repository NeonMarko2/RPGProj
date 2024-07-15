
local Classes = require(script.Parent.ModuleScripts.ClassDataBase)
local Races = require(script.Parent.ModuleScripts.RaceDataBase)

function ApplyStats(Character: Model)
	
	local StatsFolder = Character:FindFirstChild("Stats")
	local Level = StatsFolder.Level.Value
	
	local StatsToApply
	for i = Level, 0, -1 do
		print(i)
		if Classes[StatsFolder.Class.Value].StatsPerLevel[i] ~= nil then
			print("found it")
			StatsToApply = Classes[StatsFolder.Class.Value].StatsPerLevel[i]
			break
		end

	end
	
	local RaceSpecialStats
	for i = Level, 0, -1 do
		print(i)
		if Races[StatsFolder.Race.Value].StatsPerLevel[i] ~= nil then
			print("found it")
			RaceSpecialStats = Races[StatsFolder.Race.Value].StatsPerLevel[i]
			break
		end

	end
	
	Character.Humanoid.MaxHealth = StatsToApply.Health
	Character.Humanoid.Health += StatsToApply.Health
	StatsFolder.BaseStrength.Value = StatsToApply.Strength
	StatsFolder.BaseDexterity.Value = StatsToApply.Dexterity
	StatsFolder.BaseArmor.Value = StatsToApply.Armor
	
	local SpecialStats = {}
	
	for i,v in pairs(StatsToApply) do
		
		if not (i == "Strength" or i == "Health" or i == "Dexterity" or i == "Armor" or i == "Mana") then
			
			SpecialStats[i] = v
			
		end
		
	end
	
	for i,v in pairs(RaceSpecialStats) do
		
		SpecialStats[i] = v
		
	end

	for i,v in pairs(SpecialStats) do
		
		if not StatsFolder:FindFirstChild(i) then
			
			local ReplicatedStat = game.ReplicatedStorage.StatsWithSpecialResourceBars:FindFirstChild(i)
			
			if ReplicatedStat then
				
				local ReplicatedStatClone = ReplicatedStat:Clone()
				ReplicatedStatClone.Parent = StatsFolder
				ReplicatedStatClone.Value = v
				
			else
				
				local SpecialStat = Instance.new("IntValue", StatsFolder)
				SpecialStat.Name = i
				SpecialStat.Value = v
				
			end
			
		else
			
			StatsFolder:FindFirstChild(i).Value = v
			
		end
		
	end
	
end



script.ApplyCharacterStats.Event:Connect(ApplyStats)
