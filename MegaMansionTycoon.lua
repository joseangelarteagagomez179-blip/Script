-- [[ Mega Mansion tycoon ]]
-- Creator: JoseAngel_Blox
-- Date: 05/06/2026

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- CONFIGURACIÓN DE ESTADOS
local States = {
    AutoCollect = false,
    AutoBuy = false
}

-- INTERFAZ GRÁFICA (UI) INDEPENDIENTE
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MegaMansion_Hub"
ScreenGui.ResetOnSpawn = false
-- Prevención de detección básica en CoreGui
local parentTarget = CoreGui:FindFirstChild("RobloxGui") or CoreGui
ScreenGui.Parent = parentTarget

-- 1. BURBUJA FLOTANTE REDONDA (LOGOTIPO)
local BubbleButton = Instance.new("TextButton")
local BubbleCorner = Instance.new("UICorner")
local BubbleStroke = Instance.new("UIStroke")

BubbleButton.Name = "LogoBubble"
BubbleButton.Size = UDim2.new(0, 55, 0, 55)
BubbleButton.Position = UDim2.new(0.05, 0, 0.2, 0)
BubbleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
BubbleButton.Text = "MM"
BubbleButton.TextColor3 = Color3.fromRGB(0, 170, 255)
BubbleButton.TextSize = 20
BubbleButton.Font = Enum.Font.GothamBold
BubbleButton.Active = true
BubbleButton.Draggable = true -- Te permite mover la burbuja donde quieras
BubbleButton.Parent = ScreenGui

BubbleCorner.CornerRadius = UDim.new(1, 0)
BubbleCorner.Parent = BubbleButton

BubbleStroke.Thickness = 2
BubbleStroke.Color = Color3.fromRGB(0, 170, 255)
BubbleStroke.Parent = BubbleButton

-- 2. PANEL PRINCIPAL
local MainFrame = Instance.new("Frame")
local MainCorner = Instance.new("UICorner")
local MainStroke = Instance.new("UIStroke")
local TitleLabel = Instance.new("TextLabel")
local InfoLabel = Instance.new("TextLabel")

MainFrame.Name = "MainHub"
MainFrame.Size = UDim2.new(0, 300, 0, 220)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -110)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
MainFrame.Visible = false -- Inicia oculto
MainFrame.Parent = ScreenGui

MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

MainStroke.Thickness = 1.5
MainStroke.Color = Color3.fromRGB(35, 35, 45)
MainStroke.Parent = MainFrame

-- Textos de Info y Creador
TitleLabel.Size = UDim2.new(1, 0, 0, 35)
TitleLabel.Text = "Mega Mansion Tycoon"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.BackgroundTransparency = 1
TitleLabel.Parent = MainFrame

InfoLabel.Size = UDim2.new(1, 0, 0, 20)
InfoLabel.Position = UDim2.new(0, 0, 0, 30)
InfoLabel.Text = "by JoseAngel_Blox | 05/06/2026"
InfoLabel.TextColor3 = Color3.fromRGB(120, 120, 130)
InfoLabel.TextSize = 11
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.BackgroundTransparency = 1
InfoLabel.Parent = MainFrame

-- 3. CREADOR DE BOTONES ON/OFF (ESTILO EXPLOIT REAL)
local function crearToggle(nombre, posicion, callback)
    local ToggleButton = Instance.new("TextButton")
    local ToggleCorner = Instance.new("UICorner")
    local StatusIndicator = Instance.new("Frame")
    local IndicatorCorner = Instance.new("UICorner")
    
    ToggleButton.Name = nombre.."_Toggle"
    ToggleButton.Size = UDim2.new(0, 260, 0, 40)
    ToggleButton.Position = posicion
    ToggleButton.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    ToggleButton.Text = "  "..nombre
    ToggleButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    ToggleButton.TextSize = 14
    ToggleButton.Font = Enum.Font.GothamSemibold
    ToggleButton.TextXAlignment = Enum.TextXAlignment.Left
    ToggleButton.Parent = MainFrame
    
    ToggleCorner.CornerRadius = UDim.new(0, 8)
    ToggleCorner.Parent = ToggleButton
    
    StatusIndicator.Size = UDim2.new(0, 16, 0, 16)
    StatusIndicator.Position = UDim2.new(1, -30, 0.5, -8)
    StatusIndicator.BackgroundColor3 = Color3.fromRGB(255, 65, 65) -- Rojo = Apagado
    StatusIndicator.Parent = ToggleButton
    
    IndicatorCorner.CornerRadius = UDim.new(1, 0)
    IndicatorCorner.Parent = StatusIndicator
    
    local activo = false
    ToggleButton.MouseButton1Click:Connect(function()
        activo = not activo
        if activo then
            TweenService:Create(StatusIndicator, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(65, 255, 65)}):Play() -- Verde
        else
            TweenService:Create(StatusIndicator, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 65, 65)}):Play()
        end
        callback(activo)
    end)
end

-- Asignar acciones a los Toggles
crearToggle("Auto Recolectar Dinero", UDim2.new(0, 20, 0, 75), function(val)
    States.AutoCollect = val
end)

crearToggle("Auto Comprar Botones", UDim2.new(0, 20, 0, 130), function(val)
    States.AutoBuy = val
end)

-- Mostrar/Ocultar Menú al presionar la burbuja redonda
BubbleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)


-- LÓGICA DE DETECCIÓN DEL JUEGO
local function getPlot()
    local tycoons = Workspace:FindFirstChild("Tycoons") or Workspace:FindFirstChild("Plots")
    if not tycoons then return nil end
    for _, tycoon in ipairs(tycoons:GetChildren()) do
        local owner = tycoon:FindFirstChild("Owner")
        if (owner and owner.Value == LocalPlayer) or tycoon.Name == LocalPlayer.Name then
            return tycoon
        end
    end
    return nil
end

local function fireTouch(part)
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp and part then
        firetouchinterest(hrp, part, 0)
        task.wait()
        firetouchinterest(hrp, part, 1)
    end
end


-- LOOPS PRINCIPALES (SÓLO ACTÚAN SI EL TOGGLE ESTÁ EN VERDE)
task.spawn(function()
    while true do
        task.wait(1.5)
        if States.AutoCollect then
            pcall(function()
                local plot = getPlot()
                if plot then
                    local mainParts = plot:FindFirstChild("MainParts") or plot:FindFirstChild("EssentialParts") or plot
                    local collector = mainParts and (mainParts:FindFirstChild("Collector") or mainParts:FindFirstChild("Giver"))
                    if collector then fireTouch(collector) end
                end
            end)
        end
    end
end)

task.spawn(function()
    while true do
        task.wait(0.4)
        if States.AutoBuy then
            pcall(function()
                local plot = getPlot()
                local buttons = plot and plot:FindFirstChild("Buttons")
                if buttons then
                    for _, button in ipairs(buttons:GetChildren()) do
                        if button:IsA("BasePart") and button.Transparency == 0 then
                            local dependency = button:FindFirstChild("Dependency")
                            if not (dependency and dependency.Value) then
                                fireTouch(button)
                                task.wait(0.05)
                            end
                        end
                    end
                end
            end)
        end
    end
end)
