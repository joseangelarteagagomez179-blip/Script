local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
if not Player then warn("No se detectó el jugador") return end

local PlayerGui = Player:WaitForChild("PlayerGui", 10)
if not PlayerGui then warn("No se detectó PlayerGui") return end

local UIScreen = PlayerGui:WaitForChild("GigaMansionTycoonUI", 10)
if not UIScreen then warn("No se detectó GigaMansionTycoonUI") return end

local MainMenu = UIScreen:WaitForChild("MainMenu", 10)
if not MainMenu then warn("No se detectó MainMenu") return end

local RGBBubble = UIScreen:WaitForChild("RGBBubble", 10)
if not RGBBubble then warn("No se detectó RGBBubble") return end

local AutoBuildEnabled = false
local AutoCollectEnabled = false

local isDragging = false
local dragStartPos = Vector2.new()
local menuStartPos = UDim2.new()

local hue = 0
RunService.Heartbeat:Connect(function(delta)
    hue = hue + (delta * 60)
    if hue >= 360 then hue = 0 end
    local color = Color3.fromHSV(hue / 360, 0.8, 0.9)
    RGBBubble.BackgroundColor3 = color
    RGBBubble.BorderColor3 = color:lerp(Color3.new(1,1,1), 0.4)
end)

RGBBubble.MouseButton1Click:Connect(function()
    MainMenu.Visible = not MainMenu.Visible
    RGBBubble.Text = MainMenu.Visible and "✖" or "🏠"
end)

local function updateMenuPosition(mousePos)
    local mouseDelta = mousePos - dragStartPos
    local newX = menuStartPos.X.Offset + mouseDelta.X
    local newY = menuStartPos.Y.Offset + mouseDelta.Y
    local maxX = UIScreen.AbsoluteSize.X - MainMenu.AbsoluteSize.X
    local maxY = UIScreen.AbsoluteSize.Y - MainMenu.AbsoluteSize.Y
    newX = math.clamp(newX, 0, maxX)
    newY = math.clamp(newY, 0, maxY)
    MainMenu.Position = UDim2.new(0, newX, 0, newY)
end

MainMenu.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = true
        dragStartPos = UserInputService:GetMouseLocation()
        menuStartPos = MainMenu.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        updateMenuPosition(UserInputService:GetMouseLocation())
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)

local function setupMenu()
    MainMenu.Size = UDim2.new(0, 300, 0, 220)
    MainMenu.Position = UDim2.new(0, 50, 0, 50)
    MainMenu.BackgroundColor3 = Color3.new(0.12, 0.12, 0.12)
    MainMenu.BorderColor3 = Color3.new(0.35, 0.35, 0.35)
    MainMenu.BackgroundTransparency = 0.05
    MainMenu.Visible = false
    MainMenu.CornerRadius = UDim.new(0, 8)
    MainMenu.ZIndex = 10

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = MainMenu
    Title.Size = UDim2.new(1, 0, 0, 35)
    Title.BackgroundColor3 = Color3.new(0.18, 0.18, 0.18)
    Title.Text = "GIGA MANSION TYCOON"
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 19
    Title.CornerRadius = UDim.new(0, 8)
    Title.ZIndex = 11

    local InfoSection = Instance.new("Frame")
    InfoSection.Name = "InfoSection"
    InfoSection.Parent = MainMenu
    InfoSection.Size = UDim2.new(1, 0, 0, 80)
    InfoSection.Position = UDim2.new(0, 0, 0, 35)
    InfoSection.BackgroundTransparency = 1
    InfoSection.ZIndex = 11

    local InfoTitle = Instance.new("TextLabel")
    InfoTitle.Name = "InfoTitle"
    InfoTitle.Parent = InfoSection
    InfoTitle.Size = UDim2.new(1, 0, 0, 20)
    InfoTitle.Position = UDim2.new(0, 10, 0, 5)
    InfoTitle.BackgroundTransparency = 1
    InfoTitle.Text = "📋 INFORMACIÓN"
    InfoTitle.TextColor3 = Color3.new(0.95, 0.65, 0.2)
    InfoTitle.Font = Enum.Font.GothamBold
    InfoTitle.TextSize = 16
    InfoTitle.ZIndex = 11

    local CreatorText = Instance.new("TextLabel")
    CreatorText.Name = "CreatorText"
    CreatorText.Parent = InfoSection
    CreatorText.Size = UDim2.new(1, 0, 0, 20)
    CreatorText.Position = UDim2.new(0, 15, 0, 25)
    CreatorText.BackgroundTransparency = 1
    CreatorText.Text = "• Creador: JoseAngel_Blox"
    CreatorText.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    CreatorText.Font = Enum.Font.Gotham
    CreatorText.TextSize = 14
    CreatorText.ZIndex = 11

    local DateText = Instance.new("TextLabel")
    DateText.Name = "DateText"
    DateText.Parent = InfoSection
    DateText.Size = UDim2.new(1, 0, 0, 20)
    DateText.Position = UDim2.new(0, 15, 0, 45)
    DateText.BackgroundTransparency = 1
    DateText.Text = "• Fecha: 05/06/2026"
    DateText.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    DateText.Font = Enum.Font.Gotham
    DateText.TextSize = 14
    DateText.ZIndex = 11

    local TutorialText = Instance.new("TextLabel")
    TutorialText.Name = "TutorialText"
    TutorialText.Parent = InfoSection
    TutorialText.Size = UDim2.new(1, -20, 0, 30)
    TutorialText.Position = UDim2.new(0, 15, 0, 65)
    TutorialText.BackgroundTransparency = 1
    TutorialText.Text = "• Funciones: Auto construir (con dinero) y auto recoger dinero."
    TutorialText.TextColor3 = Color3.new(0.7, 0.7, 0.7)
    TutorialText.Font = Enum.Font.Gotham
    TutorialText.TextSize = 12
    TutorialText.TextWrapped = true
    TutorialText.ZIndex = 11

    local MainSection = Instance.new("Frame")
    MainSection.Name = "MainSection"
    MainSection.Parent = MainMenu
    MainSection.Size = UDim2.new(1, 0, 0, 85)
    MainSection.Position = UDim2.new(0, 0, 0, 115)
    MainSection.BackgroundTransparency = 1
    MainSection.ZIndex = 11

    local MainTitle = Instance.new("TextLabel")
    MainTitle.Name = "MainTitle"
    MainTitle.Parent = MainSection
    MainTitle.Size = UDim2.new(1, 0, 0, 20)
    MainTitle.Position = UDim2.new(0, 10, 0, 5)
    MainTitle.BackgroundTransparency = 1
    MainTitle.Text = "⚙️ OPCIONES PRINCIPALES"
    MainTitle.TextColor3 = Color3.new(0.2, 0.85, 0.6)
    MainTitle.Font = Enum.Font.GothamBold
    MainTitle.TextSize = 16
    MainTitle.ZIndex = 11

    local AutoBuildBtn = Instance.new("TextButton")
    AutoBuildBtn.Name = "AutoBuildBtn"
    AutoBuildBtn.Parent = MainSection
    AutoBuildBtn.Size = UDim2.new(1, -20, 0, 28)
    AutoBuildBtn.Position = UDim2.new(0, 10, 0, 25)
    AutoBuildBtn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    AutoBuildBtn.Text = "Auto construir: DESACTIVADO"
    AutoBuildBtn.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    AutoBuildBtn.Font = Enum.Font.Gotham
    AutoBuildBtn.TextSize = 15
    AutoBuildBtn.CornerRadius = UDim.new(0, 6)
    AutoBuildBtn.ZIndex = 11

    AutoBuildBtn.MouseButton1Click:Connect(function()
        AutoBuildEnabled = not AutoBuildEnabled
        if AutoBuildEnabled then
            AutoBuildBtn.Text = "Auto construir: ACTIVADO"
            AutoBuildBtn.BackgroundColor3 = Color3.new(0.1, 0.45, 0.15)
            print("[AUTO CONSTRUIR] Activado - Verifica que tengas dinero suficiente")
        else
            AutoBuildBtn.Text = "Auto construir: DESACTIVADO"
            AutoBuildBtn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
            print("[AUTO CONSTRUIR] Desactivado")
        end
    end)

    local AutoCollectBtn = Instance.new("TextButton")
    AutoCollectBtn.Name = "AutoCollectBtn"
    AutoCollectBtn.Parent = MainSection
    AutoCollectBtn.Size = UDim2.new(1, -20, 0, 28)
    AutoCollectBtn.Position = UDim2.new(0, 10, 0, 58)
    AutoCollectBtn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    AutoCollectBtn.Text = "Recoger dinero: DESACTIVADO"
    AutoCollectBtn.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    AutoCollectBtn.Font = Enum.Font.Gotham
    AutoCollectBtn.TextSize = 15
    AutoCollectBtn.CornerRadius = UDim.new(0, 6)
    AutoCollectBtn.ZIndex = 11

    AutoCollectBtn.MouseButton1Click:Connect(function()
        AutoCollectEnabled = not AutoCollectEnabled
        if AutoCollectEnabled then
            AutoCollectBtn.Text = "Recoger dinero: ACTIVADO"
            AutoCollectBtn.BackgroundColor3 = Color3.new(0.1, 0.45, 0.15)
            print("[AUTO RECOGER] Activado - Recolectando todo el dinero generado")
        else
            AutoCollectBtn.Text = "Recoger dinero: DESACTIVADO"
            AutoCollectBtn.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
            print("[AUTO RECOGER] Desactivado")
        end
    end)

    RGBBubble.Size = UDim2.new(0, 45, 0, 45)
    RGBBubble.Position = UDim2.new(0, 20, 0, 20)
    RGBBubble.BackgroundColor3 = Color3.new(1, 0, 0)
    RGBBubble.BorderSizePixel = 2
    RGBBubble.BorderColor3 = Color3.new(1, 1, 1)
    RGBBubble.Text = "🏠"
    RGBBubble.TextColor3 = Color3.new(1, 1, 1)
    RGBBubble.Font = Enum.Font.GothamBold
    RGBBubble.TextSize = 22
    RGBBubble.CornerRadius = UDim.new(1, 0)
    RGBBubble.ZIndex = 20
end)

setupMenu()
print("[GIGA MANSION TYCOON UI] Cargado correctamente")
