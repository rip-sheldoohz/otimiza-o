-- Serviços do Roblox
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
local StarterGui = game:GetService("StarterGui")

-- Variáveis globais
local player = Players.LocalPlayer
local optimizerActive = true
local lastOptimization = 0
local fpsBoostActive = false

-- Conexões para limpeza posterior
local connections = {}

-- Função para execução segura
local function safeExecute(func, errorHandler)
    local success, result = pcall(func)
    if not success then
        if errorHandler then
            pcall(errorHandler, result)
        end
        warn("Erro no otimizador:", result)
    end
    return success, result
end

-- Função para delay aleatório
local function randomDelay()
    return math.random(5, 15) / 100 -- 0.05 a 0.15 segundos
end

-- Otimização de iluminação
local function optimizeLighting()
    safeExecute(function()
        -- Configurações básicas de iluminação
        Lighting.Technology = Enum.Technology.Compatibility
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        Lighting.FogStart = 0
        Lighting.Brightness = 2
        Lighting.ShadowSoftness = 0
        
        -- Remove efeitos de pós-processamento
        local effectTypes = {
            "PostEffect", "BlurEffect", "SunRaysEffect", 
            "ColorCorrectionEffect", "BloomEffect", 
            "DepthOfFieldEffect", "Atmosphere"
        }
        
        for _, child in pairs(Lighting:GetChildren()) do
            for _, effectType in pairs(effectTypes) do
                if child:IsA(effectType) then
                    child:Destroy()
                    break
                end
            end
        end
    end)
end

-- Otimização de renderização
local function optimizeRendering()
    safeExecute(function()
        local settings = UserSettings():GetService("UserGameSettings")
        
        -- Configurações de qualidade gráfica
        settings.MasterVolume = 0.1
        settings.GraphicsQualityLevel = 1
        settings.SavedQualityLevel = 1
        
        -- Configurações de som
        if SoundService then
            SoundService.AmbientReverb = Enum.ReverbType.NoReverb
            SoundService.DistanceFactor = 0.1
            SoundService.DopplerScale = 0
            SoundService.RolloffScale = 0.1
        end
    end)
end

-- Otimização do workspace
local function optimizeWorkspace()
    safeExecute(function()
        local processed = 0
        local maxProcess = 50 -- Limita processamento por ciclo
        
        for _, obj in pairs(Workspace:GetDescendants()) do
            if processed >= maxProcess then break end
            
            if obj:IsA("BasePart") then
                obj.CastShadow = false
                obj.Material = Enum.Material.Plastic
                obj.Reflectance = 0
                obj.TopSurface = Enum.SurfaceType.Smooth
                obj.BottomSurface = Enum.SurfaceType.Smooth
                processed = processed + 1
            elseif obj:IsA("MeshPart") then
                obj.RenderFidelity = Enum.RenderFidelity.Performance
                obj.CollisionFidelity = Enum.CollisionFidelity.Box
                processed = processed + 1
            elseif obj:IsA("UnionOperation") then
                obj.RenderFidelity = Enum.RenderFidelity.Performance
                obj.CollisionFidelity = Enum.CollisionFidelity.Box
                processed = processed + 1
            elseif obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
                obj:Destroy()
                processed = processed + 1
            elseif obj:IsA("SpotLight") or obj:IsA("PointLight") or obj:IsA("SurfaceLight") then
                if obj.Brightness > 1 then
                    obj.Brightness = 0.5
                end
                processed = processed + 1
            end
            
            -- Pequena pausa para evitar lag
            if processed % 10 == 0 then
                wait()
            end
        end
        
        -- Otimiza terreno se existir
        if Workspace:FindFirstChild("Terrain") then
            local terrain = Workspace.Terrain
            terrain.WaterWaveSize = 0
            terrain.WaterWaveSpeed = 0
            terrain.WaterReflectance = 0
            terrain.WaterTransparency = 1
        end
    end)
end

-- Gerenciador de memória
local function manageMemory()
    safeExecute(function()
        -- Coleta lixo
        collectgarbage("collect")
        
        -- Limpa cache de conteúdo se possível
        if ContentProvider then
            for _, cache in pairs(ContentProvider:GetChildren()) do
                if cache.Name:lower():find("cache") then
                    safeExecute(function()
                        for _, item in pairs(cache:GetChildren()) do
                            if #item:GetChildren() == 0 then
                                item:Destroy()
                            end
                        end
                    end)
                end
            end
        end
    end)
end

-- Monitor de FPS dinâmico
local function dynamicFPSMonitor()
    local fpsHistory = {}
    local targetFPS = 45 -- Meta mais realista
    
    local function updateFPS()
        if not optimizerActive then return end
        
        safeExecute(function()
            local currentFPS = math.min(60, 1 / RunService.Heartbeat:Wait())
            table.insert(fpsHistory, currentFPS)
            
            if #fpsHistory > 5 then
                table.remove(fpsHistory, 1)
            end
            
            local avgFPS = 0
            for _, fps in pairs(fpsHistory) do
                avgFPS = avgFPS + fps
            end
            avgFPS = avgFPS / #fpsHistory
            
            -- Se FPS estiver muito baixo, aplica otimizações adicionais
            if avgFPS < targetFPS and not fpsBoostActive then
                fpsBoostActive = true
                
                -- Reduz qualidade temporariamente
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("ParticleEmitter") and obj.Enabled then
                        obj.Enabled = false
                        wait(0.01)
                    elseif obj:IsA("Trail") or obj:IsA("Beam") then
                        obj.Enabled = false
                        wait(0.01)
                    end
                end
                
                -- Reset após alguns segundos
                spawn(function()
                    wait(10)
                    fpsBoostActive = false
                end)
            end
        end)
    end
    
    local fpsConnection = RunService.Heartbeat:Connect(function()
        spawn(updateFPS)
    end)
    table.insert(connections, fpsConnection)
end

-- Monitoramento contínuo de novos objetos
local function setupContinuousOptimization()
    local function optimizeNewObject(obj)
        wait(randomDelay())
        
        safeExecute(function()
            if obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
                obj:Destroy()
            elseif obj:IsA("ParticleEmitter") then
                -- Preserva efeitos de armas
                if not (obj.Parent and obj.Parent.Name:lower():find("gun") or 
                        obj.Parent and obj.Parent.Name:lower():find("weapon")) then
                    obj.Enabled = false
                end
            elseif obj:IsA("BasePart") then
                obj.CastShadow = false
                obj.Material = Enum.Material.Plastic
                obj.Reflectance = 0
            elseif obj:IsA("Sound") then
                if obj.Name:lower():find("music") or 
                   obj.Name:lower():find("ambient") or 
                   obj.Name:lower():find("background") then
                    if obj.Volume > 0.2 then
                        obj.Volume = 0.1
                    end
                end
            end
        end)
    end
    
    local newObjectConnection = Workspace.DescendantAdded:Connect(optimizeNewObject)
    table.insert(connections, newObjectConnection)
end

-- Limpeza automática de recursos
local function setupAutoCleanup()
    local function periodicCleanup()
        while optimizerActive do
            wait(30) -- Executa a cada 30 segundos
            
            safeExecute(function()
                manageMemory()
                
                -- Remove objetos desnecessários
                local debris = game:GetService("Debris")
                for _, obj in pairs(debris:GetChildren()) do
                    if obj and obj.Parent then
                        obj:Destroy()
                    end
                end
            end)
        end
    end
    
    spawn(periodicCleanup)
end

-- Limpeza ao sair do jogo
local function setupExitCleanup()
    local exitConnection = game.Players.PlayerRemoving:Connect(function(p)
        if p == player then
            optimizerActive = false
            
            -- Desconecta todas as conexões
            for _, connection in pairs(connections) do
                if connection and connection.Connected then
                    connection:Disconnect()
                end
            end
            
            collectgarbage("collect")
        end
    end)
    table.insert(connections, exitConnection)
end

-- Função principal de inicialização
local function initializeOptimizer()
    -- Aguarda um pouco para o jogo carregar
    wait(2)
    
    print("Iniciando otimizador...")
    
    -- Executa otimizações iniciais
    optimizeLighting()
    wait(randomDelay())
    
    optimizeRendering()
    wait(randomDelay())
    
    optimizeWorkspace()
    wait(randomDelay())
    
    -- Inicia monitoramentos contínuos
    dynamicFPSMonitor()
    setupContinuousOptimization()
    setupAutoCleanup()
    setupExitCleanup()
    
    -- Executa limpeza inicial de memória
    manageMemory()
    
    lastOptimization = tick()
    print("Otimizador inicializado com sucesso!")
end

-- Inicia o otimizador
spawn(initializeOptimizer)
