-- EcoHub - Otimização V1
-- Painel Mobile e PC com botões toggle animados

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local PANEL_NAME = "EcoHubOptimGUI"

-- Remover GUI antiga
if PlayerGui:FindFirstChild(PANEL_NAME) then
    PlayerGui[PANEL_NAME]:Destroy()
end

-- Criar GUI principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = PlayerGui
ScreenGui.Name = PANEL_NAME
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = isMobile and UDim2.new(0, 300, 0, 350) or UDim2.new(0, 600, 0, 350)
MainFrame.Position = isMobile and UDim2.new(0.5, -150, 0.5, -175) or UDim2.new(0.5, -300, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = not isMobile
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = MainFrame

-- Título
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, -40, 0, 40)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "EcoHub - Otimização V1"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Container de botões com UIListLayout
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Parent = MainFrame
ButtonContainer.Size = UDim2.new(1, -20, 1, -50)
ButtonContainer.Position = UDim2.new(0, 10, 0, 50)
ButtonContainer.BackgroundTransparency = 1

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ButtonContainer
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

-- Botão minimizar
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Parent = MainFrame
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(1, -35, 0, 5)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MinimizeBtn.Text = "-"
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 25
MinimizeBtn.AutoButtonColor = true

-- Função criar botão toggle animado
local function CreateToggleButton(name, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = ButtonContainer
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.Text = name .. " [OFF]"
    btn.AutoButtonColor = false

    btn.LayoutOrder = #ButtonContainer:GetChildren()

    -- Hover e clique animado
    btn.MouseEnter:Connect(function()
        btn:TweenSize(UDim2.new(1, 10, 0, 45), "Out", "Quad", 0.2, true)
        btn.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
    end)
    btn.MouseLeave:Connect(function()
        btn:TweenSize(UDim2.new(1, 0, 0, 40), "Out", "Quad", 0.2, true)
        btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end)
    btn.MouseButton1Click:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        wait(0.1)
        btn.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
    end)

    -- Toggle funcional
    local toggled = false
    btn.MouseButton1Click:Connect(function()
        toggled = not toggled
        btn.Text = name .. (toggled and " [ON]" or " [OFF]")
        pcall(callback, toggled)
    end)
end

-- ===== Funções de otimização =====
local processados = {}

local function safe(func, ...)
    local success, result = pcall(func, ...)
    return success and result
end

local function aplicarFPSBooster()
    safe(function()
        local UserGameSettings = UserSettings():GetService("UserGameSettings")
        UserGameSettings.SavedQualityLevel = 1
        UserGameSettings.QualityLevel = 1
        UserGameSettings.GraphicsQualityLevel = 1
        UserGameSettings.MasterVolume = 0.05

        Lighting.Technology = Enum.Technology.Compatibility
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        Lighting.FogStart = 0
        Lighting.Brightness = 0
        Lighting.ColorShift_Bottom = Color3.new(0,0,0)
        Lighting.ColorShift_Top = Color3.new(0,0,0)
        Lighting.OutdoorAmbient = Color3.new(1,1,1)
        Lighting.Ambient = Color3.new(1,1,1)

        SoundService.AmbientReverb = Enum.ReverbType.NoReverb
        SoundService.DistanceFactor = 0.1
        SoundService.DopplerScale = 0
        SoundService.RolloffScale = 0
    end)
end

local function limparEfeitos()
    safe(function()
        for _, v in ipairs(Lighting:GetChildren()) do
            if v:IsA("PostEffect") or v:IsA("Atmosphere") or v:IsA("Sky") or v:IsA("Clouds") then
                v:Destroy()
            end
        end
    end)
end

local function otimizarObjeto(obj)
    if not obj or not obj.Parent or processados[obj] then return end
    processados[obj] = true
    if obj:IsA("BasePart") then
        obj.Material = Enum.Material.Plastic
        obj.CastShadow = false
        obj.Reflectance = 0
        obj.TopSurface = Enum.SurfaceType.Smooth
        obj.BottomSurface = Enum.SurfaceType.Smooth
    elseif obj:IsA("MeshPart") then
        obj.Material = Enum.Material.Plastic
        obj.CastShadow = false
        obj.RenderFidelity = Enum.RenderFidelity.Performance
        obj.Reflectance = 0
    elseif obj:IsA("UnionOperation") then
        obj.Material = Enum.Material.Plastic
        obj.UsePartColor = true
        obj.CastShadow = false
    elseif obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
        obj:Destroy()
    elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
        obj.Enabled = false
    elseif obj:IsA("Explosion") then
        obj.Visible = false
    elseif obj:IsA("SpecialMesh") then
        obj.TextureId = ""
    elseif obj:IsA("Decal") or obj:IsA("Texture") then
        obj.Transparency = 1
    end
end

local function otimizacaoLote()
    safe(function()
        local objetos = Workspace:GetDescendants()
        for i, obj in ipairs(objetos) do
            otimizarObjeto(obj)
            if i % 500 == 0 then RunService.Heartbeat:Wait() end
        end
    end)
end

-- ===== Adicionar botões de otimização =====
CreateToggleButton("FPS Booster", function(active)
    if active then
        task.spawn(function()
            aplicarFPSBooster()
            limparEfeitos()
            otimizacaoLote()
        end)
    end
end)

CreateToggleButton("Remover Partículas", function(active)
    if active then
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
                obj.Enabled = false
            end
        end
    end
end)

CreateToggleButton("Desativar Som", function(active)
    if active then
        SoundService.MasterVolume = 0
    else
        SoundService.MasterVolume = 1
    end
end)

-- ===== Minimizar/restaurar =====
local originalSize = MainFrame.Size
local minimizedSize = isMobile and UDim2.new(0, 300, 0, 50) or UDim2.new(0, 600, 0, 40)
local minimized = false

MinimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        MainFrame.Size = minimizedSize
        for _, btn in pairs(ButtonContainer:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.Visible = false
            end
        end
    else
        MainFrame.Size = originalSize
        for _, btn in pairs(ButtonContainer:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.Visible = true
            end
        end
    end
end)
