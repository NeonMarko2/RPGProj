local MasterStatusEffect = {}
MasterStatusEffect.__index = MasterStatusEffect





function MasterStatusEffect:New()
	local self = {}
	setmetatable(self, MasterStatusEffect)
	
	self.Name = nil
	self.Index = 0
	self.CurrentUser = nil
	
	return self
	
end

function MasterStatusEffect:onInitialized(object)
	
	warn(
		"No added function returned! \n One of the StatusEffect objects could be missing an onInitialized Function! \n No problem me"
	)
	
end

function MasterStatusEffect:onEnded(object)
	
	warn(
		"No endded function returned! \n One of the StatusEffect objects could be missing an onEnded Function! \n No problem me"
	)
	
end

return MasterStatusEffect
