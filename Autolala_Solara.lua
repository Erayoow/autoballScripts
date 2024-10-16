local userInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local ball = game.Workspace:WaitForChild("Part") -- Cambia "Part" por el nombre de tu bola
local attach = true
local autoHitEnabled = false -- Variable para controlar el golpe automático

local function CLC()
    if attach then
        VirtualInputManager:SendKeyEvent(true, "F", false, game) 
        attach = false
    end
end

local function toggleAutoHit()
    autoHitEnabled = not autoHitEnabled
end

-- Crear la GUI
local Gui = Instance.new("ScreenGui") 
Gui.Parent = player.PlayerGui

local autoHitButton = Instance.new("TextButton") 
autoHitButton.Parent = Gui
autoHitButton.Size = UDim2.new(0, 100, 0, 50) 
autoHitButton.Position = UDim2.new(0, 50, 0, 50) 
autoHitButton.Text = "Golpe Auto: Off"

autoHitButton.Activated:Connect(function()
    toggleAutoHit()
    autoHitButton.Text = "Golpe Auto: " .. (autoHitEnabled and "On" or "Off")
end)

-- Main loop
while true do
    wait(0.05) 
    if ball.Highlight.FillColor == Color3.new(1, 0, 0) then -- Cambia al color que necesites
        local playerPos = character.HumanoidRootPart.Position
        local distance = (ball.Position - playerPos).magnitude
        
        if autoHitEnabled and distance < 50 then -- Ajusta la distancia según sea necesario
            CLC()
        end
    else
        attach = true
    end
end
