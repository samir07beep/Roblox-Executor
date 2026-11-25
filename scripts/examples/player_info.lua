local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

print(("local: %s | health %d/%d | speed %d"):format(localPlayer.Name, humanoid.Health, humanoid.MaxHealth, humanoid.WalkSpeed))
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= localPlayer then
        local ok, distance = pcall(function()
            return math.floor((player.Character and player.Character:GetPivot().Position - character:GetPivot().Position).Magnitude)
        end)
        print(("%s | %s"):format(player.Name, ok and (tostring(distance) .. " studs") or "no character"))
    end
end