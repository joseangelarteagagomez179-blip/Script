-- JoseAngel_Blox Bonds v1.1 (CORREGIDO)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Farming = false
local BondsFarmeados = 0

-- Buscar bonds cercanos
local function buscarBond()
    local masCercano = nil
    local menorDistancia = math.huge
    
    -- Buscar en workspace y sus hijos
    for _, objeto in ipairs(workspace:GetDescendants()) do
        if objeto:IsA("BasePart") and objeto.Name and objeto.Name:lower():find("bond") then
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local distancia = (objeto.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                if distancia < menorDistancia then
                    menorDistancia = distancia
                    masCercano = objeto
                end
            end
        end
    end
    return masCercano, menorDistancia
end

-- Función principal de farmeo (CORREGIDA)
local function farmearBonds()
    while Farming do
        local bond, distancia = buscarBond()
        
        if bond and LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
            local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            
            if humanoid and hrp then
                -- Mover hacia la bond
                if distancia > 3 then
                    humanoid:MoveTo(bond.Position)
                end
                
                -- Si está MUY cerca (tocando), se recolecta automáticamente
                -- No necesita firetouchinterest si el personaje realmente la toca
                if distancia < 4 then
                    -- Esperar a que el juego detecte el contacto natural
                    wait(0.3)
                    
                    -- Verificar si la bond aún existe (fue recolectada?)
                    if bond and bond.Parent then
                        BondsFarmeados = BondsFarmeados + 1
                        print("✅ Bond recolectada! Total: " .. BondsFarmeados)
                        
                        -- Notificación simple
                        game.StarterGui:SetCore("SendNotification", {
                            Title = "Blox Bonds",
                            Text = "🌟 Bond recolectada! Total: " .. BondsFarmeados,
                            Duration = 2
                        })
                    end
                    wait(0.5)
                end
            end
        end
        wait(0.1)
    end
end

-- GUI Simple
local function crearGUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "BloxBonds"
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 200, 0, 80)
    frame.Position = UDim2.new(0.5, -100, 0.3, 0)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = ScreenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local titulo = Instance.new("TextLabel")
    titulo.Size = UDim2.new(1, 0, 0, 25)
    titulo.BackgroundTransparency = 1
    titulo.Text = "Blox Bonds Farm"
    titulo.TextColor3 = Color3.fromRGB(255, 170, 0)
    titulo.TextSize = 14
    titulo.Font = Enum.Font.GothamBold
    titulo.Parent = frame
    
    local contador = Instance.new("TextLabel")
    contador.Size = UDim2.new(1, 0, 0, 20)
    contador.Position = UDim2.new(0, 0, 0, 28)
    contador.BackgroundTransparency = 1
    contador.Text = "Recolectados: 0"
    contador.TextColor3 = Color3.fromRGB(200, 200, 200)
    contador.TextSize = 12
    contador.Parent = frame
    
    local boton = Instance.new("TextButton")
    boton.Size = UDim2.new(0, 160, 0, 30)
    boton.Position = UDim2.new(0.5, -80, 0, 50)
    boton.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
    boton.Text = "INICIAR"
    boton.TextColor3 = Color3.fromRGB(255, 255, 255)
    boton.TextSize = 13
    boton.Font = Enum.Font.GothamBold
    boton.Parent = frame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = boton
    
    -- Actualizar contador
    spawn(function()
        while true do
            wait(0.3)
            contador.Text = "Recolectados: " .. BondsFarmeados
        end
    end)
    
    -- Botón toggle
    boton.MouseButton1Click:Connect(function()
        Farming = not Farming
        if Farming then
            boton.Text = "DETENER"
            boton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            spawn(farmearBonds)
        else
            boton.Text = "INICIAR"
            boton.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
        end
    end)
end

-- Iniciar
crearGUI()
