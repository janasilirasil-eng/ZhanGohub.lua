-- Вставь это в секцию FightContainer
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera

local aimActive = false
local fovRadius = 150 -- Радиус круга
local circle = Drawing.new("Circle")
circle.Color = Color3.fromRGB(255, 255, 255)
circle.Thickness = 1
circle.Filled = false
circle.Visible = false
circle.Radius = fovRadius

local arrow = Drawing.new("Triangle")
arrow.Thickness = 2
arrow.Filled = true
arrow.Color = Color3.fromRGB(255, 0, 0)
arrow.Visible = false

local SuperAimBtn = createBtn("Super Aimbot [OFF]", FightContainer)
SuperAimBtn.MouseButton1Click:Connect(function()
    aimActive = not aimActive
    SuperAimBtn.Text = aimActive and "Super Aimbot [ON]" or "Super Aimbot [OFF]"
    circle.Visible = aimActive
    arrow.Visible = aimActive
end)

RunService.RenderStepped:Connect(function()
    if not aimActive then return end
    
    local mousePos = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    circle.Position = mousePos
    
    local closest = nil
    local maxDist = fovRadius
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local pos, onScreen = Camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
            if onScreen then
                local dist = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                if dist < maxDist then
                    closest = p.Character.HumanoidRootPart
                    maxDist = dist
                end
            end
        end
    end
    
    if closest then
        -- Аимбот
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, closest.Position)
        
        -- Логика стрелки
        local screenPos = Camera:WorldToViewportPoint(closest.Position)
        arrow.PointA = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2 - 50)
        arrow.PointB = Vector2.new(Camera.ViewportSize.X/2 - 10, Camera.ViewportSize.Y/2 - 70)
        arrow.PointC = Vector2.new(Camera.ViewportSize.X/2 + 10, Camera.ViewportSize.Y/2 - 70)
    end
end)

