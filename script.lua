-- ROBLOX FPS BOOSTER - VERSÃO SIMPLIFICADA E FUNCIONAL
print("Carregando otimizador...")

-- Serviços
local Players = game.Players
local Lighting = game.Lighting  
local Workspace = game.Workspace
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")

-- Player
local player = Players.LocalPlayer
local ativo = true

-- Função segura
local function executar(func)
    local ok, err = pcall(func)
    if not ok then
        warn("Erro:", err)
    end
    return ok
end

-- OTIMIZAÇÃO DE ILUMINAÇÃO
local function otimizarLuz()
    executar(function()
        Lighting.Technology = Enum.Technology.Compatibility
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        Lighting.Brightness = 2
        Lighting.ShadowSoftness = 0
        
        -- Remove efeitos
        for _, obj in pairs(Lighting:GetChildren()) do
            if obj.ClassName:find("Effect") or obj:IsA("Atmosphere") or obj:IsA("Sky") then
                obj:Destroy()
            end
        end
        
        print("✓ Iluminação otimizada")
    end)
end

-- OTIMIZAÇÃO DE SOM
local function otimizarSom()
    executar(function()
        if SoundService then
            SoundService.AmbientReverb = Enum.ReverbType.NoReverb
            SoundService.DistanceFactor = 0.1
            SoundService.DopplerScale = 0
        end
        
        print("✓ Som otimizado")
    end)
end

-- OTIMIZAÇÃO DE OBJETOS
local function otimizarObjetos()
    executar(function()
        local count = 0
        
        for _, obj in pairs(Workspace:GetDescendants()) do
            count = count + 1
            
            if obj:IsA("BasePart") then
                obj.CastShadow = false
                obj.Material = Enum.Material.Plastic
                obj.Reflectance = 0
                
            elseif obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
                obj:Destroy()
                
            elseif obj:IsA("ParticleEmitter") then
                obj.Enabled = false
                
            elseif obj:IsA("MeshPart") then
                obj.RenderFidelity = Enum.RenderFidelity.Performance
                obj.CollisionFidelity = Enum.CollisionFidelity.Box
                
            elseif obj:IsA("UnionOperation") then
                obj.RenderFidelity = Enum.RenderFidelity.Performance
                obj.CollisionFidelity = Enum.CollisionFidelity.Box
                
            elseif obj:IsA("Decal") or obj:IsA("Texture") then
                if not obj.Name:lower():find("face") then
                    obj.Transparency = 1
                end
                
            elseif obj:IsA("Sound") then
                if obj.Name:lower():find("music") or obj.Name:lower():find("ambient") then
                    obj.Volume = 0
                    obj:Stop()
                end
            end
            
            -- Pausa a cada 50 objetos
            if count % 50 == 0 then
                wait()
            end
        end
        
        print("✓ Objetos otimizados:", count)
    end)
end

-- OTIMIZAÇÃO DE TERRENO
local function otimizarTerreno()
    executar(function()
        local terrain = Workspace:FindFirstChild("Terrain")
        if terrain then
            terrain.WaterWaveSize = 0
            terrain.WaterWaveSpeed = 0
            terrain.WaterReflectance = 0
            terrain.WaterTransparency = 1
            print("✓ Terreno otimizado")
        end
    end)
end

-- MONITOR DE FPS
local function monitorFPS()
    local fps = 0
    local lastTime = tick()
    
    RunService.Heartbeat:Connect(function()
        if not ativo then return end
        
        local currentTime = tick()
        fps = 1 / (currentTime - lastTime)
        lastTime = currentTime
        
        -- Se FPS muito baixo, otimiza mais
        if fps < 30 then
            for _, obj in pairs(Workspace:GetChildren()) do
                if obj:IsA("Model") and #obj:GetChildren() > 20 then
                    for _, part in pairs(obj:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.Material = Enum.Material.Plastic
                            part.CastShadow = false
                        end
                    end
                    wait()
                    break
                end
            end
        end
    end)
end

-- LIMPEZA CONTÍNUA
local function limpezaContinua()
    Workspace.DescendantAdded:Connect(function(obj)
        if not ativo then return end
        
        wait(0.1)
        
        executar(function()
            if obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
                obj:Destroy()
            elseif obj:IsA("ParticleEmitter") then
                obj.Enabled = false
            elseif obj:IsA("BasePart") then
                obj.CastShadow = false
                obj.Material = Enum.Material.Plastic
            end
        end)
    end)
end

-- LIMPEZA DE MEMÓRIA
local function limparMemoria()
    spawn(function()
        while ativo do
            wait(60) -- A cada 1 minuto
            collectgarbage("collect")
            print("✓ Memória limpa")
        end
    end)
end

-- CONFIGURAÇÕES DE QUALIDADE
local function configurarQualidade()
    executar(function()
        local settings = UserSettings():GetService("UserGameSettings")
        settings.MasterVolume = 0.1
        settings.GraphicsQualityLevel = 1
        settings.SavedQualityLevel = 1
        print("✓ Qualidade configurada")
    end)
end

-- INICIALIZAÇÃO
local function iniciar()
    print("🚀 Iniciando otimizador FPS...")
    
    wait(2) -- Aguarda carregar
    
    -- Executa otimizações
    configurarQualidade()
    wait(0.5)
    
    otimizarLuz()
    wait(0.5)
    
    otimizarSom()
    wait(0.5)
    
    otimizarObjetos()
    wait(1)
    
    otimizarTerreno()
    wait(0.5)
    
    -- Inicia monitoramentos
    monitorFPS()
    limpezaContinua()
    limparMemoria()
    
    print("✅ Otimizador ativo! FPS deve melhorar em alguns segundos.")
end

-- LIMPEZA AO SAIR
Players.PlayerRemoving:Connect(function(p)
    if p == player then
        ativo = false
        collectgarbage("collect")
        print("Otimizador desativado")
    end
end)

-- INICIA O SCRIPT
spawn(iniciar)
