# Credentials for OpenWeatherMap API
OPEN_WEATHER_API_KEY="YOUR_API_KEY" # Your API key | required
CITY="New Delhi"                    # Your city | required
UNITS="metric"                      # Celsius -> metric, Fahrenheit -> imperial, Kelvin -> standard(default) | optional
LANG="en"                           # English -> en(default), Hindi -> hi, etc. | optional

# Display a welcome message
echo -e "\e[34mWelcome, ${USER[@]^}!😉\e[0m"

# Display the current date and time
echo -e "\e[36m$(date '+%a, %b %d, %Y %I:%M:%S %p')\e[0m"

# Determine the temperature unit symbol
if [[ $UNITS == "metric" ]]; then
    temp_symbol="°C"
elif [[ $UNITS == "imperial" ]]; then
    temp_symbol="°F"
else
    temp_symbol="K"
fi

# Fetch weather data from OpenWeatherMap API
weather_data=$(curl --silent --location "https://api.openweathermap.org/data/2.5/weather?q=$CITY&appid=$OPEN_WEATHER_API_KEY&units=$UNITS&lang=$LANG" 2>/dev/null)

# Parse and display the weather data
if [[ $weather_data ]]; then
    desc=$(echo "$weather_data" | jq -r '.weather[0].description')
    temp=$(echo "$weather_data" | jq -r '.main.temp')
    city=$(echo "$weather_data" | jq -r '.name')
    rounded_temp=$(printf "%.0f" $temp)                               # Round off to nearest integer
    echo -e "\e[32m$city | $rounded_temp$temp_symbol | ${desc^}\e[0m" # Capitalize the first letter of the description
fi

# Add a separator for clarity
echo "---------------------------------------------"
