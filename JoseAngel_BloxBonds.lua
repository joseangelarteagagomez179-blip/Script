--[[
    JOSEANGEL - BLOX BONDS | DEAD RAILS
    SOLO AUTO FARM BONDS
--]]

if _G.JoseAngelBondsOnly then
    game:GetService("StarterGui"):SetCore("SendNotification",{Title="JoseAngel",Text="Script ya activo",Duration=2})
    return
end
_G.JoseAngelBondsOnly = true

local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local CG = game:GetService("CoreGui")

local Farming = false
local Delay = 0.8

local function Notify(msg)
    game:GetService("StarterGui"):SetCore("SendNotification",{Title="JoseAngel Bonds",Text=msg,Duration=2})
end

-- SOLO buscar BONDS
local function FindBonds()
    local bonds = {}
    local descendants = game:GetDescendants()
    
    for _, obj in ipairs(descendants) do
        if obj:IsA("BasePart") or obj:IsA("Model") then
            local name = obj.Name:lower()
            -- SOLO palabras que indiquen BONOS
            if name:find("bond") or name:find("bono") or name:find("token") then
                if obj:FindFirstChild("TouchInterest") or obj:FindFirstChild("ClickDetector") or obj:FindFirstChild("ProximityPrompt") then
                    table.insert(bonds, obj)
                end
            end
        end
    end
    return bonds
end

-- Recoger BONO
local function CollectBond(bond)
    if not bond or not bond.Parent then return false end
    
    local char = LP.Character
    if not char then return false end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    
    local distance = (hrp.Position - bond.Position).Magnitude
    
    if distance > 5 then
        hrp.CFrame = CFrame.new(bond.Position)
        wait(0.2)
    end
    
    local cd = bond:FindFirstChild("ClickDetector")
    if cd then
        fireclickdetector(cd)
        return true
    end
    
    local pp = bond:FindFirstChild("ProximityPrompt")
    if pp then
        fireproximityprompt(pp)
        return true
    end
    
    return false
end

-- Bucle principal
local function FarmLoop()
    while Farming do
        local success = pcall(function()
            local bonds = FindBonds()
            
            if #bonds > 0 then
                for _, bond in ipairs(bonds) do
                    if not Farming then break end
                    CollectBond(bond)
                    wait(Delay)
                end
            else
                wait(1)
            end
        end)
        if not success then wait(1) end
    end
end

local function Start()
    if Farming then Notify("Ya está farmeando") return end
    Farming = true
    Notify("✅ Auto Farm BONDS Activado")
    task.spawn(FarmLoop)
end

local function Stop()
    Farming = false
    Notify("⏹️ Auto Farm BONDS Detenido")
end

-- GUI simple
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngelBonds"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CG

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 240, 0, 100)
MainFrame.Position = UDim2.new(0.5, -120, 0.7, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(255, 70, 100)
Title.Text = "💰 JOSEANGEL | BONDS"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local FarmButton = Instance.new("TextButton")
FarmButton.Size = UDim2.new(0.7, 0, 0.35, 0)
FarmButton.Position = UDim2.new(0.15, 0, 0.45, 0)
FarmButton.BackgroundColor3 = Color3.fromRGB(255, 70, 100)
FarmButton.Text = "💰 AUTO BONDS"
FarmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmButton.TextScaled = true
FarmButton.Font = Enum.Font.GothamBold
FarmButton.Parent = MainFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 8)
ButtonCorner.Parent = FarmButton

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, 0, 0, 20)
Status.Position = UDim2.new(0, 0, 0.85, 0)
Status.BackgroundTransparency = 1
Status.Text = "🔴 Inactivo"
Status.TextColor3 = Color3.fromRGB(200, 200, 200)
Status.TextScaled = true
Status.Font = Enum.Font.Gotham
Status.Parent = MainFrame

-- Arrastrar ventana
local dragging = false
local dragStart, startPos

Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Botón
FarmButton.MouseButton1Click:Connect(function()
    if Farming then
        Stop()
        FarmButton.BackgroundColor3 = Color3.fromRGB(255, 70, 100)
        FarmButton.Text = "💰 AUTO BONDS"
        Status.Text = "🔴 Inactivo"
        Status.TextColor3 = Color3.fromRGB(200, 200, 200)
    else
        Start()
        FarmButton.BackgroundColor3 = Color3.fromRGB(50, 200, 80)
        FarmButton.Text = "⏹️ DETENER"
        Status.Text = "🟢 Buscando Bonds..."
        Status.TextColor3 = Color3.fromRGB(100, 255, 100)
    end
end)

Notify("Script cargado | Solo farmea BONDS")
