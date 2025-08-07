local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

print("🚀 Iniciando Otimizador Máximo...")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FPSMonitor"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MonitorFrame"
mainFrame.Size = UDim2.new(0, 280, 0, 80)
mainFrame.Position = UDim2.new(0, 10, 0, 10)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(0, 255, 127)
stroke.Thickness = 2
stroke.Parent = mainFrame

local avatarImage = Instance.new("ImageLabel")
avatarImage.Name = "Avatar"
avatarImage.Size = UDim2.new(0, 50, 0, 50)
avatarImage.Position = UDim2.new(0, 10, 0, 15)
avatarImage.BackgroundTransparency = 1
avatarImage.Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
avatarImage.Parent = mainFrame

local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(0, 25)
avatarCorner.Parent = avatarImage

local usernameLabel = Instance.new("TextLabel")
usernameLabel.Name = "Username"
usernameLabel.Size = UDim2.new(0, 120, 0, 20)
usernameLabel.Position = UDim2.new(0, 70, 0, 15)
usernameLabel.BackgroundTransparency = 1
usernameLabel.Text = "@" .. player.Name
usernameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
usernameLabel.TextScaled = true
usernameLabel.TextXAlignment = Enum.TextXAlignment.Left
usernameLabel.Font = Enum.Font.GothamBold
usernameLabel.Parent = mainFrame

local fpsLabel = Instance.new("TextLabel")
fpsLabel.Name = "FPS"
fpsLabel.Size = UDim2.new(0, 80, 0, 18)
fpsLabel.Position = UDim2.new(0, 70, 0, 35)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Text = "FPS: 0"
fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 127)
fpsLabel.TextScaled = true
fpsLabel.TextXAlignment = Enum.TextXAlignment.Left
fpsLabel.Font = Enum.Font.Gotham
fpsLabel.Parent = mainFrame

local pingLabel = Instance.new("TextLabel")
pingLabel.Name = "Ping"
pingLabel.Size = UDim2.new(0, 80, 0, 18)
pingLabel.Position = UDim2.new(0, 70, 0, 52)
pingLabel.BackgroundTransparency = 1
pingLabel.Text = "MS: 0"
pingLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
pingLabel.TextScaled = true
pingLabel.TextXAlignment = Enum.TextXAlignment.Left
pingLabel.Font = Enum.Font.Gotham
pingLabel.Parent = mainFrame

local memoryLabel = Instance.new("TextLabel")
memoryLabel.Name = "Memory"
memoryLabel.Size = UDim2.new(0, 100, 0, 18)
memoryLabel.Position = UDim2.new(0, 155, 0, 35)
memoryLabel.BackgroundTransparency = 1
memoryLabel.Text = "RAM: 0 MB"
memoryLabel.TextColor3 = Color3.fromRGB(255, 105, 180)
memoryLabel.TextScaled = true
memoryLabel.TextXAlignment = Enum.TextXAlignment.Left
memoryLabel.Font = Enum.Font.Gotham
memoryLabel.Parent = mainFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "Status"
statusLabel.Size = UDim2.new(0, 100, 0, 18)
statusLabel.Position = UDim2.new(0, 155, 0, 52)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "OTIMIZADO ✅"
statusLabel.TextColor3 = Color3.fromRGB(50, 205, 50)
statusLabel.TextScaled = true
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Font = Enum.Font.GothamBold
statusLabel.Parent = mainFrame

print("🎨 Interface de monitoramento criada!")

local function optimizeLighting()
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    Lighting.FogStart = 0
    Lighting.Brightness = 3
    Lighting.Ambient = Color3.fromRGB(255, 255, 255)
    Lighting.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
    Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0)
    Lighting.OutdoorAmbient = Color3.fromRGB(200, 200, 200)
    Lighting.ClockTime = 14
    Lighting.GeographicLatitude = 0
    Lighting.ExposureCompensation = 0
    
    for _, effect in pairs(Lighting:GetChildren()) do
        if effect:IsA("PostEffect") or effect:IsA("BlurEffect") or effect:IsA("SunRaysEffect") or 
           effect:IsA("ColorCorrectionEffect") or effect:IsA("BloomEffect") or 
           effect:IsA("DepthOfFieldEffect") or effect:IsA("Atmosphere") then
            effect:Destroy()
        end
    end
end

local function optimizeWorkspace()
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.CastShadow = false
            obj.Material = Enum.Material.Plastic
            obj.Reflectance = 0
            obj.TopSurface = Enum.SurfaceType.Smooth
            obj.BottomSurface = Enum.SurfaceType.Smooth
        end

        if obj:IsA("Decal") or obj:IsA("Texture") or obj:IsA("SurfaceGui") then
            if not (obj.Name:lower():find("crosshair") or obj.Name:lower():find("sight") or
                    obj.Name:lower():find("scope") or obj.Name:lower():find("hud")) then
                obj:Destroy()
            end
        end

        if obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
            obj:Destroy()
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
            if not (obj.Parent and (obj.Parent.Name:lower():find("gun") or 
                    obj.Parent.Name:lower():find("weapon") or 
                    obj.Parent.Name:lower():find("muzzle") or
                    obj.Parent.Name:lower():find("bullet"))) then
                obj:Destroy()
            end
        end

        if obj:IsA("MeshPart") then
            obj.RenderFidelity = Enum.RenderFidelity.Performance
        end

        if obj:IsA("SpecialMesh") then
            obj.LevelOfDetail = Enum.LevelOfDetail.Disabled
        end

        if obj:IsA("SpotLight") or obj:IsA("PointLight") or obj:IsA("SurfaceLight") then
            obj:Destroy()
        end

        if obj:IsA("Sound") then
            if obj.Name:lower():find("music") or obj.Name:lower():find("ambient") or 
               obj.Name:lower():find("background") then
                obj.Volume = 0
                obj:Stop()
            end
        end
    end
end

local function optimizeTerrain()
    if Workspace:FindFirstChild("Terrain") then
        local terrain = Workspace.Terrain
        terrain.WaterWaveSize = 0
        terrain.WaterWaveSpeed = 0
        terrain.WaterReflectance = 0
        terrain.WaterTransparency = 1
        pcall(function()
            terrain.Decoration = false
        end)
    end
end

local function applyRenderSettings()
    settings().Rendering.QualityLevel = "Level01"
    settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level04
    
    pcall(function()
        UserSettings():GetService("UserGameSettings").MasterVolume = 0.1
    end)
    
    pcall(function()
        settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Skip
        settings().Physics.AllowSleep = true
        settings().Physics.ThrottleAdjustTime = 0
    end)
end

local function setupContinuousOptimization()
    Workspace.DescendantAdded:Connect(function(obj)
        if obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
            obj:Destroy()
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
            if not (obj.Parent and (obj.Parent.Name:lower():find("gun") or 
                    obj.Parent.Name:lower():find("weapon") or 
                    obj.Parent.Name:lower():find("muzzle") or
                    obj.Parent.Name:lower():find("bullet"))) then
                obj:Destroy()
            end
        elseif obj:IsA("Decal") or obj:IsA("Texture") then
            if not (obj.Name:lower():find("sight") or obj.Name:lower():find("crosshair") or
                    obj.Name:lower():find("scope") or obj.Name:lower():find("hud")) then
                obj:Destroy()
            end
        elseif obj:IsA("BasePart") then
            obj.CastShadow = false
            obj.Material = Enum.Material.Plastic
            obj.Reflectance = 0
        elseif obj:IsA("Sound") then
            if obj.Name:lower():find("music") or obj.Name:lower():find("ambient") then
                obj.Volume = 0
            end
        end
    end)
    
    spawn(function()
        while true do
            wait(15)
            for _, obj in pairs(Lighting:GetChildren()) do
                if obj:IsA("PostEffect") then
                    obj:Destroy()
                end
            end
            
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                    obj:Destroy()
                elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
                    if not (obj.Parent and obj.Parent.Name:lower():find("gun")) then
                        obj:Destroy()
                    end
                end
            end
        end
    end)
end

local frameCount = 0
local lastTime = tick()
local currentFPS = 0

local function updateMonitor()
    frameCount = frameCount + 1
    local currentTime = tick()
    
    if currentTime - lastTime >= 1 then
        currentFPS = math.floor(frameCount / (currentTime - lastTime))
        frameCount = 0
        lastTime = currentTime
        
        local fpsColor = Color3.fromRGB(0, 255, 127)
        if currentFPS < 30 then
            fpsColor = Color3.fromRGB(255, 69, 0)
        elseif currentFPS < 60 then
            fpsColor = Color3.fromRGB(255, 215, 0)
        end
        
        fpsLabel.Text = "FPS: " .. currentFPS
        fpsLabel.TextColor3 = fpsColor
        
        local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        pingLabel.Text = "MS: " .. ping
        
        local memory = math.floor(Stats:GetTotalMemoryUsageMb())
        memoryLabel.Text = "RAM: " .. memory .. " MB"
    end
end

RunService.Heartbeat:Connect(updateMonitor)

print("⚡ Aplicando otimizações...")
optimizeLighting()
print("✅ Iluminação otimizada")

optimizeWorkspace()
print("✅ Workspace otimizado")

optimizeTerrain()
print("✅ Terreno otimizado")

applyRenderSettings()
print("✅ Configurações de renderização aplicadas")

setupContinuousOptimization()
print("✅ Otimização contínua ativada")

print("🎯 OTIMIZAÇÃO MÁXIMA CONCLUÍDA!")
print("⚡ Zero lag + Zero input delay")
print("🚀 Performance extrema ativada")
print("📊 Monitor FPS em tempo real ativo")
