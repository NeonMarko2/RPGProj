local module = {}
module.__index = module
local NPCbase = require(script.Parent)

setmetatable(module, NPCbase)

local wanderState = require(script.Parent.Parent.StateBase.WanderState)
local chaseState = require(script.Parent.Parent.StateBase.ChaseState)
local attackState = require(script.Parent.Parent.StateBase.AttackState)



function module:Initialize(npc)
	
	local NPC = NPCbase:NewNpc(npc)

	NPC.Name = "Bro"
	NPC.TargetRange = 20
	NPC.CurrentState = wanderState
	NPC.wanderDistance = 10
	NPC.IsAggressive = false
	NPC.WaitTime = 2
	
	print(NPC.Abilities)
	
	coroutine.wrap(function()
		
		while wait(NPC.WaitTime) do
			
			if NPC ~= nil then
				
				if(NPC.FindClosestPlayer) then

					local player, distance = NPC:FindClosestPlayer(NPC)
				
					if distance < 100 then
						
						NPC:DoCooldown()
						
						NPC:TickState()
					
					end
					
				end
					
			end
			
		end
		
	end)()
	
end

return module
