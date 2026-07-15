-- GHCUC EXE - User Interface Module
-- Delta-style UI for script executor

local UI = {}
UI.__index = UI

-- Create UI
function UI.new()
    local self = setmetatable({}, UI)
    self.visible = false
    self.elements = {}
    return self
end

-- Create main window
function UI:createWindow()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "GHCUC_EXE"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game:GetService("CoreGui")
    
    -- Main frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 500, 0, 600)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -300)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    -- Title bar
    local titleBar = Instance.new("TextLabel")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    titleBar.BorderSizePixel = 0
    titleBar.Text = "GHCUC EXE - Delta Executor"
    titleBar.TextColor3 = Color3.fromRGB(255, 100, 0)
    titleBar.TextSize = 16
    titleBar.Font = Enum.Font.GothamBold
    titleBar.Parent = mainFrame
    
    -- Script input
    local inputBox = Instance.new("TextBox")
    inputBox.Name = "ScriptInput"
    inputBox.Size = UDim2.new(1, -20, 0, 300)
    inputBox.Position = UDim2.new(0, 10, 0, 50)
    inputBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    inputBox.BorderSizePixel = 0
    inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    inputBox.TextSize = 12
    inputBox.Font = Enum.Font.Code
    inputBox.MultiLine = true
    inputBox.ClearTextOnFocus = false
    inputBox.PlaceholderText = "Enter your Lua script here..."
    inputBox.Parent = mainFrame
    
    -- Execute button
    local executeBtn = Instance.new("TextButton")
    executeBtn.Name = "ExecuteButton"
    executeBtn.Size = UDim2.new(0, 100, 0, 35)
    executeBtn.Position = UDim2.new(0, 10, 0, 360)
    executeBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
    executeBtn.BorderSizePixel = 0
    executeBtn.Text = "Execute"
    executeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    executeBtn.TextSize = 14
    executeBtn.Font = Enum.Font.GothamBold
    executeBtn.Parent = mainFrame
    
    -- Clear button
    local clearBtn = Instance.new("TextButton")
    clearBtn.Name = "ClearButton"
    clearBtn.Size = UDim2.new(0, 100, 0, 35)
    clearBtn.Position = UDim2.new(0, 120, 0, 360)
    clearBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    clearBtn.BorderSizePixel = 0
    clearBtn.Text = "Clear"
    clearBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    clearBtn.TextSize = 14
    clearBtn.Font = Enum.Font.GothamBold
    clearBtn.Parent = mainFrame
    
    -- Console output
    local consoleBox = Instance.new("TextLabel")
    consoleBox.Name = "Console"
    consoleBox.Size = UDim2.new(1, -20, 0, 160)
    consoleBox.Position = UDim2.new(0, 10, 0, 405)
    consoleBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    consoleBox.BorderSizePixel = 0
    consoleBox.TextColor3 = Color3.fromRGB(100, 255, 100)
    consoleBox.TextSize = 10
    consoleBox.Font = Enum.Font.Code
    consoleBox.TextWrapped = true
    consoleBox.TextXAlignment = Enum.TextXAlignment.Left
    consoleBox.TextYAlignment = Enum.TextYAlignment.Top
    consoleBox.Text = "[System] GHCUC EXE Ready"
    consoleBox.Parent = mainFrame
    
    self.elements = {
        mainFrame = mainFrame,
        inputBox = inputBox,
        executeBtn = executeBtn,
        clearBtn = clearBtn,
        consoleBox = consoleBox
    }
    
    self.visible = true
    return mainFrame
end

-- Toggle UI visibility
function UI:toggle()
    if self.elements.mainFrame then
        self.elements.mainFrame.Visible = not self.elements.mainFrame.Visible
        self.visible = self.elements.mainFrame.Visible
    end
end

-- Update console
function UI:updateConsole(text)
    if self.elements.consoleBox then
        self.elements.consoleBox.Text = text
    end
end

return UI