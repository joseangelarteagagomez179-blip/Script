--[[
    JOSEANGEL - BLOX BONDS | DEAD RAILS
    Auto Farm Bonds
--]]

-- Verificar si ya está ejecutándose
if _G.JoseAngelBondsLoaded then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "JoseAngel",
        Text = "Script ya activo",
        Duration = 2
    })
    return
end

_G.JoseAngelBondsLoaded = true

-- Servicios
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- Variables
local Farming = false
local FarmDelay = 1.5

-- Funciones
local function Notify(text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "JoseAngel Bonds",
        Text = text,
        Duration = 2
    })
end

local function FindBonds()
    local bonds = {}
    local descendants = game:GetDescendants()
    
    for _, obj in ipairs(descendants) do
        if obj:IsA("BasePart") or obj:IsA("Model") then
            local name = obj.Name:lower()
            -- Palabras clave para bonds en Dead Rails
            if name:find("bond") or name:find("bono") or name:find("token") or name:find("coin") or name:find("reward") or name:find("chest") then
                if obj:FindFirstChild("TouchInterest") or obj:IsA("BasePart") then
                    table.insert(bonds, obj)
                end
            end
        end
    end
    
    return bonds
end

local function CollectBond(bond)
    if not bond or not bond.Parent then return false end
    
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return false end
    
    local hrp = character.HumanoidRootPart
    local distance = (hrp.Position - bond.Position).Magnitude
    
    if distance > 5 then
        hrp.CFrame = CFrame.new(bond.Position)
    end
    
    wait(0.3)
    return true
end

local function StartFarming()
    if Farming then
        Notify("Ya está farmeando")
        return
    end
    
    Farming = true
    Notify("Auto Farm Bonds INICIADO")
    
    while Farming do
        local success = pcall(function()
            local bonds = FindBonds()
            
            if #bonds > 0 then
                for _, bond in ipairs(bonds) do
                    if not Farming then break end
                    CollectBond(bond)
                    wait(FarmDelay)
                end
            else
                wait(1)
            end
        end)
        
        if not success then
            wait(1)
        end
    end
end

local function StopFarming()
    Farming = false
    Notify("Auto Farm Bonds DETENIDO")
end

-- GUI SIMPLE
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngelBonds"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 250, 0, 120)
MainFrame.Position = UDim2.new(0.5, -125, 0.7, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(255, 70, 100)
Title.Text = "JOSEANGEL | BLOX BONDS"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

local FarmButton = Instance.new("TextButton")
FarmButton.Size = UDim2.new(0.8, 0, 0.35, 0)
FarmButton.Position = UDim2.new(0.1, 0, 0.45, 0)
FarmButton.BackgroundColor3 = Color3.fromRGB(255, 70, 100)
FarmButton.Text = "🚀 AUTO FARM BONDS"
FarmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmButton.TextScaled = true
FarmButton.Font = Enum.Font.GothamBold
FarmButton.Parent = MainFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 8)
ButtonCorner.Parent = FarmButton

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, 0, 0, 25)
StatusText.Position = UDim2.new(0, 0, 0.85, 0)
StatusText.BackgroundTransparency = 1
StatusText.Text = "🔴 Inactivo"
StatusText.TextColor3 = Color3.fromRGB(200, 200, 200)
StatusText.TextScaled = true
StatusText.Font = Enum.Font.Gotham
StatusText.Parent = MainFrame

-- Arrastrar ventana
local dragging = false
local dragStart
local startPos

Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Botón farm
FarmButton.MouseButton1Click:Connect(function()
    if Farming then
        StopFarming()
        FarmButton.BackgroundColor3 = Color3.fromRGB(255, 70, 100)
        FarmButton.Text = "🚀 AUTO FARM BONDS"
        StatusText.Text = "🔴 Inactivo"
        StatusText.TextColor3 = Color3.fromRGB(200, 200, 200)
    else
        StartFarming()
        FarmButton.BackgroundColor3 = Color3.fromRGB(50, 200, 80)
        FarmButton.Text = "⏹️ DETENER"
        StatusText.Text = "🟢 Farmeando Bonds..."
        StatusText.TextColor3 = Color3.fromRGB(100, 255, 100)
    end
end)

Notify("Script cargado | Presiona AUTO FARM BONDS")
