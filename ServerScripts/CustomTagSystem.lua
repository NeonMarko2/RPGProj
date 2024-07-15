
local function AddObjectToTable(object)
	
	if not object:FindFirstChild("Tags") then
		
		local tagsFolder = Instance.new("Folder", object)
		tagsFolder.Name = "Tags"
		
	end
	
end

function AddTagToObject(object, tag)

	AddObjectToTable(object)
	
	local ListOfTags = object:FindFirstChild("Tags")
	
	local tagObject = Instance.new("Folder", ListOfTags)
	tagObject.Name = tag
	
	game.ReplicatedStorage.Remotes.RemoteEvents.UpdateTagAddedToObject:FireAllClients()
	
end

function RemoveTagFromObject(object, tag)
	
	local listOfTags = object:FindFirstChild("Tags")

	listOfTags:FindFirstChild(tag):Destroy()
	
end

script.AddTag.Event:Connect(AddTagToObject)

script.RemoveTag.Event:Connect(RemoveTagFromObject)


--/////////////////////////////////////////////////////// In case its laggy with the instantiation, then id suggest
--                                                        going back to this code!


--local objectsWithTags = {}

--local function AddObjectToTable(object)

--	if not objectsWithTags[object] then

--		objectsWithTags[object] = {}

--	end

--end

--function AddTagToObject(object, tag)

--	AddObjectToTable()

--	local ObjectInList = objectsWithTags[object]

--	ObjectInList[#ObjectInList+1] = tag

--end

--function RemoveTagFromObject(object, tag)

--	local ObjectInList = objectsWithTags[object]

--	if table.find(ObjectInList, tag, 1) then

--		table.remove(ObjectInList, table.find(ObjectInList, tag, 1))

--	end

--end
