-- JoseAngel_Blox Bonds - Script Especializado para Dead Rails
-- Versión: 1.0
-- Objetivo: Farmear exclusivamente bonos (Bonds) de forma automática

-- Configuración del Script
local CONFIG = {
    -- Radio de búsqueda (studs). El tren es grande, un radio amplio ayuda.
    SearchRadius = 150,
    -- Tiempo de espera entre ciclos de búsqueda (segundos)
    LoopDelay = 0.5,
    -- Auto-recolección al tocar el objeto (dejar como true)
    AutoCollect = true
}

-- Servicios y referencias
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- [[ FUNCIÓN PRINCIPAL: COLECTAR BONOS ]]
local function CollectBonds()
    -- Verificar que el personaje existe y está vivo
    local character = LocalPlayer.Character
    if not character then return end
    
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local rootPos = hrp.Position
    local bondsCollected = 0

    -- Buscar en todo el mapa (Workspace)
    for _, obj in ipairs(workspace:GetDescendants()) do
        -- Verificar que sea un objeto físico, esté cerca, y NO sea el propio personaje
        if obj:IsA("BasePart") and obj.Parent ~= character then
            -- Calcular distancia
            local distance = (obj.Position - rootPos).Magnitude
            if distance <= CONFIG.SearchRadius then
                -- IDENTIFICAR BONOS: Por nombre o por etiqueta
                -- En Dead Rails, los bonos suelen llamarse "Bond" o están en cofres "Chest"
                local objName = obj.Name:lower()
                local isBond = objName:find("bond") or objName:find("cash") or objName:find("money")
                
                -- Si es un cofre, intentar abrirlo para que salgan los bonos
                if objName:find("chest") or objName:find("crate") then
                    -- Simular un toque para abrir (FireTouchInterest)
                    if obj:FindFirstChild("TouchInterest") then
                        firetouchinterest(hrp, obj, 0)
                        firetouchinterest(hrp, obj, 1)
                        task.wait(0.1)
                    end
                end
                
                -- Si es un bono suelto, recolectarlo
                if isBond then
