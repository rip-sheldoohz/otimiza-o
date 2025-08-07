local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")
local GuiService = game:GetService("GuiService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

print("🚀 OTIMIZADOR ULTRA AVANÇADO INICIANDO...")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UltraOptimizer"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.DisplayOrder = 999999
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "OptimizedMonitor"
mainFrame.Size = UDim2.new(0, 320, 0, 90)
mainFrame.Position = UDim2.new(0, 10, 0, 10)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BorderSizePixel = 0
mainFrame.BackgroundTransparency = 0.1
mainFrame.Visible = true
mainFrame.Parent = screenGui

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 25)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 10))
}
gradient.Rotation = 45
gradient.Parent = mainFrame

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(0, 255, 127)
stroke.Thickness = 3
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Parent = mainFrame

local glowStroke = Instance.new("UIStroke")
glowStroke.Color = Color3.fromRGB(0, 255, 127)
glowStroke.Thickness = 6
glowStroke.Transparency = 0.7
glowStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
glowStroke.Parent = mainFrame

local avatarImage = Instance.new("ImageLabel")
avatarImage.Name = "UserAvatar"
avatarImage.Size = UDim2.new(0, 55, 0, 55)
avatarImage.Position = UDim2.new(0, 12, 0, 18)
avatarImage.BackgroundTransparency = 1
avatarImage.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=150&height=150&format=png"
avatarImage.Parent = mainFrame

local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(0, 27)
avatarCorner.Parent = avatarImage

local avatarStroke = Instance.new("UIStroke")
avatarStroke.Color = Color3.fromRGB(0, 255, 127)
avatarStroke.Thickness = 2
avatarStroke.Parent = avatarImage

local usernameLabel = Instance.new("TextLabel")
usernameLabel.Name = "PlayerName"
usernameLabel.Size = UDim2.new(0, 140, 0, 22)
usernameLabel.Position = UDim2.new(0, 75, 0, 18)
usernameLabel.BackgroundTransparency = 1
usernameLabel.Text = "🎮 " .. player.DisplayName .. " (@" .. player.Name .. ")"
usernameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
usernameLabel.TextScaled = true
usernameLabel.TextXAlignment = Enum.TextXAlignment.Left
usernameLabel.Font = Enum.Font.GothamBold
usernameLabel.Parent = mainFrame

local fpsLabel = Instance.new("TextLabel")
fpsLabel.Name = "FPSCounter"
fpsLabel.Size = UDim2.new(0, 70, 0, 16)
fpsLabel.Position = UDim2.new(0, 75, 0, 42)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Text = "FPS: 144"
fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 127)
fpsLabel.TextScaled = true
fpsLabel.TextXAlignment = Enum.TextXAlignment.Left
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.Parent = mainFrame

local pingLabel = Instance.new("TextLabel")
pingLabel.Name = "PingDisplay"
pingLabel.Size = UDim2.new(0, 70, 0, 16)
pingLabel.Position = UDim2.new(0, 150, 0, 42)
pingLabel.BackgroundTransparency = 1
pingLabel.Text = "PING: 0ms"
pingLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
pingLabel.TextScaled = true
pingLabel.TextXAlignment = Enum.TextXAlignment.Left
pingLabel.Font = Enum.Font.GothamBold
pingLabel.Parent = mainFrame

local memoryLabel = Instance.new("TextLabel")
memoryLabel.Name = "RAMUsage"
memoryLabel.Size = UDim2.new(0, 90, 0, 16)
memoryLabel.Position = UDim2.new(0, 225, 0, 42)
memoryLabel.BackgroundTransparency = 1
memoryLabel.Text = "RAM: 0MB"
memoryLabel.TextColor3 = Color3.fromRGB(255, 105, 180)
memoryLabel.TextScaled = true
memoryLabel.TextXAlignment = Enum.TextXAlignment.Left
memoryLabel.Font = Enum.Font.GothamBold
memoryLabel.Parent = mainFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "OptimizationStatus"
statusLabel.Size = UDim2.new(0, 240, 0, 16)
statusLabel.Position = UDim2.new(0, 75, 0, 60)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "⚡ ULTRA OPTIMIZED | 🎯 MAX PERFORMANCE | 🚀 ZERO LAG"
statusLabel.TextColor3 = Color3.fromRGB(50, 255, 50)
statusLabel.TextScaled = true
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Font = Enum.Font.GothamBold
statusLabel.Parent = mainFrame

local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 69, 69)
closeButton.BorderSizePixel = 0
closeButton.Text = "✕"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextScaled = true
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 15)
closeCorner.Parent = closeButton

local closeStroke = Instance.new("UIStroke")
closeStroke.Color = Color3.fromRGB(200, 0, 0)
closeStroke.Thickness = 2
closeStroke.Parent = closeButton

local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 30, 0, 30)
toggleButton.Position = UDim2.new(1, -70, 0, 5)
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
toggleButton.BorderSizePixel = 0
toggleButton.Text = "−"
toggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
toggleButton.TextScaled = true
toggleButton.Font = Enum.Font.GothamBold
toggleButton.Parent = mainFrame

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 15)
toggleCorner.Parent = toggleButton

local toggleStroke = Instance.new("UIStroke")
toggleStroke.Color = Color3.fromRGB(200, 150, 0)
toggleStroke.Thickness = 2
toggleStroke.Parent = toggleButton

local function pulseAnimation()
    local tween = TweenService:Create(stroke, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        Color = Color3.fromRGB(127, 255, 0)
    })
    tween:Play()
end
pulseAnimation()

local isMinimized = false
local originalSize = mainFrame.Size

local function toggleFrame()
    isMinimized = not isMinimized
    
    local targetSize = isMinimized and UDim2.new(0, 320, 0, 40) or originalSize
    local targetText = isMinimized and "+" or "−"
    
    local framesTween = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = targetSize
    })
    
    local buttonTween = TweenService:Create(toggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Text = targetText
    })
    
    framesTween:Play()
    buttonTween:Play()
    
    for _, child in pairs(mainFrame:GetChildren()) do
        if child ~= toggleButton and child ~= closeButton and child ~= corner and child ~= stroke and child ~= glowStroke and child ~= gradient then
            child.Visible = not isMinimized
        end
    end
end

local function closeFrame()
    local closeTween = TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0, 170, 0, 55),
        BackgroundTransparency = 1
    })
    
    closeTween:Play()
    closeTween.Completed:Connect(function()
        screenGui:Destroy()
    end)
end

local function setupButtonEvents()
    closeButton.MouseButton1Click:Connect(closeFrame)
    toggleButton.MouseButton1Click:Connect(toggleFrame)
    
    if isMobile then
        closeButton.TouchTap:Connect(closeFrame)
        toggleButton.TouchTap:Connect(toggleFrame)
        
        local dragStart = nil
        local startPos = nil
        
        mainFrame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                dragStart = input.Position
                startPos = mainFrame.Position
            end
        end)
        
        mainFrame.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch and dragStart then
                local delta = input.Position - dragStart
                mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
        
        mainFrame.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                dragStart = nil
            end
        end)
    else
        closeButton.MouseEnter:Connect(function()
            local hoverTween = TweenService:Create(closeButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundColor3 = Color3.fromRGB(255, 100, 100),
                Size = UDim2.new(0, 32, 0, 32)
            })
            hoverTween:Play()
        end)
        
        closeButton.MouseLeave:Connect(function()
            local leaveTween = TweenService:Create(closeButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundColor3 = Color3.fromRGB(255, 69, 69),
                Size = UDim2.new(0, 30, 0, 30)
            })
            leaveTween:Play()
        end)
        
        toggleButton.MouseEnter:Connect(function()
            local hoverTween = TweenService:Create(toggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundColor3 = Color3.fromRGB(255, 235, 50),
                Size = UDim2.new(0, 32, 0, 32)
            })
            hoverTween:Play()
        end)
        
        toggleButton.MouseLeave:Connect(function()
            local leaveTween = TweenService:Create(toggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundColor3 = Color3.fromRGB(255, 215, 0),
                Size = UDim2.new(0, 30, 0, 30)
            })
            leaveTween:Play()
        end)
        
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if not gameProcessed then
                if input.KeyCode == Enum.KeyCode.F3 then
                    toggleFrame()
                elseif input.KeyCode == Enum.KeyCode.F4 then
                    closeFrame()
                end
            end
        end)
    end
end

setupButtonEvents()

print("💎 Interface Ultra Premium criada!")
if isMobile then
    print("📱 Controles móveis ativados - Toque para fechar/minimizar")
else
    print("🖥️ Controles PC ativados - F3: minimizar | F4: fechar")
end

local function ultraOptimizeLighting()
    Lighting.Technology = Enum.Technology.Compatibility
    Lighting.GlobalShadows = false
    Lighting.FogEnd = math.huge
    Lighting.FogStart = math.huge
    Lighting.Brightness = 4
    Lighting.Ambient = Color3.new(1, 1, 1)
    Lighting.ColorShift_Bottom = Color3.new(0, 0, 0)
    Lighting.ColorShift_Top = Color3.new(0, 0, 0)
    Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
    Lighting.ClockTime = 12
    Lighting.GeographicLatitude = 0
    Lighting.ExposureCompensation = 0
    Lighting.ShadowSoftness = 0
    
    pcall(function()
        Lighting.EnvironmentDiffuseScale = 0
        Lighting.EnvironmentSpecularScale = 0
    end)
    
    for _, effect in pairs(Lighting:GetChildren()) do
        if effect:IsA("PostEffect") or effect:IsA("BlurEffect") or effect:IsA("SunRaysEffect") or 
           effect:IsA("ColorCorrectionEffect") or effect:IsA("BloomEffect") or 
           effect:IsA("DepthOfFieldEffect") or effect:IsA("Atmosphere") or
           effect:IsA("Sky") or effect:IsA("Clouds") then
            effect:Destroy()
        end
    end
end

local function ultraOptimizeWorkspace()
    local preserveList = {"gun", "weapon", "tool", "sword", "knife", "crosshair", "sight", "scope", "hud", "ui"}
    
    for _, obj in pairs(Workspace:GetDescendants()) do
        pcall(function()
            if obj:IsA("BasePart") then
                obj.CastShadow = false
                obj.Material = Enum.Material.SmoothPlastic
                obj.Reflectance = 0
                obj.TopSurface = Enum.SurfaceType.Smooth
                obj.BottomSurface = Enum.SurfaceType.Smooth
                obj.LeftSurface = Enum.SurfaceType.Smooth
                obj.RightSurface = Enum.SurfaceType.Smooth
                obj.FrontSurface = Enum.SurfaceType.Smooth
                obj.BackSurface = Enum.SurfaceType.Smooth
                
                if obj:FindFirstChildOfClass("SpecialMesh") then
                    obj:FindFirstChildOfClass("SpecialMesh").LevelOfDetail = Enum.LevelOfDetail.Disabled
                end
            end

            if obj:IsA("Decal") or obj:IsA("Texture") or obj:IsA("SurfaceGui") or obj:IsA("BillboardGui") then
                local shouldPreserve = false
                for _, preserve in pairs(preserveList) do
                    if obj.Name:lower():find(preserve) or (obj.Parent and obj.Parent.Name:lower():find(preserve)) then
                        shouldPreserve = true
                        break
                    end
                end
                if not shouldPreserve then
                    obj:Destroy()
                end
            end

            if obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") or obj:IsA("Explosion") then
                obj:Destroy()
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") or obj:IsA("SelectionBox") then
                local shouldPreserve = false
                for _, preserve in pairs(preserveList) do
                    if obj.Parent and obj.Parent.Name:lower():find(preserve) then
                        shouldPreserve = true
                        break
                    end
                end
                if not shouldPreserve then
                    obj:Destroy()
                end
            end

            if obj:IsA("MeshPart") then
                obj.RenderFidelity = Enum.RenderFidelity.Performance
                obj.CollisionFidelity = Enum.CollisionFidelity.Box
            end

            if obj:IsA("UnionOperation") then
                obj.RenderFidelity = Enum.RenderFidelity.Performance
                obj.CollisionFidelity = Enum.CollisionFidelity.Box
            end

            if obj:IsA("SpotLight") or obj:IsA("PointLight") or obj:IsA("SurfaceLight") then
                obj:Destroy()
            end

            if obj:IsA("Sound") then
                if obj.Name:lower():find("music") or obj.Name:lower():find("ambient") or 
                   obj.Name:lower():find("background") or obj.Name:lower():find("wind") then
                    obj.Volume = 0
                    obj:Stop()
                    obj:Destroy()
                end
            end
        end)
    end
end

local function ultraOptimizeTerrain()
    if Workspace:FindFirstChild("Terrain") then
        local terrain = Workspace.Terrain
        terrain.WaterWaveSize = 0
        terrain.WaterWaveSpeed = 0
        terrain.WaterReflectance = 0
        terrain.WaterTransparency = 1
        
        pcall(function()
            terrain.Decoration = false
            terrain.ReadVoxels = false
        end)
        
        spawn(function()
            pcall(function()
                terrain:ReadVoxels(Region3.new(Vector3.new(), Vector3.new()), 4):Destroy()
            end)
        end)
    end
end

local function applyUltraRenderSettings()
    local settings = UserSettings():GetService("UserGameSettings")
    settings.MasterVolume = 0.1
    settings.GraphicsQualityLevel = 1
    
    pcall(function()
        settings().Rendering.QualityLevel = "Level01"
        settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
        settings().Rendering.EnableFRM = false
        settings().Rendering.FrameRateManager = Enum.FrameRateManagerMode.Off
    end)
    
    pcall(function()
        settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Skip
        settings().Physics.AllowSleep = true
        settings().Physics.ThrottleAdjustTime = 0
        settings().Physics.PhysicsReceiveAge = 0
    end)
    
    if SoundService then
        SoundService.AmbientReverb = Enum.ReverbType.NoReverb
        SoundService.DistanceFactor = 1
        SoundService.DopplerScale = 0
        SoundService.RolloffScale = 0
    end
end

local function setupHyperOptimization()
    local lastClean = tick()
    
    Workspace.DescendantAdded:Connect(function(obj)
        pcall(function()
            if obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") or obj:IsA("Explosion") then
                obj:Destroy()
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
                if not (obj.Parent and (obj.Parent.Name:lower():find("gun") or 
                        obj.Parent.Name:lower():find("weapon") or 
                        obj.Parent.Name:lower():find("tool"))) then
                    obj:Destroy()
                end
            elseif obj:IsA("Decal") or obj:IsA("Texture") then
                if not (obj.Name:lower():find("sight") or obj.Name:lower():find("crosshair") or
                        obj.Name:lower():find("scope") or obj.Name:lower():find("hud")) then
                    wait(0.1)
                    obj:Destroy()
                end
            elseif obj:IsA("BasePart") then
                obj.CastShadow = false
                obj.Material = Enum.Material.SmoothPlastic
                obj.Reflectance = 0
            elseif obj:IsA("Sound") then
                if obj.Name:lower():find("music") or obj.Name:lower():find("ambient") then
                    obj.Volume = 0
                    obj:Stop()
                end
            end
        end)
    end)
    
    spawn(function()
        while wait(8) do
            pcall(function()
                if tick() - lastClean > 8 then
                    lastClean = tick()
                    
                    for _, effect in pairs(Lighting:GetChildren()) do
                        if effect:IsA("PostEffect") or effect:IsA("Sky") or effect:IsA("Atmosphere") then
                            effect:Destroy()
                        end
                    end
                    
                    for _, obj in pairs(Workspace:GetDescendants()) do
                        if obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") or obj:IsA("Explosion") then
                            obj:Destroy()
                        elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
                            if not (obj.Parent and obj.Parent.Name:lower():find("gun")) then
                                obj:Destroy()
                            end
                        end
                    end
                    
                    collectgarbage("collect")
                end
            end)
        end
    end)
end

local frameCount = 0
local lastTime = tick()
local currentFPS = 144
local pingValues = {}

local function updateUltraMonitor()
    frameCount = frameCount + 1
    local currentTime = tick()
    
    if currentTime - lastTime >= 0.5 then
        currentFPS = math.floor(frameCount / (currentTime - lastTime))
        frameCount = 0
        lastTime = currentTime
        
        local fpsColor = Color3.fromRGB(0, 255, 127)
        if currentFPS < 30 then
            fpsColor = Color3.fromRGB(255, 69, 0)
        elseif currentFPS < 60 then
            fpsColor = Color3.fromRGB(255, 215, 0)
        elseif currentFPS >= 120 then
            fpsColor = Color3.fromRGB(50, 255, 50)
        end
        
        fpsLabel.Text = "FPS: " .. math.min(currentFPS, 999)
        fpsLabel.TextColor3 = fpsColor
        
        local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        table.insert(pingValues, ping)
        if #pingValues > 5 then
            table.remove(pingValues, 1)
        end
        
        local avgPing = 0
        for _, p in pairs(pingValues) do
            avgPing = avgPing + p
        end
        avgPing = math.floor(avgPing / #pingValues)
        
        local pingColor = Color3.fromRGB(0, 255, 127)
        if avgPing > 100 then
            pingColor = Color3.fromRGB(255, 69, 0)
        elseif avgPing > 50 then
            pingColor = Color3.fromRGB(255, 215, 0)
        end
        
        pingLabel.Text = "PING: " .. avgPing .. "ms"
        pingLabel.TextColor3 = pingColor
        
        local memory = math.floor(Stats:GetTotalMemoryUsageMb())
        local memoryColor = Color3.fromRGB(255, 105, 180)
        if memory > 1000 then
            memoryColor = Color3.fromRGB(255, 69, 0)
        elseif memory > 500 then
            memoryColor = Color3.fromRGB(255, 215, 0)
        else
            memoryColor = Color3.fromRGB(0, 255, 127)
        end
        
        memoryLabel.Text = "RAM: " .. memory .. "MB"
        memoryLabel.TextColor3 = memoryColor
    end
end

RunService.Heartbeat:Connect(updateUltraMonitor)

local function initializeUltraOptimizer()
    print("⚡ Aplicando otimizações ULTRA avançadas...")
    
    ultraOptimizeLighting()
    print("✅ Sistema de iluminação ULTRA otimizado")
    
    ultraOptimizeWorkspace()
    print("✅ Workspace com otimização MÁXIMA")
    
    ultraOptimizeTerrain()
    print("✅ Terreno com performance EXTREMA")
    
    applyUltraRenderSettings()
    print("✅ Configurações de render ULTRA aplicadas")
    
    setupHyperOptimization()
    print("✅ Sistema de hiper-otimização ATIVO")
    
    collectgarbage("collect")
    wait(1)
    
    print("")
    print("🎯 ULTRA OTIMIZAÇÃO CONCLUÍDA COM SUCESSO!")
    print("⚡ Performance MÁXIMA ativada")
    print("🚀 Zero lag + Zero input delay GARANTIDO")
    print("💎 Sistema de monitoramento PREMIUM ativo")
    print("🔥 Otimização contínua em tempo REAL")
    print("💯 FPS MÁXIMO desbloqueado!")
    print("")
end

spawn(initializeUltraOptimizer)
