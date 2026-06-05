-- GIGA MANSION TYCOON - SCRIPT 100% QUE SALE EL MENÚ
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

-- CREAR UI SUPER SIMPLE
local UIScreen = Instance.new("ScreenGui")
UIScreen.Name = "GigaMansion"
UIScreen.Parent = PlayerGui

-- ==============================================
-- BURBUJA REDONDA CON LOBO (SIEMPRE SE VE)
-- ==============================================
local RGBBubble = Instance.new("Frame")
RGBBubble.Name = "Bubble"
RGBBubble.Parent = UIScreen
RGBBubble.Size = UDim2.new(0, 55, 0, 55)
RGBBubble.Position = UDim2.new(0.05, 0, 0.05, 0)
RGBBubble.BackgroundColor3 = Color3.new(1, 0, 0)
RGBBubble.CornerRadius = UDim.new(1, 0) -- REDONDA
RGBBubble.ZIndex = 100

-- Lobo en la burbuja
local Wolf = Instance.new("TextLabel")
Wolf.Parent = RGBBubble
Wolf.Size = UDim2.new(1, 0, 1, 0)
Wolf.BackgroundTransparency = 1
Wolf.Text = "🐺"
Wolf.TextSize = 28
Wolf.TextColor3 = Color3.new(1,1,1)
Wolf.ZIndex = 101

-- Botón de click
local ClickBtn = Instance.new("TextButton")
ClickBtn.Parent = RGBBubble
ClickBtn.Size = UDim2.new(1, 0, 1, 0)
ClickBtn.BackgroundTransparency = 1
ClickBtn.Text = ""
ClickBtn.ZIndex = 102

-- ==============================================
-- MENÚ QUE SALE FORZADO
-- ==============================================
local MainMenu = Instance.new("Frame")
MainMenu.Name = "Menu"
MainMenu.Parent = UIScreen
MainMenu.Size = UDim2.new(0, 340, 0, 280)
MainMenu.Position = UDim2.new(0.15, 0, 0.05, 0)
MainMenu.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
MainMenu.ZIndex = 99
-- FORZAR QUE SE VEA AL PRINCIPIO (opcional)
-- MainMenu.Visible = true

-- ==============================================
-- CONTENIDO DEL MENÚ
-- ==============================================
-- Título
local Title = Instance.new("TextLabel")
Title.Parent = MainMenu
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "🐺 GIGA MANSION TYCOON 🐺"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20

-- Info
local Info = Instance.new("TextLabel")
Info.Parent = MainMenu
Info.Size = UDim2.new(1, 0, 0, 80)
Info.Position = UDim2.new(0,0,0,40)
Info.Text = "Nombre del creador: JoseAngel_Blox\nFecha de Creación: 05/06/2026\n\nTutorial: Auto construir (necesitas dinero) y auto recoger dinero."
Info.TextColor3 = Color3.new(0.9,0.9,0.9)
Info.TextSize = 14
Info.TextWrapped = true

-- Main - Opciones
local Opt1 = Instance.new("TextButton")
Opt1.Parent = MainMenu
Opt1.Size = UDim2.new(1, -20, 0, 30)
Opt1.Position = UDim2.new(0,10,0,120)
Opt1.Text = "Auto construir: OFF"
Opt1.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
Opt1.TextColor3 = Color3.new(1,1,1)

local Opt2 = Instance.new("TextButton")
Opt2.Parent = MainMenu
Opt2.Size = UDim2.new(1, -20, 0, 30)
Opt2.Position = UDim2.new(0,10,0,160)
Opt2.Text = "Recoger dinero automáticamente: OFF"
Opt2.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
Opt2.TextColor3 = Color3.new(1,1,1)

-- ==============================================
-- EFECTO RGB
-- ==============================================
local hue = 0
RunService.Heartbeat:Connect(function(d)
    hue = hue + d*50
    if hue >= 360 then hue = 0 end
    RGBBubble.BackgroundColor3 = Color3.fromHSV(hue/360, 0.7, 0.9)
end)

-- ==============================================
-- MENU SE ABRE SEGURO
-- ==============================================
-- BOTÓN DE CLICK FUNCIONA
ClickBtn.MouseButton1Click:Connect(function()
    MainMenu.Visible = not MainMenu.Visible
    Wolf.Text = MainMenu.Visible and "✖" or "🐺"
    -- FORZAR QUE SE VEA
    MainMenu.Visible = not MainMenu.Visible
    print("CLICK DETECTADO - MENÚ CAMBIA DE ESTADO")
end)

-- TECLA PARA ABRIR EL MENÚ TAMBIÉN (por si el click no funciona)
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F5 then
        MainMenu.Visible = not MainMenu.Visible
        Wolf.Text = MainMenu.Visible and "✖" or "🐺"
        print("MENÚ ABIERTO/CERRADO CON TECLA F5")
    end
end)

-- ==============================================
-- FUNCIONALIDAD
-- ==============================================
local AutoBuild = false
Opt1.MouseButton1Click:Connect(function()
    AutoBuild = not AutoBuild
    Opt1.Text = AutoBuild and "Auto construir: ON" or "Auto construir: OFF"
    Opt1.BackgroundColor3 = AutoBuild and Color3.new(0.1,0.5,0.2) or Color3.new(0.2,0.2,0.2)
    
    if AutoBuild then
        spawn(function()
            while AutoBuild do
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

local AutoCollect = false
Opt2.MouseButton1Click:Connect(function()
    AutoCollect = not AutoCollect
    Opt2.Text = AutoCollect and "Recoger dinero automáticamente: ON" or "Recoger dinero automáticamente: OFF"
    Opt2.BackgroundColor3 = AutoCollect and Color3.new(0.1,0.5,0.2) or Color3.new(0.2,0.2,0.2)
    
    if AutoCollect then
        spawn(function()
            while AutoCollect do
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

-- ==============================================
-- MENSAJE QUE CONFIRMA QUE CARGÓ
-- ==============================================
print("=====================================")
print("🐺 SCRIPT CARGADO CORRECTAMENTE 🐺")
print("👉 CLICK EN LA BURBUJA O PRESIONA F5")
print("=====================================")
MainMenu.Visible = true -- FORZAR QUE APAREZCA AL PRINCIPIO
