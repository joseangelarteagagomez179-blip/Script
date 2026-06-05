-- GIGA MANSIÓN TYCOON - SCRIPT PERSONALIZADO
-- Solo válido para: https://www.roblox.com/es/games/14238596528/Giga-Mansion-Tycoon


-- VERIFICACIÓN DEL JUEGO
local GAME_ID = 14238596528
if game.PlaceId ~= GAME_ID then
    warn("Este script solo funciona en Giga Mansion Tycoon (ID: 14238596528)")
    return
end


-- SERVICIOS
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer


-- INTERFAZ GRÁFICA
local UI = Instance.new("ScreenGui")
UI.Name = "GigaMansionTycoon_CustomScript"
UI.Parent = LocalPlayer.PlayerGui


-- FONDO PRINCIPAL
local MainBackground = Instance.new("Frame")
MainBackground.Name = "FondoPrincipal"
MainBackground.Size = UDim2.new(0, 320, 0, 450)
MainBackground.Position = UDim2.new(0.02, 0, 0.5, -225)
MainBackground.BackgroundColor3 = Color3.fromRGB(20, 40, 80)
MainBackground.BorderSizePixel = 0
MainBackground.Parent = UI

-- GRADIENTE DE FONDO
local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 40, 80)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(35, 65, 120)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 30, 60))
})
Gradient.Rotation = 45
Gradient.Parent = MainBackground

-- BORDE DECORATIVO
local Border = Instance.new("Frame")
Border.Name = "BordeDecorativo"
Border.Size = UDim2.new(1, 10, 1, 10)
Border.Position = UDim2.new(0, -5, 0, -5)
Border.BackgroundTransparency = 1
Border.BorderColor3 = Color3.fromRGB(255, 180, 50)
Border.BorderSizePixel = 2
Border.Parent = MainBackground


-- TÍTULO
local Title = Instance.new("TextLabel")
Title.Name = "Titulo"
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "GIGA MANSIÓN TYCOON"
Title.TextColor3 = Color3.fromRGB(255, 200, 60)
Title.TextScaled = true
Title.Font = Enum.Font.RobotoMono
Title.Parent = MainBackground

-- LÍNEA DIVISORIA
local TitleLine = Instance.new("Frame")
TitleLine.Name = "LineaTitulo"
TitleLine.Size = UDim2.new(0.8, 0, 0, 2)
TitleLine.Position = UDim2.new(0.1, 0, 0, 55)
TitleLine.BackgroundColor3 = Color3.fromRGB(255, 180, 50)
TitleLine.BorderSizePixel = 0
TitleLine.Parent = MainBackground


-- PANEL DE OPCIONES
local OptionsFrame = Instance.new("Frame")
OptionsFrame.Name = "PanelOpciones"
OptionsFrame.Size = UDim2.new(1, -20, 0, 370)
OptionsFrame.Position = UDim2.new(0, 10, 0, 70)
OptionsFrame.BackgroundTransparency = 1
OptionsFrame.Parent = MainBackground


-- BOTÓN INFO
local InfoButton = Instance.new("TextButton")
InfoButton.Name = "BotonInfo"
InfoButton.Size = UDim2.new(1, 0, 0, 60)
InfoButton.Position = UDim2.new(0, 0, 0, 0)
InfoButton.BackgroundColor3 = Color3.fromRGB(255, 180, 50)
InfoButton.BorderSizePixel = 0
InfoButton.Text = "INFO DEL SCRIPT"
InfoButton.TextColor3 = Color3.fromRGB(10, 20, 40)
InfoButton.TextScaled = true
InfoButton.Font = Enum.Font.RobotoBold
InfoButton.Parent = OptionsFrame


-- BOTÓN MAIN
local MainButton = Instance.new("TextButton")
MainButton.Name = "BotonMain"
MainButton.Size = UDim2.new(1, 0, 0, 60)
MainButton.Position = UDim2.new(0, 0, 0, 70)
MainButton.BackgroundColor3 = Color3.fromRGB(40, 100, 180)
MainButton.BorderSizePixel = 0
MainButton.Text = "FUNCIONES PRINCIPALES"
MainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MainButton.TextScaled = true
MainButton.Font = Enum.Font.RobotoBold
MainButton.Parent = OptionsFrame


-- EFECTO HOVER PARA BOTONES
local function HoverEffect(button, originalColor, hoverColor)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = originalColor}):Play()
    end)
end

HoverEffect(InfoButton, Color3.fromRGB(255, 180, 50), Color3.fromRGB(255, 210, 80))
HoverEffect(MainButton, Color3.fromRGB(40, 100, 180), Color3.fromRGB(60, 130, 210))


-- PANEL DE INFORMACIÓN
local InfoPanel = Instance.new("Frame")
InfoPanel.Name = "PanelInformacion"
InfoPanel.Size = UDim2.new(1, 0, 0, 220)
InfoPanel.Position = UDim2.new(0, 0, 0, 140)
InfoPanel.BackgroundTransparency = 0.3
InfoPanel.BackgroundColor3 = Color3.fromRGB(10, 20, 40)
InfoPanel.BorderSizePixel = 0
InfoPanel.Visible = false
InfoPanel.Parent = OptionsFrame

local InfoText = Instance.new("TextLabel")
InfoText.Name = "TextoInfo"
InfoText.Size = UDim2.new(1, -20, 1, -20)
InfoText.Position = UDim2.new(0, 10, 0, 10)
InfoText.BackgroundTransparency = 1
InfoText.Text = "INFORMACIÓN DEL SCRIPT\n\nNombre del creador: JoseAngel_Blox\nFecha de creación: 05/06/2026\n\nSolo válido para Giga Mansion Tycoon\nVersión: 1.0"
InfoText.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoText.TextSize = 18
InfoText.Font = Enum.Font.Roboto
InfoText.TextWrapped = true
InfoText.Parent = InfoPanel


-- PANEL DE FUNCIONES PRINCIPALES
local MainPanel = Instance.new("Frame")
MainPanel.Name = "PanelFunciones"
MainPanel.Size = UDim2.new(1, 0, 0, 220)
MainPanel.Position = UDim2.new(0, 0, 0, 140)
MainPanel.BackgroundTransparency = 0.3
MainPanel.BackgroundColor3 = Color3.fromRGB(10, 20, 40)
MainPanel.BorderSizePixel = 0
MainPanel.Visible = false
MainPanel.Parent = OptionsFrame


-- BOTÓN AUTO CONSTRUIR
local AutoBuildButton = Instance.new("TextButton")
AutoBuildButton.Name = "BotonAutoConstruir"
AutoBuildButton.Size = UDim2.new(1, -20, 0, 50)
AutoBuildButton.Position = UDim2.new(0, 10, 0, 20)
AutoBuildButton.BackgroundColor3 = Color3.fromRGB(30, 150, 80)
AutoBuildButton.BorderSizePixel = 0
AutoBuildButton.Text = "AUTO CONSTRUIR TODAS LAS ÁREAS"
AutoBuildButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoBuildButton.TextScaled = true
AutoBuildButton.Font = Enum.Font.RobotoMedium
AutoBuildButton.Parent = MainPanel

local AutoBuildState = Instance.new("TextLabel")
AutoBuildState.Name = "EstadoAutoConstruir"
AutoBuildState.Size = UDim2.new(1, -20, 0, 20)
AutoBuildState.Position = UDim2.new(0, 10, 0, 75)
AutoBuildState.BackgroundTransparency = 1
AutoBuildState.Text = "Estado: DESACTIVADO"
AutoBuildState.TextColor3 = Color3.fromRGB(255, 80, 80)
AutoBuildState.TextSize = 14
AutoBuildState.Font = Enum.Font.Roboto
AutoBuildState.Parent = MainPanel

HoverEffect(AutoBuildButton, Color3.fromRGB(30, 150, 80), Color3.fromRGB(50, 180, 100))


-- BOTÓN RECOGER DINERO
local CollectMoneyButton = Instance.new("TextButton")
CollectMoneyButton.Name = "BotonRecogerDinero"
CollectMoneyButton.Size = UDim2.new(1, -20, 0, 50)
CollectMoneyButton.Position = UDim2.new(0, 10, 0, 105)
CollectMoneyButton.BackgroundColor3 = Color3.fromRGB(200, 120, 30)
CollectMoneyButton.BorderSizePixel = 0
CollectMoneyButton.Text = "RECOGER DINERO AUTOMÁTICO"
CollectMoneyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CollectMoneyButton.TextScaled = true
CollectMoneyButton.Font = Enum.Font.RobotoMedium
CollectMoneyButton.Parent = MainPanel

local CollectMoneyState = Instance.new("TextLabel")
CollectMoneyState.Name = "EstadoRecogerDinero"
CollectMoneyState.Size = UDim2.new(1, -20, 0, 20)
CollectMoneyState.Position = UDim2.new(0, 10, 0, 160)
CollectMoneyState.BackgroundTransparency = 1
CollectMoneyState.Text = "Estado: DESACTIVADO"
CollectMoneyState.TextColor3 = Color3.fromRGB(255, 80, 80)
CollectMoneyState.TextSize = 14
CollectMoneyState.Font = Enum.Font.Roboto
CollectMoneyState.Parent = MainPanel

HoverEffect(CollectMoneyButton, Color3.fromRGB(200, 120, 30), Color3.fromRGB(230, 150, 50))


-- MOSTRAR Y OCULTAR PANELES
local currentOpenPanel = nil

local function TogglePanel(panel)
    if currentOpenPanel == panel then
        panel.Visible = false
        currentOpenPanel = nil
    else
        if currentOpenPanel then currentOpenPanel.Visible = false end
        panel.Visible = true
        currentOpenPanel = panel
    end
end

InfoButton.MouseButton1Click:Connect(function() TogglePanel(InfoPanel) end)
MainButton.MouseButton1Click:Connect(function() TogglePanel(MainPanel) end)


-- MOVER INTERFAZ
local dragging = false
local dragStartPos = Vector2.new()
local uiStartPos = UDim2.new()

MainBackground.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStartPos = UserInputService:GetMouseLocation()
        uiStartPos = MainBackground.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mousePos = UserInputService:GetMouseLocation()
        local delta = mousePos - dragStartPos
        MainBackground.Position = UDim2.new(
            uiStartPos.X.Scale,
            uiStartPos.X.Offset + delta.X,
            uiStartPos.Y.Scale,
            uiStartPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)


-- FUNCIONALIDADES
local autoBuildActive = false
local autoCollectActive = false

-- OBTENER ÁREAS DEL JUEGO
local function GetAllAreas()
    local tycoon = workspace.Tycoons:FindFirstChild(LocalPlayer.Name)
    if not tycoon then return {} end
    
    local areas = {}
    for _, area in ipairs(tycoon:GetChildren()) do
        if area:FindFirstChild("BuildButton") or area:FindFirstChild("UpgradeButton") then
            table.insert(areas, area)
        end
    end
    return areas
end

-- AUTO CONSTRUIR
local function AutoBuild()
    while autoBuildActive do
        local areas = GetAllAreas()
        for _, area in ipairs(areas) do
            local buildButton = area:FindFirstChild("BuildButton")
            if buildButton and buildButton:FindFirstChild("ClickDetector") then
                fireclickdetector(buildButton.ClickDetector)
                task.wait(0.2)
            end
            
            local upgradeButton = area:FindFirstChild("UpgradeButton")
            if upgradeButton and upgradeButton:FindFirstChild("ClickDetector") then
                fireclickdetector(upgradeButton.ClickDetector)
                task.wait(0.2)
            end
        end
        task.wait(1)
    end
end

AutoBuildButton.MouseButton1Click:Connect(function()
    autoBuildActive = not autoBuildActive
    if autoBuildActive then
        AutoBuildState.Text = "Estado: ACTIVADO"
        AutoBuildState.TextColor3 = Color3.fromRGB(80, 255, 80)
        task.spawn(AutoBuild)
    else
        AutoBuildState.Text = "Estado: DESACTIVADO"
        AutoBuildState.TextColor3 = Color3.fromRGB(255, 80, 80)
    end
end)

-- AUTO RECOGER DINERO
local function AutoCollectMoney()
    while autoCollectActive do
        local tycoon = workspace.Tycoons:FindFirstChild(LocalPlayer.Name)
        if tycoon then
            for _, generator in ipairs(tycoon:GetDescendants()) do
                if generator.Name == "MoneyCollector" and generator:FindFirstChild("ClickDetector") then
                    fireclickdetector(generator.ClickDetector)
                    task.wait(0.1)
                end
            end
        end
        task.wait(0.5)
    end
end

CollectMoneyButton.MouseButton1Click:Connect(function()
    autoCollectActive = not autoCollectActive
    if autoCollectActive then
        CollectMoneyState.Text = "Estado: ACTIVADO"
        CollectMoneyState.TextColor3 = Color3.fromRGB(80, 255, 80)
        task.spawn(AutoCollectMoney)
    else
        CollectMoneyState.Text = "Estado: DESACTIVADO"
        CollectMoneyState.TextColor3 = Color3.fromRGB(255, 80, 80)
    end
end)


-- MENSAJE DE INICIO
print("GIGA MANSIÓN TYCOON - SCRIPT DE JoseAngel_Blox")
print("Fecha de creación: 05/06/2026")
print("Juego válido: https://www.roblox.com/es/games/14238596528/")
print("Versión 1.0")
