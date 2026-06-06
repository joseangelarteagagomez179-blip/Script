-- NOMBRE DEL SCRIPT: Mega Mansion Tycoon
-- NOMBRE DEL CREADOR: JoseAngel_Blox
-- FECHA DE CREACIÓN: 05/06/2026
-- DESCRIPCIÓN: Script para automatizar recolección de dinero y compra de botones/mejoras en Mega Mansion Tycoon


-- CONFIGURACIÓN PERSONALIZABLE
local CONFIG = {
    -- RECOLECCIÓN DE DINERO
    AUTO_COLLECT_MONEY = true,
    COLLECT_ALL_TYPES = true,
    COLLECT_INTERVAL = 0.5,
    COLLECT_ONLY_VISIBLE = false,

    -- COMPRA AUTOMÁTICA
    AUTO_BUY = true,
    BUY_PRIORITY = "LOW_COST_FIRST",
    MAX_SPEND_PER_CYCLE = nil,
    BUY_INTERVAL = 1,
    AVOID_INACTIVE_BUTTONS = true,
    PRIORITY_BUILD_LIST = {
        "EntranceUpgrade",
        "CoinGenerator",
        "PoolArea",
        "GarageExpansion",
        "Penthouse"
    },

    -- OTROS AJUSTES
    SAFETY_DELAY = 0.2,
    SHOW_LOGS = true
}


-- REFERENCIAS AL JUEGO
local Player = game:GetService("Players").LocalPlayer
local Leaderstats = Player:WaitForChild("leaderstats")
local MoneyValue = Leaderstats:WaitForChild("Money") or Leaderstats:WaitForChild("Cash")
local Tycoon = workspace:WaitForChild("Tycoons"):FindFirstChild(Player.Name)

local MoneyPickups = Tycoon and Tycoon:WaitForChild("MoneyPickups") or nil
local BuyableButtons = Tycoon and Tycoon:WaitForChild("BuyableButtons") or nil
local BuildZones = Tycoon and Tycoon:WaitForChild("BuildZones") or nil


-- FUNCIÓN PARA MOSTRAR MENSAJES
local function Log(message, isWarning)
    if not CONFIG.SHOW_LOGS then return end
    local prefix = isWarning and "[!] " or "[+] "
    print(prefix .. message)
end


-- FUNCIÓN DE RECOLECCIÓN AUTOMÁTICA
local function AutoCollectMoney()
    if not CONFIG.AUTO_COLLECT_MONEY or not MoneyPickups then return end

    for _, Pickup in pairs(MoneyPickups:GetChildren()) do
        local ClickDetector = Pickup:FindFirstChild("ClickDetector")
        local IsCollectible = Pickup:FindFirstChild("IsCollectible") and Pickup.IsCollectible.Value or true

        if ClickDetector and IsCollectible then
            if CONFIG.COLLECT_ONLY_VISIBLE then
                local ScreenPos, IsOnScreen = workspace.CurrentCamera:WorldToScreenPoint(Pickup.Position)
                if not IsOnScreen then continue end
            end

            fireclickdetector(ClickDetector)
            Log("Recolectado: " .. Pickup.Name .. " | Valor: " .. (Pickup.Value.Value or "Desconocido"))
            wait(CONFIG.SAFETY_DELAY)
        end
    end
end


-- FUNCIÓN PARA ORDENAR ELEMENTOS COMPRABLES
local function SortBuyables(buyablesList)
    local SortedList = {}

    for _, Buyable in pairs(buyablesList) do
        table.insert(SortedList, Buyable)
    end

    if CONFIG.BUY_PRIORITY == "LOW_COST_FIRST" then
        table.sort(SortedList, function(a, b)
            local CostA = tonumber(a.Cost.Value) or math.huge
            local CostB = tonumber(b.Cost.Value) or math.huge
            return CostA < CostB
        end)

    elseif CONFIG.BUY_PRIORITY == "HIGH_COST_FIRST" then
        table.sort(SortedList, function(a, b)
            local CostA = tonumber(a.Cost.Value) or 0
            local CostB = tonumber(b.Cost.Value) or 0
            return CostA > CostB
        end)

    elseif CONFIG.BUY_PRIORITY == "PRIORITY_LIST" then
        table.sort(SortedList, function(a, b)
            local PosA = table.find(CONFIG.PRIORITY_BUILD_LIST, a.Name) or math.huge
            local PosB = table.find(CONFIG.PRIORITY_BUILD_LIST, b.Name) or math.huge
            return PosA < PosB
        end)
    end

    return SortedList
end


-- FUNCIÓN DE COMPRA AUTOMÁTICA
local function AutoBuyButtons()
    if not CONFIG.AUTO_BUY or (not BuyableButtons and not BuildZones) then return end

    local AllBuyables = {}

    if BuyableButtons then
        for _, Button in pairs(BuyableButtons:GetChildren()) do
            local IsActive = Button:FindFirstChild("IsActive") and Button.IsActive.Value or true
            local Cost = Button:FindFirstChild("Cost") and tonumber(Button.Cost.Value) or nil

            if IsActive and Cost and (not CONFIG.AVOID_INACTIVE_BUTTONS or Button.Enabled) then
                table.insert(AllBuyables, Button)
            end
        end
    end

    if BuildZones then
        for _, Zone in pairs(BuildZones:GetChildren()) do
            local BuyButton = Zone:FindFirstChild("BuyButton")
            local IsActive = Zone:FindFirstChild("IsUnlocked") and Zone.IsUnlocked.Value or true
            local Cost = Zone:FindFirstChild("BuildCost") and tonumber(Zone.BuildCost.Value) or nil

            if BuyButton and IsActive and Cost then
                table.insert(AllBuyables, {
                    Name = Zone.Name,
                    Cost = { Value = Cost },
                    ClickDetector = BuyButton:FindFirstChild("ClickDetector")
                })
            end
        end
    end

    if #AllBuyables == 0 then
        Log("No hay elementos disponibles para comprar", true)
        return
    end

    local SortedBuyables = SortBuyables(AllBuyables)
    local TotalSpentThisCycle = 0

    for _, Buyable in pairs(SortedBuyables) do
        local Cost = tonumber(Buyable.Cost.Value) or math.huge
        local ClickDetector = Buyable:FindFirstChild("ClickDetector")

        local CanBuy = (MoneyValue.Value >= Cost)
            and (not CONFIG.MAX_SPEND_PER_CYCLE or (TotalSpentThisCycle + Cost) <= CONFIG.MAX_SPEND_PER_CYCLE)
            and ClickDetector

        if CanBuy then
            fireclickdetector(ClickDetector)
            Log("Comprado: " .. Buyable.Name .. " | Costo: " .. Cost)
            TotalSpentThisCycle = TotalSpentThisCycle + Cost
            MoneyValue.Changed:Wait()
            wait(CONFIG.SAFETY_DELAY)
        else
            if MoneyValue.Value < Cost then
                Log("No hay suficiente dinero para: " .. Buyable.Name .. " | Necesario: " .. Cost, true)
            else
                Log("No se puede comprar: " .. Buyable.Name, true)
            end
        end
    end
end


-- FUNCIÓN PARA ESPERAR CARGA DEL TYCOON
local function WaitForTycoon()
    if Tycoon then return true end

    Log("Esperando carga del tycoon...", true)
    local TycoonLoaded = workspace.Tycoons.ChildAdded:Wait()

    if TycoonLoaded.Name == Player.Name then
        Tycoon = TycoonLoaded
        MoneyPickups = Tycoon:WaitForChild("MoneyPickups")
        BuyableButtons = Tycoon:WaitForChild("BuyableButtons")
        BuildZones = Tycoon:WaitForChild("BuildZones")
        MoneyValue = Leaderstats:WaitForChild("Money") or Leaderstats:WaitForChild("Cash")
        Log("Tycoon cargado correctamente")
        return true
    else
        return WaitForTycoon()
    end
end


-- BUCLE PRINCIPAL
local function MainLoop()
    Log("=== SCRIPT INICIADO ===")
    Log("Recolección automática: " .. (CONFIG.AUTO_COLLECT_MONEY and "ACTIVADA" or "DESACTIVADA"))
    Log("Compra automática: " .. (CONFIG.AUTO_BUY and "ACTIVADA" or "DESACTIVADA"))
    Log("Prioridad de compra: " .. CONFIG.BUY_PRIORITY)

    spawn(function()
        while wait(CONFIG.COLLECT_INTERVAL) do
            pcall(AutoCollectMoney)
        end
    end)

    spawn(function()
        while wait(CONFIG.BUY_INTERVAL) do
            pcall(AutoBuyButtons)
        end
    end)
end


-- INICIO DEL SCRIPT
if WaitForTycoon() then
    MainLoop()
else
    Log("No se pudo cargar el tycoon - Script detenido", true)
end
