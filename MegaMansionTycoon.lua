-- SERVICIOS
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

-- LOCAL
local LP = Players.LocalPlayer
local Char = LP.Character or LP.CharacterAdded:Wait()
local Hum = Char:WaitForChild("Humanoid")
local HRP = Char.HumanoidRootPart

-- ENCONTRAR TU TYCOON
local MyTycoon = nil
local Tycoons = Workspace:FindFirstChild("Zednov's Tycoon Kit") and Workspace["Zednov's Tycoon Kit"].Tycoons

if Tycoons then
    for _,v in pairs(Tycoons:GetChildren()) do
        if v.Owner and v.Owner.Value == LP then
            MyTycoon = v
            break
        end
    end
end

-- CREAR MENU
local PlayerGui = LP.PlayerGui
if PlayerGui:FindFirstChild("MegaMenu") then PlayerGui.MegaMenu:Destroy() end

local Menu = Instance.new("ScreenGui")
Menu.Name = "MegaMenu"
Menu.Parent = PlayerGui

-- MARCO PRINCIPAL
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 300, 0, 400)
Main.Position = UDim2.new(0.05, 0, 0.15, 0)
Main.BackgroundColor3 = Color3.new(0.08, 0.08, 0.08)
Main.BorderColor3 = Color3.new(1, 0.5, 0)
Main.BorderSizePixel = 2
Main.Draggable = true
Main.Active = true
Main.Parent = Menu

-- TITULO
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "MEGA MANSION TYCOON"
Title.TextColor3 = Color3.new(1, 0.8, 0)
Title.Font = Enum.Font.FredokaOne
Title.TextSize = 18
Title.Parent = Main

-- BOTONES DE PESTAÑAS
local BtnInfo = Instance.new("TextButton")
BtnInfo.Size = UDim2.new(0.5, -2, 0, 30)
BtnInfo.Position = UDim2.new(0, 0, 1, -30)
BtnInfo.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
BtnInfo.BorderColor3 = Color3.new(1,1,1)
BtnInfo.Text = "INFO"
BtnInfo.TextColor3 = Color3.new(1,1,1)
BtnInfo.Font = Enum.Font.GothamBold
BtnInfo.Parent = Main

local BtnMain = Instance.new("TextButton")
BtnMain.Size = UDim2.new(0.5, -2, 0, 30)
BtnMain.Position = UDim2.new(0.5, 2, 1, -30)
BtnMain.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
BtnMain.BorderColor3 = Color3.new(1,1,1)
BtnMain.Text = "MAIN"
BtnMain.TextColor3 = Color3.new(1,1,1)
BtnMain.Font = Enum.Font.GothamBold
BtnMain.Parent = Main

-- PESTAÑA INFO
local InfoFrame = Instance.new("Frame")
InfoFrame.Size = UDim2.new(1, -20, 1, -80)
InfoFrame.Position = UDim2.new(0, 10, 0, 45)
InfoFrame.BackgroundTransparency = 1
InfoFrame.Parent = Main

local Texto = Instance.new("TextLabel")
Texto.Size = UDim2.new(1, 0, 1, 0)
Texto.BackgroundTransparency = 1
Texto.Text = [[
Creador: JoseAngel_Blox
Fecha: 05/06/2026

COMO USAR:

1. Ve a la pestaña MAIN
2. Activa lo que quieras usar

AUTO COLLECT:
Recoge dinero automatico.

AUTO COMPRAR:
Construye y mejora todo.

VELOCIDAD:
Corre mas rapido.
]]
Texto.TextColor3 = Color3.new(1,1,1)
Texto.Font = Enum.Font.Gotham
Texto.TextSize = 13
Texto.TextWrapped = true
Texto.Parent = InfoFrame

-- PESTAÑA MAIN
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(1, -20, 1, -80)
MainFrame.Position = UDim2.new(0, 10, 0, 45)
MainFrame.BackgroundTransparency = 1
MainFrame.Visible = false
MainFrame.Parent = Main

-- VARIABLES
local On = false
local Con = nil

-- BOTON AUTO COLLECT
local Btn1 = Instance.new("TextButton")
Btn1.Size = UDim2.new(1, 0, 0, 45)
Btn1.Position = UDim2.new(0, 0, 0, 10)
Btn1.BackgroundColor3 = Color3.new(0.15,0.15,0.15)
Btn1.BorderColor3 = Color3.new(1,0,0)
Btn1.BorderSizePixel = 2
Btn1.Text = "AUTO COLLECT"
Btn1.TextColor3 = Color3.new(1,1,1)
Btn1.Font = Enum.Font.GothamBold
Btn1.Parent = MainFrame

-- BOTON AUTO COMPRAR
local Btn2 = Instance.new("TextButton")
Btn2.Size = UDim2.new(1, 0, 0, 45)
Btn2.Position = UDim2.new(0, 0, 0, 65)
Btn2.BackgroundColor3 = Color3.new(0.15,0.15,0.15)
Btn2.BorderColor3 = Color3.new(1,0,0)
Btn2.BorderSizePixel = 2
Btn2.Text = "AUTO COMPRAR"
Btn2.TextColor3 = Color3.new(1,1,1)
Btn2.Font = Enum.Font.GothamBold
Btn2.Parent = MainFrame

-- BOTON VELOCIDAD
local Btn3 = Instance.new("TextButton")
Btn3.Size = UDim2.new(1, 0, 0, 45)
Btn3.Position = UDim2.new(0, 0, 0, 120)
Btn3.BackgroundColor3 = Color3.new(0.15,0.15,0.15)
Btn3.BorderColor3 = Color3.new(1,0,0)
Btn3.BorderSizePixel = 2
Btn3.Text = "VELOCIDAD"
Btn3.TextColor3 = Color3.new(1,1,1)
Btn3.Font = Enum.Font.GothamBold
Btn3.Parent = MainFrame

-- FUNCION DE CAMBIAR PESTAÑAS
BtnInfo.MouseButton1Click:Connect(function()
    InfoFrame.Visible = true
    MainFrame.Visible = false
    BtnInfo.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
    BtnMain.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
end)

BtnMain.MouseButton1Click:Connect(function()
    InfoFrame.Visible = false
    MainFrame.Visible = true
    BtnInfo.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
    BtnMain.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
end)

-- AUTO COLLECT
Btn1.MouseButton1Click:Connect(function()
    On = not On
    if On then
        Btn1.Text = "AUTO COLLECT [ON]"
        Btn1.BorderColor3 = Color3.new(0,1,0)
        Con = RunService.Heartbeat:Connect(function()
            pcall(function()
                if MyTycoon and MyTycoon.Essentials and MyTycoon.Essentials.Giver then
                    firetouchinterest(MyTycoon.Essentials.Giver, HRP, 0)
                    firetouchinterest(MyTycoon.Essentials.Giver, HRP, 1)
                end
            end)
        end)
    else
        Btn1.Text = "AUTO COLLECT"
        Btn1.BorderColor3 = Color3.new(1,0,0)
        Con:Disconnect()
    end
end)

-- AUTO COMPRAR
local Con2 = nil
Btn2.MouseButton1Click:Connect(function()
    On = not On
    if On then
        Btn2.Text = "AUTO COMPRAR [ON]"
        Btn2.BorderColor3 = Color3.new(0,1,0)
        Con2 = RunService.Heartbeat:Connect(function()
            pcall(function()
                if MyTycoon then
                    for _,v in pairs(MyTycoon:GetDescendants()) do
                        if v:IsA("ClickDetector") then
                            fireclickdetector(v)
                        end
                        if v:IsA("ProximityPrompt") then
                            v:Trigger()
                        end
                    end
                end
            end)
        end)
    else
        Btn2.Text = "AUTO COMPRAR"
        Btn2.BorderColor3 = Color3.new(1,0,0)
        Con2:Disconnect()
    end
end)

-- VELOCIDAD
Btn3.MouseButton1Click:Connect(function()
    On = not On
    if On then
        Btn3.Text = "VELOCIDAD [ON]"
        Btn3.BorderColor3 = Color3.new(0,1,0)
        Hum.WalkSpeed = 70
    else
        Btn3.Text = "VELOCIDAD"
        Btn3.BorderColor3 = Color3.new(1,0,0)
        Hum.WalkSpeed = 16
    end
end)
