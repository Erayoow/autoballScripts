-- Configuración inicial
getgenv().AutoParry = true
getgenv().Visualize = false

local players = game:GetService("Players")
local socialService = game:GetService("SocialService")
local statsService = game:GetService("Stats")
local replicated = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local player = players.LocalPlayer
local camera = workspace.CurrentCamera

-- Variables para el parry
local parried = false
local targetted = false
local opponent = nil
local event = nil

-- Creación de la interfaz
local function createUI()
    -- Creación de ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AutoParryUI"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    -- Creación del marco principal
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 200)
    mainFrame.Position = UDim2.new(0.5, -200, 0, 50)
    mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    mainFrame.BorderSizePixel = 2
    mainFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
    mainFrame.Parent = screenGui
    
    -- Efecto de esquina redondeada
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.05, 0)
    corner.Parent = mainFrame
    
    -- Texto "NANO" en la parte superior
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Text = "NANO"
    titleLabel.Size = UDim2.new(1, 0, 0, 50)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextScaled = true
    titleLabel.Parent = mainFrame

    -- Texto de estado
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Text = "Auto Parry: Enabled"
    statusLabel.Size = UDim2.new(1, 0, 0, 50)
    statusLabel.Position = UDim2.new(0, 0, 0.4, 0)
    statusLabel.BackgroundTransparency = 1
    statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextScaled = true
    statusLabel.Parent = mainFrame
    
    -- Botón de encendido/apagado
    local toggleButton = Instance.new("TextButton")
    toggleButton.Text = "Disable Auto Parry"
    toggleButton.Size = UDim2.new(0, 200, 0, 50)
    toggleButton.Position = UDim2.new(0.5, -100, 0.7, 0)
    toggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.Font = Enum.Font.GothamBold
    toggleButton.TextScaled = true
    toggleButton.Parent = mainFrame
    
    -- Funcionalidad del botón
    local function toggleAutoParry()
        if getgenv().AutoParry then
            getgenv().AutoParry = false
            toggleButton.Text = "Enable Auto Parry"
            statusLabel.Text = "Auto Parry: Disabled"
            statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0) -- Cambia el color a rojo
            toggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Cambia el botón a verde
        else
            getgenv().AutoParry = true
            toggleButton.Text = "Disable Auto Parry"
            statusLabel.Text = "Auto Parry: Enabled"
            statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0) -- Cambia el color a verde
            toggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Cambia el botón a rojo
        end
    end
    
    -- Conectar el evento de clic del botón con la función
    toggleButton.MouseButton1Click:Connect(toggleAutoParry)
    
    -- Animación de entrada
    local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = tweenService:Create(mainFrame, tweenInfo, {Position = UDim2.new(0.5, -200, 0.2, 50)})
    tween:Play()
    
    return statusLabel
end

-- Llamada a la función para crear la UI
local statusLabel = createUI()

-- Creación de la esfera (si está activada la visualización)
local function createSphere()
    local sphere = Instance.new("Part")
    sphere.Material = Enum.Material.ForceField
    sphere.Anchored = true
    sphere.CanCollide = false
    sphere.Parent = workspace
    sphere.CastShadow = false
    sphere.Shape = Enum.PartType.Ball
    sphere.Color = Color3.fromRGB(255, 0, 0)
    return sphere
end

local sphere = getgenv().Visualize and createSphere() or nil

function parry()
    local cf = camera.CFrame
    local x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = cf:GetComponents()

    local args = {
        [1] = 0,
        [2] = CFrame.new(x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22),
        [3] = {},
        [4] = {
            [1] = camera.ViewportSize.X / 2,
            [2] = camera.ViewportSize.Y / 2
        },
        [5] = false
    }

    event = event or socialService:WaitForChild("\n")

    if event then
        event:FireServer(unpack(args))
    end
end

function getBall()
    local realBall = nil

    for _, ball in pairs(workspace.Balls:GetChildren()) do
        if not ball:GetAttribute("realBall") then continue end

        realBall = ball
        break
    end

    return realBall
end

function getPing()
    return statsService:FindFirstChild("PerformanceStats"):FindFirstChild("Ping"):GetValue()
end

function isWalking()
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return false, "N/A" end

    local hrp = character:FindFirstChild("HumanoidRootPart")
    local velocity = hrp.Velocity

    if velocity.Magnitude > 2 then
        if math.abs(velocity.X) > math.abs(velocity.Z) then
            return true, (velocity.X > 0 and "Right" or "Left")
        else
            return true, (velocity.Z > 0 and "Forward" or "Backward")
        end
    end

    return false, "Stationary"
end

local function onPlayerDeath()
    if getgenv().Visualize then
        if sphere then
            sphere:Destroy()
        end
    end
end

player.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid").Died:Connect(onPlayerDeath)
end)

while getgenv().AutoParry do
    task.wait()

    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then continue end
    
    local ball = getBall()
    if not ball then continue end
    
    local hrp = character:FindFirstChild("HumanoidRootPart")
    local distance = (hrp.Position - ball.Position).Magnitude
    local speed = ball.AssemblyLinearVelocity.Magnitude
    
    local desiredVelocity = (hrp.Position - ball.Position).Unit
    local actualVelocity = ball.AssemblyLinearVelocity.Unit
    local dot = desiredVelocity:Dot(actualVelocity)
    local curve = (1 - dot) / 2
    local radius = (speed * 0.5) * (1 + (curve / 4))

    local ping = getPing() / 1000
    radius = radius + ping

    local isWalking, direction = isWalking()
    if isWalking then
        radius = radius + 2
    end

    if ball:GetAttribute("target") ~= player.Name then
        opponent = players:FindFirstChild(ball:GetAttribute("target")) or workspace.Alive:FindFirstChild(ball:GetAttribute("target"))
        opponent = opponent and opponent:IsA("Player") and opponent.Character or opponent
    end

    if ball:GetAttribute("target") == player.Name and not targetted then
        parried = false
    end
    
    local opponentDistance = opponent and opponent:FindFirstChild("HumanoidRootPart") and (hrp.Position - opponent.HumanoidRootPart.Position).Magnitude or 99999
    
    if getgenv().Visualize and sphere then
        sphere.CFrame = hrp.CFrame
        sphere.Size = Vector3.new(radius, radius, radius)
    end
    
    targetted = ball:GetAttribute("target") == player.Name
    
    if curve > 0.5 or speed <= 0 then continue end
    if distance > radius then continue end
    if ball:GetAttribute("target") ~= player.Name then continue end
    if parried then continue end
    
    parried = speed > 5
    if parried then
        parry()
    end
end

if sphere then sphere:Destroy() end
