local StatusEffectsSystem = {}



local ListOfPlayersStatusEffects = {}


local StatusEffects = {}

for i,v in pairs(script.MasterStatusEffect:GetChildren()) do
	
	local statusEffect = require(v):New()
	
	print(statusEffect)
	
	StatusEffects[statusEffect.Name] = statusEffect
	
end

print(StatusEffects)

function StatusEffectsSystem:ReturnPlayersStatusEffects(player)

	--print(player.ClassName)
	if ListOfPlayersStatusEffects[player] == nil then
		--print(ListOfPlayersStatusEffects[player])
		ListOfPlayersStatusEffects[player] = {}
		
	end
	
	return ListOfPlayersStatusEffects[player]
	
end

function StatusEffectsSystem:AddStatusEffect(player, effect, duration)

	local listofEffects = StatusEffectsSystem:ReturnPlayersStatusEffects(player)
	
	--local effect = require(effect):New(player.Character)
	local effect = StatusEffects[effect.Name]
	effect.CurrentUser = player.Character
	--print(effect)
	local sameAbility = false
	
	for i,v in pairs(listofEffects) do
		
		print(v, effect)
		
		if v[1].Index == effect.Index then
			
			sameAbility = true
			
		end
		
	end
	
	print(sameAbility)
		
	if sameAbility == false then
		
		listofEffects[#listofEffects+1] = {effect, duration}
		--print(StatusEffectsSystem:ReturnPlayersStatusEffects(player))
		effect:onInitialized()
		
	end
		
end

function StatusEffectsSystem:ReturnAllActiveStatusEffects()
	
	return ListOfPlayersStatusEffects
	
end

return StatusEffectsSystem
