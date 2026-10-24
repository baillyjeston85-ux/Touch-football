
-- TOUCH FOOTBALL HUB | MOBILE EDITION
-- A installer comme LocalScript dans StarterPlayerScripts
-- Les scores sont une simulation locale : ils ne modifient pas
-- le score officiel d'un serveur Roblox tiers.

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("TouchFootballHub")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "TouchFootballHub"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 290, 0, 365)
frame.Position = UDim2.new(0.5, -145, 0.5, -182)
frame.BackgroundColor3 = Color3.fromRGB(24, 20, 38)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = frame

local function makeButton(name, text, y, color)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Text = text
    button.Size = UDim2.new(1, -24, 0, 42)
    button.Position = UDim2.new(0, 12, 0, y)
    button.BackgroundColor3 = color
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextScaled = true
    button.Font = Enum.Font.GothamBold
    button.AutoButtonColor = true
    button.Parent = frame

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = button

    return button
end

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 38)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = "TOUCH FOOTBALL HUB"
title.TextColor3 = Color3.fromRGB(205, 150, 255)
title.Font = Enum.Font.GothamBlack
title.TextScaled = true
title.Parent = frame

local score = Instance.new("TextLabel")
score.Size = UDim2.new(1, -20, 0, 35)
score.Position = UDim2.new(0, 10, 0, 45)
score.BackgroundTransparency = 1
score.TextColor3 = Color3.new(1, 1, 1)
score.Font = Enum.Font.GothamBold
score.TextScaled = true
score.Parent = frame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -20, 0, 25)
status.Position = UDim2.new(0, 10, 0, 80)
status.BackgroundTransparency = 1
status.TextColor3 = Color3.fromRGB(210, 210, 220)
status.TextScaled = true
status.Font = Enum.Font.Gotham
status.Parent = frame

local teams = {"Rouge", "Bleu", "Vert", "Jaune"}
local selected = 1
local goals = {0, 0, 0, 0}

local function updateScore()
    score.Text = teams[1] .. " " .. goals[1]
        .. " - " .. goals[2] .. " " .. teams[2]
end

local teamButton = makeButton(
    "ChooseTeam", "Équipe : Rouge", 112,
    Color3.fromRGB(105, 60, 160)
)

local goalButton = makeButton(
    "AddGoal", "⚽ Ajouter un but", 162,
    Color3.fromRGB(30, 145, 90)
)

local resetButton = makeButton(
    "ResetScore", "Réinitialiser le score", 212,
    Color3.fromRGB(180, 65, 65)
)

local hideButton = makeButton(
    "HideMenu", "Masquer le menu", 262,
    Color3.fromRGB(65, 75, 100)
)

local showButton = Instance.new("TextButton")
showButton.Name = "OpenMenu"
showButton.Size = UDim2.new(0, 135, 0, 45)
showButton.Position = UDim2.new(0, 15, 0.5, -22)
showButton.Text = "⚽ FOOTBALL HUB"
showButton.TextScaled = true
showButton.Font = Enum.Font.GothamBold
showButton.TextColor3 = Color3.new(1, 1, 1)
showButton.BackgroundColor3 = Color3.fromRGB(105, 60, 160)
showButton.Visible = false
showButton.Parent = gui

teamButton.Activated:Connect(function()
    selected = selected % #teams + 1
    teamButton.Text = "Équipe : " .. teams[selected]
    status.Text = "Équipe sélectionnée : " .. teams[selected]
end)

goalButton.Activated:Connect(function()
    goals[selected] = goals[selected] + 1
    updateScore()
    status.Text = "But simulé pour " .. teams[selected]
end)

resetButton.Activated:Connect(function()
    for i = 1, #goals do
        goals[i] = 0
    end
    updateScore()
    status.Text = "Score réinitialisé"
end)

hideButton.Activated:Connect(function()
    frame.Visible = false
    showButton.Visible = true
end)

showButton.Activated:Connect(function()
    frame.Visible = true
    showButton.Visible = false
end)

updateScore()
status.Text = "Prêt ! Choisis une équipe."
