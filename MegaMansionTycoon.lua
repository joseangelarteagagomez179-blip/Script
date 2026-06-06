-- // Servicios
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

-- // Variables locales
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

-- // Encontrar tu Tycoon
local TuTycoon = nil
local TycoonsFolder = Workspace:FindFirstChild("Zednov's Tycoon Kit") and Workspace["Zednov's Tycoon Kit"]:FindFirstChild("Tycoons")

if TycoonsFolder then
    for _, Tycoon in pairs(TycoonsFolder:GetChildren()) do
        if Tycoon:FindFirstChild("Owner") and Tycoon.Owner.Value == LocalPlayer then
            TuTycoon = Tycoon
            break
        end
    end
end

-- ==============================================
-- 🖥️ CREAR INTERFAZ PRINCIPAL
-- ==============================================
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Eliminar GUI anterior si existe
if PlayerGui:FindFirstChild("MegaMansionGUI") then PlayerGui.MegaMansionGUI:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Titulo = Instance.new("TextLabel")

-- Botones de selección
local BtnInfo = Instance.new("TextButton")
local BtnMain = Instance.new("TextButton")

-- Contenedores
local FrameInfo = Instance.new("Frame")
local FrameMain = Instance.new("Frame")

ScreenGui.Name = "MegaMansionGUI"
ScreenGui.Parent = PlayerGui

-- Diseño del cuadro principal
MainFrame.Size = UDim2.new(0, 320, 0, 420)
MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
MainFrame.BorderSizePixel = 2
MainFrame.Draggable = true
MainFrame.Active = true
MainFrame.Parent = ScreenGui

-- Título
Titulo.Size = UDim2.new(1, 0, 0, 35)
Titulo.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
Titulo.Text = "✨ Mega Mansion Tycoon ✨"
Titulo.TextColor3 = Color3.new(1, 1, 1)
Titulo.Font = Enum.Font.GothamBold
Titulo.TextSize = 16
Titulo.Parent = MainFrame

-- ==============================================
-- 📄 PESTAÑA INFO
-- ==============================================
FrameInfo.Size = UDim2.new(1, -20, 1, -80)
FrameInfo.Position = UDim2.new(0, 10, 0, 45)
FrameInfo.BackgroundTransparency = 1
FrameInfo.Visible = true -- Empezar mostrando esta
FrameInfo.Parent = MainFrame

local TextoInfo = Instance.new("TextLabel")
TextoInfo.Size = UDim2.new(1, 0, 1, 0)
TextoInfo.BackgroundTransparency = 1
TextoInfo.Text = [[
Nombre del creador: JoseAngel_Blox

Fecha de lanzamiento: 05/06/2026

📖 TUTORIAL DE USO:

1. Ve a la pestaña "MAIN".
2. Activa "AUTO COLLECT" para
   que el dinero llegue solo.
3. Activa "AUTO COMPRAR" para
   que mejore todo automáticamente.
4. Usa "VELOCIDAD" para moverte
   mucho más rápido por el mapa.
5. ¡Disfruta construyendo tu
   mansión más rápido!
]]
TextoInfo.TextColor3 = Color3.new(1, 1, 1)
TextoInfo.Font = Enum.Font.Gotham
TextoInfo.TextSize = 13
TextoInfo.TextWrapped = true
TextoInfo.Parent = FrameInfo

-- ==============================================
-- ⚙️ PESTAÑA MAIN
-- ==============================================
FrameMain.Size = UDim2.new(1, -20, 1, -80)
FrameMain.Position = UDim2.new(0, 10, 0, 45)
FrameMain.BackgroundTransparency = 1
FrameMain.Visible = false
FrameMain.Parent = MainFrame

-- Título Main
local TituloMain = Instance.new("TextLabel")
TituloMain.Size = UDim2.new(1, 0, 0, 20)
TituloMain.Position = UDim2.new(0, 0, 0, 0)
TituloMain.BackgroundTransparency = 1
TituloMain.Text = "⚙️ FUNCIONES"
TituloMain.TextColor3 = Color3.new(0.2, 1, 0.2)
TituloMain.Font = Enum.Font.GothamBold
TituloMain.TextSize = 14
TituloMain.Parent = FrameMain

-- === BOTÓN 1: AUTO COLLECT ===
local AutoCollectON = false
local BtnAutoCollect = Instance.new("TextButton")
BtnAutoCollect.Size = UDim2.new(1, 0, 0, 40)
BtnAutoCollect.Position = UDim2.new(0, 0, 0, 30)
BtnAutoCollect.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
BtnAutoCollect.Text = "🔴 Auto Collect: OFF"
BtnAutoCollect.TextColor3 = Color3.new(1,1,1)
BtnAutoCollect.Font = Enum.Font.GothamBold
BtnAutoCollect.Parent = FrameMain

-- === BOTÓN 2: AUTO COMPRAR ===
local AutoBuyON = false
local BtnAutoBuy = Instance.new("TextButton")
BtnAutoBuy.Size = UDim2.new(1, 0, 0, 40)
BtnAutoBuy.Position = UDim2.new(0, 0, 0, 80)
BtnAutoBuy.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
BtnAutoBuy.Text = "🔴 Auto Comprar: OFF"
BtnAutoBuy.TextColor3 = Color3.new(1,1,1)
BtnAutoBuy.Font = Enum.Font.GothamBold
BtnAutoBuy.Parent = FrameMain

-- === BOTÓN 3: VELOCIDAD ===
local SpeedON = false
local BtnSpeed = Instance.new("TextButton")
BtnSpeed.Size = UDim2.new(1, 0, 0, 40)
BtnSpeed.Position = UDim2.new(0, 0, 0, 130)
BtnSpeed.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
BtnSpeed.Text = "🔴 Velocidad: OFF"
BtnSpeed.TextColor3 = Color3.new(1,1,1)
BtnSpeed.Font = Enum.Font.GothamBold
BtnSpeed.Parent = FrameMain

-- ==============================================
-- 🔘 BOTONES DE MENU (ARRIBA)
-- ==============================================
BtnInfo.Size = UDim2.new(0.5, -2, 0, 30)
BtnInfo.Position = UDim2.new(0, 0, 1, -30)
BtnInfo.BackgroundColor3 = Color3.new(0.3,0.3,0.3)
BtnInfo.Text = "ℹ️ INFO"
BtnInfo.TextColor3 = Color3.new(1,1,1)
BtnInfo.Font = Enum.Font.GothamBold
BtnInfo.Parent = MainFrame

BtnMain.Size = UDim2.new(0.5, -2, 0, 30)
BtnMain.Position = UDim2.new(0.5, 2, 1, -30)
BtnMain.BackgroundColor3 = Color3.new(0.15,0.15,0.15)
BtnMain.Text = "⚙️ MAIN"
BtnMain.TextColor3 = Color3.new(1,1,1)
BtnMain.Font = Enum.Font.GothamBold
BtnMain.Parent = MainFrame

-- ==============================================
-- 🔧 LÓGICA DE FUNCIONES
-- ==============================================
local ConnectionCollect = nil
local ConnectionBuy = nil

-- Cambiar entre pestañas
BtnInfo.MouseButton1Click:Connect(function()
    FrameInfo.Visible = true
    FrameMain.Visible = false
    BtnInfo.BackgroundColor3 = Color3.new(0.3,0.3,0.3)
    BtnMain.BackgroundColor3 = Color3.new(0.15,0.15,0.15)
end)

BtnMain.MouseButton1Click:Connect(function()
    FrameInfo.Visible = false
    FrameMain.Visible = true
    BtnInfo.BackgroundColor3 = Color3.new(0.15,0.15,0.15)
    BtnMain.BackgroundColor3 = Color3.new(0.3,0.3,0.3)
end)

-- === FUNCIÓN AUTO COLLECT ===
BtnAutoCollect.MouseButton1Click:Connect(function()
    AutoCollectON = not AutoCollectON
    if AutoCollectON then
        BtnAutoCollect.Text = "🟢 Auto Collect: ON"
        BtnAutoCollect.BackgroundColor3 = Color3.new(0,0.4,0)
        
        if TuTycoon then
            local Giver = TuTycoon:FindFirstChild("Essentials") and TuTycoon.Essentials:FindFirstChild("Giver")
            if Giver then
                ConnectionCollect = RunService.Heartbeat:Connect(function()
                    pcall(function()
                        firetouchinterest(Giver, HumanoidRootPart, 0)
                        firetouchinterest(Giver, HumanoidRootPart, 1)
                    end)
                end)
            end
        end
    else
        BtnAutoCollect.Text = "🔴 Auto Collect: OFF"
        BtnAutoCollect.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
        if ConnectionCollect then ConnectionCollect:Disconnect() end
    end
end)

-- === FUNCIÓN AUTO COMPRAR ===
BtnAutoBuy.MouseButton1Click:Connect(function()
    AutoBuyON = not AutoBuyON
    if AutoBuyON then
        BtnAutoBuy.Text = "🟢 Auto Comprar: ON"
        BtnAutoBuy.BackgroundColor3 = Color3.new(0,0.4,0)
        
        ConnectionBuy = RunService.Heartbeat:Connect(function()
            pcall(function()
                if TuTycoon then
                    -- Busca todos los botones de compra dentro de tu tycoon
                    for _, button in pairs(TuTycoon:GetDescendants()) do
                        if button:IsA("ClickDetector") then
                            fireclickdetector(button)
                        end
                    end
                end
            end)
        end)
    else
        BtnAutoBuy.Text = "🔴 Auto Comprar: OFF"
        BtnAutoBuy.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
        if ConnectionBuy then ConnectionBuy:Disconnect() end
    end
end)

-- === FUNCIÓN VELOCIDAD ===
BtnSpeed.MouseButton1Click:Connect(function()
    SpeedON = not SpeedON
    if SpeedON then
        BtnSpeed.Text = "🟢 Velocidad: ON"
        BtnSpeed.BackgroundColor3 = Color3.new(0,0.4,0)
        Humanoid.WalkSpeed = 70
    else
        BtnSpeed.Text = "🔴 Velocidad: OFF"
        BtnSpeed.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
        Humanoid.WalkSpeed = 16 -- Velocidad normal
    end
end)

print("🎉 Script Mega Mansion Tycoon cargado!")
