local Players = game:GetService("Players")
local player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local saved = nil

local function pivot()
    local character = player.Character
    return character and character:GetPivot()
end

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.Z then
        local p = pivot()
        if p then saved = p; print("saved waypoint") end
    elseif input.KeyCode == Enum.KeyCode.X then
        local p = pivot()
        if p and saved then p.Position = saved.Position; print("returned to waypoint") end
    end
end)

print("Z saves, X returns")