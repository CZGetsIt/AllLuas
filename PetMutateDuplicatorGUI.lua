-- Pet Mutate / Duplicator GUI Script
-- Made by CZ

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- Main GUI Frame
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PetMutateDuplicatorGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
MainFrame.BorderSizePixel = 0
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Title
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Text = "PET MUTATE / DUPLICATOR"
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.TextColor3 = Color3.fromRGB(0, 0, 0)
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, -40, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.Parent = MainFrame

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Text = "X"
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -30, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 14
CloseButton.Parent = MainFrame
CloseButton.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

-- Notes
local Note = Instance.new("TextLabel")
Note.Name = "Note"
Note.Text = "NOTE: Kindly hold the pet you want to make changes"
Note.Font = Enum.Font.SourceSans
Note.TextSize = 14
Note.TextWrapped = true
Note.TextColor3 = Color3.fromRGB(0, 0, 0)
Note.BackgroundTransparency = 1
Note.Size = UDim2.new(1, -20, 0, 30)
Note.Position = UDim2.new(0, 10, 0, 40)
Note.Parent = MainFrame

-- Reconnect Note (Top Right)
local ReconnectNote = Instance.new("TextLabel")
ReconnectNote.Name = "ReconnectNote"
ReconnectNote.Text = "NOTE: If the game reconnects, just wait patiently"
ReconnectNote.Font = Enum.Font.SourceSans
ReconnectNote.TextSize = 14
ReconnectNote.TextWrapped = true
ReconnectNote.TextColor3 = Color3.fromRGB(100, 100, 100)
ReconnectNote.BackgroundTransparency = 1
ReconnectNote.Size = UDim2.new(1, -20, 0, 30)
ReconnectNote.Position = UDim2.new(0, 10, 1, -35)
ReconnectNote.Parent = MainFrame

-- Mutate / Dupe Button
local ActionButton = Instance.new("TextButton")
ActionButton.Name = "ActionButton"
ActionButton.Text = "MUTATE / DUPE"
ActionButton.Font = Enum.Font.SourceSansBold
ActionButton.TextSize = 16
ActionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ActionButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
ActionButton.Size = UDim2.new(0, 200, 0, 40)
ActionButton.Position = UDim2.new(0.5, -100, 1, -80)
ActionButton.Parent = MainFrame

-- Cooldown label
local CooldownNote = Instance.new("TextLabel")
CooldownNote.Name = "CooldownNote"
CooldownNote.Text = "Button has 10 seconds cooldown"
CooldownNote.Font = Enum.Font.SourceSans
CooldownNote.TextSize = 12
CooldownNote.TextColor3 = Color3.fromRGB(0, 0, 0)
CooldownNote.BackgroundTransparency = 1
CooldownNote.Size = UDim2.new(1, 0, 0, 20)
CooldownNote.Position = UDim2.new(0, 0, 1, -40)
CooldownNote.Parent = MainFrame

-- Footer
local Footer = Instance.new("TextLabel")
Footer.Name = "Footer"
Footer.Text = "Made by CZ"
Footer.Font = Enum.Font.SourceSansItalic
Footer.TextSize = 12
Footer.TextColor3 = Color3.fromRGB(120, 120, 120)
Footer.BackgroundTransparency = 1
Footer.Size = UDim2.new(1, 0, 0, 20)
Footer.Position = UDim2.new(0, 0, 1, -20)
Footer.Parent = MainFrame

-- Popup Frame
local Popup = Instance.new("Frame")
Popup.Name = "ChoicePopup"
Popup.Size = UDim2.new(0, 250, 0, 150)
Popup.Position = UDim2.new(0.5, -125, 0.5, -75)
Popup.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Popup.BorderSizePixel = 0
Popup.Visible = false
Popup.Parent = ScreenGui

local PopupTitle = Instance.new("TextLabel")
PopupTitle.Text = "Choose Action"
PopupTitle.Font = Enum.Font.SourceSansBold
PopupTitle.TextSize = 18
PopupTitle.TextColor3 = Color3.fromRGB(0, 0, 0)
PopupTitle.BackgroundTransparency = 1
PopupTitle.Size = UDim2.new(1, 0, 0, 30)
PopupTitle.Parent = Popup

local MutateBtn = Instance.new("TextButton")
MutateBtn.Text = "MUTATE"
MutateBtn.Font = Enum.Font.SourceSansBold
MutateBtn.TextSize = 16
MutateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MutateBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
MutateBtn.Size = UDim2.new(0.8, 0, 0, 35)
MutateBtn.Position = UDim2.new(0.1, 0, 0.4, 0)
MutateBtn.Parent = Popup

local DupeBtn = Instance.new("TextButton")
DupeBtn.Text = "DUPLICATE"
DupeBtn.Font = Enum.Font.SourceSansBold
DupeBtn.TextSize = 16
DupeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DupeBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
DupeBtn.Size = UDim2.new(0.8, 0, 0, 35)
DupeBtn.Position = UDim2.new(0.1, 0, 0.7, 0)
DupeBtn.Parent = Popup

-- Action Button Logic
ActionButton.MouseButton1Click:Connect(function()
	Popup.Visible = true
end)

-- Mutate and Dupe Button Logic
MutateBtn.MouseButton1Click:Connect(function()
	Popup.Visible = false
	print("Mutate selected")
	-- Add mutate logic here
end)

DupeBtn.MouseButton1Click:Connect(function()
	Popup.Visible = false
	print("Duplicate selected")
	-- Add dupe logic here
end)


-- Loading Bar and Success Message
local function showLoadingAndSuccess(actionName)
    local LoadingBar = Instance.new("Frame")
    LoadingBar.Size = UDim2.new(0, 0, 0, 5)
    LoadingBar.Position = UDim2.new(0.1, 0, 0.3, 0)
    LoadingBar.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
    LoadingBar.BorderSizePixel = 0
    LoadingBar.Parent = Popup

    -- Animate bar (3 seconds)
    LoadingBar:TweenSize(UDim2.new(0.8, 0, 0, 5), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 3, true)
    task.wait(3)
    LoadingBar:Destroy()

    local SuccessMsg = Instance.new("TextLabel")
    SuccessMsg.Text = actionName .. " Successful!"
    SuccessMsg.Font = Enum.Font.SourceSansBold
    SuccessMsg.TextSize = 18
    SuccessMsg.TextColor3 = Color3.fromRGB(0, 200, 100)
    SuccessMsg.BackgroundTransparency = 1
    SuccessMsg.Size = UDim2.new(1, 0, 0, 30)
    SuccessMsg.Position = UDim2.new(0, 0, 0.3, 0)
    SuccessMsg.Parent = Popup

    task.wait(2)
    SuccessMsg:Destroy()
end

-- Cooldown handling
local onCooldown = false
local function handleCooldown(actionName)
    if onCooldown then return end
    onCooldown = true
    showLoadingAndSuccess(actionName)
    task.wait(10)
    onCooldown = false
end

-- Replace previous Mutate and Dupe logic
MutateBtn.MouseButton1Click:Connect(function()
    Popup.Visible = true
    handleCooldown("Mutation")
end)

DupeBtn.MouseButton1Click:Connect(function()
    Popup.Visible = true
    handleCooldown("Duplication")
end)
