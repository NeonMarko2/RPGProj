local module = {}



function module:Tick(npc)
	
	local distance = (npc.CurrentlyTargeting.PrimaryPart.Position - npc.Model.PrimaryPart.Position).Magnitude
	
	if distance < 5 then
		
		npc:ChangeState(require(script.Parent.AttackState))
		
	else
		
		if npc.CurrentlyTargeting then

			npc.Model.Humanoid:MoveTo(npc.CurrentlyTargeting.PrimaryPart.Position+(npc.CurrentlyTargeting.PrimaryPart.Velocity*.1))

			npc.WaitTime = .2

			if distance > (npc.TargetRange*3) then

				npc.IsAggressive = false
				npc:ChangeState(require(script.Parent.WanderState))

			end

		else

			npc.IsAggressive = false
			npc:ChangeState(require(script.Parent.WanderState))

		end
		
	end
		
end

return module
