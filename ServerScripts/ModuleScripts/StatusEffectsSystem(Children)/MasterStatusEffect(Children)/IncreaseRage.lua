local StatusEffect = {}
StatusEffect.__index = StatusEffect

local MasterStatusEffect = require(script.Parent)
setmetatable(StatusEffect, MasterStatusEffect)

local CollectionService = game:GetService("CollectionService")



function StatusEffect:New(user)
	
	local self = MasterStatusEffect:New()
	
	self.Name = "IncreaseRage"
	self.Index = 2	
	self.CurrentUser = user
	--print(self)
	
	return self
	
end

function MasterStatusEffect:onInitialized()

	coroutine.wrap(function()
		
		for i = 0, 10, 1 do
			
			self.CurrentUser.Stats.Rage.Value += 1
			
			wait(.1)
			
		end
		
	end)()

end

function MasterStatusEffect:onEnded()

	print(self.Name)
	
end

return StatusEffect
