-- GHCUC EXE - Joke Generator UI Module
-- Interface for displaying jokes

local JokeUI = {}
JokeUI.__index = JokeUI

-- Create UI
function JokeUI.new()
    local self = setmetatable({}, JokeUI)
    self.visible = false
    self.elements = {}
    return self
end

-- Create joke window
function JokeUI:createJokeWindow()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "JokeGenerator_UI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game:GetService("CoreGui")
    
    -- Main frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "JokeFrame"
    mainFrame.Size = UDim2.new(0, 600, 0, 500)
    mainFrame.Position = UDim2.new(0.5, -300, 0.5, -250)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    -- Title bar
    local titleBar = Instance.new("TextLabel")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    titleBar.BorderSizePixel = 0
    titleBar.Text = "🎭 GHCUC Joke Generator"
    titleBar.TextColor3 = Color3.fromRGB(255, 150, 0)
    titleBar.TextSize = 18
    titleBar.Font = Enum.Font.GothamBold
    titleBar.Parent = mainFrame
    
    -- Joke display
    local jokeBox = Instance.new("TextLabel")
    jokeBox.Name = "JokeDisplay"
    jokeBox.Size = UDim2.new(1, -20, 0, 250)
    jokeBox.Position = UDim2.new(0, 10, 0, 50)
    jokeBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    jokeBox.BorderSizePixel = 0
    jokeBox.TextColor3 = Color3.fromRGB(100, 255, 100)
    jokeBox.TextSize = 14
    jokeBox.Font = Enum.Font.GothamMonoMedium
    jokeBox.TextWrapped = true
    jokeBox.TextXAlignment = Enum.TextXAlignment.Left
    jokeBox.TextYAlignment = Enum.TextYAlignment.Top
    jokeBox.Text = "[Click 'Get Joke' to start laughing!]"
    jokeBox.Parent = mainFrame
    
    -- Get Joke button
    local getJokeBtn = Instance.new("TextButton")
    getJokeBtn.Name = "GetJokeButton"
    getJokeBtn.Size = UDim2.new(0, 140, 0, 40)
    getJokeBtn.Position = UDim2.new(0, 10, 0, 310)
    getJokeBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
    getJokeBtn.BorderSizePixel = 0
    getJokeBtn.Text = "😂 Get Joke"
    getJokeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    getJokeBtn.TextSize = 14
    getJokeBtn.Font = Enum.Font.GothamBold
    getJokeBtn.Parent = mainFrame
    
    -- Get Programming Joke button
    local getProgJokeBtn = Instance.new("TextButton")
    getProgJokeBtn.Name = "GetProgJokeButton"
    getProgJokeBtn.Size = UDim2.new(0, 140, 0, 40)
    getProgJokeBtn.Position = UDim2.new(0, 160, 0, 310)
    getProgJokeBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
    getProgJokeBtn.BorderSizePixel = 0
    getProgJokeBtn.Text = "💻 Programming"
    getProgJokeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    getProgJokeBtn.TextSize = 14
    getProgJokeBtn.Font = Enum.Font.GothamBold
    getProgJokeBtn.Parent = mainFrame
    
    -- Clear History button
    local clearBtn = Instance.new("TextButton")
    clearBtn.Name = "ClearButton"
    clearBtn.Size = UDim2.new(0, 140, 0, 40)
    clearBtn.Position = UDim2.new(0, 310, 0, 310)
    clearBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    clearBtn.BorderSizePixel = 0
    clearBtn.Text = "🗑️ Clear"
    clearBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    clearBtn.TextSize = 14
    clearBtn.Font = Enum.Font.GothamBold
    clearBtn.Parent = mainFrame
    
    -- Status label
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Name = "Status"
    statusLabel.Size = UDim2.new(1, -20, 0, 30)
    statusLabel.Position = UDim2.new(0, 10, 0, 360)
    statusLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    statusLabel.BorderSizePixel = 0
    statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    statusLabel.TextSize = 12
    statusLabel.Font = Enum.Font.GothamMonoSmall
    statusLabel.Text = "Status: Ready"
    statusLabel.Parent = mainFrame
    
    -- Joke count label
    local countLabel = Instance.new("TextLabel")
    countLabel.Name = "JokeCount"
    countLabel.Size = UDim2.new(1, -20, 0, 30)
    countLabel.Position = UDim2.new(0, 10, 0, 400)
    countLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    countLabel.BorderSizePixel = 0
    countLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    countLabel.TextSize = 12
    countLabel.Font = Enum.Font.GothamMonoSmall
    countLabel.Text = "Jokes collected: 0"
    countLabel.Parent = mainFrame
    
    self.elements = {
        mainFrame = mainFrame,
        jokeBox = jokeBox,
        getJokeBtn = getJokeBtn,
        getProgJokeBtn = getProgJokeBtn,
        clearBtn = clearBtn,
        statusLabel = statusLabel,
        countLabel = countLabel
    }
    
    self.visible = true
    return mainFrame
end

-- Update joke display
function JokeUI:displayJoke(jokeText)
    if self.elements.jokeBox then
        self.elements.jokeBox.Text = jokeText or "Failed to load joke!"
    end
end

-- Update status
function JokeUI:updateStatus(text)
    if self.elements.statusLabel then
        self.elements.statusLabel.Text = "Status: " .. text
    end
end

-- Update joke count
function JokeUI:updateCount(count)
    if self.elements.countLabel then
        self.elements.countLabel.Text = "Jokes collected: " .. tostring(count)
    end
end

-- Toggle visibility
function JokeUI:toggle()
    if self.elements.mainFrame then
        self.elements.mainFrame.Visible = not self.elements.mainFrame.Visible
        self.visible = self.elements.mainFrame.Visible
    end
end

return JokeUI
