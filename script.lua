local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local SoundService = game:GetService("SoundService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ContentProvider = game:GetService("ContentProvider")
local LogService = game:GetService("LogService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local optimizerActive = true
local lastOptimization = 0
local fpsBoostActive = false

local function generateRandomDelay()
    return math.random(50, 200) / 1000
end

local function silentExecute(func, fallback)
    local success, result = pcall(func)
    if not success and fallback then
        pcall(fallback)
    end
    return success, result
end

local function advancedBypass()
    local mt = getrawmetatable(game)
    if not mt then return end
    
    local oldIndex = mt.__index
    local oldNewindex = mt.__newindex
    local oldNamecall = mt.__namecall
    
    setreadonly(mt, false)
    
    local suspiciousPatterns = {
        "anti", "detect", "security", "check", "log", "report", "ban", "kick", 
        "monitor", "track", "watch", "guard", "protect", "scan", "verify"
    }
    
    mt.__namecall = function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        if method == "FireServer" or method == "InvokeServer" then
            local name = tostring(self):lower()
            for _, pattern in pairs(suspiciousPatterns) do
                if string.find(name, pattern) then
                    return
                end
            end
        end
        
        if method == "Kick" or method == "Remove" then
            if self == player or (self.Parent and self.Parent == player) then
                return
            end
        end
        
        return oldNamecall(self, ...)
    end
    
    mt.__newindex = function(self, key, value)
        if key == "WalkSpeed" and self == player.Character and self:FindFirstChild("Humanoid") then
            if value > 50 then
                return oldNewindex(self, key, 16)
            end
        end
        
        return oldNewindex(self, key, value)
    end
    
    setreadonly(mt, true)
    
    if hookfunction then
        hookfunction(Stats.GetTotalMemoryUsageMb, function()
            return math.random(200, 400)
        end)
    end
end

local function ultraLightingOptimization()
    silentExecute(function()
        Lighting.Technology = Enum.Technology.Compatibility
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        Lighting.FogStart = 0
        Lighting.Brightness = 10
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        Lighting.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
        Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0)
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        Lighting.ClockTime = 14
        Lighting.GeographicLatitude = 0
        Lighting.ExposureCompensation = -2
        Lighting.ShadowSoftness = 0
        
        if Lighting:FindFirstChild("SunRaysEffect") then
            Lighting.SunRaysEffect.Enabled = false
        end
        
        for _, effect in pairs(Lighting:GetChildren()) do
            if effect:IsA("PostEffect") or effect:IsA("BlurEffect") or effect:IsA("SunRaysEffect") or 
               effect:IsA("ColorCorrectionEffect") or effect:IsA("BloomEffect") or 
               effect:IsA("DepthOfFieldEffect") or effect:IsA("Atmosphere") or
               effect:IsA("Sky") or effect:IsA("Clouds") then
                effect:Destroy()
            end
        end
    end)
end

local function hyperRenderOptimization()
    silentExecute(function()
        local settings = UserSettings():GetService("UserGameSettings")
        settings.MasterVolume = 0.02
        settings.GraphicsQualityLevel = 1
        settings.SavedQualityLevel = 1
        
        settings().Rendering.QualityLevel = 1
        settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level04
        settings().Rendering.EnableFRM = false
        settings().Rendering.FrameRateManager = Enum.FrameRateManagerMode.Off
        
        if setfpscap then
            setfpscap(1000)
        end
        
        settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Skip
        settings().Physics.AllowSleep = true
        settings().Physics.ThrottleAdjustTime = 0
        settings().Physics.PhysicsReceiveAge = 0
        
        if SoundService then
            SoundService.AmbientReverb = Enum.ReverbType.NoReverb
            SoundService.DistanceFactor = 0.1
            SoundService.DopplerScale = 0
            SoundService.RolloffScale = 0.05
            SoundService.EmitterDistance = 1
        end
    end)
end

local function aggressiveWorkspaceCleanup()
    local preserveItems = {
        "gun", "weapon", "tool", "sword", "knife", "crosshair", "sight", "scope", 
        "hud", "ui", "gui", "menu", "health", "ammo", "reload", "fire", "shoot",
        "player", "character", "humanoid", "torso", "head", "arm", "leg"
    }
    
    local function shouldPreserve(objName, parentName)
        local name = objName:lower()
        local parent = parentName and parentName:lower() or ""
        
        for _, preserve in pairs(preserveItems) do
            if string.find(name, preserve) or string.find(parent, preserve) then
                return true
            end
        end
        return false
    end
    
    spawn(function()
        while optimizerActive and wait(3) do
            silentExecute(function()
                local processed = 0
                
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if processed > 100 then break end
                    
                    local objName = obj.Name
                    local parentName = obj.Parent and obj.Parent.Name
                    
                    if obj:IsA("BasePart") then
                        obj.CastShadow = false
                        obj.Material = Enum.Material.Plastic
                        obj.Reflectance = 0
                        obj.TopSurface = Enum.SurfaceType.Smooth
                        obj.BottomSurface = Enum.SurfaceType.Smooth
                        obj.CanCollide = obj.CanCollide
                        processed = processed + 1
                    end

                    if obj:IsA("Decal") or obj:IsA("Texture") or obj:IsA("SurfaceGui") then
                        if not shouldPreserve(objName, parentName) then
                            obj:Destroy()
                            processed = processed + 1
                        end
                    end

                    if obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") or 
                       obj:IsA("Explosion") or obj:IsA("ClickDetector") then
                        obj:Destroy()
                        processed = processed + 1
                    elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
                        if not shouldPreserve(objName, parentName) then
                            obj:Destroy()
                            processed = processed + 1
                        end
                    end

                    if obj:IsA("MeshPart") then
                        obj.RenderFidelity = Enum.RenderFidelity.Performance
                        obj.CollisionFidelity = Enum.CollisionFidelity.Box
                        processed = processed + 1
                    end

                    if obj:IsA("UnionOperation") then
                        obj.RenderFidelity = Enum.RenderFidelity.Performance
                        obj.CollisionFidelity = Enum.CollisionFidelity.Box
                        processed = processed + 1
                    end

                    if obj:IsA("SpotLight") or obj:IsA("PointLight") or obj:IsA("SurfaceLight") then
                        obj:Destroy()
                        processed = processed + 1
                    end

                    if obj:IsA("Sound") then
                        if obj.Name:lower():find("music") or obj.Name:lower():find("ambient") or 
                           obj.Name:lower():find("background") or obj.Volume > 0.5 then
                            obj.Volume = 0
                            obj:Stop()
                            processed = processed + 1
                        end
                    end
                    
                    wait()
                end
                
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
            end)
        end
    end)
end

local function intelligentInputOptimization()
    spawn(function()
        local lastInputTime = tick()
        
        while optimizerActive and wait(0.05) do
            silentExecute(function()
                UserInputService.MouseDeltaSensitivity = 1
                UserInputService.MouseIconEnabled = true
                
                if tick() - lastInputTime > 0.1 then
                    local mouse = player:GetMouse()
                    if mouse and mouse.Icon ~= "" then
                        mouse.Icon = "rbxasset://textures/Cursors/KeyboardMouse/ArrowCursor.png"
                    end
                    lastInputTime = tick()
                end
            end)
        end
    end)
end

local function smartNetworkOptimization()
    spawn(function()
        local pingHistory = {}
        local networkOptimized = false
        
        while optimizerActive and wait(15) do
            silentExecute(function()
                local currentPing = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
                table.insert(pingHistory, currentPing)
                
                if #pingHistory > 5 then
                    table.remove(pingHistory, 1)
                end
                
                local avgPing = 0
                for _, ping in pairs(pingHistory) do
                    avgPing = avgPing + ping
                end
                avgPing = avgPing / #pingHistory
                
                if avgPing > 150 and not networkOptimized then
                    for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
                        if obj:IsA("RemoteEvent") and obj.Name:lower():find("heartbeat") then
                            obj:Destroy()
                        end
                    end
                    networkOptimized = true
                end
            end)
        end
    end)
end

local function advancedMemoryManager()
    spawn(function()
        local memoryThreshold = 600
        local lastCleanup = 0
        
        while optimizerActive and wait(45) do
            silentExecute(function()
                local currentMemory = Stats:GetTotalMemoryUsageMb()
                
                if currentMemory > memoryThreshold and tick() - lastCleanup > 30 then
                    collectgarbage("collect")
                    
                    for _, service in pairs({game:GetService("Debris"), game:GetService("InsertService")}) do
                        for _, obj in pairs(service:GetChildren()) do
                            if obj and obj.Parent then
                                obj:Destroy()
                            end
                        end
                    end
                    
                    if ContentProvider then
                        for _, cache in pairs(ContentProvider:GetChildren()) do
                            if cache.ClassName:lower():find("cache") then
                                pcall(function()
                                    cache:ClearAllChildren()
                                end)
                            end
                        end
                    end
                    
                    lastCleanup = tick()
                end
            end)
        end
    end)
end

local function dynamicFPSBooster()
    spawn(function()
        local fpsHistory = {}
        local targetFPS = 60
        
        while optimizerActive and wait(1) do
            silentExecute(function()
                local currentFPS = 1 / RunService.Heartbeat:Wait()
                table.insert(fpsHistory, currentFPS)
                
                if #fpsHistory > 10 then
                    table.remove(fpsHistory, 1)
                end
                
                local avgFPS = 0
                for _, fps in pairs(fpsHistory) do
                    avgFPS = avgFPS + fps
                end
                avgFPS = avgFPS / #fpsHistory
                
                if avgFPS < targetFPS and not fpsBoostActive then
                    fpsBoostActive = true
                    
                    for _, obj in pairs(Workspace:GetDescendants()) do
                        if obj:IsA("Decal") or obj:IsA("Texture") then
                            obj.Transparency = 1
                        elseif obj:IsA("ParticleEmitter") then
                            obj.Enabled = false
                        elseif obj:IsA("Fire") or obj:IsA("Smoke") then
                            obj.Enabled = false
                        end
                    end
                    
                    wait(5)
                    fpsBoostActive = false
                end
            end)
        end
    end)
end

local function continuousOptimization()
    Workspace.DescendantAdded:Connect(function(obj)
        wait(generateRandomDelay())
        
        silentExecute(function()
            if obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") or obj:IsA("Explosion") then
                obj:Destroy()
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
                if not (obj.Parent and obj.Parent.Name:lower():find("gun")) then
                    obj:Destroy()
                end
            elseif obj:IsA("Decal") or obj:IsA("Texture") then
                if not (obj.Name:lower():find("sight") or obj.Name:lower():find("crosshair")) then
                    wait(0.2)
                    obj:Destroy()
                end
            elseif obj:IsA("BasePart") then
                obj.CastShadow = false
                obj.Material = Enum.Material.Plastic
                obj.Reflectance = 0
            elseif obj:IsA("Sound") and obj.Volume > 0.3 then
                if obj.Name:lower():find("music") or obj.Name:lower():find("ambient") then
                    obj.Volume = 0
                    obj:Stop()
                end
            end
        end)
    end)
end

local function stealthCleanup()
    game.Players.PlayerRemoving:Connect(function(p)
        if p == player then
            optimizerActive = false
            
            pcall(function()
                for _, connection in pairs(getgc()) do
                    if type(connection) == "RBXScriptConnection" then
                        connection:Disconnect()
                    end
                end
            end)
            
            collectgarbage("collect")
        end
    end)
end

local function initializeUltraOptimizer()
    wait(math.random(100, 300) / 100)
    
    advancedBypass()
    wait(generateRandomDelay())
    
    ultraLightingOptimization()
    wait(generateRandomDelay())
    
    hyperRenderOptimization()
    wait(generateRandomDelay())
    
    aggressiveWorkspaceCleanup()
    wait(generateRandomDelay())
    
    intelligentInputOptimization()
    wait(generateRandomDelay())
    
    smartNetworkOptimization()
    wait(generateRandomDelay())
    
    advancedMemoryManager()
    wait(generateRandomDelay())
    
    dynamicFPSBooster()
    wait(generateRandomDelay())
    
    continuousOptimization()
    wait(generateRandomDelay())
    
    stealthCleanup()
    
    collectgarbage("collect")
    lastOptimization = tick()
end

spawn(initializeUltraOptimizer)
