local NPCbase = {}
NPCbase.__index = NPCbase

local abilities = require(game.ServerScriptService.ModuleScripts.AbilityBase)



function NPCbase:Died()
	
	self.ChangeState(require(script.Parent.StateBase.DeadState))
	setmetatable(self, nil)
	self = nil
	
end

function NPCbase:NewNpc(npc: Model)
	

	local self = {}
	self.Model = npc
	self.Name = nil
	self.Abilities = {{abilities:ReturnAbilities().Heal, 20}}
	self.TargetRange = 0
	self.IsAggressive = false
	self.CurrentlyTargeting = nil
	self.CurrentState = nil
	self.wanderDistance = 0
	self.WaitTime = 0
	
	self.Model.Humanoid.Changed:Connect(function()
		
		if self.Model.Humanoid.Health <= 0 then
			
			if self.Died then
					
				self:Died()
				
			end
				
		end

	end)
	
	if not self.Model:FindFirstChild("Events") then
		
		local BindableEvent = Instance.new("BindableEvent", self.Model:FindFirstChild("Events"))
		BindableEvent.Name = "Damaged"
		
	end
	
	return setmetatable(self, NPCbase)
	
end

function NPCbase:DoCooldown()
	
	for i=1, #self.Abilities do
		
		self.Abilities[i][2] -= self.WaitTime
		
	end
	
end

function NPCbase:TickState()
	
	
	if self.CurrentState ~= nil then
	
		self.CurrentState:Tick(self)
		
	end
		
end

function NPCbase:ChangeState(state)
	
	self.CurrentState = state
	--print(self.Name.. " Changed state")
	
end

function NPCbase:FindClosestPlayer(npc)

	local biggest = 10000
	local player = nil

	for i,v:Player in pairs(game:GetService("Players"):GetPlayers()) do
		
		local distance = v:DistanceFromCharacter(npc.Model.PrimaryPart.Position)

		if distance < biggest then

			player = v.Character
			biggest = distance

		end

	end

	return player, biggest

end

return NPCbase
