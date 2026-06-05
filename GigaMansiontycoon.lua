-- GIGA MANSIÓN TYCOON - SCRIPT PERSONALIZADO
-- Solo para: https://www.roblox.com/es/games/14238596528/Giga-Mansion-Tycoon


-- VERIFICAR JUEGO
if game.PlaceId ~= 14238596528 then
    warn("Este script solo funciona en Giga Mansion Tycoon")
    return
end


-- SERVICIOS
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer


-- INTERFAZ PRINCIPAL
local UI = Instance.new("ScreenGui")
UI.Name = "GigaMansionTycoonScript"
UI.Parent = LocalPlayer.PlayerGui


-- BOTÓN DE ACTIVAR/DESACTIVAR MENU
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "BotonToggle"
ToggleButton.Size = UDim2.new(0, 40, 0, 40)
ToggleButton.Position = UDim2.new(0.02, 0, 0.1, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 180, 50)
ToggleButton.BorderSizePixel = 0
ToggleButton.Text = "☰"
ToggleButton.TextColor3 = Color3.fromRGB(10, 20, 40)
ToggleButton.TextSize = 20
ToggleButton.Font = Enum.Font.RobotoBold
ToggleButton.Parent = UI

-- EFECTO BOTON TOGGLE
ToggleButton.MouseEnter:Connect(function()
    TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 210, 80)}):Play()
end)
ToggleButton.MouseLeave:Connect(function()
    TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 180, 50)}):Play()
end)


-- MENU PRINCIPAL
local MainMenu = Instance.new("Frame")
MainMenu.Name = "MenuPrincipal"
MainMenu.Size = UDim2.new(0, 280, 0, 380)
MainMenu.Position = UDim2.new(0.02, 45, 0.1, 0)
MainMenu.BackgroundColor3 = Color3.fromRGB(15, 30, 60)
MainMenu.BorderSizePixel = 0
MainMenu.Visible = false
MainMenu.Parent = UI

-- GRADIENTE MENU
local MenuGradient = Instance.new("UIGradient")
MenuGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 30, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 40, 80))
})
MenuGradient.Rotation = 30
MenuGradient.Parent = MainMenu

-- BORDE MENU
local MenuBorder = Instance.new("Frame")
MenuBorder.Name = "BordeMenu"
MenuBorder.Size = UDim2.new(1, 4, 1, 4)
MenuBorder.Position = UDim2.new(0, -2, 0, -2)
MenuBorder.BackgroundTransparency = 1
MenuBorder.BorderColor3 = Color3.fromRGB(255, 180, 50)
MenuBorder.BorderSizePixel = 1
MenuBorder.Parent = MainMenu


-- TITULO MENU
local MenuTitle = Instance.new("TextLabel")
MenuTitle.Name = "TituloMenu"
MenuTitle.Size = UDim2.new(1, 0, 0, 40)
MenuTitle.Position = UDim2.new(0, 0, 0, 0)
MenuTitle.BackgroundTransparency = 1
MenuTitle.Text = "GIGA MANSIÓN TYCOON"
MenuTitle.TextColor3 = Color3.fromRGB(255, 200, 60)
MenuTitle.TextScaled = true
MenuTitle.Font = Enum.Font.RobotoMono
MenuTitle.Parent = MainMenu


-- BOTON INFO
local InfoBtn = Instance.new("TextButton")
InfoBtn.Name = "BotonInfo"
InfoBtn.Size = UDim2.new(1, -20, 0, 50)
InfoBtn.Position = UDim2.new(0, 10, 0, 50)
InfoBtn.BackgroundColor3 = Color3.fromRGB(40, 100, 180)
InfoBtn.BorderSizePixel = 0
InfoBtn.Text = "INFO"
InfoBtn.TextColor3 = Color3.new(1,1,1)
InfoBtn.TextScaled = true
InfoBtn.Font = Enum.Font.RobotoBold
InfoBtn.Parent = MainMenu

-- EFECTO BOTON INFO
InfoBtn.MouseEnter:Connect(function()
    TweenService:Create(InfoBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 130, 210)}):Play()
end)
InfoBtn.MouseLeave:Connect(function()
    TweenService:Create(InfoBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 100, 180)}):Play()
end)


-- BOTON MAIN
local MainBtn = Instance.new("TextButton")
MainBtn.Name = "BotonMain"
MainBtn.Size = UDim2.new(1, -20, 0, 50)
MainBtn.Position = UDim2.new(0, 10, 0, 110)
MainBtn.BackgroundColor3 = Color3.fromRGB(30, 150, 80)
MainBtn.BorderSizePixel = 0
MainBtn.Text = "MAIN"
MainBtn.TextColor3 = Color3.new(1,1,1)
MainBtn.TextScaled = true
MainBtn.Font = Enum.Font.RobotoBold
MainBtn.Parent = MainMenu

-- EFECTO BOTON MAIN
MainBtn.MouseEnter:Connect(function()
    TweenService:Create(MainBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 180, 100)}):Play()
end)
MainBtn.MouseLeave:Connect(function()
    TweenService:Create(MainBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 150, 80)}):Play()
end)


-- PANEL INFO
local InfoPanel = Instance.new("Frame")
InfoPanel.Name = "PanelInfo"
InfoPanel.Size = UDim2.new(1, -20, 0, 180)
InfoPanel.Position = UDim2.new(0, 10, 0, 170)
InfoPanel.BackgroundTransparency = 0.2
InfoPanel.BackgroundColor3 = Color3.fromRGB(10, 20, 40)
InfoPanel.BorderSizePixel = 0
InfoPanel.Visible = false
InfoPanel.Parent = MainMenu

local InfoText = Instance.new("TextLabel")
InfoText.Size = UDim2.new(1, -10, 1, -10)
InfoText.Position = UDim2.new(0, 5, 0, 5)
InfoText.BackgroundTransparency = 1
InfoText.Text = "Nombre del creador:\nJoseAngel_Blox\n\nFecha de Creación:\n05/06/2026"
InfoText.TextColor3 = Color3.new(1,1,1)
InfoText.TextSize = 19
InfoText.Font = Enum.Font.Roboto
InfoText.TextWrapped = true
InfoText.Parent = InfoPanel


-- PANEL MAIN
local MainPanel = Instance.new("Frame")
MainPanel.Name = "PanelMain"
MainPanel.Size = UDim2.new(1, -20, 0, 180)
MainPanel.Position = UDim2.new(0, 10, 0, 170)
MainPanel.BackgroundTransparency = 0.2
MainPanel.BackgroundColor3 = Color3.fromRGB(10, 20, 40)
MainPanel.BorderSizePixel = 0
MainPanel.Visible = false
MainPanel.Parent = MainMenu


-- BOTON AUTO CONSTRUIR
local AutoBuildBtn = Instance.new("TextButton")
AutoBuildBtn.Name = "BotonAutoConstruir"
AutoBuildBtn.Size = UDim2.new(1, 0, 0, 45)
AutoBuildBtn.Position = UDim2.new(0, 0, 0, 20)
AutoBuildBtn.BackgroundColor3 = Color3.fromRGB(200, 120, 30)
AutoBuildBtn.BorderSizePixel = 0
AutoBuildBtn.Text = "AUTO CONSTRUIR"
AutoBuildBtn.TextColor3 = Color3.new(1,1,1)
AutoBuildBtn.TextScaled = true
AutoBuildBtn.Font = Enum.Font.RobotoMedium
AutoBuildBtn.Parent = MainPanel

local AutoBuildState = Instance.new("TextLabel")
AutoBuildState.Size = UDim2.new(1, 0, 0, 20)
AutoBuildState.Position = UDim2.new(0, 0, 0, 50)
AutoBuildState.BackgroundTransparency = 1
AutoBuildState.Text = "Estado: Apagado"
AutoBuildState.TextColor3 = Color3.fromRGB(255, 80, 80)
AutoBuildState.TextSize = 14
AutoBuildState.Font = Enum.Font.Roboto
AutoBuildState.Parent = MainPanel

-- EFECTO BOTON AUTO CONSTRUIR
AutoBuildBtn.MouseEnter:Connect(function()
    TweenService:Create(AutoBuildBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(230, 150, 50)}):Play()
end)
AutoBuildBtn.MouseLeave:Connect(function()
    TweenService:Create(AutoBuildBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(200, 120, 30)}):Play()
end)


-- BOTON AUTO RECOGER
local AutoCollectBtn = Instance.new("TextButton")
AutoCollectBtn.Name = "BotonAutoRecoger"
AutoCollectBtn.Size = UDim2.new(1, 0, 0, 45)
AutoCollectBtn.Position = UDim2.new(0, 0, 0, 90)
AutoCollectBtn.BackgroundColor3 = Color3.fromRGB(180, 70, 120)
AutoCollectBtn.BorderSizePixel = 0
AutoCollectBtn.Text = "AUTO RECOGER DINERO"
AutoCollectBtn.TextColor3 = Color3.new(1,1,1)
AutoCollectBtn.TextScaled = true
AutoCollectBtn.Font = Enum.Font.RobotoMedium
AutoCollectBtn.Parent = MainPanel

local AutoCollectState = Instance.new("TextLabel")
AutoCollectState.Size = UDim2.new(1, 0, 0, 20)
AutoCollectState.Position = UDim2.new(0, 0, 0, 135)
AutoCollectState.BackgroundTransparency = 1
AutoCollectState.Text = "Estado: Apagado"
AutoCollectState.TextColor3 = Color3.fromRGB(255, 80, 80)
AutoCollectState.TextSize = 14
AutoCollectState.Font = Enum.Font.Roboto
AutoCollectState.Parent = MainPanel

-- EFECTO BOTON AUTO RECOGER
AutoCollectBtn.MouseEnter:Connect(function()
    TweenService:Create(AutoCollectBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(210, 90, 140)}):Play()
end)
AutoCollectBtn.MouseLeave:Connect(function()
    TweenService:Create(AutoCollectBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(180, 70, 120)}):Play()
end)


-- MOSTRAR/OCULTAR MENU
local menuVisible = false
ToggleButton.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    MainMenu.Visible = menuVisible
    
    if menuVisible then
        ToggleButton.Text = "X"
    else
        ToggleButton.Text = "☰"
        InfoPanel.Visible = false
        MainPanel.Visible = false
    end
end)


-- MOSTRAR PANELES
local currentPanel = nil
local function ShowPanel(panel)
    if currentPanel == panel then
        panel.Visible = false
        currentPanel = nil
    else
        if currentPanel then currentPanel.Visible = false end
        panel.Visible = true
        currentPanel = panel
    end
end

InfoBtn.MouseButton1Click:Connect(function() ShowPanel(InfoPanel) end)
MainBtn.MouseButton1Click:Connect(function() ShowPanel(MainPanel) end)


-- MOVER BOTON PRINCIPAL
local dragging = false
local startPos = Vector2.new()
local uiPos = UDim2.new()

ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        startPos = UserInputService:GetMouseLocation()
        uiPos = ToggleButton.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mousePos = UserInputService:GetMouseLocation()
        local delta = mousePos - startPos
        ToggleButton.Position = UDim2.new(
            uiPos.X.Scale,
            uiPos.X.Offset + delta.X,
            uiPos.Y.Scale,
            uiPos.Y.Offset + delta.Y
        )
        MainMenu.Position = UDim2.new(
            uiPos.X.Scale,
            uiPos.X.Offset + delta.X + 45,
            uiPos.Y.Scale,
            uiPos.Y.Offset + delta.Y
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

-- OBTENER AREAS DEL JUEGO
local function GetTycoonAreas()
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
local function RunAutoBuild()
    while autoBuildActive do
        local areas = GetTycoonAreas()
        for _, area in ipairs(areas) do
            local buildBtn = area:FindFirstChild("BuildButton")
            if buildBtn and buildBtn:FindFirstChild("ClickDetector") then
                fireclickdetector(buildBtn.ClickDetector)
                task.wait(0.3)
            end
            
            local upgradeBtn = area:FindFirstChild("UpgradeButton")
            if upgradeBtn and upgradeBtn:FindFirstChild("ClickDetector") then
                fireclickdetector(upgradeBtn.ClickDetector)
                task.wait(0.3)
            end
        end
        task.wait(1)
    end
end

AutoBuildBtn.MouseButton1Click:Connect(function()
    autoBuildActive = not autoBuildActive
    if autoBuildActive then
        AutoBuildState.Text = "Estado: Encendido"
        AutoBuildState.TextColor3 = Color3.fromRGB(80, 255, 80)
        task.spawn(RunAutoBuild)
    else
        AutoBuildState.Text = "Estado: Apagado"
        AutoBuildState.TextColor3 = Color3.fromRGB(255, 80, 80)
    end
end)

-- AUTO RECOGER DINERO
local function RunAutoCollect()
    while autoCollectActive do
        local tycoon = workspace.Tycoons:FindFirstChild(LocalPlayer.Name)
        if tycoon then
            for _, collector in ipairs(tycoon:GetDescendants()) do
                if collector.Name == "MoneyCollector" and collector:FindFirstChild("ClickDetector") then
                    fireclickdetector(collector.ClickDetector)
                    task.wait(0.1)
                end
            end
        end
        task.wait(0.5)
    end
end

AutoCollectBtn.MouseButton1Click:Connect(function()
    autoCollectActive = not autoCollectActive
    if autoCollectActive then
        AutoCollectState.Text = "Estado: Encendido"
        AutoCollectState.TextColor3 = Color3.fromRGB(80, 255, 80)
        task.spawn(RunAutoCollect)
    else
        AutoCollectState.Text = "Estado: Apagado"
        AutoCollectState.TextColor3 = Color3.fromRGB(255, 80, 80)
    end
end)


-- MENSAJE INICIO
print("Giga Mansión Tycoon - Script personalizado")
print("Creado por JoseAngel_Blox | 05/06/2026")
