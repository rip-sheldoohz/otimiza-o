-- FPS BOOSTER CORRIGIDO
local Players = game.Players
local Lighting = game.Lighting
local Workspace = game.Workspace
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local ativo = true

-- Execução segura
local function safe(func)
    pcall(func)
end

-- Otimizar luz
local function luz()
    safe(function()
        Lighting.Technology = Enum.Technology.Compatibility
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        Lighting.Brightness = 2
        
        for i, v in pairs(Lighting:GetChildren()) do
            if v:IsA("PostEffect") then
                v:Destroy()
            end
        end
    end)
end

-- Otimizar som
local function som()
    safe(function()
        SoundService.AmbientReverb = Enum.ReverbType.NoReverb
        SoundService.DistanceFactor = 0.1
    end)
end

-- Otimizar objetos
local function objetos()
    safe(function()
        for i, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CastShadow = false
                v.Material = Enum.Material.Plastic
                v.Reflectance = 0
            elseif v:IsA("Fire") then
                v:Destroy()
            elseif v:IsA("Smoke") then
                v:Destroy()
            elseif v:IsA("ParticleEmitter") then
                v.Enabled = false
            elseif v:IsA("MeshPart") then
                v.RenderFidelity = Enum.RenderFidelity.Performance
            end
            
            if i % 100 == 0 then
                wait()
            end
        end
    end)
end

-- Monitor FPS
local function fps()
    RunService.Heartbeat:Connect(function()
        if not ativo then return end
        
        for i, v in pairs(Workspace:GetChildren()) do
            if v:IsA("Model") then
                for j, k in pairs(v:GetChildren()) do
                    if k:IsA("BasePart") then
                        k.Material = Enum.Material.Plastic
                    end
                end
            end
            
            if i > 10 then break end
        end
    end)
end

-- Limpeza contínua  
local function continua()
    Workspace.DescendantAdded:Connect(function(obj)
        wait(0.1)
        safe(function()
            if obj:IsA("Fire") then
                obj:Destroy()
            elseif obj:IsA("Smoke") then
                obj:Destroy()
            elseif obj:IsA("BasePart") then
                obj.CastShadow = false
            end
        end)
    end)
end

-- Configurações
local function config()
    safe(function()
        local settings = UserSettings():GetService("UserGameSettings")
        settings.MasterVolume = 0.1
        settings.GraphicsQualityLevel = 1
    end)
end

-- Iniciar tudo
spawn(function()
    wait(2)
    config()
    luz()
    som() 
    objetos()
    fps()
    continua()
end)

-- Limpeza ao sair
Players.PlayerRemoving:Connect(function(p)
    if p == player then
        ativo = false
    end
end)
