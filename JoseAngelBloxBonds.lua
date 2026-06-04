--!strict
-- JoseAngel_Blox Bonds | Dead Rails
-- Auto-Farm Completo - Detecta + Explora + Recoge
-- Optimizado Delta Executor

local Config = {
    BonoName = "Bond",
    DistanciaMaxima = 800,
    DistanciaCerca = 12,
    Retraso = 0.35,
    BuscarPorSimilitud = true,
    TraerSiSePuede = true,
    ColorFondo = Color3.fromRGB(18, 20, 28),
    ColorTexto = Color3.fromRGB(235, 235, 255),
    ColorActivo = Color3.fromRGB(70, 160, 255)
}

_G.JoseAngel_Blox_Activado = false

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Character, Humanoid, HRoot

local function ActualizarPersonaje()
    Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    Humanoid = Character:FindFirstChildOfClass("Humanoid")
    HRoot = Character:FindFirstChild("HumanoidRootPart")
    return Humanoid and Humanoid.Health > 0 and HRoot ~= nil
end

local function CrearUI()
    if CoreGui:FindFirstChild("JoseAngel_Blox_Bonds") then
        CoreGui.JoseAngel_Blox_Bonds:Destroy()
    end

    local Gui = Instance.new("ScreenGui")
    Gui.Name = "JoseAngel_Blox_Bonds"
    Gui.ResetOnSpawn = false
    Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Gui.Parent = CoreGui

    local Ventana = Instance.new("Frame")
    Ventana.Size = UDim2.new(0, 290, 0, 170)
    Ventana.Position = UDim2.new(0.02, 0, 0.06, 0)
    Ventana.BackgroundColor3 = Config.ColorFondo
    Ventana.BorderSizePixel = 0
    Ventana.Active, Ventana.Draggable = true, true
    Ventana.Parent = Gui

    Instance.new("UICorner", Ventana).CornerRadius = UDim.new(0, 10)
    local Borde = Instance.new("UIStroke", Ventana)
    Borde.Color = Config.ColorActivo
    Borde.Thickness, Borde.Transparency = 2, 0.3

    local Titulo = Instance.new("TextLabel", Ventana)
    Titulo.Size = UDim2.new(1, 0, 0, 42)
    Titulo.BackgroundTransparency = 1
    Titulo.Font = Enum.Font.GothamBold
    Titulo.Text = "✨ JoseAngel_Blox Bonds"
    Titulo.TextColor3 = Config.ColorActivo
    Titulo.TextSize = 18

    local Separador = Instance.new("Frame", Ventana)
    Separador.Size = UDim2.new(0.9, 0, 0, 1)
    Separador.Position = UDim2.new(0.05, 0, 0, 42)
    Separador.BackgroundColor3 = Config.ColorActivo
    Separador.BackgroundTransparency = 0.6

    local Estado = Instance.new("TextLabel", Ventana)
    Estado.Size = UDim2.new(1, -20, 0, 32)
    Estado.Position = UDim2.new(0, 10, 0, 55)
    Estado.BackgroundTransparency = 1
    Estado.Font = Enum.Font.Gotham
    Estado.Text = "Estado: Apagado ❌"
    Estado.TextColor3 = Config.ColorTexto
    Estado.TextSize = 16
    Estado.TextXAlignment = Enum.TextXAlignment.Left

    local Boton = Instance.new("TextButton", Ventana)
    Boton.Size = UDim2.new(0.86, 0, 0, 42)
    Boton.Position = UDim2.new(0.07, 0, 0, 105)
    Boton.BackgroundColor3 = Config.ColorActivo
    Boton.Font = Enum.Font.GothamBold
    Boton.Text = "ACTIVAR AUTO-FARM"
    Boton.TextColor3 = Color3.new(1,1,1)
    Boton.TextSize = 15
    Instance.new("UICorner", Boton).CornerRadius = UDim.new(0, 8)

    Boton.MouseButton1Click:Connect(function()
        _G.JoseAngel_Blox_Activado = not _G.JoseAngel_Blox_Activado
        if _G.JoseAngel_Blox_Activado then
            Estado.Text = "Estado: ACTIVO ✅"
            Boton.Text = "DESACTIVAR"
            Boton.BackgroundColor3 = Color3.fromRGB(220, 70, 70)
        else
            Estado.Text = "Estado: Apagado ❌"
            Boton.Text = "ACTIVAR AUTO-FARM"
            Boton.BackgroundColor3 = Config.ColorActivo
        end
    end)
end

local function BuscarTodosLosBonos()
    local lista = {}
    if not ActualizarPersonaje() then return lista end

    for _, obj in ipairs(Workspace:GetDescendants()) do
        if not (obj:IsA("BasePart") or obj:IsA("Model")) then continue end

        local coincide = Config.BuscarPorSimilitud
            and string.find(obj.Name, Config.BonoName, 1, true)
            or obj.Name == Config.BonoName

        if coincide then
            local pos = obj:IsA("Model") and obj:GetPivot().Position or obj.Position
            local dist = (HRoot.Position - pos).Magnitude

            if dist <= Config.DistanciaMaxima then
                table.insert(lista, {Obj = obj, Pos = pos, Dist = dist})
            end
        end
    end

    table.sort(lista, function(a,b) return a.Dist < b.Dist end)
    return lista
end

local function IrYRecoger(datos)
    if not datos.Obj:IsDescendantOf(Workspace) then return end

    -- Si está lejos, teletransportar
    if datos.Dist > Config.DistanciaCerca then
        HRoot.CFrame = CFrame.new(datos.Pos.X, datos.Pos.Y + 2, datos.Pos.Z)
        task.wait(0.12)
    end

    -- Métodos de recolección combinados
    if Config.TraerSiSePuede then
        pcall(function() datos.Obj.Position = HRoot.Position + Vector3.new(0, 3, 0) end)
        task.wait(0.08)
    end

    -- ClickDetector
    if datos.Obj:FindFirstChildOfClass("ClickDetector", true) then
        fireclickdetector(datos.Obj:FindFirstChildOfClass("ClickDetector", true))
    end

    -- ProximityPrompt
    local prompt = datos.Obj:FindFirstChildOfClass("ProximityPrompt", true)
    if prompt and prompt.Enabled then
        fireproximityprompt(prompt)
    end

    -- Click directo en la parte
    if datos.Obj:IsA("BasePart") then
        fireclickdetector(datos.Obj)
    end
end

-- Bucle principal auto-farm
task.spawn(function()
    CrearUI()
    while task.wait(0.25) do
        if not _G.JoseAngel_Blox_Activado then
            task.wait(1)
            continue
        end

        if not ActualizarPersonaje() then
            LocalPlayer.CharacterAdded:Wait()
            continue
        end

        local bonos = BuscarTodosLosBonos()
        if #bonos == 0 then
            task.wait(0.6)
            continue
        end

        for _, info in ipairs(bonos) do
            if not _G.JoseAngel_Blox_Activado then break end
            IrYRecoger(info)
            task.wait(Config.Retraso)
        end
    end
end)
