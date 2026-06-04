--!strict
-- JoseAngel_Blox Bonds | Dead Rails
-- Optimizado para Delta Executor

local Config = {
    BonoName = "Bond",
    UsarTeletransporte = true,
    UsarProximityPrompt = true,
    DistanciaMaxima = 250,
    RetrasoEntreAcciones = 0.6,
    BuscarPorSimilitud = true,
    ColorFondo = Color3.fromRGB(20, 22, 30),
    ColorTexto = Color3.fromRGB(240, 240, 255),
    ColorResaltado = Color3.fromRGB(85, 170, 255)
}

_G.JoseAngel_Blox_Activado = false

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart") :: Part
local Humanoid = Character:WaitForChild("Humanoid") :: Humanoid

local function CrearInterfaz()
    if CoreGui:FindFirstChild("JoseAngel_Blox_BondsUI") then
        CoreGui.JoseAngel_Blox_BondsUI:Destroy()
    end

    local Pantalla = Instance.new("ScreenGui")
    Pantalla.Name = "JoseAngel_Blox_BondsUI"
    Pantalla.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Pantalla.ResetOnSpawn = false
    Pantalla.Parent = CoreGui

    local Ventana = Instance.new("Frame")
    Ventana.Name = "Ventana"
    Ventana.Size = UDim2.new(0, 280, 0, 160)
    Ventana.Position = UDim2.new(0.02, 0, 0.05, 0)
    Ventana.BackgroundColor3 = Config.ColorFondo
    Ventana.BorderSizePixel = 0
    Ventana.Active = true
    Ventana.Draggable = true
    Ventana.Parent = Pantalla

    local Esquinas = Instance.new("UICorner")
    Esquinas.CornerRadius = UDim.new(0, 10)
    Esquinas.Parent = Ventana

    local Borde = Instance.new("UIStroke")
    Borde.Color = Config.ColorResaltado
    Borde.Thickness = 2
    Borde.Transparency = 0.3
    Borde.Parent = Ventana

    local Titulo = Instance.new("TextLabel")
    Titulo.Size = UDim2.new(1, 0, 0, 40)
    Titulo.BackgroundTransparency = 1
    Titulo.Font = Enum.Font.GothamBold
    Titulo.Text = "✨ JoseAngel_Blox Bonds"
    Titulo.TextColor3 = Config.ColorResaltado
    Titulo.TextSize = 18
    Titulo.Parent = Ventana

    local Linea = Instance.new("Frame")
    Linea.Size = UDim2.new(0.9, 0, 0, 1)
    Linea.Position = UDim2.new(0.05, 0, 0, 40)
    Linea.BackgroundColor3 = Config.ColorResaltado
    Linea.BackgroundTransparency = 0.6
    Linea.BorderSizePixel = 0
    Linea.Parent = Ventana

    local Estado = Instance.new("TextLabel")
    Estado.Size = UDim2.new(1, -20, 0, 30)
    Estado.Position = UDim2.new(0, 10, 0, 60)
    Estado.BackgroundTransparency = 1
    Estado.Font = Enum.Font.Gotham
    Estado.Text = "Estado: Apagado ❌"
    Estado.TextColor3 = Config.ColorTexto
    Estado.TextSize = 16
    Estado.TextXAlignment = Enum.TextXAlignment.Left
    Estado.Parent = Ventana

    local Boton = Instance.new("TextButton")
    Boton.Size = UDim2.new(0.85, 0, 0, 40)
    Boton.Position = UDim2.new(0.075, 0, 0, 105)
    Boton.BackgroundColor3 = Config.ColorResaltado
    Boton.Font = Enum.Font.GothamBold
    Boton.Text = "ACTIVAR"
    Boton.TextColor3 = Color3.new(1, 1, 1)
    Boton.TextSize = 15
    Boton.Parent = Ventana

    local EsquinasBoton = Instance.new("UICorner")
    EsquinasBoton.CornerRadius = UDim.new(0, 8)
    EsquinasBoton.Parent = Boton

    Boton.MouseButton1Click:Connect(function()
        _G.JoseAngel_Blox_Activado = not _G.JoseAngel_Blox_Activado
        if _G.JoseAngel_Blox_Activado then
            Estado.Text = "Estado: Activo ✅"
            Boton.Text = "DESACTIVAR"
            Boton.BackgroundColor3 = Color3.fromRGB(220, 80, 80)
        else
            Estado.Text = "Estado: Apagado ❌"
            Boton.Text = "ACTIVAR"
            Boton.BackgroundColor3 = Config.ColorResaltado
        end
    end)
end

local function VerificarPersonaje()
    Character = LocalPlayer.Character
    if not Character then return false end
    Humanoid = Character:FindFirstChild("Humanoid") :: Humanoid
    if not Humanoid or Humanoid.Health <= 0 then return false end
    HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart") :: Part
    return HumanoidRootPart ~= nil
end

local function BuscarBonos()
    local lista = {}
    if not VerificarPersonaje() then return lista end
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if not (obj:IsA("BasePart") or obj:IsA("Model")) then continue end
        local coincide = Config.BuscarPorSimilitud and string.find(obj.Name, Config.BonoName, 1, true) or obj.Name == Config.BonoName
        if coincide then
            local pos = obj:IsA("Model") and obj:GetPivot().Position or obj.Position
            local dist = (HumanoidRootPart.Position - pos).Magnitude
            if dist <= Config.DistanciaMaxima then
                table.insert(lista, {Objeto = obj, Posicion = pos, Distancia = dist})
            end
        end
    end
    table.sort(lista, function(a, b) return a.Distancia < b.Distancia end)
    return lista
end

local function IrHacia(pos)
    if VerificarPersonaje() then
        HumanoidRootPart.CFrame = CFrame.new(pos.X, pos.Y + 2.5, pos.Z)
    end
end

local function UsarPrompt(obj)
    if not Config.UsarProximityPrompt then return end
    local prompt = obj:FindFirstChildOfClass("ProximityPrompt", true)
    if prompt and prompt.Enabled then
        fireproximityprompt(prompt)
    end
end

task.spawn(function()
    CrearInterfaz()
    while task.wait(0.2) do
        if not _G.JoseAngel_Blox_Activado then
            task.wait(0.8)
            continue
        end
        if not VerificarPersonaje() then
            LocalPlayer.CharacterAdded:Wait()
            continue
        end
        local bonos = BuscarBonos()
        if #bonos == 0 then
            task.wait(0.5)
            continue
        end
        for _, info in ipairs(bonos) do
            if not _G.JoseAngel_Blox_Activado then break end
            if Config.UsarTeletransporte then IrHacia(info.Posicion) end
            UsarPrompt(info.Objeto)
            task.wait(Config.RetrasoEntreAcciones)
        end
    end
end)
