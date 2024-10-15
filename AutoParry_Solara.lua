-- Improved Adapted Script for Death Ball with Auto Parry, Auto Curve Ball, Advanced UI, and Additional Features

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- User Interface Creation
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local StatusLabel = Instance.new("TextLabel")
local ToggleButtonParry = Instance.new("TextButton")
local ToggleButtonCurve = Instance.new("TextButton")
local ToggleButtonAutoAim = Instance.new("TextButton")
local ResizeButton = Instance.new("TextButton")

ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "NanoInterface"
ScreenGui.ResetOnSpawn = false

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.Visible = true

TitleLabel.Parent = MainFrame
TitleLabel.Text = "NANO - Death Ball Helper"
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 30
TitleLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
TitleLabel.Size = UDim2.new(1, 0, 0.2, 0)
TitleLabel.BackgroundTransparency = 1

StatusLabel.Parent = MainFrame
StatusLabel.Text = "Auto Parry: ON\nAuto Curve: ON\nAuto Aim: OFF"
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.TextSize = 20
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.Position = UDim2.new(0, 0, 0.2, 0)
StatusLabel.Size = UDim2.new(1, 0, 0.4, 0)
StatusLabel.BackgroundTransparency = 1

ToggleButtonParry.Parent = MainFrame
ToggleButtonParry.Text = "Toggle Auto Parry (P)"
ToggleButtonParry.Font = Enum.Font.SourceSans
ToggleButtonParry.TextSize = 20
ToggleButtonParry.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButtonParry.Position = UDim2.new(0, 10, 0.65, 0)
ToggleButtonParry.Size = UDim2.new(0.3, -10, 0.2, 0)

ToggleButtonCurve.Parent = MainFrame
ToggleButtonCurve.Text = "Toggle Auto Curve (C)"
ToggleButtonCurve.Font = Enum.Font.SourceSans
ToggleButtonCurve.TextSize = 20
ToggleButtonCurve.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButtonCurve.Position = UDim2.new(0.35, 10, 0.65, 0)
ToggleButtonCurve.Size = UDim2.new(0.3, -10, 0.2, 0)

ToggleButtonAutoAim.Parent = MainFrame
ToggleButtonAutoAim.Text = "Toggle Auto Aim (A)"
ToggleButtonAutoAim.Font = Enum.Font.SourceSans
ToggleButtonAutoAim.TextSize = 20
ToggleButtonAutoAim.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButtonAutoAim.Position = UDim2.new(0.7, 10, 0.65, 0)
ToggleButtonAutoAim.Size = UDim2.new(0.3, -10, 0.2, 0)

ResizeButton.Parent = MainFrame
ResizeButton.Text = "Resize UI"
ResizeButton.Font = Enum.Font.SourceSans
ResizeButton.TextSize = 20
ResizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ResizeButton.Position = UDim2.new(0.35, 0, 0.9, 0)
ResizeButton.Size = UDim2.new(0.3, 0, 0.1, 0)

-- Variables for Auto Parry, Curve Ball, and Auto Aim
local autoParryEnabled = true
local autoCurveEnabled = true
local autoAimEnabled = false
local uiSmall = false

-- Function for Auto Parry
local function autoParry()
    if not autoParryEnabled then return end
    
    -- Detect incoming balls and perform parry
    for _, ball in pairs(workspace:GetChildren()) do
        if ball.Name == "Ball" and ball:FindFirstChild("Thrower") and ball.Thrower.Value ~= LocalPlayer then
            local distance = (ball.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if distance < 15 then -- Adjust distance threshold as needed
                local parryEvent = ReplicatedStorage:FindFirstChild("ParryEvent")
                if parryEvent then
                    parryEvent:FireServer(ball)
                    -- Trigger parry animation or feedback
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                        local animation = Instance.new("Animation")
                        animation.AnimationId = "rbxassetid://12345678" -- Replace with actual animation ID
                        local animator = LocalPlayer.Character.Humanoid:FindFirstChildOfClass("Animator")
                        if animator then
                            animator:LoadAnimation(animation):Play()
                        end
                    end
                end
            end
        end
    end
end

-- Function for Auto Curve Ball
local function autoCurveBall()
    if not autoCurveEnabled then return end
    
    -- Detect key press to curve the ball
    if UserInputService:IsKeyDown(Enum.KeyCode.E) then
        local curveEvent = ReplicatedStorage:FindFirstChild("CurveEvent")
        if curveEvent then
            curveEvent:FireServer() -- Replace with actual curve ball logic
        end
    end
end

-- Function for Auto Aim
local function autoAim()
    if not autoAimEnabled then return end
    
    -- Find nearest target to aim at
    local nearestBall = nil
    local shortestDistance = math.huge
    for _, ball in pairs(workspace:GetChildren()) do
        if ball.Name == "Ball" and ball:FindFirstChild("Thrower") and ball.Thrower.Value ~= LocalPlayer then
            local distance = (ball.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestBall = ball
            end
        end
    end
    
    -- Adjust player character's aim to target the nearest ball
    if nearestBall and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local direction = (nearestBall.Position - LocalPlayer.Character.HumanoidRootPart.Position).Unit
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.Position, LocalPlayer.Character.HumanoidRootPart.Position + direction)
    end
end

-- Function to Resize UI
local function resizeUI()
    if uiSmall then
        MainFrame.Size = UDim2.new(0, 300, 0, 200)
    else
        MainFrame.Size = UDim2.new(0, 150, 0, 100)
    end
    uiSmall = not uiSmall
end

-- Connecting functions to RenderStep for continuous checks
RunService.RenderStepped:Connect(function()
    autoParry()
    autoCurveBall()
    autoAim()
end)

-- Toggle Functions (Keybinds and UI Buttons to toggle Auto Parry, Auto Curve, Auto Aim, and Resize UI)
UserInputService.InputBegan:Connect(function(input, isProcessed)
    if isProcessed then return end
    if input.KeyCode == Enum.KeyCode.P then
        autoParryEnabled = not autoParryEnabled
        StatusLabel.Text = "Auto Parry: " .. (autoParryEnabled and "ON" or "OFF") .. "\nAuto Curve: " .. (autoCurveEnabled and "ON" or "OFF") .. "\nAuto Aim: " .. (autoAimEnabled and "ON" or "OFF")
    elseif input.KeyCode == Enum.KeyCode.C then
        autoCurveEnabled = not autoCurveEnabled
        StatusLabel.Text = "Auto Parry: " .. (autoParryEnabled and "ON" or "OFF") .. "\nAuto Curve: " .. (autoCurveEnabled and "ON" or "OFF") .. "\nAuto Aim: " .. (autoAimEnabled and "ON" or "OFF")
    elseif input.KeyCode == Enum.KeyCode.A then
        autoAimEnabled = not autoAimEnabled
        StatusLabel.Text = "Auto Parry: " .. (autoParryEnabled and "ON" or "OFF") .. "\nAuto Curve: " .. (autoCurveEnabled and "ON" or "OFF") .. "\nAuto Aim: " .. (autoAimEnabled and "ON" or "OFF")
    elseif input.KeyCode == Enum.KeyCode.R then
        resizeUI()
    end
end)

ToggleButtonParry.MouseButton1Click:Connect(function()
    autoParryEnabled = not autoParryEnabled
    StatusLabel.Text = "Auto Parry: " .. (autoParryEnabled and "ON" or "OFF") .. "\nAuto Curve: " .. (autoCurveEnabled and "ON" or "OFF") .. "\nAuto Aim: " .. (autoAimEnabled and "ON" or "OFF")
end)

ToggleButtonCurve.MouseButton1Click:Connect(function()
    autoCurveEnabled = not autoCurveEnabled
    StatusLabel.Text = "Auto Parry: " .. (autoParryEnabled and "ON" or "OFF") .. "\nAuto Curve: " .. (autoCurveEnabled and "ON" or "OFF") .. "\nAuto Aim: " .. (autoAimEnabled and "ON" or "OFF")
end)

ToggleButtonAutoAim.MouseButton1Click:Connect(function()
    autoAimEnabled = not autoAimEnabled
    StatusLabel.Text = "Auto Parry: " .. (autoParryEnabled and "ON" or "OFF") .. "\nAuto Curve: " .. (autoCurveEnabled and "ON" or "OFF") .. "\nAuto Aim: " .. (autoAimEnabled and "ON" or "OFF")
end)

ResizeButton.MouseButton1Click:Connect(function()
    resizeUI()
end)

-- Create a field of view indicator (only visible to the player)
local FoVPart = Instance.new("Part")
FoVPart.Anchored = true
FoVPart.CanCollide = false
FoVPart.CanQuery = false
FoVPart.CanTouch = false
FoVPart.Transparency = 0.9
FoVPart.Color = Color3.fromRGB(0, 255, 0)
FoVPart.Size = Vector3.new(30, 0.2, 30)
FoVPart.Shape = Enum.PartType.Cylinder
FoVPart.Parent = workspace
FoVPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0)

RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        FoVPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0)
    end
end)

print("Death Ball Script Loaded Successfully with Enhanced Features")
