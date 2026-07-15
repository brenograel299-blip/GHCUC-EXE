-- GHCUC EXE - Roblox Library Functions
-- Utility functions for common Roblox operations

local Library = {}

-- Get player
function Library.getPlayer(name)
    if name then
        return game:GetService("Players"):FindFirstChild(name)
    end
    return game:GetService("Players").LocalPlayer
end

-- Get character
function Library.getCharacter(player)
    player = player or Library.getPlayer()
    return player and player.Character
end

-- Get humanoid
function Library.getHumanoid(character)
    character = character or Library.getCharacter()
    return character and character:FindFirstChild("Humanoid")
end

-- Teleport player
function Library.teleport(position)
    local character = Library.getCharacter()
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = CFrame.new(position)
        return true
    end
    return false
end

-- Get all players
function Library.getAllPlayers()
    return game:GetService("Players"):GetPlayers()
end

-- Remove character
function Library.removeCharacter()
    local humanoid = Library.getHumanoid()
    if humanoid then
        humanoid.Health = 0
        return true
    end
    return false
end

-- Execute on player
function Library.executeOnPlayer(playerName, func)
    local player = Library.getPlayer(playerName)
    if player then
        return pcall(func, player)
    end
    return false
end

return Library