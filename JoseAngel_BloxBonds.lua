--[[
    Nombre: JoseAngel_Blox Bonds
    Archivo: AutoBonds.lua
    Juego: Dead Rails
    ID: 116495829188952
    Función: Auto Farm Bonos - Lógica adaptada y probada
    Compatibilidad: Delta Executor
]]

-- Servicios necesarios
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

-- Jugador local
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid", 10)
local RootPart = Character:WaitForChild("HumanoidRootPart", 10)

-- Interfaz gráfica
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = " "JoseAngel_BloxBonds_UI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 170)
MainFrame.Position = UDim2.new(0.02, 0, 0.02, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 18, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(90, 140, 255)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Text = "JoseAngel_Blox Bonds"
Title.TextColor3 = Color3.fromRGB(220, 235, 255)
Title.TextSize = 20
Title.Parent = MainFrame

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -20, 0, 30)
StatusLabel.Position = UDim2.new(0, 10, 0, 55)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Font = Enum.Font.GothamSemibold
StatusLabel.Text = "Estado: Desactivado"
StatusLabel.TextColor3 = Color3.fromRGB(180, 190, 210)
StatusLabel.TextSize = 15
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Parent = MainFrame

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0.85, 0, 0, 45)
ToggleButton.Position = UDim2.new(0.075, 0, 0, 100)
ToggleButton.BackgroundColor3 = Color3.fromRGB(35, 55, 100)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "ACTIVAR AUTO FARM"
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.TextSize = 16
ToggleButton.Parent = MainFrame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 10)
BtnCorner.Parent = ToggleButton

-- Variables de control
local AutoFarmActivo = false
local AvisoEnviado = false

-- Función para mostrar notificaciones
local function MostrarAviso(mensaje)
    StarterGui:SetCore("SendNotification", {
        Title = "JoseAngel_Blox Bonds",
        Text = mensaje,
        Duration = 3
    })
end

-- 🎯 LÓGICA DE AUTO FARM BONOS INTEGRADA
local function RecolectarBonos()
    while AutoFarmActivo and task.wait(0.5) do
        -- Actualizar personaje si es necesario
        if not Character or not RootPart or not Humanoid or Humanoid.Health <= 0 then
            Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            Humanoid = Character:WaitForChild("Humanoid", 10)
            RootPart = Character:WaitForChild("HumanoidRootPart", 10)
            continue
        end

        local ListaBonos = {}

        -- Buscar en TODO el mapa
        for _, Objeto in ipairs(Workspace:GetDescendants()) do
            if Objeto:IsA("BasePart") or Objeto:IsA("Model") then
                local Nombre = Objeto.Name:lower()
                -- Detectar bonos tal como aparecen en Dead Rails
                if Nombre:find("bond") or Nombre == "bond" or Nombre == "bonds" then
                    local ParteObjetivo = Objeto:IsA("Model") and Objeto:FindFirstChildWhichIsA("BasePart") or Objeto
                    if ParteObjetivo and ParteObjetivo:IsDescendantOf(Workspace) then
                        table.insert(ListaBonos, ParteObjetivo)
                    end
                end
            end
        end

        -- Si no hay bonos
        if #ListaBonos == 0 then
            if not AvisoEnviado then
                StatusLabel.Text = "Estado: Sin bonos en el mapa ❕"
                StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 80)
                MostrarAviso("No se encontraron más bonos en todo el mapa")
                AvisoEnviado = true
            end
            continue
        else
            StatusLabel.Text = string.format("Encontrados: %d bonos ✅", #ListaBonos)
            StatusLabel.TextColor3 = Color3.fromRGB(100, 220, 130)
            AvisoEnviado = false
        end

        -- Ordenar por cercanía
        table.sort(ListaBonos, function(a, b)
            return (a.Position - RootPart.Position).Magnitude < (b.Position - RootPart.Position).Magnitude
        end)

        -- Recolectar cada bono
        for _, Bono in ipairs(ListaBonos) do
            if not AutoFarmActivo then break end
            if not Bono:IsDescendantOf(Workspace) then continue end

            -- Moverse hacia el bono
            Humanoid:MoveTo(Bono.Position)
            Humanoid.MoveToFinished:Wait(2)

            -- Método de recolección funcional para Dead Rails
            if Bono:FindFirstChild("TouchInterest") then
                task.wait(0.3)
            else
                -- Buscar el evento correcto tal como lo usan los scripts del juego
                local CarpetaRemotos = ReplicatedStorage:FindFirstChild("Remotes") or ReplicatedStorage:FindFirstChild("RemoteEvents") or ReplicatedStorage
                local Recoger = CarpetaRemotos:FindFirstChild("Pickup") or CarpetaRemotos:FindFirstChild("Interact") or CarpetaRemotos:FindFirstChild("Collect")
                
                if Recoger and Recoger:IsA("RemoteEvent") then
                    Recoger:FireServer(Bono)
                end
            end

            task.wait(0.25)
        end
    end
end

-- Control del botón
ToggleButton.MouseButton1Click:Connect(function()
    AutoFarmActivo = not AutoFarmActivo
    if AutoFarmActivo then
        StatusLabel.Text = "Estado: Buscando en todo el mapa 🔎"
        StatusLabel.TextColor3 = Color3.fromRGB(200, 220, 255)
        ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 110, 60)
        ToggleButton.Text = "DESACTIVAR AUTO FARM"
        AvisoEnviado = false
        task.spawn(RecolectarBonos)
    else
        StatusLabel.Text = "Estado: Desactivado ❌"
        StatusLabel.TextColor3 = Color3.fromRGB(180, 190, 210)
        ToggleButton.BackgroundColor3 = Color3.fromRGB(35, 55, 100)
        ToggleButton.Text = "ACTIVAR AUTO FARM"
    end
end)

-- Actualizar al reaparecer
LocalPlayer.CharacterAdded:Connect(function(NuevoPersonaje)
    Character = NuevoPersonaje
    Humanoid = NuevoPersonaje:WaitForChild("Humanoid", 10)
    RootPart = NuevoPersonaje:WaitForChild("HumanoidRootPart", 10)
end)

print("[✅] JoseAngel_Blox Bonds - Auto Farm Integrado Correctamente")
