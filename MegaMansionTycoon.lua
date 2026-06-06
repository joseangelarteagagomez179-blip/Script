-- [[ Mega Mansion Tycoon Hub ]]
-- Creado por: JoseAngel_Blox
-- Fecha de Creación: 05/06/2026

if not game:IsLoaded() then game.Loaded:Wait() end

-- Evitar duplicados de la interfaz
if game.CoreGui:FindFirstChild("MegaMansionTycoonHub") then
    game.CoreGui:FindFirstChild("MegaMansionTycoonHub"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIGradient = Instance.new("UIGradient")
local Sidebar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local InfoBtn = Instance.new("TextButton")
local MainBtn = Instance.new("TextButton")
local ContentFrame = Instance.new("Frame")
local InfoTab = Instance.new("ScrollingFrame")
local MainTab = Instance.new("Frame")
local ToggleCollect = Instance.new("TextButton")
local ToggleBuy = Instance.new("TextButton")

-- Propiedades Principales de la UI
ScreenGui.Name = "MegaMansionTycoonHub"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.Position = UDim2.new(0.35, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 480, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true -- Permite arrastrar el menú por la pantalla

UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Fondo Bonito (Degradado Moderno Oscuro/Azulado)
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 18, 26)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(32, 34, 47))
}
UIGradient.Rotation = 45
UIGradient.Parent = MainFrame

-- Barra Lateral (Navegación)
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Sidebar.BackgroundTransparency = 0.6
Sidebar.Size = UDim2.new(0, 140, 1, 0)

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 12)
SidebarCorner.Parent = Sidebar

Title.Name = "Title"
Title.Parent = Sidebar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 10, 0, 15)
Title.Size = UDim2.new(0, 120, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "Mega Mansion Tycoon"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.TextWrapped = true

-- Botón Pestana Info
InfoBtn.Name = "InfoBtn"
InfoBtn.Parent = Sidebar
InfoBtn.BackgroundColor3 = Color3.fromRGB(45, 48, 68)
InfoBtn.Position = UDim2.new(0, 10, 0, 70)
InfoBtn.Size = UDim2.new(0, 120, 0, 35)
InfoBtn.Font = Enum.Font.GothamSemibold
InfoBtn.Text = "ℹ️ Info"
InfoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoBtn.TextSize = 14
local CornerInfo = Instance.new("UICorner") CornerInfo.CornerRadius = UDim.new(0, 6) CornerInfo.Parent = InfoBtn

-- Botón Pestana Main
MainBtn.Name = "MainBtn"
MainBtn.Parent = Sidebar
MainBtn.BackgroundColor3 = Color3.fromRGB(35, 37, 53)
MainBtn.Position = UDim2.new(0, 10, 0, 115)
MainBtn.Size = UDim2.new(0, 120, 0, 35)
MainBtn.Font = Enum.Font.GothamSemibold
MainBtn.Text = "⚙️ Main"
MainBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MainBtn.TextSize = 14
local CornerMain = Instance.new("UICorner") CornerMain.CornerRadius = UDim.new(0, 6) CornerMain.Parent = MainBtn

-- Contenedor de Páginas
ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 150, 0, 15)
ContentFrame.Size = UDim2.new(0, 315, 0, 270)

-- =========================================================
-- CONTENIDO: PESTAÑA INFO
-- =========================================================
InfoTab.Name = "InfoTab"
InfoTab.Parent = ContentFrame
InfoTab.BackgroundTransparency = 1
InfoTab.Size = UDim2.new(1, 0, 1, 0)
InfoTab.CanvasSize = UDim2.new(0, 0, 1.2, 0)
InfoTab.ScrollBarThickness = 4

local function CreateLabel(text, font, size, pos, parent, color)
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Position = pos
    label.Size = UDim2.new(1, -10, 0, 20)
    label.Font = font
    label.Text = text
    label.TextColor3 = color or Color3.fromRGB(230, 230, 230)
    label.TextSize = size
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Top
    label.TextWrapped = true
    label.Parent = parent
    return label
end

CreateLabel("Nombre del creador: JoseAngel_Blox", Enum.Font.GothamBold, 14, UDim2.new(0, 0, 0, 0), InfoTab, Color3.fromRGB(0, 210, 255))
CreateLabel("Fecha de Creación: 05/06/2026", Enum.Font.GothamSemibold, 12, UDim2.new(0, 0, 0, 25), InfoTab, Color3.fromRGB(150, 150, 160))

local tutorialTitle = CreateLabel("Tutorial de cómo usar:", Enum.Font.GothamBold, 13, UDim2.new(0, 0, 0, 60), InfoTab, Color3.fromRGB(255, 255, 255))
local tutorialBody = CreateLabel("Este script tiene dos funciones la primera opción es auto recojer dinero y la segunda función auto construir en auto construir es para comprar los botones automáticamente sin estar parándote en uno de ellos y el auto recojer dinero es para recojer dinero automáticamente sin ir al puesto de cartas", Enum.Font.Gotham, 12, UDim2.new(0, 0, 0, 85), InfoTab, Color3.fromRGB(200, 200, 205))
tutorialBody.Size = UDim2.new(1, -10, 0, 150)

-- =========================================================
-- CONTENIDO: PESTAÑA MAIN
-- =========================================================
MainTab.Name = "MainTab"
MainTab.Parent = ContentFrame
MainTab.BackgroundTransparency = 1
MainTab.Size = UDim2.new(1, 0, 1, 0)
MainTab.Visible = false

-- Botón Toggle Auto-Collect
ToggleCollect.Name = "ToggleCollect"
ToggleCollect.Parent = MainTab
ToggleCollect.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
ToggleCollect.Position = UDim2.new(0, 10, 0, 20)
ToggleCollect.Size = UDim2.new(1, -20, 0, 45)
ToggleCollect.Font = Enum.Font.GothamBold
ToggleCollect.Text = "Auto Recoger Dinero: DESACTIVADO"
ToggleCollect.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleCollect.TextSize = 13
local CornerTC = Instance.new("UICorner") CornerTC.CornerRadius = UDim.new(0, 8) CornerTC.Parent = ToggleCollect

-- Botón Toggle Auto-Buy
ToggleBuy.Name = "ToggleBuy"
ToggleBuy.Parent = MainTab
ToggleBuy.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
ToggleBuy.Position = UDim2.new(0, 10, 0, 85)
ToggleBuy.Size = UDim2.new(1, -20, 0, 45)
ToggleBuy.Font = Enum.Font.GothamBold
ToggleBuy.Text = "Auto Construir: DESACTIVADO"
ToggleBuy.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBuy.TextSize = 13
local CornerTB = Instance.new("UICorner") CornerTB.CornerRadius = UDim.new(0, 8) CornerTB.Parent = ToggleBuy

-- Navegación del Menú (Cambio de Pestañas)
InfoBtn.MouseButton1Click:Connect(function()
    InfoTab.Visible = true
    MainTab.Visible = false
    InfoBtn.BackgroundColor3 = Color3.fromRGB(45, 48, 68)
    InfoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MainBtn.BackgroundColor3 = Color3.fromRGB(35, 37, 53)
    MainBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
end)

MainBtn.MouseButton1Click:Connect(function()
    MainTab.Visible = true
    InfoTab.Visible = false
    MainBtn.BackgroundColor3 = Color3.fromRGB(45, 48, 68)
    MainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    InfoBtn.BackgroundColor3 = Color3.fromRGB(35, 37, 53)
    InfoBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
end)

-- =========================================================
-- LÓGICA DE AUTOMATIZACIÓN (BACKEND)
-- =========================================================
getgenv().AutoCollect = false
getgenv().AutoBuy = false

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local RootPart = Character:WaitForChild("HumanoidRootPart")

local MyTycoon = nil
for _, obj in pairs(workspace:GetDescendants()) do
    if (obj.Name == "Owner" or obj.Name == "Claimed") and obj.Value == LocalPlayer then
        MyTycoon = obj.Parent
        break
    end
end

local MoneyStat = LocalPlayer:FindFirstChild("leaderstats") and (LocalPlayer.leaderstats:FindFirstChild("Money") or LocalPlayer.leaderstats:FindFirstChild("Cash"))

local function Touch(part)
    if firetouchinterest then
        firetouchinterest(RootPart, part, 0)
        task.wait(0.02)
        firetouchinterest(RootPart, part, 1)
    else
        local oldCFrame = RootPart.CFrame
        RootPart.CFrame = part.CFrame
        task.wait(0.05)
        RootPart.CFrame = oldCFrame
    end
end

-- Interactividad de los botones ON/OFF
ToggleCollect.MouseButton1Click:Connect(function()
    getgenv().AutoCollect = not getgenv().AutoCollect
    if getgenv().AutoCollect then
        ToggleCollect.BackgroundColor3 = Color3.fromRGB(50, 180, 90)
        ToggleCollect.Text = "Auto Recoger Dinero: ACTIVADO"
    else
        ToggleCollect.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
        ToggleCollect.Text = "Auto Recoger Dinero: DESACTIVADO"
    end
end)

ToggleBuy.MouseButton1Click:Connect(function()
    getgenv().AutoBuy = not getgenv().AutoBuy
    if getgenv().AutoBuy then
        ToggleBuy.BackgroundColor3 = Color3.fromRGB(50, 180, 90)
        ToggleBuy.Text = "Auto Construir: ACTIVADO"
    else
        ToggleBuy.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
        ToggleBuy.Text = "Auto Construir: DESACTIVADO"
    end
end)

-- Hilos de ejecución en segundo plano
task.spawn(function()
    while true do
        task.wait(0.5)
        if getgenv().AutoCollect and MyTycoon then
            pcall(function()
                for _, obj in pairs(MyTycoon:GetDescendants()) do
                    if obj.Name:lower():find("collect") or obj.Name:lower():find("giver") then
                        if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then
                            Touch(obj)
                        end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while true do
