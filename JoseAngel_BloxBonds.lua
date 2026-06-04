-- [[ JoseAngel_Blox Bonds - Script Oficial ]] --

-- Cargar la librería visual Rayfield (Interfaz Moderna)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu'))()

-- Crear la ventana principal del script
local Window = Rayfield:CreateWindow({
   Name = "JoseAngel_Blox Bonds 💰",
   LoadingTitle = "Cargando Interfaz...",
   LoadingSubtitle = "por JoseAngel_Blox",
   ConfigurationSaving = {
      Enabled = false
   },
   KeySystem = false -- Sin molestos sistemas de llaves/keys
})

-- Variables de control
_G.AutoFarmBonds = false
local player = game.Players.LocalPlayer

-- Crear Pestaña Principal
local MainTab = Window:CreateTab("Principal", 4483345998) -- Icono de la pestaña

-- Función lógica optimizada para buscar y atraer los bonos
local function recolectarBonos()
    while _G.AutoFarmBonds do
        task.wait(0.4) -- Pausa equilibrada para rendimiento y efectividad
        
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            
            -- Buscar en todo el Workspace
            for _, objeto in pairs(workspace:GetDescendants()) do
                if not _G.AutoFarmBonds then break end
                
                -- Detectar el objeto "Bond" o "Bonds"
                if objeto:IsA("Tool") and (objeto.Name == "Bond" or objeto.Name == "Bonds") then
                    
                    -- Método seguro: Traer el bono hacia los pies del jugador
                    if objeto:FindFirstChild("Handle") then
                        objeto.Handle.CFrame = hrp.CFrame + Vector3.new(0, 2, 0)
                    elseif objeto:IsA("Model") and objeto:GetPrimaryPartCFrame() then
                        objeto:SetPrimaryPartCFrame(hrp.CFrame + Vector3.new(0, 2, 0))
                    end
                    
                    task.wait(0.05) -- Micro-espera entre cada bono para evitar alertas
                end
            end
        end
    end
end

-- Crear Sección Visual en la Pestaña
local Section = MainTab:CreateSection("Automatización")

-- Interruptor (Toggle) con diseño moderno
MainTab:CreateToggle({
   Name = "Activar Auto-Farm (Traer Bonos)",
   CurrentValue = false,
   Flag = "ToggleBonds",
   Callback = function(Value)
      _G.AutoFarmBonds = Value
      if Value then
          task.spawn(recolectarBonos)
          Rayfield:Notify({
             Title = "JoseAngel_Blox",
             Content = "Buscando y recolectando bonos en el mapa...",
             Duration = 4,
             Image = 4483345998,
             Actions = {},
          })
      else
          Rayfield:Notify({
             Title = "JoseAngel_Blox",
             Content = "Auto-Farm desactivado correctamente.",
             Duration = 3,
             Image = 4483345998,
             Actions = {},
          })
      end
   end,
})

-- Sección de Créditos
local CreditsTab = Window:CreateTab("Créditos", 4483345998)
local CreditsSection = CreditsTab:CreateSection("Creador")
CreditsTab:CreateLabel("Script diseñado por: JoseAngel_Blox")
CreditsTab:CreateLabel("Versión: 1.0.0")

Rayfield:Notify({
   Title = "¡Listo!",
   Content = "JoseAngel_Blox Bonds cargado con éxito.",
   Duration = 5,
   Image = 4483345998,
   Actions = {},
})
