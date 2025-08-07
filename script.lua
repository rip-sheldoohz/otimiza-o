local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local SoundService = game:GetService("SoundService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

local function silentExecute(func)
    local success, error = pcall(func)
    if not success then
        return false
    end
    return true
end

local function bypassDetection()
    local mt = getrawmetatable(game)
    local oldNamecall = mt.__namecall
    
    setreadonly(mt, false)
    
    mt.__namecall = function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        
        if method == "FireServer" or method == "InvokeServer" then
            if string.find(tostring(self), "Anti") or string.find(tostring(self), "Detect") or 
               string.find(tostring(self), "Security") or string.find(tostring(self), "Check") then
                return
            end
        end
        
        return oldNamecall(self, ...)
    end
    
    setreadonly(mt, true)
end

local function advancedOptimization()
    silentExecute(function()
        Lighting.Technology = Enum.Technology.Compatibility
        Lighting.GlobalShadows = false
        Lighting.FogEnd = math.huge
        Lighting.FogStart = math.huge
        Lighting.Brightness = 5
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.ColorShift_Bottom = Color3.new(0, 0, 0)
        Lighting.ColorShift_Top = Color3.new(0, 0, 0)
        Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
        Lighting.ClockTime = 12
        Lighting.GeographicLatitude = 0
        Lighting.ExposureCompensation = 0
        Lighting.ShadowSoftness = 0
        
        for _, effect in pairs(Lighting:GetChildren()) do
            if effect:IsA("PostEffect") or effect:IsA("BlurEffect") or effect:IsA("SunRaysEffect") or 
               effect:IsA("ColorCorrectionEffect") or effect:IsA("BloomEffect") or 
               effect:IsA("DepthOfFieldEffect") or effect:IsA("Atmosphere") or
               effect:IsA("Sky") or effect:IsA("Clouds") then
                effect:Destroy()
            end
        end
    end)
    
    silentExecute(function()
        local settings = UserSettings():GetService("UserGameSettings")
        settings.MasterVolume = 0.05
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
            SoundService.DistanceFactor = 0.1
            SoundService.DopplerScale = 0
            SoundService.RolloffScale = 0.1
        end
    end)
end

local function removeVisualClutter()
    spawn(function()
        while wait(5) do
            silentExecute(function()
                for _, obj in pairs(Workspace:GetDescendants()) do
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
                    end

                    if obj:IsA("Decal") or obj:IsA("Texture") then
                        if not (obj.Name:lower():find("crosshair") or obj.Name:lower():find("sight") or
                                obj.Name:lower():find("scope") or obj.Name:lower():find("hud") or
                                obj.Name:lower():find("gui") or obj.Name:lower():find("ui")) then
                            obj:Destroy()
                        end
                    end

                    if obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") or obj:IsA("Explosion") then
                        obj:Destroy()
                    elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
                        if not (obj.Parent and (obj.Parent.Name:lower():find("gun") or 
                                obj.Parent.Name:lower():find("weapon") or 
                                obj.Parent.Name:lower():find("tool") or
                                obj.Parent.Name:lower():find("sword"))) then
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
                           obj.Name:lower():find("background") or obj.Name:lower():find("wind") or
                           obj.Name:lower():find("rain") or obj.Name:lower():find("weather") then
                            obj.Volume = 0
                            obj:Stop()
                            obj:Destroy()
                        end
                    end
                end
                
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
                end
                
                for _, effect in pairs(Lighting:GetChildren()) do
                    if effect:IsA("PostEffect") or effect:IsA("Sky") or effect:IsA("Atmosphere") then
                        effect:Destroy()
                    end
                end
                
                collectgarbage("collect")
            end)
        end
    end)
end

local function optimizeInput()
    spawn(function()
        while wait(0.1) do
            silentExecute(function()
                if UserInputService.MouseDeltaSensitivity ~= 1 then
                    UserInputService.MouseDeltaSensitivity = 1
                end
                
                local mouse = player:GetMouse()
                if mouse then
                    mouse.Icon = "rbxasset://textures/Cursors/KeyboardMouse/ArrowCursor.png"
                end
            end)
        end
    end)
end

local function continuousOptimization()
    Workspace.DescendantAdded:Connect(function(obj)
        silentExecute(function()
            wait(0.1)
            
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
                        obj.Name:lower():find("scope") or obj.Name:lower():find("hud") or
                        obj.Name:lower():find("gui")) then
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
end

local function networkOptimization()
    spawn(function()
        while wait(30) do
            silentExecute(function()
                if Stats.Network.ServerStatsItem["Data Ping"]:GetValue() > 200 then
                    for _, obj in pairs(Workspace:GetDescendants()) do
                        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                            if obj.Name:lower():find("heartbeat") or obj.Name:lower():find("ping") then
                                pcall(function()
                                    obj:Destroy()
                                end)
                            end
                        end
                    end
                end
            end)
        end
    end)
end

local function memoryOptimization()
    spawn(function()
        while wait(60) do
            silentExecute(function()
                if Stats:GetTotalMemoryUsageMb() > 800 then
                    collectgarbage("collect")
                    
                    for _, obj in pairs(game:GetService("Debris"):GetChildren()) do
                        if obj then
                            obj:Destroy()
                        end
                    end
                    
                    for _, cache in pairs(game:GetService("ContentProvider"):GetChildren()) do
                        if cache.Name:lower():find("cache") then
                            cache:ClearAllChildren()
                        end
                    end
                end
            end)
        end
    end)
end

local function initializeOptimizer()
    wait(1)
    
    bypassDetection()
    wait(0.5)
    
    advancedOptimization()
    wait(0.5)
    
    removeVisualClutter()
    wait(0.3)
    
    optimizeInput()
    wait(0.3)
    
    continuousOptimization()
    wait(0.2)
    
    networkOptimization()
    wait(0.2)
    
    memoryOptimization()
    
    wait(2)
    collectgarbage("collect")
end

spawn(initializeOptimizer)

local connection
connection = game.Players.PlayerRemoving:Connect(function(p)
    if p == player then
        connection:Disconnect()
        for _, thread in pairs(getgc()) do
            if type(thread) == "thread" then
                pcall(function()
                    task.cancel(thread)
                end)
            end
        end
    end
end)
