local AbilityBase = {}

AbilityBase.__index = AbilityBase


function AbilityBase:NewAbility()
	
	local self = {}
	
	self.Name = "AbilityName"
	self.Cooldown = 0
	self.Range = 0
	self.Icon = ""
	self.NeedTarget = false
	self.ChannelAmount = 0
	self.Index = -1
	
	return setmetatable(self, AbilityBase)
	
end

function AbilityBase:Activate(user, target)
	
	print("Should have activated ability")
	
end

function CheckDistance(target1, target2)

	local distance = (target1 - target2).Magnitude

	return distance

end

return AbilityBase
