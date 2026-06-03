--[[
    Script       : JoseAngel_Blox Bonds
    Juego        : Dead Rails (116495829188952)
    Función      : Farmear bonos automáticamente (solo bonds)
    Seguridad    : Movimiento suave y respeto de tiempos
    Interfaz     : Bonita, minimalista y funcional
--]]

-- Variables del jugador
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRoot = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

-- Configuración
local farming = false
local bondCount = 0
local searchRadius = 40  -- Radio de búsqueda en studs
local collectDelay = 0.5 -- Segundos entre recogidas (evita detección)

-- Palabras clave para identificar bonos (ajústalas si el juego cambia los nombres)
local bondKeywords = {"Bond", "Bono", "Moneda", "Coin", "Pickup", "Reward"}

-- Crear GUI principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "JoseAngelBonds"
screenGui.Parent = game.CoreGui

-- Marco principal (efecto vidrio + gradiente)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 360, 0, 200)
mainFrame.Position = UDim2.new(0.5, -180, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
mainFrame.BackgroundTransparency = 0.2
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Esquinas redondeadas
local corners = Instance.new("UICorner")
corners.CornerRadius = UDim.new(0, 12)
corners.Parent = mainFrame

-- Gradiente de fondo
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 20, 70)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 30))
})
gradient.Rotation = 30
gradient.Parent = mainFrame

-- Sombra sutil
local shadow = Instance.new("UIShadow")
shadow.Color = Color3.fromRGB(0,0,0)
shadow.Transparency = 0.5
shadow.Size = 0.4
shadow.Parent = mainFrame

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "✨ JoseAngel_Blox Bonds ✨"
title.TextColor3 = Color3.fromRGB(255, 215, 0)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

-- Línea decorativa
local line = Instance.new("Frame")
line.Size = UDim2.new(0.9, 0, 0, 2)
line.Position = UDim2.new(0.05, 0, 0, 47)
line.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
line.BackgroundTransparency = 0.4
line.Parent = mainFrame

-- Contador de bonos
local counterLabel = Instance.new("TextLabel")
counterLabel.Size = UDim2.new(1, 0, 0, 40)
counterLabel.Position = UDim2.new(0, 0, 0, 55)
counterLabel.BackgroundTransparency = 1
counterLabel.Text = "💰 Bonos: 0 💰"
counterLabel.TextColor3 = Color3.fromRGB(255,255,255)
counterLabel.TextScaled = true
counterLabel.Font = Enum.Font.Gotham
counterLabel.Parent = mainFrame

-- Botón de inicio/parada
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0.7, 0, 0, 45)
toggleButton.Position = UDim2.new(0.15, 0, 0, 110)
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
toggleButton.BackgroundTransparency = 0.2
toggleButton.Text = "🔘 ACTIVAR AUTO FARM BONDS"
toggleButton.TextColor3 = Color3.fromRGB(255,255,255)
toggleButton.TextScaled = true
toggleButton.Font = Enum.Font.GothamBold

local btnCorners = Instance.new("UICorner")
btnCorners.CornerRadius = UDim.new(0, 8)
btnCorners.Parent = toggleButton

toggleButton.Parent = mainFrame

-- Botón cerrar (X)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
closeBtn.BackgroundTransparency = 0.3
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold

local closeCorners = Instance.new("UICorner")
closeCorners.CornerRadius = UDim.new(0, 8)
closeCorners.Parent = closeBtn

closeBtn.Parent = mainFrame

-- Animación de aparición
mainFrame:TweenSize(UDim2.new(0, 360, 0, 200), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.4, true)

-- Actualizar contador visual
local function updateCounter()
    counterLabel.Text = "💰 Bonos recolectados: " .. bondCount .. " 💰"
end

-- Función segura para recolectar un bono (movimiento suave)
local function collectBond(bondPart)
    if not bondPart or not bondPart.Parent then return false end
    if not character or not humanoidRoot then return false end
    
    -- Evitar recoger el mismo bono varias veces
    if bondPart:GetAttribute("collecting") then return false end
    bondPart:SetAttribute("collecting", true)
    
    -- Mover al jugador justo encima del bono
    local success, err = pcall(function()
        humanoidRoot.CFrame = CFrame.new(bondPart.Position)
        task.wait(0.1) -- Pequeña pausa para que el juego detecte el contacto
        -- Si el bono todavía existe, lo "tocamos" suavemente con firetouchinterest (opcional)
        -- firetouchinterest(humanoidRoot, bondPart, 0) -- descomentar si es necesario
    end)
    
    task.wait(0.2)
    bondPart:SetAttribute("collecting", nil)
    
    if success then
        bondCount = bondCount + 1
        updateCounter()
        return true
    else
        warn("Error al recoger bono:", err)
        return false
    end
end

-- Bucle principal de farmeo
local function farmLoop()
    while farming do
        task.wait(0.3) -- Comprobar cada 0.3 segundos
        
        -- Asegurar que el personaje existe
        if not character or not character.Parent then
            character = player.Character
            if character then
                humanoidRoot = character:WaitForChild("HumanoidRootPart")
                humanoid = character:WaitForChild("Humanoid")
            else
                continue
            end
        end
        
        -- Buscar todos los objetos en el mundo
        local bondsNearby = {}
        local allParts = workspace:GetDescendants()
        local rootPos = humanoidRoot.Position
        
        for _, obj in ipairs(allParts) do
            if obj:IsA("BasePart") and obj.Name then
                local lowerName = obj.Name:lower()
                for _, kw in ipairs(bondKeywords) do
                    if lowerName:find(kw:lower()) then
                        local dist = (rootPos - obj.Position).Magnitude
                        if dist <= searchRadius then
                            table.insert(bondsNearby, {part = obj, distance = dist})
                        end
                        break
                    end
                end
            end
        end
        
        -- Ordenar por distancia (más cercano primero)
        table.sort(bondsNearby, function(a,b) return a.distance < b.distance end)
        
        -- Recoger el bono más cercano
        if #bondsNearby > 0 then
            local target = bondsNearby[1].part
            collectBond(target)
            task.wait(collectDelay) -- Esperar antes de buscar otro
        end
    end
end

-- Manejo del botón toggle
toggleButton.MouseButton1Click:Connect(function()
    farming = not farming
    if farming then
        toggleButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        toggleButton.Text = "⏹️ DETENER AUTO FARM BONDS"
        -- Iniciar el farmeo en una tarea separada
        task.spawn(farmLoop)
    else
        toggleButton.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
        toggleButton.Text = "🔘 ACTIVAR AUTO FARM BONDS"
    end
end)

-- Cerrar GUI
closeBtn.MouseButton1Click:Connect(function()
    farming = false
    screenGui:Destroy()
end)

-- Notificación de carga
local toast = Instance.new("TextLabel")
toast.Size = UDim2.new(0, 240, 0, 35)
toast.Position = UDim2.new(0.5, -120, 0, 20)
toast.BackgroundColor3 = Color3.fromRGB(0,0,0)
toast.BackgroundTransparency = 0.6
toast.TextColor3 = Color3.fromRGB(255,255,255)
toast.Text = "✅ JoseAngel_Blox Bonds cargado"
toast.TextScaled = true
toast.Font = Enum.Font.Gotham
local toastCorner = Instance.new("UICorner")
toastCorner.CornerRadius = UDim.new(0, 10)
toastCorner.Parent = toast
toast.Parent = screenGui
task.wait(2)
toast:Destroy()

print("Script JoseAngel_Blox Bonds listo. Solo farmeo de bonos activado.")
