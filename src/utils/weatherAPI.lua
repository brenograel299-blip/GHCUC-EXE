-- GHCUC EXE - Weather API Module
-- Integration with Open-Meteo API for weather data

local WeatherAPI = {}
WeatherAPI.__index = WeatherAPI

-- Initialize weather API
function WeatherAPI.new()
    local self = setmetatable({}, WeatherAPI)
    self.baseUrl = "https://api.open-meteo.com/v1/forecast"
    self.currentWeather = nil
    self.forecast = nil
    self.location = {
        latitude = 0,
        longitude = 0,
        name = "Unknown"
    }
    return self
end

-- Get weather by coordinates
function WeatherAPI:getWeatherByCoords(latitude, longitude)
    local url = string.format(
        "%s?latitude=%.4f&longitude=%.4f&current=temperature_2m,relative_humidity_2m,weather_code,wind_speed_10m,is_day&timezone=auto",
        self.baseUrl,
        latitude,
        longitude
    )
    
    local success, result = pcall(function()
        local response = game:GetService("HttpService"):GetAsync(url)
        return game:GetService("HttpService"):JSONDecode(response)
    end)
    
    if success and result then
        self.currentWeather = result.current
        self.location.latitude = latitude
        self.location.longitude = longitude
        return result
    else
        return nil
    end
end

-- Get forecast data
function WeatherAPI:getForecast(latitude, longitude, days)
    days = days or 7
    local url = string.format(
        "%s?latitude=%.4f&longitude=%.4f&daily=temperature_2m_max,temperature_2m_min,weather_code,precipitation_sum&forecast_days=%d&timezone=auto",
        self.baseUrl,
        latitude,
        longitude,
        days
    )
    
    local success, result = pcall(function()
        local response = game:GetService("HttpService"):GetAsync(url)
        return game:GetService("HttpService"):JSONDecode(response)
    end)
    
    if success and result then
        self.forecast = result.daily
        return result
    else
        return nil
    end
end

-- Get weather description from code
function WeatherAPI:getWeatherDescription(code, isDay)
    isDay = isDay ~= false
    
    local descriptions = {
        [0] = isDay and "Clear sky" or "Clear night",
        [1] = "Mainly clear",
        [2] = "Partly cloudy",
        [3] = "Overcast",
        [45] = "Foggy",
        [48] = "Depositing rime fog",
        [51] = "Light drizzle",
        [53] = "Moderate drizzle",
        [55] = "Dense drizzle",
        [61] = "Slight rain",
        [63] = "Moderate rain",
        [65] = "Heavy rain",
        [71] = "Slight snow",
        [73] = "Moderate snow",
        [75] = "Heavy snow",
        [77] = "Snow grains",
        [80] = "Slight rain showers",
        [81] = "Moderate rain showers",
        [82] = "Violent rain showers",
        [85] = "Slight snow showers",
        [86] = "Heavy snow showers",
        [95] = "Thunderstorm",
        [96] = "Thunderstorm with slight hail",
        [99] = "Thunderstorm with heavy hail"
    }
    
    return descriptions[code] or "Unknown"
end

-- Get emoji for weather
function WeatherAPI:getWeatherEmoji(code, isDay)
    isDay = isDay ~= false
    
    if code == 0 then return isDay and "☀️" or "🌙" end
    if code == 1 or code == 2 then return "⛅" end
    if code == 3 then return "☁️" end
    if code == 45 or code == 48 then return "🌫️" end
    if code >= 51 and code <= 55 then return "🌧️" end
    if code >= 61 and code <= 65 then return "🌧️" end
    if code >= 71 and code <= 77 then return "❄️" end
    if code >= 80 and code <= 82 then return "⛈️" end
    if code >= 85 and code <= 86 then return "🌨️" end
    if code >= 95 and code <= 99 then return "⛈️" end
    
    return "🌡️"
end

-- Format current weather
function WeatherAPI:formatCurrentWeather()
    if not self.currentWeather then
        return "No weather data available"
    end
    
    local weather = self.currentWeather
    local description = self:getWeatherDescription(weather.weather_code, weather.is_day == 1)
    local emoji = self:getWeatherEmoji(weather.weather_code, weather.is_day == 1)
    
    return string.format(
        "%s %s\n🌡️ Temperature: %.1f°C\n💧 Humidity: %d%%\n💨 Wind Speed: %.1f km/h",
        emoji,
        description,
        weather.temperature_2m,
        weather.relative_humidity_2m,
        weather.wind_speed_10m
    )
end

-- Get current weather summary
function WeatherAPI:getCurrentWeatherSummary()
    if not self.currentWeather then
        return nil
    end
    
    return {
        temperature = self.currentWeather.temperature_2m,
        humidity = self.currentWeather.relative_humidity_2m,
        windSpeed = self.currentWeather.wind_speed_10m,
        weatherCode = self.currentWeather.weather_code,
        isDay = self.currentWeather.is_day == 1,
        description = self:getWeatherDescription(self.currentWeather.weather_code, self.currentWeather.is_day == 1),
        emoji = self:getWeatherEmoji(self.currentWeather.weather_code, self.currentWeather.is_day == 1)
    }
end

-- Get forecast summary
function WeatherAPI:getForecastSummary()
    if not self.forecast then
        return nil
    end
    
    local forecast = {}
    for i = 1, #self.forecast.time do
        table.insert(forecast, {
            date = self.forecast.time[i],
            tempMax = self.forecast.temperature_2m_max[i],
            tempMin = self.forecast.temperature_2m_min[i],
            weatherCode = self.forecast.weather_code[i],
            precipitation = self.forecast.precipitation_sum[i],
            description = self:getWeatherDescription(self.forecast.weather_code[i], true),
            emoji = self:getWeatherEmoji(self.forecast.weather_code[i], true)
        })
    end
    
    return forecast
end

return WeatherAPI
