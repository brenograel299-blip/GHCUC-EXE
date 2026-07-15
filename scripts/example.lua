-- GHCUC EXE - Example Scripts
-- Copy and paste these into the executor

-- Example 1: Print message
print("Hello from GHCUC EXE!")

-- Example 2: Get player info
local player = game:GetService("Players").LocalPlayer
print("Player: " .. player.Name)
print("UserId: " .. player.UserId)

-- Example 3: Simple health modification
-- Uncomment to use:
-- local humanoid = player.Character:FindFirstChild("Humanoid")
-- if humanoid then
--     humanoid.MaxHealth = 100
--     humanoid.Health = 100
-- end

-- Example 4: List all players
local players = game:GetService("Players"):GetPlayers()
for _, p in pairs(players) do
    print("- " .. p.Name)
end

-- Example 5: Teleport (modify position as needed)
-- local targetPos = Vector3.new(0, 50, 0)
-- if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
--     player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPos)
-- end