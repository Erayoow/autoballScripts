local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.5, 0, 0.7, 0)
frame.Position = UDim2.new(0.25, 0.1, 0.1, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Parent = gui

local gradient = Instance.new("UIGradient")
gradient.Rotation = 45
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),  -- Preto
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))  -- Vermelho
})
gradient.Parent = frame

local title = Instance.new("TextLabel")
title.Text = "My Little Porn v1"
title.Font = Enum.Font.GothamSemibold
title.TextSize = 36
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Position = UDim2.new(0.5, 0, 0.1, 0)
title.AnchorPoint = Vector2.new(0.5, 0)
title.Parent = frame

local function CreateRandomPosition()
    return UDim2.new(math.random(), 0, math.random(), 0)
end

local function CreateRandomDrawing()
    local drawing = Instance.new("ImageLabel")
    drawing.Size = UDim2.new(0, math.random(50, 100), 0, math.random(50, 100))
    drawing.Position = CreateRandomPosition()
    drawing.Image = "rbxassetid://13334354464"  -- Substitua pelo ID da sua imagem
    drawing.Parent = frame
end

-- Crie alguns desenhos aleatórios
for _ = 1, 5 do
    CreateRandomDrawing()
end

local button1 = Instance.new("TextButton")
button1.Text = "Spirit Boss"
button1.Size = UDim2.new(0, 250, 0, 55)
button1.Position = UDim2.new(0.5, 0, 0.4, 0)
button1.AnchorPoint = Vector2.new(0.5, 0)
button1.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
button1.TextColor3 = Color3.fromRGB(255, 255, 255)
button1.Font = Enum.Font.SourceSansBold
button1.TextSize = 24
button1.Parent = frame

local button2 = Instance.new("TextButton")
button2.Text = "Mecha Boss"
button2.Size = UDim2.new(0, 250, 0, 55)
button2.Position = UDim2.new(0.5, 0, 0.6, 0)
button2.AnchorPoint = Vector2.new(0.5, 0)
button2.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
button2.TextColor3 = Color3.fromRGB(255, 255, 255)
button2.Font = Enum.Font.SourceSansBold
button2.TextSize = 24
button2.Parent = frame

local function ShowSubcategories(buttonName)
    print("Botão '" .. buttonName .. "' pressionado!")
    -- Insira o código específico para cada botão aqui
    if buttonName == "Spirit Boss" then
        local player = game.Players.LocalPlayer
        local bossPosition = Vector3.new(483.05, 333.55, 1222.51)  -- Coordenadas do boss
        local lobbyPosition = Vector3.new(467.59, 285.60, 844.08)   -- Coordenadas do lobby

        -- Variável para controlar o estado do script
        local isTeleporting = false
        local bossPartCreated = false

        -- Função para teleportar o jogador para o boss
        local function teleportToBoss()
            if not isTeleporting then
                isTeleporting = true
                while isTeleporting do
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(bossPosition)
                    wait()  -- Pequeno atraso para tornar o teleporte imperceptível
                    if not bossPartCreated then
                        bossPartCreated = true
                        -- Crie a parte do BOSS aqui (seu código para criar a parte)
                        -- Por exemplo, você pode usar Instance.new() para criar uma parte
                        local bossPart = Instance.new("Part")
                        bossPart.Size = Vector3.new(11, 11, 11)  -- Tamanho da parte do BOSS
                        bossPart.Position = bossPosition + Vector3.new(0, -7, 0)  -- Posição abaixo da coordenada do boss
                        bossPart.Anchored = true
                        bossPart.Parent = game.Workspace  -- Adicione à Workspace ou outro objeto relevante
                    end
                end
            end
        end

        -- Função para teleportar o jogador para o lobby
        local function teleportToLobby()
            isTeleporting = false
            player.Character.HumanoidRootPart.CFrame = CFrame.new(lobbyPosition)
        end

        -- Crie os botões para teleportar
        local gui = Instance.new("ScreenGui")
        gui.Parent = player.PlayerGui

        local bossButton = Instance.new("TextButton")
        bossButton.Position = UDim2.new(0.8, 0, 0.45, 0)
        bossButton.Size = UDim2.new(0, 150, 0, 35)
        bossButton.Parent = gui
        bossButton.Text = "BOSS farm"
        bossButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)  -- Azul
        bossButton.Font = Enum.Font.SourceSansBold
        bossButton.TextSize = 18  -- Aumente o tamanho da fonte
        bossButton.MouseButton1Click:Connect(teleportToBoss)  -- Conecte ao teleport para o boss

        local lobbyButton = Instance.new("TextButton")
        lobbyButton.Position = UDim2.new(0.8, 0, 0.55, 0)
        lobbyButton.Size = UDim2.new(0, 150, 0, 35)
        lobbyButton.Parent = gui
        lobbyButton.Text = "LOBBY"
        lobbyButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)  -- Azul
        lobbyButton.Font = Enum.Font.SourceSansBold
        lobbyButton.TextSize = 20  -- Aumente o tamanho da fonte
        lobbyButton.MouseButton1Click:Connect(teleportToLobby)  -- Conecte ao teleport para o lobby

        -- Crie a hub maior com o texto "BY CALiXTO"
        local hubBackground = Instance.new("TextLabel")
        hubBackground.Size = UDim2.new(0, 400, 0, 100)
        hubBackground.Position = UDim2.new(0.87, 0, 0.3, 0)
        hubBackground.AnchorPoint = Vector2.new(0.5, 0.5)
        hubBackground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        hubBackground.BackgroundTransparency = 0.5
        hubBackground.Text = "BY CALiXTO and COPiLOT AI"
        hubBackground.Font = Enum.Font.SourceSansBold
        hubBackground.TextSize = 24
        hubBackground.TextColor3 = Color3.fromRGB(255, 255, 255)
        hubBackground.Parent = gui

        -- Código para Spirit Boss (continuado)
    elseif buttonName == "Mecha Boss" then
        local player = game.Players.LocalPlayer
        local bossPosition = Vector3.new(483.05, 333.55, 1222.51)  -- Coordenadas do boss
        local lobbyPosition = Vector3.new(467.59, 285.60, 844.08)   -- Coordenadas do lobby

        -- Variável para controlar o estado do script
        local isTeleporting = false
        local bossPartCreated = false

        -- Função para teleportar o jogador para o boss
        local function teleportToBoss()
            if not isTeleporting then
                isTeleporting = true
                while isTeleporting do
                    player.Character.HumanoidRootPart.CFrame = CFrame.new(bossPosition)
                    wait()  -- Pequeno atraso para tornar o teleporte imperceptível
                    if not bossPartCreated then
                        bossPartCreated = true
                        -- Crie a parte do BOSS aqui (seu código para criar a parte)
                        -- Por exemplo, você pode usar Instance.new() para criar uma parte
                        local bossPart = Instance.new("Part")
                        bossPart.Size = Vector3.new(11, 11, 11)  -- Tamanho da parte do BOSS
                        bossPart.Position = bossPosition + Vector3.new(0, -7, 0)  -- Posição abaixo da coordenada do boss
                        bossPart.Anchored = true
                        bossPart.Parent = game.Workspace  -- Adicione à Workspace ou outro objeto relevante
                    end
                end
            end
        end

        -- Função para teleportar o jogador para o lobby
        local function teleportToLobby()
            isTeleporting = false
            player.Character.HumanoidRootPart.CFrame = CFrame.new(lobbyPosition)
        end

        -- Crie os botões para teleportar
        local gui = Instance.new("ScreenGui")
        gui.Parent = player.PlayerGui

        local bossButton = Instance.new("TextButton")
        bossButton.Position = UDim2.new(0.8, 0, 0.45, 0)
        bossButton.Size = UDim2.new(0, 150, 0, 35)
        bossButton.Parent = gui
        bossButton.Text = "BOSS farm"
        bossButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)  -- Azul
        bossButton.Font = Enum.Font.SourceSansBold
        bossButton.TextSize = 18  -- Aumente o tamanho da fonte
        bossButton.MouseButton1Click:Connect(teleportToBoss)  -- Conecte ao teleport para o boss

        local lobbyButton = Instance.new("TextButton")
        lobbyButton.Position = UDim2.new(0.8, 0, 0.55, 0)
        lobbyButton.Size = UDim2.new(0, 150, 0, 35)
        lobbyButton.Parent = gui
        lobbyButton.Text = "LOBBY"
        lobbyButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)  -- Azul
        lobbyButton.Font = Enum.Font.SourceSansBold
        lobbyButton.TextSize = 20  -- Aumente o tamanho da fonte
        lobbyButton.MouseButton1Click:Connect(teleportToLobby)  -- Conecte ao teleport para o lobby

        -- Crie a hub maior com o texto "BY CALiXTO"
        local hubBackground = Instance.new("TextLabel")
        hubBackground.Size = UDim2.new(0, 400, 0, 100)
        hubBackground.Position = UDim2.new(0.87, 0, 0.3, 0)
        hubBackground.AnchorPoint = Vector2.new(0.5, 0.5)
        hubBackground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        hubBackground.BackgroundTransparency = 0.5
        hubBackground.Text = "BY CALiXTO and COPiLOT AI"
        hubBackground.Font = Enum.Font.SourceSansBold
        hubBackground.TextSize = 24
        hubBackground.TextColor3 = Color3.fromRGB(255, 255, 255)
        hubBackground.Parent = gui

        -- Código para Mecha Boss (continuado)
    end

    wait(1)
    frame:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 1, true)
    wait(1)
    gui:Destroy()
end

button1.MouseButton1Click:Connect(function()
    ShowSubcategories("Spirit Boss")
end)

button2.MouseButton1Click:Connect(function()
    ShowSubcategories("Mecha Boss")
end)
