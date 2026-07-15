-- GHCUC EXE - Joke Generator Main
-- Random joke generator using JokeAPI

local JokeGenerator = require(script.Parent.utils.jokeGenerator)
local JokeUI = require(script.Parent.ui.jokeUI)

-- Initialize
local jokeGen = JokeGenerator.new()
local jokeUI = JokeUI.new()

-- Create UI
jokeUI:createJokeWindow()

-- Get random joke
local function getRandomJoke()
    jokeUI:updateStatus(\"Loading...\")
    
    local joke = jokeGen:getRandomJoke()
    if joke then
        local formatted = jokeGen:getFormattedJoke()
        jokeUI:displayJoke(formatted)
        jokeGen:storeJoke()
        jokeUI:updateStatus(\"Loaded!\")
        jokeUI:updateCount(#jokeGen:getJokeHistory())
    else
        jokeUI:displayJoke(\"Failed to load joke. Check your internet connection!\")
        jokeUI:updateStatus(\"Error loading joke\")
    end
end

-- Get programming joke
local function getProgrammingJoke()
    jokeUI:updateStatus(\"Loading programming joke...\")
    
    local joke = jokeGen:getJokeByCategory(\"Programming\")
    if joke then
        local formatted = jokeGen:getFormattedJoke()
        jokeUI:displayJoke(formatted)
        jokeGen:storeJoke()
        jokeUI:updateStatus(\"Loaded!\")
        jokeUI:updateCount(#jokeGen:getJokeHistory())
    else
        jokeUI:displayJoke(\"Failed to load programming joke!\")
        jokeUI:updateStatus(\"Error loading joke\")
    end
end

-- Clear history
local function clearHistory()
    jokeGen:clearHistory()
    jokeUI:displayJoke(\"[History cleared! Click 'Get Joke' to start fresh]\")
    jokeUI:updateStatus(\"History cleared\")
    jokeUI:updateCount(0)
end

-- Connect buttons
jokeUI.elements.getJokeBtn.MouseButton1Click:Connect(getRandomJoke)
jokeUI.elements.getProgJokeBtn.MouseButton1Click:Connect(getProgrammingJoke)
jokeUI.elements.clearBtn.MouseButton1Click:Connect(clearHistory)

-- Startup message
jokeUI:displayJoke(\"🎭 Welcome to GHCUC Joke Generator!\\n\\nClick 'Get Joke' for a random joke or 'Programming' for coding jokes!\\n\\nEnjoy the laughs! 😄\")\njokeUI:updateStatus(\"Ready\")\n\nprint(\"=== GHCUC Joke Generator ===\")\nprint(\"Joke Generator loaded successfully!\")\nprint(\"Click the buttons to get jokes!\")\nprint(\"=============================\")\n