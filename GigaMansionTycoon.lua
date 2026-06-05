-- GIGA MANSION TYCOON - SCRIPT BONITO Y FUNCIONAL
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

-- Crear UI principal
local UIScreen = Instance.new("ScreenGui")
UIScreen.Name = "GigaMansionTycoon"
UIScreen.Parent = PlayerGui
UIScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ==============================================
-- BURBUJA RGB REDONDA CON TOQUE DE LOBO
-- ==============================================
local RGBBubble = Instance.new("TextButton")
RGBBubble.Name = "WolfBubble"
RGBBubble.Parent = UIScreen
RGBBubble.Size = UDim2.new(0, 55, 0, 55)
RGBBubble.Position = UDim2.new(0.05, 0, 0.05, 0)
RGBBubble.CornerRadius = UDim.new(1, 0) -- TOTALMENTE REDONDA
RGBBubble.BorderSizePixel = 3
RGBBubble.BorderColor3 = Color3.new(0.2, 0.2, 0.2)
RGBBubble.Text = "🐺" -- EMOTE DE LOBO
RGBBubble.TextSize = 28
RGBBubble.Font = Enum.Font.GothamBold
RGBBubble.TextColor3 = Color3.new(1, 1, 1)
RGBBubble.AutoButtonColor = false

-- ==============================================
-- MENÚ PRINCIPAL BONITO
-- ==============================================
local MainMenu = Instance.new("Frame")
MainMenu.Name = "MainMenu"
MainMenu.Parent = UIScreen
MainMenu.Size = UDim2.new(0, 320, 0, 250)
MainMenu.Position = UDim2.new(0.15, 0, 0.05, 0)
MainMenu.BackgroundColor3 = Color3.new(0.12, 0.12, 0.18)
MainMenu.BorderSizePixel = 0
MainMenu.Visible = false
MainMenu.CornerRadius = UDim.new(0, 12)
-- Sombra para dar profundidad
local Shadow = Instance.new("Frame")
Shadow.Name = "Shadow"
Shadow.Parent = MainMenu
Shadow.Size = UDim2.new(1, 10, 1, 10)
Shadow.Position = UDim2.new(0, -5, 0, -5)
Shadow.BackgroundColor3 = Color3.new(0, 0, 0)
Shadow.BackgroundTransparency = 0.7
Shadow.CornerRadius = UDim.new(0, 15)
Shadow.ZIndex = 0

-- ==============================================
-- CONTENIDO DEL MENÚ
-- ==============================================
-- Encabezado con lobo
local Header = Instance.new("Frame")
Header.Parent = MainMenu
Header.Size = UDim2.new(1, 0, 0, 60)
Header.BackgroundColor3 = Color3.new(0.2, 0.25, 0.35)
Header.CornerRadius = UDim.new(0, 12)
Header.ZIndex = 2

local WolfIcon = Instance.new("TextLabel")
WolfIcon.Parent = Header
WolfIcon.Size = UDim2.new(0, 50, 0, 50)
WolfIcon.Position = UDim2.new(0, 10, 0, 5)
WolfIcon.BackgroundTransparency = 1
WolfIcon.Text = "🐺 GIGA MANSION"
WolfIcon.TextColor3 = Color3.new(1, 1, 1)
WolfIcon.Font = Enum.Font.GothamBold
WolfIcon.TextSize = 18
WolfIcon.ZIndex = 3

local Title = Instance.new("TextLabel")
Title.Parent = Header
Title.Size = UDim2.new(1, -70, 0, 30)
Title.Position = UDim2.new(0, 70, 0, 15)
Title.BackgroundTransparency = 1
Title.Text = "TYCOON - CONTROL"
Title.TextColor3 = Color3.new(0.8, 0.9, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.ZIndex = 3

-- Sección de Info
local InfoSection = Instance.new("Frame")
InfoSection.Parent = MainMenu
InfoSection.Size = UDim2.new(1, 0, 0, 70)
InfoSection.Position = UDim2.new(0, 0, 0, 60)
InfoSection.BackgroundTransparency = 1
InfoSection.ZIndex = 2

local InfoTitle = Instance.new("TextLabel")
InfoTitle.Parent = InfoSection
InfoTitle.Size = UDim2.new(1, 0, 0, 20)
InfoTitle.Position = UDim2.new(0, 15, 0, 10)
InfoTitle.BackgroundTransparency = 1
InfoTitle.Text = "📋 INFORMACIÓN"
InfoTitle.TextColor3 = Color3.new(0.6, 0.8, 1)
InfoTitle.Font = Enum.Font.GothamBold
InfoTitle.TextSize = 15
InfoTitle.ZIndex = 3

local CreatorText = Instance.new("TextLabel")
CreatorText.Parent = InfoSection
CreatorText.Size = UDim2.new(1, 0, 0, 20)
CreatorText.Position = UDim2.new(0, 20, 0, 35)
CreatorText.BackgroundTransparency = 1
CreatorText.Text = "• Creador: JoseAngel_Blox"
CreatorText.TextColor3 = Color3.new(0.9, 0.9, 0.9)
CreatorText.Font = Enum.Font.Gotham
CreatorText.TextSize = 14
CreatorText.ZIndex = 3

local DateText = Instance.new("TextLabel")
DateText.Parent = InfoSection
DateText.Size = UDim2.new(1, 0, 0, 20)
DateText.Position = UDim2.new(0, 20, 0, 55)
DateText.BackgroundTransparency = 1
DateText.Text = "• Fecha: 05/06/2026"
DateText.TextColor3 = Color3.new(0.9, 0.9, 0.9)
DateText.Font = Enum.Font.Gotham
DateText.TextSize = 14
DateText.ZIndex = 3

-- Sección de Opciones
local OptionsSection = Instance.new("Frame")
OptionsSection.Parent = MainMenu
OptionsSection.Size = UDim2.new(1, 0, 0, 90)
OptionsSection.Position = UDim2.new(0, 0, 0, 130)
OptionsSection.BackgroundTransparency = 1
OptionsSection.ZIndex = 2

local OptionsTitle = Instance.new("TextLabel")
OptionsTitle.Parent = OptionsSection
OptionsTitle.Size = UDim2.new(1, 0, 0, 20)
OptionsTitle.Position = UDim2.new(0, 15, 0, 10)
OptionsTitle.BackgroundTransparency = 1
OptionsTitle.Text = "⚙️ OPCIONES PRINCIPALES"
OptionsTitle.TextColor3 = Color3.new(0.6, 1, 0.8)
OptionsTitle.Font = Enum.Font.GothamBold
OptionsTitle.TextSize = 15
OptionsTitle.ZIndex = 3

-- Botón Auto Construir
local AutoBuildBtn = Instance.new("TextButton")
AutoBuildBtn.Name = "AutoBuildBtn"
AutoBuildBtn.Parent = OptionsSection
AutoBuildBtn.Size = UDim2.new(1, -30, 0, 30)
AutoBuildBtn.Position = UDim2.new(0, 15, 0, 35)
AutoBuildBtn.BackgroundColor3 = Color3.new(0.25, 0.3, 0.4)
AutoBuildBtn.BorderSizePixel = 0
AutoBuildBtn.CornerRadius = UDim.new(0, 8)
AutoBuildBtn.Text = "🐺 Auto Construir: DESACTIVADO"
AutoBuildBtn.TextColor3 = Color3.new(0.9, 0.9, 0.9)
AutoBuildBtn.Font = Enum.Font.Gotham
AutoBuildBtn.TextSize = 15
AutoBuildBtn.ZIndex = 3
-- Efecto hover en botón
AutoBuildBtn.MouseEnter:Connect(function()
    AutoBuildBtn.BackgroundColor3 = Color3.new(0.3, 0.35, 0.45)
end)
AutoBuildBtn.MouseLeave:Connect(function()
    if not AutoBuildEnabled then
        AutoBuildBtn.BackgroundColor3 = Color3.new(0.25, 0.3, 0.4)
    end
end)

-- Botón Auto Recoger
local AutoCollectBtn = Instance.new("TextButton")
AutoCollectBtn.Name = "AutoCollectBtn"
AutoCollectBtn.Parent = OptionsSection
AutoCollectBtn.Size = UDim2.new(1, -30, 0, 30)
AutoCollectBtn.Position = UDim2.new(0, 15, 0, 70)
AutoCollectBtn.BackgroundColor3 = Color3.new(0.25, 0.3, 0.4)
AutoCollectBtn.BorderSizePixel = 0
AutoCollectBtn.CornerRadius = UDim.new(0, 8)
AutoCollectBtn.Text = "💰 Auto Recoger: DESACTIVADO"
AutoCollectBtn.TextColor3 = Color3.new(0.9, 0.9, 0.9)
AutoCollectBtn.Font = Enum.Font.Gotham
AutoCollectBtn.TextSize = 15
AutoCollectBtn.ZIndex = 3
-- Efecto hover en botón
AutoCollectBtn.MouseEnter:Connect(function()
    AutoCollectBtn.BackgroundColor3 = Color3.new(0.3, 0.35, 0.45)
end)
AutoCollectBtn.MouseLeave:Connect(function()
    if not AutoCollectEnabled then
        AutoCollectBtn.BackgroundColor3 = Color3.new(0.25, 0.3, 0.4)
    end
end)

-- ==============================================
-- EFECTO RGB EN BURBUJA
-- ==============================================
local hue = 0
RunService.Heartbeat:Connect(function(d)
    hue = hue + d*50
    if hue >= 360 then hue = 0 end
    local color = Color3.fromHSV(hue/360, 0.7, 0.9)
    RGBBubble.BackgroundColor3 = color
    RGBBubble.BorderColor3 = color:lerp(Color3.new(0.1,0.1,0.1), 0.5)
end)

-- ==============================================
-- MOSTRAR/OCULTAR MENÚ (FUNCIONAL 100%)
-- ==============================================
RGBBubble.MouseButton1Click:Connect(function()
    MainMenu.Visible = not MainMenu.Visible
    if MainMenu.Visible then
        RGBBubble.Text = "✖"
        RGBBubble.TextSize = 25
    else
        RGBBubble.Text = "🐺"
        RGBBubble.TextSize = 28
    end
end)

-- ==============================================
-- MOVER MENÚ POR PANTALLA
-- ==============================================
local isDragging = false
local dragStart = Vector2.new()
local menuStart = UDim2.new()

MainMenu.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = true
        dragStart = UserInputService:GetMouseLocation()
        menuStart = MainMenu.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = UserInputService:GetMouseLocation() - dragStart
        MainMenu.Position = UDim2.new(
            menuStart.X.Scale, menuStart.X.Offset + delta.X,
            menuStart.Y.Scale, menuStart.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)

-- ==============================================
-- FUNCIONALIDAD DE BOTONES
-- ==============================================
local AutoBuildEnabled = false
AutoBuildBtn.MouseButton1Click:Connect(function()
    AutoBuildEnabled = not AutoBuildEnabled
    if AutoBuildEnabled then
        AutoBuildBtn.Text = "🐺 Auto Construir: ACTIVADO"
        AutoBuildBtn.BackgroundColor3 = Color3.new(0.2, 0.5, 0.3)
        spawn(function()
            while AutoBuildEnabled do
                local BuildGui = PlayerGui:FindFirstChild("BuildGui")
                if BuildGui then
                    for _, btn in pairs(BuildGui:GetDescendants()) do
                        if btn:IsA("TextButton") and btn.BackgroundColor3 == Color3.new(0,1,0) then
                            pcall(function() btn:Activate() end)
                        end
                    end
                end
                wait(1)
            end
        end)
    else
        AutoBuildBtn.Text = "🐺 Auto Construir: DESACTIVADO"
        AutoBuildBtn.BackgroundColor3 = Color3.new(0.25, 0.3, 0.4)
    end
end)

local AutoCollectEnabled = false
AutoCollectBtn.MouseButton1Click:Connect(function()
    AutoCollectEnabled = not AutoCollectEnabled
    if AutoCollectEnabled then
        AutoCollectBtn.Text = "💰 Auto Recoger: ACTIVADO"
        AutoCollectBtn.BackgroundColor3 = Color3.new(0.2, 0.5, 0.3)
        spawn(function()
            while AutoCollectEnabled do
                local Coins = game.Workspace:FindFirstChild("Coins")
                if Coins and Player.Character then
                    for _, coin in pairs(Coins:GetChildren()) do
                        pcall(function()
                            if coin:IsA("BasePart") then
                                coin.CFrame = Player.Character.HumanoidRootPart.CFrame
                            end
                        end)
                    end
                end
                wait(0.5)
            end
        end)
    else
        AutoCollectBtn.Text = "💰 Auto Recoger: DESACTIVADO"
        AutoCollectBtn.BackgroundColor3 = Color3.new(0.25, 0.3, 0.4)
    end
end)

-- ==============================================
-- MENSAJE DE CARGA
-- ==============================================
print("🐺 SCRIPT CARGADO CORRECTAMENTE - MENÚ LISTO 🐺")
