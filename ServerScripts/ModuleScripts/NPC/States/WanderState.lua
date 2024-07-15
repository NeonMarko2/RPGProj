local module = {}



function module:Tick(npc)
	
	local player, distance = npc:FindClosestPlayer(npc)
	
	if distance < npc.TargetRange then

		npc.IsAggressive = true

	end
	
	if npc.IsAggressive then

		npc.CurrentlyTargeting = player
		npc:ChangeState(require(script.Parent.ChaseState))
		
	else
		
		npc.Model.Humanoid:MoveTo(Vector3.new(math.random(-npc.wanderDistance, npc.wanderDistance)+npc.Model.PrimaryPart.Position.X, npc.Model.PrimaryPart.Position.Y, math.random(-npc.wanderDistance, npc.wanderDistance)+npc.Model.PrimaryPart.Position.Z))
		
	end
	
end

return module
