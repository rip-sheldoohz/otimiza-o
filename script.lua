-- FPS BOOSTER FLASH OTIMIZADO
-- Performance máxima para Roblox

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting") 
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local player = Players.LocalPlayer
local conexoes = {}
local ativo = true

-- Cache para otimização
local materiaisCache = {}
local processados = {}

-- Função segura otimizada
local function safe(func, ...)
    local success, result = pcall(func, ...)
    return success and result
end

-- Configurações gráficas extremas
local function configurarGraficos()
    safe(function()
        -- UserGameSettings otimizadas
        UserGameSettings.SavedQualityLevel = 1
        UserGameSettings.QualityLevel = 1
        UserGameSettings.GraphicsQualityLevel = 1
        UserGameSettings.MasterVolume = 0.05
        
        -- Lighting otimizada
        Lighting.Technology = Enum.Technology.Compatibility
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        Lighting.FogStart = 0
        Lighting.Brightness = 0
        Lighting.ColorShift_Bottom = Color3.new(0,0,0)
        Lighting.ColorShift_Top = Color3.new(0,0,0)
        Lighting.OutdoorAmbient = Color3.new(1,1,1)
        Lighting.Ambient = Color3.new(1,1,1)
        
        -- Som otimizado  
        SoundService.AmbientReverb = Enum.ReverbType.NoReverb
        SoundService.DistanceFactor = 0.1
        SoundService.DopplerScale = 0
        SoundService.RolloffScale = 0
    end)
end

-- Remover efeitos visuais
local function limparEfeitos()
    safe(function()
        for _, v in ipairs(Lighting:GetChildren()) do
            if v:IsA("PostEffect") or v:IsA("Atmosphere") or v:IsA("Sky") or v:IsA("Clouds") then
                v:Destroy()
            end
        end
    end)
end

-- Otimizar objeto individual
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
        return
        
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

-- Otimização em lote super rápida
local function otimizacaoLote()
    safe(function()
        local objetos = Workspace:GetDescendants()
        local total = #objetos
        local lote = 50 -- Processar 50 por vez
        
        for i = 1, total, lote do
            for j = i, math.min(i + lote - 1, total) do
                otimizarObjeto(objetos[j])
            end
            
            if i % 500 == 0 then
                RunService.Heartbeat:Wait()
            end
        end
    end)
end

-- Monitoramento contínuo ultra leve
local function monitoramentoContinuo()
    conexoes[#conexoes + 1] = Workspace.DescendantAdded:Connect(function(obj)
        task.wait(0.01)
        if ativo then
            otimizarObjeto(obj)
        end
    end)
    
    -- Limpeza periódica super leve
    conexoes[#conexoes + 1] = RunService.Heartbeat:Connect(function()
        if not ativo then return end
        
        -- Processar apenas alguns objetos por frame
        local count = 0
        for _, obj in ipairs(Workspace:GetChildren()) do
            if count >= 5 then break end
            
            if obj:IsA("Model") then
                for _, part in ipairs(obj:GetChildren()) do
                    if part:IsA("BasePart") and not processados[part] then
                        otimizarObjeto(part)
                        count = count + 1
                        break
                    end
                end
            end
        end
    end)
end

-- Configurações especiais do jogador
local function configurarJogador()
    safe(function()
        if player.Character then
            for _, part in ipairs(player.Character:GetChildren()) do
                if part:IsA("Accessory") then
                    part:Destroy()
                end
            end
        end
    end)
end

-- Limpeza ao sair
local function configurarLimpeza()
    conexoes[#conexoes + 1] = Players.PlayerRemoving:Connect(function(p)
        if p == player then
            ativo = false
            for _, conexao in ipairs(conexoes) do
                if conexao then conexao:Disconnect() end
            end
        end
    end)
end

-- Inicialização super otimizada
local function inicializar()
    print("🚀 Iniciando FPS Booster Flash...")
    
    -- Executar em ordem otimizada
    configurarGraficos()
    limparEfeitos()
    configurarJogador()
    
    -- Aguardar um frame antes da otimização pesada
    RunService.Heartbeat:Wait()
    
    otimizacaoLote()
    monitoramentoContinuo()
    configurarLimpeza()
    
    print("⚡ FPS Booster ativo! Performance máxima aplicada.")
end

-- Iniciar otimização
task.spawn(inicializar)

-- Comando para reativar se necessário
_G.BoosterAtivo = function()
    return ativo
end

_G.ReativarBooster = function()
    if not ativo then
        ativo = true
        inicializar()
    end
end
