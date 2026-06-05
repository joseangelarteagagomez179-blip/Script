-- GIGA MANSION TYCOON - SCRIPT QUE NO FALLA
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

-- CREAR UI QUE SI SE VE
local UIScreen = Instance.new("ScreenGui")
UIScreen.Name = "GigaMansion"
UIScreen.Parent = PlayerGui

-- ==============================================
-- BURBUJA REDONDA (SIN DEPENDER DE CORNERRADIUS)
-- ==============================================
local RGBBubble = Instance.new("ImageButton") -- Usamos ImageButton para forma redonda
RGBBubble.Name = "WolfBubble"
RGBBubble.Parent = UIScreen
RGBBubble.Size = UDim2.new(0, 55, 0, 55)
RGBBubble.Position = UDim2.new(0.05, 0, 0.05, 0)
RGBBubble.BackgroundTransparency = 1
-- Imagen redonda por defecto de Roblox
RGBBubble.Image = "rbxassetid://107091627"
RGBBubble.ImageColor3 = Color3.new(1, 0, 0)
RGBBubble.ScaleType = Enum.ScaleType.Fit
-- Texto de lobo encima
local BubbleText = Instance.new("TextLabel")
BubbleText.Parent = RGBBubble
BubbleText.Size = UDim2.new(1, 0, 1, 0)
BubbleText.BackgroundTransparency = 1
BubbleText.Text = "🐺"
BubbleText.TextSize = 28
BubbleText.Font = Enum.Font.GothamBold
BubbleText.TextColor3 = Color3.new(1,1,1)

-- ==============================================
-- MENÚ PRINCIPAL QUE SI APARECE
-- ==============================================
local MainMenu = Instance.new("Frame")
MainMenu.Name = "MainMenu"
MainMenu.Parent = UIScreen
MainMenu.Size = UDim2.new(0, 320, 0, 250)
MainMenu.Position = UDim2.new(0.15, 0, 0.05, 0)
MainMenu.BackgroundColor3 = Color3.new(0.1, 0.1, 0.2)
MainMenu.BorderSizePixel = 2
MainMenu.BorderColor3 = Color3.new(0.3, 0.3, 0.5)
MainMenu.Visible = false
-- Hacer bordes redondos con una imagen
local MenuImage = Instance.new("ImageLabel")
MenuImage.Parent = MainMenu
MenuImage.Size = UDim2.new(1, 0, 1, 0)
MenuImage.BackgroundTransparency = 1
MenuImage.Image = "rbxassetid://4623342923" -- Imagen de marco redondo
MenuImage.ImageColor3 = Color3.new(0.1, 0.1, 0.2)
MenuImage.ZIndex = 0

-- ==============================================
-- CONTENIDO DEL MENÚ
-- ==============================================
-- Título con lobo
local Title = Instance.new("TextLabel")
Title.Parent = MainMenu
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.new(0.2, 0.2, 0.35)
Title.Text = "🐺 GIGA MANSION TYCOON 🐺"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

-- Info
local Info = Instance.new("TextLabel")
Info.Parent = MainMenu
Info.Size = UDim2.new(1, 0, 0, 60)
Info.Position = UDim2.new(0,0,0,40)
Info.BackgroundTransparency = 1
Info.Text = "Creador: JoseAngel_Blox\nFecha: 05/06/2026\nClick en la burbuja para mostrar/ocultar"
Info.TextColor3 = Color3.new(0.9,0.9,0.9)
Info.TextSize = 14
Info.TextWrapped = true

-- Botón Auto Construir
local AutoBuildBtn = Instance.new("TextButton")
AutoBuildBtn.Parent = MainMenu
AutoBuildBtn.Size = UDim2.new(1, -20, 0, 35)
AutoBuildBtn.Position = UDim2.new(0,10,0,100)
AutoBuildBtn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.35)
AutoBuildBtn.Text = "🐺 Auto Construir: OFF"
AutoBuildBtn.TextColor3 = Color3.new(1,1,1)
AutoBuildBtn.Font = Enum.Font.GothamBold
AutoBuildBtn.TextSize = 16

-- Botón Auto Recoger
local AutoCollectBtn = Instance.new("TextButton")
AutoCollectBtn.Parent = MainMenu
AutoCollectBtn.Size = UDim2.new(1, -20, 0, 35)
AutoCollectBtn.Position = UDim2.new(0,10,0,140)
AutoCollectBtn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.35)
AutoCollectBtn.Text = "💰 Auto Recoger: OFF"
AutoCollectBtn.TextColor3 = Color3.new(1,1,1)
AutoBuildBtn.Font = Enum.Font.GothamBold
AutoCollectBtn.TextSize = 16

-- ==============================================
-- EFECTO RGB EN BURBUJA
-- ==============================================
local hue = 0
RunService.Heartbeat:Connect(function(d)
    hue = hue + d*50
    if hue >= 360 then hue = 0 end
    RGBBubble.ImageColor3 = Color3.fromHSV(hue/360, 0.7, 0.9)
end)

-- ==============================================
-- MOSTRAR/Ocultar MENÚ - 100% FUNCIONAL
-- ==============================================
RGBBubble.MouseButton1Click:Connect(function()
    MainMenu.Visible = not MainMenu.Visible
    if MainMenu.Visible then
        BubbleText.Text = "✖"
    else
        BubbleText.Text = "🐺"
    end
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
local AutoBuild = false
AutoBuildBtn.MouseButton1Click:Connect(function()
    AutoBuild = not AutoBuild
    AutoBuildBtn.Text = AutoBuild and "🐺 Auto Construir: ON" or "🐺 Auto Construir: OFF"
    AutoBuildBtn.BackgroundColor3 = AutoBuild and Color3.new(0.1, 0.5, 0.2) or Color3.new(0.2, 0.2, 0.35)
    if AutoBuild then
        spawn(function()
            while AutoBuild do
                local BuildGui = PlayerGui:FindFirstChild("BuildGui")
                if BuildGui then
                    for _,b in pairs(BuildGui:GetDescendants()) do
                        if b:IsA("TextButton") and b.BackgroundColor3 == Color3.new(0,1,0) then
                            pcall(function() b:Activate() end)
                        end
                    end
                end
                wait(1)
            end
        end)
    end
end)

local AutoCollect = false
AutoCollectBtn.MouseButton1Click:Connect(function()
    AutoCollect = not AutoCollect
    AutoCollectBtn.Text = AutoCollect and "💰 Auto Recoger: ON" or "💰 Auto Recoger: OFF"
    AutoCollectBtn.BackgroundColor3 = AutoCollect and Color3.new(0.1, 0.5, 0.2) or Color3.new(0.2, 0.2, 0.35)
    if AutoCollect then
        spawn(function()
            while AutoCollect do
                local Coins = game.Workspace:FindFirstChild("Coins")
                if Coins and Player.Character then
                    for _,c in pairs(Coins:GetChildren()) do
                        pcall(function()
                            if c:IsA("BasePart") then
                                c.CFrame = Player.Character.HumanoidRootPart.CFrame
                            end
                        end)
                    end
                end
                wait(0.5)
            end
        end)
    end
end)

-- MENSAJE DE CONFIRMACIÓN
print("🐺 SCRIPT CARGADO - BURBUJA REDONDA LISTA 🐺")
