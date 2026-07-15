-- GHCUC EXE - Main Entry Point
-- Delta-style Roblox Executor

local Executor = require(script.Parent.core.executor)
local UI = require(script.Parent.ui.interface)
local Library = require(script.Parent.utils.library)

-- Initialize executor
local executor = Executor.new()
local ui = UI.new()

-- Create UI
ui:createWindow()

-- Connect execute button
ui.elements.executeBtn.MouseButton1Click:Connect(function()
    local scriptCode = ui.elements.inputBox.Text
    executor:execute(scriptCode)
    
    -- Update console
    local consoleText = table.concat(executor:getConsoleHistory(), "\n")
    ui:updateConsole(consoleText)
end)

-- Connect clear button
ui.elements.clearBtn.MouseButton1Click:Connect(function()
    ui.elements.inputBox.Text = ""
    executor:clearConsole()
    ui:updateConsole("[System] Console cleared")
end)

-- Log startup
executor:log("GHCUC EXE - Delta Executor Loaded", "success")
executor:log("Ready to execute scripts", "info")

-- Update console on startup
ui:updateConsole(table.concat(executor:getConsoleHistory(), "\n"))

print("=== GHCUC EXE - Delta Executor ===")
print("Type your Lua scripts in the executor window")
print("Click Execute to run the script")
print("====================================")