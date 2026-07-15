-- GHCUC EXE - Core Executor Module
-- Delta-style Roblox Script Executor

local Executor = {}
Executor.__index = Executor

-- Initialize executor
function Executor.new()
    local self = setmetatable({}, Executor)
    self.scripts = {}
    self.isRunning = false
    self.console = {}
    return self
end

-- Execute script
function Executor:execute(scriptCode)
    if not scriptCode or scriptCode == "" then
        self:log("Error: Empty script", "error")
        return false
    end
    
    self:log("Executing script...", "info")
    
    local success, result = pcall(function()
        return loadstring(scriptCode)()
    end)
    
    if success then
        self:log("Script executed successfully!", "success")
        return true
    else
        self:log("Execution error: " .. tostring(result), "error")
        return false
    end
end

-- Clear console
function Executor:clearConsole()
    self.console = {}
    self:log("Console cleared", "info")
end

-- Log message
function Executor:log(message, level)
    level = level or "info"
    local timestamp = os.date("%H:%M:%S")
    local logEntry = string.format("[%s] [%s] %s", timestamp, level:upper(), message)
    table.insert(self.console, logEntry)
    print(logEntry)
end

-- Get console history
function Executor:getConsoleHistory()
    return self.console
end

-- Create instance
return Executor