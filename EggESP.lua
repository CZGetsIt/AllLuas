-- SETTINGS
local targetEggName = "Common Egg"
local customPetNames = {"Golden Lab", "Dog", "Bunny"}
local weightSequence = {"1.56", "2.65", "1.28", "4.46", "3.92", "7.18"}
local targetEggName = "Uncommon Egg"
local customPetNames = {"Black Bunny", "Chicken", "Cat", "Deer"}
local weightSequence = {"1.56", "2.65", "1.28", "4.46", "3.92", "7.18"}
local targetEggName = "Legendary Egg"
local customPetNames = {"Cow", "Silver Monkey", "Sea Otter", "Turtle", "Polar Bear"}
local weightSequence = {"1.56", "2.65", "1.28", "4.46", "3.92", "7.18"}
local targetEggName = "Mythical Egg"
local customPetNames = {"Grey Mouse", "Brown Mouse", "Squirrel", "Red Giant Ant", "Red Fox"}
local weightSequence = {"1.56", "2.65", "1.28", "4.46", "3.92", "7.18"}
local targetEggName = "Bug Egg"
local customPetNames = {"Snail", "Giant Ant", "Caterpillar", "Praying Mantis", "Dragonfly"}
local weightSequence = {"1.56", "2.65", "1.28", "4.46", "3.92", "7.18"}
local targetEggName = "Night Egg"
local customPetNames = {"Hedgehog", "Mole", "Frog", "Echo Frog", "Night Owl", "Raccoon"}
local weightSequence = {"1.56", "2.65", "1.28", "4.46", "3.92", "7.18"}
local targetEggName = "Bee Egg"
local customPetNames = {"Bee", "Honey Bee", "Bear Bee", "Petal Bee", "Queen Bee"}
local weightSequence = {"1.56", "2.65", "1.28", "4.46", "3.92", "7.18"}
local targetEggName = "Anti Bee Egg"
local customPetNames = {"Wasp", "Tarantula Hawk", "Moth", "Butterfly", "Disco Bee"}
local weightSequence = {"1.56", "2.65", "1.28", "4.46", "3.92", "7.18"}
local targetEggName = "Common Summer Egg"
local customPetNames = {"Starfish", "Seagull", "Crab"}
local weightSequence = {"1.56", "2.65", "1.28", "4.46", "3.92", "7.18"}
local targetEggName = "Rare Summer Egg"
local customPetNames = {"Flamingo", "Toucan", "Sea Turtle", "Orangutan", "Seal"}
local weightSequence = {"1.56", "2.65", "1.28", "4.46", "3.92", "7.18"}
local targetEggName = "Paradise Egg"
local customPetNames = {"Ostrich", "Peacock", "Capybara", "Scarlet Macaw", "Mimic Octopus"}
local weightSequence = {"1.56", "2.65", "1.28", "4.46", "3.92", "7.18"}
local targetEggName = "Oasis Egg"
local customPetNames = {"Meerkat", "Sand Snake", "Axolotl", "Hyacinth Macaw", "Fennec Fox"}
local weightSequence = {"1.56", "2.65", "1.28", "4.46", "3.92", "7.18"}
local targetEggName = "Dinosaur Egg"
local customPetNames = {"Raptor", "Triceratops", "Stegosaurus", "Pterodactyl", "Brontosaurus", "T-Rex"}
local weightSequence = {"1.56", "2.65", "1.28", "4.46", "3.92", "7.18"}
local targetEggName = "Primal Egg"
local customPetNames = {"Parasaurolophus", "Iguanodon", "Pachycephalosaurus", "Dilophosaurus", "Ankylosaurus", "Spinosaurus"}
local weightSequence = {"1.56", "2.65", "1.28", "4.46", "3.92", "7.18"}


-- SERVICES
local replicatedStorage = game:GetService("ReplicatedStorage")
local collectionService = game:GetService("CollectionService")
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local localPlayer = players.LocalPlayer
local camera = workspace.CurrentCamera

-- TOGGLES
local espEnabled = true
local weightChangeActive = false
local weightCountdown = 30

-- EGG FUNCTION SETUP
local conn = getconnections(replicatedStorage.GameEvents.PetEggService.OnClientEvent)
local hatchFunction = getupvalue(getupvalue(conn[1].Function, 1), 2)
local eggModels = getupvalue(hatchFunction, 1)

-- TABLES
local espCache, activeEggs, countdowns = {}, {}, {}

-- UTILS
local function getObjectFromId(id)
for egg in eggModels do
if egg:GetAttribute("OBJECT_UUID") == id then
return egg
end
end
end

local function updateEsp(objectId, petName)
local obj = getObjectFromId(objectId)
if not obj or not espCache[objectId] then return end
local data = countdowns[objectId]
local weight = weightSequence[data.weightIndex or 1] or 1.0
espCache[objectId].Text = {obj:GetAttribute("EggName")} | {petName} ({data.timeLeft}s) - {weight}kg
end

local function addEsp(object)
if object:GetAttribute("OWNER") ~= localPlayer.Name then return end
if object:GetAttribute("EggName") ~= targetEggName then return end
local objectId = object:GetAttribute("OBJECT_UUID")
if not objectId then return end

local fakePet = customPetNames[math.random(1, #customPetNames)]  
local label = Drawing.new("Text")  
label.Size = 18  
label.Color = Color3.new(1, 1, 1)  
label.Outline = true  
label.OutlineColor = Color3.new(0, 0, 0)  
label.Center = true  
label.Visible = false  

espCache[objectId] = label  
activeEggs[objectId] = object  
countdowns[objectId] = {  
	pet = fakePet,  
	timeLeft = 30,  
	weightIndex = 1  
}

end

local function removeEsp(object)
local objectId = object:GetAttribute("OBJECT_UUID")
if espCache[objectId] then espCache[objectId]:Remove() end
espCache[objectId], activeEggs[objectId], countdowns[objectId] = nil, nil, nil
end

-- COUNTDOWN + WEIGHT
task.spawn(function()
while true do
task.wait(1)
for objectId, data in pairs(countdowns) do
if espCache[objectId] and activeEggs[objectId] then
data.timeLeft -= 1
if data.timeLeft <= 0 then
data.pet = customPetNames[math.random(1, #customPetNames)]
data.weightIndex = ((data.weightIndex or 1) % #weightSequence) + 1
data.timeLeft = 30
end
updateEsp(objectId, data.pet)
end
end
if weightChangeActive then
weightCountdown -= 1
if weightCountdown <= 0 then
for _, data in pairs(countdowns) do
data.weightIndex = ((data.weightIndex or 1) % #weightSequence) + 1
end
weightChangeActive = false
weightCountdown = 30
end
end
end
end)

-- ESP POSITION
runService.RenderStepped:Connect(function()
for objectId, object in pairs(activeEggs) do
local label = espCache[objectId]
if label then
local pos, onScreen = camera:WorldToViewportPoint(object:GetPivot().Position)
label.Position = Vector2.new(pos.X, pos.Y)
label.Visible = espEnabled and onScreen
end
end
end)

-- SPAWN ESP FOR EXISTING EGGS
for _, object in collectionService:GetTagged("PetEggServer") do
task.spawn(addEsp, object)
end
collectionService:GetInstanceAddedSignal("PetEggServer"):Connect(addEsp)
collectionService:GetInstanceRemovedSignal("PetEggServer"):Connect(removeEsp)

-- HOOK FINAL NAME
local old
old = hookfunction(getconnections(replicatedStorage.GameEvents.EggReadyToHatch_RE.OnClientEvent)[1].Function, newcclosure(function(objectId, petName)
updateEsp(objectId, petName)
return old(objectId, petName)
end))

-- CHANGE WEIGHT BUTTON
local weightBtn = Drawing.new("Text")
weightBtn.Text = "[Change Weight]"
weightBtn.Size = 18
weightBtn.Center = true
weightBtn.Outline = true
weightBtn.Color = Color3.fromRGB(255, 255, 0)
weightBtn.Position = Vector2.new(150, 100)
weightBtn.Visible = true

local dragging = false
local dragOffset = Vector2.zero

userInputService.InputBegan:Connect(function(input, gpe)
if gpe then return end
if input.UserInputType == Enum.UserInputType.MouseButton1 then
local mouse = input.Position
if (mouse - weightBtn.Position).Magnitude <= 80 then
if not dragging then
weightChangeActive = true
weightCountdown = 30
weightBtn.Text = "[Weight CD: 30s]"
task.spawn(function()
while weightChangeActive do
task.wait(1)
weightBtn.Text = "[Weight CD: " .. tostring(weightCountdown) .. "s]"
end
weightBtn.Text = "[Change Weight]"
end)
end
dragging = true
dragOffset = weightBtn.Position - mouse
end
end
end)

userInputService.InputEnded:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
dragging = false
end
end)

runService.RenderStepped:Connect(function()
if dragging then
local mouse = userInputService:GetMouseLocation()
weightBtn.Position = mouse + dragOffset
end
end)

print("✅ ESP Loaded with Weight Sync + Change Button")
