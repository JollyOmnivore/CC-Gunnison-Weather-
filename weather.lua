while true do
 
-- URL of your external service that returns the weather JSON response
local url = "https://api.openweathermap.org/data/2.5/weather?lat=38.54&lon=-106.92&appid=8ff97c4b35a979509e2abc4f2fa8a7fc"
 
local function getWeatherInfo()
    -- Make the HTTP GET request
    local response = http.get(url)
    
    -- Check if the request was successful
    if response then
        -- Read the entire content of the response
        local responseBody = response.readAll()
        response.close()
        
        -- Parse the JSON response body to a Lua table
        local jsonData = textutils.unserializeJSON(responseBody)
        
        -- Extract weather information
        if jsonData and jsonData["weather"] and jsonData["weather"][1] and jsonData["main"] then
            local weatherCondition = jsonData["weather"][1]["main"]
            local weatherDescription = jsonData["weather"][1]["description"]
            local temperature = jsonData["main"]["temp"]
            local humidity = jsonData["main"]["humidity"]
            
            -- Convert Kelvin to Celsius (since the temperature is likely in Kelvin)
            local tempCelsius = (9/5) * (temperature - 273.15)+32
            
            print("Weather in " .. jsonData["name"] .. ": " .. weatherCondition .. " (" .. weatherDescription .. ")")
            print("Temperature: " .. string.format("%.2f", tempCelsius) .. "°F")
            print("Humidity: " .. humidity .. "%")
        else
            print("Failed to extract weather information from the response.")
        end
    else
        print("Failed to fetch weather information.")
    end
end
term.clear()
getWeatherInfo()
term.setCursorPos(1,1)
sleep(120)
--waits for 2 minutes to refresh
end
