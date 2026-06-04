-- JoseAngel_Blox Bonds - AutoFarm de Bonos (Bonds/Bones) para Dead Rails
-- Script optimizado en Luau para Delta Executor (Mobile)
-- Autor: JoseAngel_Blox (Asistente experto)
-- --------------------------------------------------------

-- ======= CONFIGURACIÓN INICIAL =======

-- Nombre o texto clave para detectar objetos bono en Workspace
local BonoName = "Bond" -- Cambiar por "Bone" o nombre adecuado según el juego

-- Cooldown entre teletransportes para evitar detección o rubberbanding (segundos)
local Cooldown = 0.5

-- Interruptor global para activar/desactivar el AutoFarm desde consola/Delta Executor
_G.AutoFarmBonds = true

-- ======= REFERENCIAS INICIALES =======
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Función para obtener el Character y HumanoidRootPart válidos y vivos
local function getCharacterAndHRP()
    local character = LocalPlayer.Character
    if character then
        local hrp = character:FindFirstChild("HumanoidRootPart")
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if hrp and humanoid and humanoid.Health > 0 then
            return character, hrp
        end
    end
    return nil, nil
end

-- Función para teletransportar suavemente usando TweenService al objetivo (Vector3)
local function teleportToPosition(hrp, position)
    if not hrp or not position then return end
    -- Configuración del tween para teletransporte rápido pero suave
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(hrp, tweenInfo, {CFrame = CFrame.new(position + Vector3.new(0, 3, 0))})
    tween:Play()
    -- Esperamos que el tween termine antes de continuar
    tween.Completed:Wait()
end

-- Función para activar cualquier ProximityPrompt dentro del objeto bono
local function activateProximityPrompts(bonoObject)
    if not bonoObject then return end
    for _, descendant in pairs(bonoObject:GetDescendants()) do
        if descendant:IsA("ProximityPrompt") then
            -- Método seguro para activar el prompt
            task.spawn(function()
                pcall(function()
                    descendant:InputHoldBegin() -- Para casos que requieran hold; si no, usar InputTrigger
                    descendant:InputTrigger()
                    descendant:InputHoldEnd()
                end)
            end)
            -- También se puede usar fireproximityprompt si está disponible:
            -- pcall(function() fireproximityprompt(descendant) end)
        end
    end
end

-- Función principal de auto-farm en loop
local function autoFarmBonds()
    while _G.AutoFarmBonds do
        local character, hrp = getCharacterAndHRP()
        if character and hrp then
            -- Buscar bonos en Workspace
            for _, obj in pairs(game.Workspace:GetDescendants()) do
                -- Verificamos que sea un Modelo o Parte con nombre similar a BonoName (case insensitive)
                if obj.Name and string.find(string.lower(obj.Name), string.lower(BonoName)) then
                    -- Intentar teletransportar y recolectar solo si el objeto tiene posición válida
                    local pos
                    if obj:IsA("BasePart") then
                        pos = obj.Position
                    elseif obj:IsA("Model") then
                        local primaryPart = obj.PrimaryPart or obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")
                        if primaryPart then
                            pos = primaryPart.Position
                        end
                    end

                    if pos then
                        -- Teletransportamos al bono
                        teleportToPosition(hrp, pos)

                        -- Activar ProximityPrompt si existe para recolectar
                        activateProximityPrompts(obj)

                        -- Esperamos cooldown para evitar detección o lag
                        task.wait(Cooldown)
                    end
                end
            end
        else
            -- Personaje o HRP no válido o muerto, esperar un poco antes de reintentar
            task.wait(1)
        end
        -- Pequeña pausa para no saturar recursos
        task.wait(0.1)
    end
end

-- Lanzar el autoFarm en un hilo separado para que no bloquee el hilo principal
task.spawn(autoFarmBonds)

--[[
INSTRUCCIONES:

- Cambia la variable 'BonoName' al nombre o palabra clave usada por los bonos en el juego.
- Activa o desactiva la función desde
