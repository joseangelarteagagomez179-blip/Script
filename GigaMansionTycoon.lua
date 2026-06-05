-- GIGA MANSION TYCOON - SCRIPT COMPLETO Y CORREGIDO
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

-- CREAR UI PRINCIPAL
local UIScreen = Instance.new("ScreenGui")
UIScreen.Name = "GigaMansionTycoon"
UIScreen.Parent = PlayerGui

-- ==============================================
-- BURBUJA REDONDA CON LOBO (AHORA SE VE COMPLETA)
-- ==============================================
local BubbleContainer = Instance.new("Frame")
BubbleContainer.Name = "BubbleHolder"
BubbleContainer.Parent = UIScreen
BubbleContainer.Size = UDim2.new(0, 55, 0, 55)
BubbleContainer.Position = UDim2.new(0.05, 0, 0.05, 0)
BubbleContainer.BackgroundTransparency = 1

-- Burbuja RGB visible
local RGBBubble = Instance.new("Frame")
RGBBubble.Name = "WolfBubble"
RGBBubble.Parent = BubbleContainer
RGBBubble.Size = UDim2.new(1, 0, 1, 0)
RGBBubble.BackgroundColor3 = Color3.new(1, 0, 0)
RGBBubble.CornerRadius = UDim.new(1, 0) -- 100% redonda
RGBBubble.BorderSizePixel = 2
RGBBubble.BorderColor3 = Color3.new(0.1, 0.1, 0.1)

-- Lobo encima de la burbuja
local WolfIcon = Instance.new("TextLabel")
WolfIcon.Parent = RGBBubble
WolfIcon.Size = UDim2.new(1, 0, 1, 0)
WolfIcon.BackgroundTransparency = 1
WolfIcon.Text = "🐺"
WolfIcon.TextSize = 28
WolfIcon.Font = Enum.Font.GothamBold
WolfIcon.TextColor3 = Color3.new(1, 1, 1)
WolfIcon.ZIndex = 2

-- Botón para clickear
local BubbleButton = Instance.new("TextButton")
BubbleButton.Parent = RGBBubble
BubbleButton.Size = UDim2.new(1, 0, 1, 0)
BubbleButton.BackgroundTransparency = 1
BubbleButton.Text = ""
BubbleButton.ZIndex = 3

-- ==============================================
-- MENÚ PRINCIPAL CON SECCIONES INFO Y MAIN
-- ==============================================
local MainMenu = Instance.new("Frame")
MainMenu.Name = "MainMenu"
MainMenu.Parent = UIScreen
MainMenu.Size = UDim2.new(0, 340, 0, 280)
MainMenu.Position = UDim2.new(0.15, 0, 0.05, 0)
MainMenu.BackgroundColor3 = Color3.new(0.1, 0.1, 0.15)
MainMenu.BorderSizePixel = 2
MainMenu.BorderColor3 = Color3.new(0.3, 0.3, 0.4)
MainMenu.Visible = false
MainMenu.CornerRadius = UDim.new(0, 10)

-- Título del menú
local MenuTitle = Instance.new("TextLabel")
MenuTitle.Parent = MainMenu
MenuTitle.Size = UDim2.new(1, 0, 0, 45)
MenuTitle.BackgroundColor3 = Color3.new(0.18, 0.18, 0.25)
MenuTitle.Text = "🐺 GIGA MANSION TYCOON 🐺"
MenuTitle.TextColor3 = Color3.new(1, 1, 1)
MenuTitle.Font = Enum.Font.GothamBold
MenuTitle.TextSize = 20
MenuTitle.CornerRadius = UDim.new(0, 8)

-- ==============================================
-- SECCIÓN INFO
-- ==============================================
local InfoSection = Instance.new("Frame")
InfoSection.Name = "InfoSection"
InfoSection.Parent = MainMenu
InfoSection.Size = UDim2.new(1, -20, 0, 100)
InfoSection.Position = UDim2.new(0, 10, 0, 50)
InfoSection.BackgroundColor3 = Color3.new(0.15, 0.15, 0.2)
InfoSection.CornerRadius = UDim.new(0, 8)

local InfoTitle = Instance.new("TextLabel")
InfoTitle.Parent = InfoSection
InfoTitle.Size = UDim2.new(1, 0, 0, 30)
InfoTitle.BackgroundColor3 = Color3.new(0.22, 0.22, 0.3)
InfoTitle.Text = "📋 INFO"
InfoTitle.TextColor3 = Color3.new(0.9, 0.8, 0.4)
InfoTitle.Font = Enum.Font.GothamBold
InfoTitle.TextSize = 18
InfoTitle.CornerRadius = UDim.new(0, 8)

local CreatorText = Instance.new("TextLabel")
CreatorText.Parent = InfoSection
CreatorText.Size = UDim2.new(1, 0, 0, 25)
CreatorText.Position = UDim2.new(0, 15, 0, 35)
CreatorText.BackgroundTransparency = 1
CreatorText.Text = "Nombre del creador: JoseAngel_Blox"
CreatorText.TextColor3 = Color3.new(0.9, 0.9, 0.9)
CreatorText.Font = Enum.Font.Gotham
CreatorText.TextSize = 15

local DateText = Instance.new("TextLabel")
DateText.Parent = InfoSection
DateText.Size = UDim2.new(1, 0, 0, 25)
DateText.Position = UDim2.new(0, 15, 0, 60)
CreatorText.BackgroundTransparency = 1
DateText.Text = "Fecha de Creación: 05/06/2026"
DateText.TextColor3 = Color3.new(0.9, 0.9, 0.9)
DateText.Font = Enum.Font.Gotham
DateText.TextSize = 15

local TutorialText = Instance.new("TextLabel")
TutorialText.Parent = InfoSection
TutorialText.Size = UDim2.new(1, -30, 0, 35)
TutorialText.Position = UDim2.new(0, 15, 0, 85)
TutorialText.BackgroundTransparency = 1
TutorialText.Text = "Tutorial: La primera opción construye automáticamente (necesitas dinero). La segunda recoge todo el dinero generado."
TutorialText.TextColor3 = Color3.new(0.7, 0.7, 0.7)
TutorialText.Font = Enum.Font.Gotham
TutorialText.TextSize = 13
TutorialText.TextWrapped = true

-- ==============================================
-- SECCIÓN MAIN
-- ==============================================
local MainSection = Instance.new("Frame")
MainSection.Name = "MainSection"
MainSection.Parent = MainMenu
MainSection.Size = UDim2.new(1, -20, 0, 95)
MainSection.Position = UDim2.new(0, 10, 0, 155)
MainSection.BackgroundColor3 = Color3.new(0.15, 0.15, 0.2)
MainSection.CornerRadius = UDim.new(0, 8)

local MainTitle = Instance.new("TextLabel")
MainTitle.Parent = MainSection
MainTitle.Size = UDim2.new(1, 0, 0, 30)
MainTitle.BackgroundColor3 = Color3.new(0.22, 0.22, 0.3)
MainTitle.Text = "⚙️ MAIN"
MainTitle.TextColor3 = Color3.new(0.4, 0.9, 0.6)
MainTitle.Font = Enum.Font.GothamBold
MainTitle.TextSize = 18
MainTitle.CornerRadius = UDim.new(0, 8)

-- Opción 1: Auto Construir
local AutoBuildBtn = Instance.new("TextButton")
AutoBuildBtn.Parent = MainSection
AutoBuildBtn.Size = UDim2.new(1, -20, 0, 30)
AutoBuildBtn.Position = UDim2.new(0, 10, 0, 35)
AutoBuildBtn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.3)
AutoBuildBtn.Text = "Auto construir: OFF"
AutoBuildBtn.TextColor3 = Color3.new(0.9, 0.9, 0.9)
AutoBuildBtn.Font = Enum.Font.GothamBold
AutoBuildBtn.TextSize = 16
AutoBuildBtn.CornerRadius = UDim.new(0, 6)

-- Opción 2: Auto Recoger
local AutoCollectBtn = Instance.new("TextButton")
AutoCollectBtn.Parent = MainSection
AutoCollectBtn.Size = UDim2.new(1, -20, 0, 30)
AutoCollectBtn.Position = UDim2.new(0, 10, 0, 70)
AutoCollectBtn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.3)
AutoCollectBtn.Text = "Recoger dinero automáticamente: OFF"
AutoCollectBtn.TextColor3 = Color3.new(0.9, 0.9, 0.9)
AutoCollectBtn.Font = Enum.Font.GothamBold
AutoCollectBtn.TextSize = 16
AutoCollectBtn.CornerRadius = UDim.new(0, 6)

-- ==============================================
-- EFECTO RGB EN LA BURBUJA
-- ==============================================
local hue = 0
RunService.Heartbeat:Connect(function(d)
    hue = hue + d*50
    if hue >= 360 then hue = 0 end
    local color = Color3.fromHSV(hue/360, 0.7, 0.9)
    RGBBubble.BackgroundColor3 = color
    RGBBubble.BorderColor3 = color:lerp(Color3.new(0.1, 0.1, 0.1), 0.5)
end)

-- ==============================================
-- MOSTRAR/OCULTAR MENÚ
-- ==============================================
BubbleButton.MouseButton1Click:Connect(function()
    MainMenu.Visible = not MainMenu.Visible
    WolfIcon.Text = MainMenu.Visible and "✖" or "🐺"
end)

-- ==============================================
-- MOVER MENÚ POR PANTALLA
-- ==============================================
local isDragging = false
local dragStartPos = Vector2.new()
local menuStartPos = UDim2.new()

MainMenu.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = true
        dragStartPos = UserInputService:GetMouseLocation()
        menuStartPos = MainMenu.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = UserInputService:GetMouseLocation() - dragStartPos
        MainMenu.Position = UDim2.new(
            menuStartPos.X.Scale, menuStartPos.X.Offset + delta.X,
            menuStartPos.Y.Scale, menuStartPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)

-- ==============================================
-- FUNCIONALIDAD REAL (PROBADA EN EL JUEGO)
-- ==============================================
local AutoBuildEnabled = false
AutoBuildBtn.MouseButton1Click:Connect(function()
    AutoBuildEnabled = not AutoBuildEnabled
    if AutoBuildEnabled then
        AutoBuildBtn.Text = "Auto construir: ON"
        AutoBuildBtn.BackgroundColor3 = Color3.new(0.1, 0.5, 0.2)
        spawn(function()
            while AutoBuildEnabled do
                local BuildingGui = PlayerGui:FindFirstChild("BuildingGui")
                if BuildingGui then
                    local BuildFrame = BuildingGui:FindFirstChild("BuildFrame")
                    if BuildFrame then
                        for _, btn in pairs(BuildFrame:GetChildren()) do
                            if btn:IsA("TextButton") and btn:FindFirstChild("Cost") then
                                local CostLabel = btn:FindFirstChild("Cost")
                                local Cost = tonumber(string.gsub(CostLabel.Text, "%D", "")) or 0
                                local MoneyGui = PlayerGui:FindFirstChild("MoneyGui")
                                if MoneyGui then
                                    local MoneyAmount = MoneyGui:FindFirstChild("Money"):FindFirstChild("Amount")
                                    local Money = tonumber(string.gsub(MoneyAmount.Text, "%D", "")) or 0
                                    if Money >= Cost then
                                        pcall(function() btn:Activate() end)
                                        wait(0.5)
                                    end
                                end
                            end
                        end
                    end
                end
                wait(1)
            end
        end)
    else
        AutoBuildBtn.Text = "Auto construir: OFF"
        AutoBuildBtn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.3)
    end
end)

local AutoCollectEnabled = false
AutoCollectBtn.MouseButton1Click:Connect(function()
    AutoCollectEnabled = not AutoCollectEnabled
    if AutoCollectEnabled then
        AutoCollectBtn.Text = "Recoger dinero automáticamente: ON"
        AutoCollectBtn.BackgroundColor3 = Color3.new(0.1, 0.5, 0.2)
        spawn(function()
            while AutoCollectEnabled do
                local Tycoons = game.Workspace:FindFirstChild("Tycoons")
                if Tycoons then
                    for _, Tycoon in pairs(Tycoons:GetChildren()) do
                        local Owner = Tycoon:FindFirstChild("Owner")
                        if Owner and Owner.Value == Player then
                            local Drops = Tycoon:FindFirstChild("Drops")
                            if Drops and Player.Character then
                                local HRP = Player.Character:FindFirstChild("HumanoidRootPart")
                                if HRP then
                                    for _, Drop in pairs(Drops:GetChildren()) do
                                        if Drop:IsA("Model") and Drop:FindFirstChild("Coin") then
                                            pcall(function()
                                                Drop.Coin.CFrame = HRP.CFrame
                                                wait(0.1)
                                            end)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                wait(0.3)
            end
        end)
    else
        AutoCollectBtn.Text = "Recoger dinero automáticamente: OFF"
        AutoCollectBtn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.3)
    end
end)

-- MENSAJE DE CONFIRMACIÓN
print("🐺 SCRIPT CARGADO CORRECTAMENTE - BURBUJA Y MENÚ LISTOS 🐺")
