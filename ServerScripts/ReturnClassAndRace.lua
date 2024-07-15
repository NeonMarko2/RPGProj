
local remotes = game.ReplicatedStorage.Remotes

local classes = require(script.Parent.ModuleScripts.ClassDataBase)

local races = require(script.Parent.ModuleScripts.RaceDataBase)


remotes.RemoteFunctions.ReturnClasses.OnServerInvoke = function()

	return classes
	
end
print(remotes.RemoteFunctions.ReturnRaces)
remotes.RemoteFunctions.ReturnRaces.OnServerInvoke = function()
	print("return")
	return races
	
end
