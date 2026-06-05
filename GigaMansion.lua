-- GIGA MANSION TYCOON - SCRIPT QUE SI CARGA
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

-- Crear UI desde cero (nunca falla)
local UIScreen = Instance.new("ScreenGui")
UIScreen.Name = "GigaMansionTycoon"
UIScreen.Parent = PlayerGui

local RGBBubble = Instance.new("TextButton")
RGBBubble.Name = "Bubble"
RGBBubble.Parent = UIScreen
RGBBubble.Size = UDim2.new(0, 50, 0, 50)
RGBBubble.Position = UDim2.new(0.1, 0, 0.1, 0)
RGBBubble.CornerRadius = UDim.new(1, 0)
RGBBubble.Text = "🏠"
RGBBubble.TextSize = 25
RGBBubble.BorderSizePixel = 2

local MainMenu = Instance.new("Frame")
MainMenu.Name = "Menu"
MainMenu.Parent = UIScreen
MainMenu.Size = UDim2.new(0, 250, 0, 180)
MainMenu.Position = UDim2.new(0.2, 0, 0.1, 0)
MainMenu.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
MainMenu.Visible = false
MainMenu.CornerRadius = UDim.new(0, 8)

-- Titulo
local Title = Instance.new("TextLabel")
Title.Parent = MainMenu
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "GIGA MANSION TYCOON"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold

-- Info
local Info = Instance.new("TextLabel")
Info.Parent = MainMenu
Info.Size = UDim2.new(1, 0, 0, 50)
Info.Position = UDim2.new(0,0,0,30)
Info.BackgroundTransparency = 1
Info.Text = "Creador: JoseAngel_Blox\nFecha: 05/06/2026"
Info.TextColor3 = Color3.new(0.9,0.9,0.9)
Info.TextSize = 12
Info.TextWrapped = true

-- Boton Auto Construir
local AutoBuildBtn = Instance.new("TextButton")
AutoBuildBtn.Parent = MainMenu
AutoBuildBtn.Size = UDim2.new(1, -20, 0, 25)
AutoBuildBtn.Position = UDim2.new(0,10,0,80)
AutoBuildBtn.Text = "Auto Construir: OFF"
AutoBuildBtn.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
AutoBuildBtn.CornerRadius = UDim.new(0,5)

-- Boton Auto Recoger
local AutoCollectBtn = Instance.new("TextButton")
AutoCollectBtn.Parent = MainMenu
AutoCollectBtn.Size = UDim2.new(1, -20, 0, 25)
AutoCollectBtn.Position = UDim2.new(0,10,0,110)
AutoCollectBtn.Text = "Auto Recoger: OFF"
AutoCollectBtn.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
AutoCollectBtn.CornerRadius = UDim.new(0,5)

-- Efecto RGB Burbuja
local hue = 0
RunService.Heartbeat:Connect(function(d)
    hue = hue + d*70
    if hue >= 360 then hue = 0 end
    RGBBubble.BackgroundColor3 = Color3.fromHSV(hue/360, 0.8, 0.9)
end)

-- Mostrar/Ocultar Menu
RGBBubble.MouseButton1Click:Connect(function()
    MainMenu.Visible = not MainMenu.Visible
    RGBBubble.Text = MainMenu.Visible and "✖" or "🏠"
end)

-- Mover Menu
local drag = false
MainMenu.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        drag = true
        local pos = UserInputService:GetMouseLocation()
        local menuPos = MainMenu.Position
        local delta = pos - Vector2.new(menuPos.X.Offset, menuPos.Y.Offset)
        while drag do
            local newPos = UserInputService:GetMouseLocation() - delta
            MainMenu.Position = UDim2.new(0, newPos.X, 0, newPos.Y)
            wait()
        end
    end
end)

UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        drag = false
    end
end)

-- Funciones Auto Construir
local AutoBuild = false
AutoBuildBtn.MouseButton1Click:Connect(function()
    AutoBuild = not AutoBuild
    AutoBuildBtn.Text = AutoBuild and "Auto Construir: ON" or "Auto Construir: OFF"
    AutoBuildBtn.BackgroundColor3 = AutoBuild and Color3.new(0.1,0.4,0.1) or Color3.new(0.2,0.2,0.2)
    if AutoBuild then
        spawn(function()
            while AutoBuild do
                local BuildGui = PlayerGui:FindFirstChild("BuildGui")
                if BuildGui then
                    local Buttons = BuildGui:GetDescendants()
                    for _,b in pairs(Buttons) do
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

-- Funciones Auto Recoger
local AutoCollect = false
AutoCollectBtn.MouseButton1Click:Connect(function()
    AutoCollect = not AutoCollect
    AutoCollectBtn.Text = AutoCollect and "Auto Recoger: ON" or "Auto Recoger: OFF"
    AutoCollectBtn.BackgroundColor3 = AutoCollect and Color3.new(0.1,0.4,0.1) or Color3.new(0.2,0.2,0.2)
    if AutoCollect then
        spawn(function()
            while AutoCollect do
                local Coins = game.Workspace:FindFirstChild("Coins")
                if Coins then
                    for _,c in pairs(Coins:GetChildren()) do
                        if c:IsA("BasePart") and Player.Character then
                            pcall(function()
                                c.CFrame = Player.Character.HumanoidRootPart.CFrame
                            end)
                        end
                    end
                end
                wait(0.5)
            end
        end)
    end
end)

print("SCRIPT CARGADO CORRECTAMENTE")
