-- GHCUC EXE - Weather Dashboard Main
-- Real-time weather data from Open-Meteo API

local WeatherAPI = require(script.Parent.utils.weatherAPI)
local WeatherUI = require(script.Parent.ui.weatherUI)

-- Initialize
local weatherAPI = WeatherAPI.new()
local weatherUI = WeatherUI.new()

-- Create UI
weatherUI:createWeatherWindow()

-- Default coordinates (São Paulo, Brazil)
local defaultLat = -23.5505
local defaultLon = -46.6333

-- Get current weather
local function getCurrentWeather()
    weatherUI:updateStatus("Loading current weather...")
    
    local weather = weatherAPI:getWeatherByCoords(defaultLat, defaultLon)
    if weather then
        local formatted = weatherAPI:formatCurrentWeather()
        weatherUI:displayCurrentWeather(formatted)
        weatherUI:updateStatus("Weather loaded!")
    else
        weatherUI:displayCurrentWeather("Failed to load weather. Check your internet connection!")
        weatherUI:updateStatus("Error loading weather")
    end
end

-- Get forecast
local function getForecast()
    weatherUI:updateStatus("Loading forecast...")
    
    local forecast = weatherAPI:getForecast(defaultLat, defaultLon, 7)
    if forecast then
        local summary = weatherAPI:getForecastSummary()
        if summary then
            local forecastText = "📅 7-Day Forecast:\n\n"
            for i, day in ipairs(summary) do
                forecastText = forecastText .. string.format(
                    "%s %s (%s)\n🔺 %d°C | 🔻 %d°C | 💧 %.1f mm\n\n",
                    day.emoji,
                    day.date,
                    day.description,
                    math.ceil(day.tempMax),
                    math.ceil(day.tempMin),
                    day.precipitation
                )
            end
            weatherUI:displayForecast(forecastText)
            weatherUI:updateStatus("Forecast loaded!")
        end
    else
        weatherUI:displayForecast("Failed to load forecast!")
        weatherUI:updateStatus("Error loading forecast")
    end
end

-- Connect buttons
weatherUI.elements.getWeatherBtn.MouseButton1Click:Connect(getCurrentWeather)
weatherUI.elements.getForecastBtn.MouseButton1Click:Connect(getForecast)

-- Startup message
weatherUI:displayCurrentWeather("🌤️ Welcome to GHCUC Weather Dashboard!\n\nClick 'Get Weather' to see current conditions or 'Get Forecast' to see the 7-day forecast!\n\nLocation: São Paulo, Brazil\n\nEnjoy! 🌍")
weatherUI:updateStatus("Ready")

print("=== GHCUC Weather Dashboard ===")
print("Weather Dashboard loaded successfully!")
print("Click the buttons to get weather data!")
print("================================")
