local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local Activado = false
local Conexion = nil
local Jugador = Players.LocalPlayer

local Gui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Titulo = Instance.new("TextLabel")
local Btn = Instance.new("TextButton")
local Fondo = Instance.new("ImageLabel")
local Gradiente = Instance.new("UIGradient")

Gui.Parent = game.CoreGui

Main.Name = "Main"
Main.Parent = Gui
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.05, 0, 0.35, 0)
Main.Size = UDim2.new(0, 260, 0, 140)
Main.Active = true
Main.Draggable = true

Fondo.Name = "Fondo"
Fondo.Parent = Main
Fondo.BackgroundTransparency = 1
Fondo.Position = UDim2.new(-1, 0, -1, 0)
Fondo.Size = UDim2.new(3, 0, 3, 0)
Fondo.Image = "rbxassetid://10595758027"
Fondo.ImageColor3 = Color3.fromRGB(255, 215, 0)
Fondo.ImageTransparency = 0.3

Gradiente.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 215, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 140, 0))
}
Gradiente.Rotation = 45
Gradiente.Parent = Fondo

Titulo.Name = "Titulo"
Titulo.Parent = Main
Titulo.BackgroundTransparency = 1
Titulo.Size = UDim2.new(0, 260, 0, 30)
Titulo.Font = Enum.Font.GothamBold
Titulo.Text = "JoseAngel_Blox Bonds"
Titulo.TextColor3 = Color3.new(1,1,1)
Titulo.TextSize = 16

Btn.Name = "Boton"
Btn.Parent = Main
Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
Btn.BorderSizePixel = 0
Btn.Position = UDim2.new(0.5, -95, 0.5, -18)
Btn.Size = UDim2.new(0, 190, 0, 36)
Btn.Font = Enum.Font.GothamBold
Btn.Text = "▶ ACTIVAR"
Btn.TextColor3 = Color3.new(1,1,1)
Btn.TextSize = 14

local UICorner1 = Instance.new("UICorner", Main)
local UICorner2 = Instance.new("UICorner", Btn)
UICorner1.CornerRadius = UDim.new(0, 8)
UICorner2.CornerRadius = UDim.new(0, 6)

local Tween = TweenService:Create(Gradiente, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), {Rotation = 360})
Tween:Play()

-- ⚡ FUNCION DEL SCRIPT ORIGINAL (LA QUE SÍ FUNCIONA) ⚡
local function FarmearBonds()
    local Character = Jugador.Character
    if not Character then return end
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    if not HumanoidRootPart then return end

    for i,v in pairs(Workspace:GetChildren()) do
        if v:FindFirstChild("Bill") or v:FindFirstChild("Bond") or v:FindFirstChild("Money") or v.Name == "Enlace" then
            if v:FindFirstChildOfClass("ProximityPrompt") then
                local Distancia = (HumanoidRootPart.Position - v.Position).Magnitude
                if Distancia < 70 then
                    HumanoidRootPart.CFrame = CFrame.new(v.Position + Vector3.new(0,2,0))
                    fireproximityprompt(v.ProximityPrompt)
                    task.wait(0.05)
                end
            end
        end
    end
end

Btn.MouseButton1Click:Connect(function()
    Activado = not Activado
    if Activado then
        Btn.Text = "⏸ DESACTIVAR"
        Btn.BackgroundColor3 = Color3.fromRGB(20, 90, 30)
        Conexion = RunService.Heartbeat:Connect(FarmearBonds)
    else
        Btn.Text = "▶ ACTIVAR"
        Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        if Conexion then Conexion:Disconnect() end
    end
end)
