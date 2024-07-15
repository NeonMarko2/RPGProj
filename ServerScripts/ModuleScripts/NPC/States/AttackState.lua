local module = {}



function module:Tick(npc)
	
	--print(npc.Abilities)	
	npc.WaitTime = 1
	npc:ChangeState(require(script.Parent.ChaseState))
	
	if npc.Abilities[1][2] <= 0 then
		
		npc.WaitTime = 1
		--npc.Abilities[1][1]:Activate(npc.Model, npc.CurrentlyTargeting)
		game.ServerScriptService.AbilityRemote.ActivateAbility:Fire(npc.Model, npc.Abilities[1][1], npc.CurrentlyTargeting)
		npc.Abilities[1][2] = 4
		
	end
	
end

return module
