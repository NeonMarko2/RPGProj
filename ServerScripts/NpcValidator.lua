
local NPCbase = script.Parent.ModuleScripts.NPC.NPCbase

function ValidateNPC(npc)
	
	local npcModule = require(NPCbase:FindFirstChild(npc.Name))
	npcModule:Initialize(npc)
	
end

for i,v in pairs(workspace.Folder:GetChildren()) do

	v.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
	v.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
	v.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying, false)
	v.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
	v.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)

	v.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, false)
	v.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, false)
	v.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)

	v.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
	v.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true)
	
	for _, item in pairs(v:GetDescendants()) do
		if item:IsA("BasePart") or item:IsA("MeshPart") then
			item:SetNetworkOwner(nil)
		end
	end
	ValidateNPC(v)

end

