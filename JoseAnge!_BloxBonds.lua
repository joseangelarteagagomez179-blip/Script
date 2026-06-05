--[[
    JoseAngel_Blox Bonds v1.0
    Sistema automático de farmeo de Bonds
    By JoseAngel
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Variables
local Farming = false
local BondsFarmeados = 0
local Connection

-- Efectos visuales
local function crearNotificacion(texto)
    spawn(function()
        local gui = Instance.new("ScreenGui")
        gui.Parent = LocalPlayer.PlayerGui
        
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 250, 0, 40)
        frame.Position = UDim2.new(0.5, -125, 0.85, 0)
        frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        frame.BackgroundTransparency = 0.2
        frame.BorderSizePixel = 0
        frame.ClipsDescendants = true
        frame.Parent = gui
        
        local gradient = Instance.new("UIGradient")
        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 180, 0)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 120, 0))
        })
        gradient.Rotation = 90
        gradient.Parent = frame
        
        local borde = Instance.new("Frame")
        borde.Size = UDim2.new(0, 2, 1, 0)
        borde.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
        borde.BorderSizePixel = 0
        borde.Parent = frame
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -10, 1, 0)
        label.Position = UDim2.new(0, 10, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = texto
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextSize = 14
        label.Font = Enum.Font.GothamBold
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        -- Animación
        frame.Position = UDim2.new(0.5, -125, 1, 0)
        local tweenIn = TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), 
            {Position = UDim2.new(0.5, -125, 0.85, 0)})
        tweenIn:Play()
        
        wait(2.5)
        
        local tweenOut = TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), 
            {Position = UDim2.new(0.5, -125, 1, 0)})
        tweenOut:Play()
        
        wait(0.3)
        gui:Destroy()
    end)
end

-- Buscar Bonds cercanos
local function buscarBond()
    local masCercano = nil
    local menorDistancia = math.huge
    
    for _, objeto in pairs(workspace:GetDescendants()) do
        if objeto:IsA("BasePart") and objeto.Name:lower():find("bond") then
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local distancia = (objeto.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                if distancia < menorDistancia and objeto:IsDescendantOf(workspace) then
                    menorDistancia = distancia
                    masCercano = objeto
                end
            end
        end
    end
    
    return masCercano
end

-- Función principal de farmeo
local function farmearBonds()
    while Farming do
        local bond = buscarBond()
        
        if bond and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local humanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
            if humanoid then
                local distancia = (bond.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                
                if distancia > 5 then
                    humanoid:MoveTo(bond.Position)
                end
                
                -- Recolectar si está cerca
                if distancia < 10 then
                    firetouchinterest(LocalPlayer.Character.HumanoidRootPart, bond, 0)
                    wait(0.1)
                    firetouchinterest(LocalPlayer.Character.HumanoidRootPart, bond, 1)
                    BondsFarmeados = BondsFarmeados + 1
                    
                    spawn(function()
                        crearNotificacion("🌟 Bond recolectado! Total: " .. BondsFarmeados)
                    end)
                    
                    wait(0.5)
                end
            end
        end
        
        wait(0.1)
    end
end

-- GUI Principal
local function crearGUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "JoseAngel_Blox"
    ScreenGui.Parent = LocalPlayer.PlayerGui
    ScreenGui.ResetOnSpawn = false
    
    -- Frame principal
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 280, 0, 120)
    MainFrame.Position = UDim2.new(0.5, -140, 0.3, -60)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.BorderSizePixel = 0
    MainFrame.BackgroundTransparency = 0.15
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui
    
    -- Borde superior con gradiente
    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, 4)
    TopBar.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame
    
    local barGradient = Instance.new("UIGradient")
    barGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 200, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 150, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 100, 0))
    })
    barGradient.Parent = TopBar
    
    -- Esquinas redondeadas
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = MainFrame
    
    -- Sombra
    local Shadow = Instance.new("ImageLabel")
    Shadow.Size = UDim2.new(1, 20, 1, 20)
    Shadow.Position = UDim2.new(0, -10, 0, -10)
    Shadow.BackgroundTransparency = 1
    Shadow.Image = "rbxassetid://1316045217"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.5
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    Shadow.Parent = MainFrame
    
    -- Título
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, 0, 0, 30)
    TitleLabel.Position = UDim2.new(0, 0, 0, 8)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "JoseAngel_Blox Bonds"
    TitleLabel.TextColor3 = Color3.fromRGB(255, 180, 0)
    TitleLabel.TextSize = 18
    TitleLabel.Font = Enum.Font.GothamBlack
    TitleLabel.Parent = MainFrame
    
    -- Contador
    local ContadorLabel = Instance.new("TextLabel")
    ContadorLabel.Size = UDim2.new(1, 0, 0, 20)
    ContadorLabel.Position = UDim2.new(0, 0, 0, 42)
    ContadorLabel.BackgroundTransparency = 1
    ContadorLabel.Text = "Bonds recolectados: 0"
    ContadorLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    ContadorLabel.TextSize = 12
    ContadorLabel.Font = Enum.Font.Gotham
    ContadorLabel.Name = "Contador"
    ContadorLabel.Parent = MainFrame
    
    -- Botón principal
    local FarmButton = Instance.new("TextButton")
    FarmButton.Name = "FarmButton"
    FarmButton.Size = UDim2.new(0, 240, 0, 35)
    FarmButton.Position = UDim2.new(0.5, -120, 0, 70)
    FarmButton.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
    FarmButton.BorderSizePixel = 0
    FarmButton.Text = "INICIAR FARM"
    FarmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    FarmButton.TextSize = 15
    FarmButton.Font = Enum.Font.GothamBold
    FarmButton.AutoButtonColor = false
    FarmButton.Parent = MainFrame
    
    -- Borde del botón
    local buttonBorder = Instance.new("UIStroke")
    buttonBorder.Thickness = 1
    buttonBorder.Color = Color3.fromRGB(255, 200, 0)
    buttonBorder.Transparency = 0.5
    buttonBorder.Parent = FarmButton
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 4)
    buttonCorner.Parent = FarmButton
    
    -- Efecto hover
    FarmButton.MouseEnter:Connect(function()
        FarmButton.BackgroundColor3 = Color3.fromRGB(255, 160, 20)
    end)
    
    FarmButton.MouseLeave:Connect(function()
        if not Farming then
            FarmButton.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
        end
    end)
    
    -- Actualizar contador
    spawn(function()
        while true do
            if ContadorLabel then
                ContadorLabel.Text = "Bonds recolectados: " .. BondsFarmeados
            end
            wait(0.5)
        end
    end)
    
    -- Función del botón
    FarmButton.MouseButton1Click:Connect(function()
        Farming = not Farming
        
        if Farming then
            FarmButton.Text = "⏸️  DETENER FARM"
            FarmButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
            
            crearNotificacion("⚡ AutoFarm de Bonds ACTIVADO")
            
            -- Iniciar farmeo
            Connection = RunService.RenderStepped:Connect(function()
                if not Farming then
                    if Connection then
                        Connection:Disconnect()
                    end
                    return
                end
            end)
            
            spawn(farmearBonds)
            
        else
            FarmButton.Text = "INICIAR FARM"
            FarmButton.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
            
            crearNotificacion("💤 AutoFarm de Bonds DESACTIVADO")
            
            if Connection then
                Connection:Disconnect()
            end
        end
    end)
    
    -- Botón cerrar
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 20, 0, 20)
    CloseButton.Position = UDim2.new(1, -24, 0, 6)
    CloseButton.BackgroundTransparency = 1
    CloseButton.Text = "✕"
    CloseButton.TextColor3 = Color3.fromRGB(150, 150, 150)
    CloseButton.TextSize = 16
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = MainFrame
    
    CloseButton.MouseButton1Click:Connect(function()
        Farming = false
        if Connection then
            Connection:Disconnect()
        end
        ScreenGui:Destroy()
    end)
end

-- Sistema de reconexión
LocalPlayer.CharacterAdded:Connect(function()
    if Farming then
        wait(1)
        spawn(farmearBonds)
    end
end)

-- Iniciar todo
crearGUI()
crearNotificacion("✅ JoseAngel_Blox Bonds cargado correctamente")
