local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Parent = player.PlayerGui

-- Main Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.4, 0, 0.6, 0)
frame.Position = UDim2.new(0.3, 0, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 2
frame.Parent = gui

-- Gradient for Frame
local gradient = Instance.new("UIGradient")
gradient.Rotation = 45
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 85, 0)) -- Black to Orange
})
gradient.Parent = frame

-- Title Label
local title = Instance.new("TextLabel")
title.Text = "Auto Parry System"
title.Font = Enum.Font.GothamSemibold
title.TextSize = 32
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Position = UDim2.new(0.5, 0, 0.05, 0)
title.AnchorPoint = Vector2.new(0.5, 0)
title.BackgroundTransparency = 1
title.Parent = frame

-- Auto Parry Toggle Button
local autoParryButton = Instance.new("TextButton")
autoParryButton.Text = "Auto Parry: OFF"
autoParryButton.Size = UDim2.new(0.6, 0, 0.1, 0)
autoParryButton.Position = UDim2.new(0.2, 0, 0.2, 0)
autoParryButton.BackgroundColor3 = Color3.fromRGB(85, 170, 255) -- Light Blue
autoParryButton.TextColor3 = Color3.fromRGB(255, 255, 255)
autoParryButton.Font = Enum.Font.SourceSansBold
autoParryButton.TextSize = 24
autoParryButton.Parent = frame

local autoParryEnabled = false

local function toggleAutoParry()
    autoParryEnabled = not autoParryEnabled
    if autoParryEnabled then
        autoParryButton.Text = "Auto Parry: ON"
        autoParryButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0) -- Green
    else
        autoParryButton.Text = "Auto Parry: OFF"
        autoParryButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0) -- Red
    end
end

autoParryButton.MouseButton1Click:Connect(toggleAutoParry)

-- Auto Parry Logic
game:GetService("RunService").Stepped:Connect(function()
    if autoParryEnabled then
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            -- Replace this with the auto parry logic specific to the game
            print("Auto parry triggered")
            -- Add specific detection and parry mechanisms here.
        end
    end
end)

-- Visual Enhancements
local function addCornerRadius(element, radius)
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, radius)
    uiCorner.Parent = element
end

addCornerRadius(frame, 10)
addCornerRadius(autoParryButton, 10)

-- Footer Label
local footer = Instance.new("TextLabel")
footer.Text = "Created by CALIXTO & Aura"
footer.Font = Enum.Font.Gotham
footer.TextSize = 18
footer.TextColor3 = Color3.fromRGB(255, 255, 255)
footer.Position = UDim2.new(0.5, 0, 0.9, 0)
footer.AnchorPoint = Vector2.new(0.5, 0)
footer.BackgroundTransparency = 1
footer.Parent = frame

-- Additional Buttons from Original Code
local button1 = Instance.new("TextButton")
button1.Text = "Spirit Boss"
button1.Size = UDim2.new(0.6, 0, 0.1, 0)
button1.Position = UDim2.new(0.2, 0, 0.35, 0)
button1.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
button1.TextColor3 = Color3.fromRGB(255, 255, 255)
button1.Font = Enum.Font.SourceSansBold
button1.TextSize = 24
button1.Parent = frame

local button2 = Instance.new("TextButton")
button2.Text = "Mecha Boss"
button2.Size = UDim2.new(0.6, 0, 0.1, 0)
button2.Position = UDim2.new(0.2, 0, 0.5, 0)
button2.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
button2.TextColor3 = Color3.fromRGB(255, 255, 255)
button2.Font = Enum.Font.SourceSansBold
button2.TextSize = 24
button2.Parent = frame

local function ShowSubcategories(buttonName)
    print("Botão '" .. buttonName .. "' pressionado!")
    if buttonName == "Spirit Boss" then
        print("Executando script para Spirit Boss...")
        -- Add logic for Spirit Boss here
    elseif buttonName == "Mecha Boss" then
        print("Executando script para Mecha Boss...")
        -- Add logic for Mecha Boss here
    end
end

button1.MouseButton1Click:Connect(function()
    ShowSubcategories("Spirit Boss")
end)

button2.MouseButton1Click:Connect(function()
    ShowSubcategories("Mecha Boss")
end)

-- Add corner radius to additional buttons
addCornerRadius(button1, 10)
addCornerRadius(button2, 10)
