-- ZHANKO HUB: AUTO FARM BOXES
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

local function collectBoxes()
    -- Имя объекта коробки может отличаться, 
    -- проверь в Explorer, как они называются (обычно это "MysteryBox" или "Box")
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name == "MysteryBox" then -- Замени "MysteryBox" на точное имя из Explorer
            if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                lp.Character.HumanoidRootPart.CFrame = obj.CFrame
                task.wait(0.5) -- Задержка для сбора
            end
        end
    end
end

-- Запуск сбора
collectBoxes()
print("Сбор коробок завершен!")

