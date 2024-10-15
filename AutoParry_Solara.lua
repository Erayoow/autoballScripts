-- Adapted Script for Death Ball with Auto Parry, Auto Curve Ball, and UI

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- User Interface Creation
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")

ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "NanoInterface"
ScreenGui.ResetOnSpawn = false

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0, 300, 0, 100)
MainFrame.Visible = true

TitleLabel.Parent = MainFrame
TitleLabel.Text = "NANO"
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 30
TitleLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
TitleLabel.Size = UDim2.new(1, 0, 0.3, 0)
TitleLabel.BackgroundTransparency = 1

-- Variables for Auto Parry and Curve Ball
local autoParryEnabled = true
local autoCurveEnabled = true

-- Function for Auto Parry
local function autoParry()
    if not autoParryEnabled then return end
    
    -- Assuming the game has a "Ball" object and we detect incoming balls
    for _, ball in pairs(workspace:GetChildren()) do
        if ball.Name == "Ball" and ball:FindFirstChild("Thrower") and ball.Thrower.Value ~= LocalPlayer then
            local distance = (ball.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if distance < 15 then -- Adjust distance threshold as needed
                -- Perform parry
                local parryEvent = game.ReplicatedStorage:FindFirstChild("ParryEvent")
                if parryEvent then
                    parryEvent:FireServer(ball)
                    -- Ensure animation or visual feedback is triggered
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                        LocalPlayer.Character.Humanoid:LoadAnimation(script.ParryAnimation):Play()
                    end
                end
            end
        end
    end
end

-- Function for Auto Curve Ball
local function autoCurveBall()
    if not autoCurveEnabled then return end
    
    -- Assuming there's a way to curve the ball after throwing
    if UserInputService:IsKeyDown(Enum.KeyCode.E) then
        local curveEvent = game.ReplicatedStorage:FindFirstChild("CurveEvent")
        if curveEvent then
            curveEvent:FireServer() -- Replace with actual curve ball logic
        end
    end
end

-- Connecting functions to RenderStep for continuous checks
RunService.RenderStepped:Connect(function()
    autoParry()
    autoCurveBall()
end)

-- Toggle Functions (You can set up keybinds to toggle Auto Parry and Auto Curve)
UserInputService.InputBegan:Connect(function(input, isProcessed)
    if isProcessed then return end
    if input.KeyCode == Enum.KeyCode.P then
        autoParryEnabled = not autoParryEnabled
        TitleLabel.Text = "NANO - Auto Parry: " .. (autoParryEnabled and "ON" or "OFF")
    elseif input.KeyCode == Enum.KeyCode.C then
        autoCurveEnabled = not autoCurveEnabled
        TitleLabel.Text = "NANO - Auto Curve: " .. (autoCurveEnabled and "ON" or "OFF")
    end
end)  

-- Create a field of view indicator (only visible to the player)
local FoVPart = Instance.new("Part")
FoVPart.Anchored = true
FoVPart.CanCollide = false
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

print("Death Ball Script Loaded Successfully")
