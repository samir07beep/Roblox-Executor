local camera = workspace.CurrentCamera
local originalFov = camera.FieldOfView

camera.FieldOfView = 90
print("fov set to 90 (was " .. tostring(originalFov) .. ")")

task.delay(20, function()
    camera.FieldOfView = originalFov
    print("fov restored")
end)