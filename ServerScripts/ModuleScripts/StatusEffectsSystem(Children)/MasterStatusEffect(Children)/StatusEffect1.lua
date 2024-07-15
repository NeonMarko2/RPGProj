local StatusEffect = {}
StatusEffect.__index = StatusEffect

local MasterStatusEffect = require(script.Parent)
setmetatable(StatusEffect, MasterStatusEffect)

local CollectionService = game:GetService("CollectionService")



function StatusEffect:New()
	
	local self = MasterStatusEffect:New()
	
	self.Name = "StatusEffect1"
	self.Index = 1	
	self.CurrentUser = nil
	--print(self)
	
	return self
	
end

function MasterStatusEffect:onInitialized()
	
	print(self.Name)
	
	local children = self.CurrentUser:GetChildren()
	
	for i,v in pairs(children) do
		
		if v.Name == "Head" then

			v.face.Transparency = 1
			v.Transparency = 1

		elseif v.ClassName == "Part" or v.ClassName == "MeshPart" then
			
			v.Transparency = 1
			
		end
		
	end
	
	script.Parent.Parent.Parent.Parent.CustomTagSystem.AddTag:Fire(self.CurrentUser, "UnTargetable")

end

function MasterStatusEffect:onEnded()

	local children = self.CurrentUser:GetChildren()
	
	for i,v in pairs(children) do
		
		if v.Name == "Head" then
			
			v.face.Transparency = 0
			v.Transparency = 0
			
		elseif v.ClassName == "Part" or v.ClassName == "MeshPart" then
			
			if not (v.Name == "HumanoidRootPart" or v.Name == "RaycastHitbox") then -- if youre looking back at this
				-- its crazy, i didnt think this type of syntaxing was possible in the future let alone this moment
				v.Transparency = 0
				
			end
			
		end
		
	end
	
	script.Parent.Parent.Parent.Parent.CustomTagSystem.RemoveTag:Fire(self.CurrentUser, "UnTargetable")
	
	setmetatable(self, nil)
	
end

return StatusEffect
