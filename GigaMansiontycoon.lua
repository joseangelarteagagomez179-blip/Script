-- ==============================================
-- GIGA MANSION TYCOON - CONTROL UI
-- Para proyectos propios en Roblox Studio
-- ==============================================

-- Referencias a elementos de la UI
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui
local UIScreen = PlayerGui:WaitForChild("GigaMansionTycoonUI")
local MainMenu = UIScreen:WaitForChild("MainMenu")
local RGBBubble = UIScreen:WaitForChild("RGBBubble")

-- Estado de las funciones
local AutoBuildEnabled = false
local AutoCollectEnabled = false

-- Variables para mover el menú
local isDragging = false
local dragStartPos = Vector2.new()
local menuStartPos = UDim2.new()


-- ==============================================
-- FUNCIÓN 1: EFECTO RGB EN LA BURBUJA
-- ==============================================
local hue = 0
RunService.RenderStepped:Connect(function(deltaTime)
    -- Actualizar color RGB cíclicamente
    hue = hue + (deltaTime * 50)
    if hue >= 360 then hue = 0 end
    
    local color = Color3.fromHSV(hue/360, 0.8, 0.9)
    RGBBubble.BackgroundColor3 = color
    RGBBubble.BorderColor3 = color:lerp(Color3.new(1,1,1), 0.5)
end)


-- ==============================================
-- FUNCIÓN 2: MOSTRAR/OCULTAR MENÚ CON LA BURBUJA
-- ==============================================
RGBBubble.MouseButton1Click:Connect(function()
    MainMenu.Visible = not MainMenu.Visible
    if MainMenu.Visible then
        RGBBubble.Text = "✖"
    else
        RGBBubble.Text = "🏠"
    end
end)


-- ==============================================
-- FUNCIÓN 3: MOVER EL MENÚ POR LA PANTALLA
-- ==============================================
MainMenu.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = true
        dragStartPos = UserInputService:GetMouseLocation()
        menuStartPos = MainMenu.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mouseDelta = UserInputService:GetMouseLocation() - dragStartPos
        local newPos = UDim2.new(
            menuStartPos.X.Scale, menuStartPos.X.Offset + mouseDelta.X,
            menuStartPos.Y.Scale, menuStartPos.Y.Offset + mouseDelta.Y
        )
        -- Evitar que el menú se salga de la pantalla
        newPos = UDim2.new(
            math.clamp(newPos.X.Scale, 0, 1), math.clamp(newPos.X.Offset, 0, UIScreen.AbsoluteSize.X - MainMenu.AbsoluteSize.X),
            math.clamp(newPos.Y.Scale, 0, 1), math.clamp(newPos.Y.Offset, 0, UIScreen.AbsoluteSize.Y - MainMenu.AbsoluteSize.Y)
        )
        MainMenu.Position = newPos
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)


-- ==============================================
-- FUNCIÓN 4: CONFIGURAR EL MENÚ (INFO + OPCIONES)
-- ==============================================
local function setupMenu()
    -- Diseño del menú
    MainMenu.Size = UDim2.new(0, 300, 0, 220)
    MainMenu.Position = UDim2.new(0.5, -150, 0.3, 0)
    MainMenu.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    MainMenu.BorderColor3 = Color3.new(0.3, 0.3, 0.3)
    MainMenu.BackgroundTransparency = 0.1
    MainMenu.Visible = false
    MainMenu.ClipsDescendants = true

    -- Título
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = MainMenu
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    Title.Text = "GIGA MANSION TYCOON"
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 18

    -- Sección INFO
    local InfoSection = Instance.new("Frame")
    InfoSection.Name = "InfoSection"
    InfoSection.Parent = MainMenu
    InfoSection.Size = UDim2.new(1, 0, 0, 80)
    InfoSection.Position = UDim2.new(0, 0, 0, 30)
    InfoSection.BackgroundTransparency = 1

    local InfoTitle = Instance.new("TextLabel")
    InfoTitle.Name = "InfoTitle"
    InfoTitle.Parent = InfoSection
    InfoTitle.Size = UDim2.new(1, 0, 0, 20)
    InfoTitle.BackgroundTransparency = 1
    InfoTitle.Text = "📋 INFO"
    InfoTitle.TextColor3 = Color3.new(0.9, 0.6, 0.2)
    InfoTitle.Font = Enum.Font.SourceSansBold
    InfoTitle.TextSize = 16

    local CreatorText = Instance.new("TextLabel")
    CreatorText.Name = "CreatorText"
    CreatorText.Parent = InfoSection
    CreatorText.Size = UDim2.new(1, 0, 0, 20)
    CreatorText.Position = UDim2.new(0, 0, 0, 20)
    CreatorText.BackgroundTransparency = 1
    CreatorText.Text = "Nombre del creador: JoseAngel_Blox"
    CreatorText.TextColor3 = Color3.new(1, 1, 1)
    CreatorText.Font = Enum.Font.SourceSans
    CreatorText.TextSize = 14

    local DateText = Instance.new("TextLabel")
    DateText.Name = "DateText"
    DateText.Parent = InfoSection
    DateText.Size = UDim2.new(1, 0, 0, 20)
    DateText.Position = UDim2.new(0, 0, 0, 40)
    DateText.BackgroundTransparency = 1
    DateText.Text = "Fecha de creación: 05/06/2026"
    DateText.TextColor3 = Color3.new(1, 1, 1)
    DateText.Font = Enum.Font.SourceSans
    DateText.TextSize = 14

    local TutorialText = Instance.new("TextLabel")
    TutorialText.Name = "TutorialText"
    TutorialText.Parent = InfoSection
    TutorialText.Size = UDim2.new(1, 0, 0, 40)
    TutorialText.Position = UDim2.new(0, 0, 0, 60)
    TutorialText.BackgroundTransparency = 1
    TutorialText.Text = "Tutorial: Auto construir (sin botones) y auto recoger dinero (requiere fondos)."
    TutorialText.TextColor3 = Color3.new(0.8, 0.8, 0.8)
    TutorialText.Font = Enum.Font.SourceSans
    TutorialText.TextSize = 12
    TutorialText.TextWrapped = true

    -- Sección MAIN (Opciones)
    local MainSection = Instance.new("Frame")
    MainSection.Name = "MainSection"
    MainSection.Parent = MainMenu
    MainSection.Size = UDim2.new(1, 0, 0, 80)
    MainSection.Position = UDim2.new(0, 0, 0, 110)
    MainSection.BackgroundTransparency = 1

    local MainTitle = Instance.new("TextLabel")
    MainTitle.Name = "MainTitle"
    MainTitle.Parent = MainSection
    MainTitle.Size = UDim2.new(1, 0, 0, 20)
    MainTitle.BackgroundTransparency = 1
    MainTitle.Text = "⚙️ MAIN"
    MainTitle.TextColor3 = Color3.new(0.2, 0.8, 0.6)
    MainTitle.Font = Enum.Font.SourceSansBold
    MainTitle.TextSize = 16

    -- Botón Auto Construir
    local AutoBuildBtn = Instance.new("TextButton")
    AutoBuildBtn.Name = "AutoBuildBtn"
    AutoBuildBtn.Parent = MainSection
    AutoBuildBtn.Size = UDim2.new(1, -20, 0, 25)
    AutoBuildBtn.Position = UDim2.new(0, 10, 0, 20)
    AutoBuildBtn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    AutoBuildBtn.Text = "Auto construir: OFF"
    AutoBuildBtn.TextColor3 = Color3.new(1, 1, 1)
    AutoBuildBtn.Font = Enum.Font.SourceSans
    AutoBuildBtn.TextSize = 14

    AutoBuildBtn.MouseButton1Click:Connect(function()
        AutoBuildEnabled = not AutoBuildEnabled
        if AutoBuildEnabled then
            AutoBuildBtn.Text = "Auto construir: ON"
            AutoBuildBtn.BackgroundColor3 = Color3.new(0.1, 0.4, 0.1)
            -- Aquí iría el código para auto construir en TU PROYECTO
            print("[AUTO CONSTRUIR] Activado - Asegúrate de tener dinero suficiente")
        else
            AutoBuildBtn.Text = "Auto construir: OFF"
            AutoBuildBtn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
            print("[AUTO CONSTRUIR] Desactivado")
        end
    end)

    -- Botón Auto Recoger Dinero
    local AutoCollectBtn = Instance.new("TextButton")
    AutoCollectBtn.Name = "AutoCollectBtn"
    AutoCollectBtn.Parent = MainSection
    AutoCollectBtn.Size = UDim2.new(1, -20, 0, 25)
    AutoCollectBtn.Position = UDim2.new(0, 10, 0, 50)
    AutoCollectBtn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    AutoCollectBtn.Text = "Recoger dinero automáticamente: OFF"
    AutoCollectBtn.TextColor3 = Color3.new(1, 1, 1)
    AutoCollectBtn.Font = Enum.Font.SourceSans
    AutoCollectBtn.TextSize = 14

    AutoCollectBtn.MouseButton1Click:Connect(function()
        AutoCollectEnabled = not AutoCollectEnabled
        if AutoCollectEnabled then
            AutoCollectBtn.Text = "Recoger dinero automáticamente: ON"
            AutoCollectBtn.BackgroundColor3 = Color3.new(0.1, 0.4, 0.1)
            -- Aquí iría el código para auto recoger dinero en TU PROYECTO
            print("[AUTO RECOGER] Activado - Recolectando dinero automáticamente")
        else
            AutoCollectBtn.Text = "Recoger dinero automáticamente: OFF"
            AutoCollectBtn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
            print("[AUTO RECOGER] Desactivado")
        end
    end)

    -- Diseño de la burbuja
    RGBBubble.Size = UDim2.new(0, 40, 0, 40)
    RGBBubble.Position = UDim2.new(0.9, -20, 0.1, 0)
    RGBBubble.BackgroundColor3 = Color3.new(1, 0, 0)
    RGBBubble.BorderSizePixel = 2
    RGBBubble.BorderColor3 = Color3.new(1, 1, 1)
    RGBBubble.Text = "🏠"
    RGBBubble.TextColor3 = Color3.new(1, 1, 1)
    RGBBubble.Font = Enum.Font.SourceSansBold
    RGBBubble.TextSize = 20
    RGBBubble.CornerRadius = UDim.new(1, 0) -- Hacerla circular
end)


-- ==============================================
-- INICIAR EL SISTEMA
-- ==============================================
setupMenu()
print("[GIGA MANSION TYCOON UI] Cargado correctamente - Para proyectos propios")
