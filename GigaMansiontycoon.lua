-- GIGA MANSION TYCOON - SCRIPT DEFINITIVO
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

-- CREAR UI
local UIScreen = Instance.new("ScreenGui")
UIScreen.Name = "GigaMansionTycoon"
UIScreen.Parent = PlayerGui

-- ==============================================
-- BURBUJA REDONDA CON LOBO (100% VISIBLE)
-- ==============================================
local RGBBubble = Instance.new("ImageButton")
RGBBubble.Name = "WolfBubble"
RGBBubble.Parent = UIScreen
RGBBubble.Size = UDim2.new(0, 55, 0, 55)
RGBBubble.Position = UDim2.new(0.05, 0, 0.05, 0)
RGBBubble.BackgroundTransparency = 1
-- Imagen redonda de burbuja
RGBBubble.Image = "rbxassetid://6014261943"
RGBBubble.ImageColor3 = Color3.new(1, 0, 0)
RGBBubble.ScaleType = Enum.ScaleType.Fit

-- Texto del lobo
local WolfText = Instance.new("TextLabel")
WolfText.Parent = RGBBubble
WolfText.Size = UDim2.new(1, 0, 1, 0)
WolfText.BackgroundTransparency = 1
WolfText.Text = "🐺"
WolfText.TextSize = 28
WolfText.Font = Enum.Font.GothamBold
WolfText.TextColor3 = Color3.new(1,1,1)
WolfText.ZIndex = 2

-- ==============================================
-- MENÚ PRINCIPAL (SIEMPRE APARECE AL CLICK)
-- ==============================================
local MainMenu = Instance.new("Frame")
MainMenu.Name = "MainMenu"
MainMenu.Parent = UIScreen
MainMenu.Size = UDim2.new(0, 340, 0, 280)
MainMenu.Position = UDim2.new(0.15, 0, 0.05, 0)
MainMenu.BackgroundColor3 = Color3.new(0.1, 0.1, 0.15)
MainMenu.BorderSizePixel = 0
MainMenu.Visible = false
-- Marco redondo para el menú
local MenuImage = Instance.new("ImageLabel")
MenuImage.Parent = MainMenu
MenuImage.Size = UDim2.new(1, 0, 1, 0)
MenuImage.BackgroundTransparency = 1
MenuImage.Image = "rbxassetid://4623342923"
MenuImage.ImageColor3 = Color3.new(0.1, 0.1, 0.15)
MenuImage.ZIndex = 0

-- Título
local MenuTitle = Instance.new("TextLabel")
MenuTitle.Parent = MainMenu
MenuTitle.Size = UDim2.new(1, 0, 0, 45)
MenuTitle.BackgroundTransparency = 1
MenuTitle.Text = "🐺 GIGA MANSION TYCOON 🐺"
MenuTitle.TextColor3 = Color3.new(1, 1, 1)
MenuTitle.Font = Enum.Font.GothamBold
MenuTitle.TextSize = 20
MenuTitle.ZIndex = 2

-- ==============================================
-- SECCIÓN INFO
-- ==============================================
local InfoSection = Instance.new("Frame")
InfoSection.Parent = MainMenu
InfoSection.Size = UDim2.new(0, 300, 0, 100)
InfoSection.Position = UDim2.new(0, 20, 0, 50)
InfoSection.BackgroundTransparency = 1
InfoSection.ZIndex = 2

local InfoTitle = Instance.new("TextLabel")
InfoTitle.Parent = InfoSection
InfoTitle.Size = UDim2.new(1, 0, 0, 30)
InfoTitle.Text = "📋 INFO"
InfoTitle.TextColor3 = Color3.new(0.9, 0.8, 0.4)
InfoTitle.Font = Enum.Font.GothamBold
InfoTitle.TextSize = 18
InfoTitle.BackgroundTransparency = 1
InfoTitle.ZIndex = 2

local CreatorText = Instance.new("TextLabel")
CreatorText.Parent = InfoSection
CreatorText.Size = UDim2.new(1, 0, 0, 25)
CreatorText.Position = UDim2.new(0, 0, 0, 35)
CreatorText.Text = "Nombre del creador: JoseAngel_Blox"
CreatorText.TextColor3 = Color3.new(0.9, 0.9, 0.9)
CreatorText.Font = Enum.Font.Gotham
CreatorText.TextSize = 15
CreatorText.BackgroundTransparency = 1
CreatorText.ZIndex = 2

local DateText = Instance.new("TextLabel")
DateText.Parent = InfoSection
DateText.Size = UDim2.new(1, 0, 0, 25)
DateText.Position = UDim2.new(0, 0, 0, 60)
DateText.Text = "Fecha de Creación: 05/06/2026"
DateText.TextColor3 = Color3.new(0.9, 0.9, 0.9)
DateText.Font = Enum.Font.Gotham
DateText.TextSize = 15
DateText.BackgroundTransparency = 1
DateText.ZIndex = 2

local TutorialText = Instance.new("TextLabel")
TutorialText.Parent = InfoSection
TutorialText.Size = UDim2.new(1, 0, 0, 35)
TutorialText.Position = UDim2.new(0, 0, 0, 85)
TutorialText.Text = "Tutorial: La primera opción construye automáticamente (necesitas dinero). La segunda recoge todo el dinero generado."
TutorialText.TextColor3 = Color3.new(0.7, 0.7, 0.7)
TutorialText.Font = Enum.Font.Gotham
TutorialText.TextSize = 13
TutorialText.TextWrapped = true
TutorialText.BackgroundTransparency = 1
TutorialText.ZIndex = 2

-- ==============================================
-- SECCIÓN MAIN
-- ==============================================
local MainSection = Instance.new("Frame")
MainSection.Parent = MainMenu
MainSection.Size = UDim2.new(0, 300, 0, 95)
MainSection.Position = UDim2.new(0, 20, 0, 155)
MainSection.BackgroundTransparency = 1
MainSection.ZIndex = 2

local MainTitle = Instance.new("TextLabel")
MainTitle.Parent = MainSection
MainTitle.Size = UDim2.new(1, 0, 0, 30)
MainTitle.Text = "⚙️ MAIN"
MainTitle.TextColor3 = Color3.new(0.4, 0.9, 0.6)
MainTitle.Font = Enum.Font.GothamBold
MainTitle.TextSize = 18
MainTitle.BackgroundTransparency = 1
MainTitle.ZIndex = 2

-- Botón Auto Construir
local AutoBuildBtn = Instance.new("TextButton")
AutoBuildBtn.Parent = MainSection
AutoBuildBtn.Size = UDim2.new(1, 0, 0, 30)
AutoBuildBtn.Position = UDim2.new(0, 0, 0, 35)
AutoBuildBtn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.3)
AutoBuildBtn.Text = "Auto construir: OFF"
AutoBuildBtn.TextColor3 = Color3.new(0.9, 0.9, 0.9)
AutoBuildBtn.Font = Enum.Font.GothamBold
AutoBuildBtn.TextSize = 16
AutoBuildBtn.CornerRadius = UDim.new(0, 6)
AutoBuildBtn.ZIndex = 2

-- Botón Auto Recoger
local AutoCollectBtn = Instance.new("TextButton")
AutoCollectBtn.Parent = MainSection
AutoCollectBtn.Size = UDim2.new(1, 0, 0, 30)
AutoCollectBtn.Position = UDim2.new(0, 0, 0, 70)
AutoCollectBtn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.3)
AutoCollectBtn.Text = "Recoger dinero automáticamente: OFF"
AutoCollectBtn.TextColor3 = Color3.new(0.9, 0.9, 0.9)
AutoCollectBtn.Font = Enum.Font.GothamBold
AutoCollectBtn.TextSize = 16
AutoCollectBtn.CornerRadius = UDim.new(0, 6)
AutoCollectBtn.ZIndex = 2

-- ==============================================
-- EFECTO RGB BURBUJA
-- ==============================================
local hue = 0
RunService.Heartbeat:Connect(function(d)
    hue = hue + d*50
    if hue >= 360 then hue = 0 end
    RGBBubble.ImageColor3 = Color3.fromHSV(hue/360, 0.7, 0.9)
end)

-- ==============================================
-- ABRIR/CERRAR MENÚ (FUNCIONA SEGURO)
-- ==============================================
RGBBubble.MouseButton1Click:Connect(function()
    MainMenu.Visible = not MainMenu.Visible
    WolfText.Text = MainMenu.Visible and "✖" or "🐺"
    -- Forzar que se vea bien
    MainMenu.ZIndex = 10
    MenuImage.ZIndex = 0
end)

-- ==============================================
-- MOVER MENÚ
-- ==============================================
local drag = false
MainMenu.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        drag = true
        local pos = UserInputService:GetMouseLocation()
        local x = MainMenu.Position.X.Offset
        local y = MainMenu.Position.Y.Offset
        local dx = pos.X - x
        local dy = pos.Y - y
        while drag do
            local newPos = UserInputService:GetMouseLocation()
            MainMenu.Position = UDim2.new(0, newPos.X - dx, 0, newPos.Y - dy)
            wait()
        end
    end
end)

UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        drag = false
    end
end)

-- ==============================================
-- FUNCIONALIDAD
-- ==============================================
local AutoBuildEnabled = false
AutoBuildBtn.MouseButton1Click:Connect(function()
    AutoBuildEnabled = not AutoBuildEnabled
    AutoBuildBtn.Text = AutoBuildEnabled and "Auto construir: ON" or "Auto construir: OFF"
    AutoBuildBtn.BackgroundColor3 = AutoBuildEnabled and Color3.new(0.1, 0.5, 0.2) or Color3.new(0.2, 0.2, 0.3)
    
    if AutoBuildEnabled then
        spawn(function()
            while AutoBuildEnabled do
                local BuildingGui = PlayerGui:FindFirstChild("BuildingGui")
                if BuildingGui then
                    local BuildFrame = BuildingGui:FindFirstChild("BuildFrame")
                    if BuildFrame then
                        for _, btn in pairs(BuildFrame:GetChildren()) do
                            if btn:IsA("TextButton") and btn:FindFirstChild("Cost") then
                                local Cost = tonumber(string.gsub(btn.Cost.Text, "%D", "")) or 0
                                local Money = tonumber(string.gsub(PlayerGui.MoneyGui.Money.Amount.Text, "%D", "")) or 0
                                if Money >= Cost then
                                    pcall(function() btn:Activate() end)
                                    wait(0.5)
                                end
                            end
                        end
                    end
                end
                wait(1)
            end
        end)
    end
end)

local AutoCollectEnabled = false
AutoCollectBtn.MouseButton1Click:Connect(function()
    AutoCollectEnabled = not AutoCollectEnabled
    AutoCollectBtn.Text = AutoCollectEnabled and "Recoger dinero automáticamente: ON" or "Recoger dinero automáticamente: OFF"
    AutoCollectBtn.BackgroundColor3 = AutoCollectEnabled and Color3.new(0.1, 0.5, 0.2) or Color3.new(0.2, 0.2, 0.3)
    
    if AutoCollectEnabled then
        spawn(function()
            while AutoCollectEnabled do
                local Tycoons = game.Workspace:FindFirstChild("Tycoons")
                if Tycoons then
                    for _, Tycoon in pairs(Tycoons:GetChildren()) do
                        if Tycoon.Owner.Value == Player then
                            local Drops = Tycoon:FindFirstChild("Drops")
                            if Drops and Player.Character then
                                local HRP = Player.Character.HumanoidRootPart
                                for _, Drop in pairs(Drops:GetChildren()) do
                                    if Drop:FindFirstChild("Coin") then
                                        pcall(function() Drop.Coin.CFrame = HRP.CFrame end)
                                        wait(0.1)
                                    end
                                end
                            end
                        end
                    end
                end
                wait(0.3)
            end
        end)
    end
end)

-- CONFIRMACIÓN
print("🐺 SCRIPT LISTO - BURBUJA REDONDA Y MENÚ FUNCIONAL 🐺")
