#!/bin/bash
: '
Author: Rohit Kumar (https://github.com/rohit1kumar)
Weatherly is a bash script displaying greetings, current date, time, and city weather.
Project repository: https://github.com/rohit1kumar/weatherly
'
# Source the configuration file
CONFIG_PATH="$HOME/.weatherly_config"
if [[ -f $CONFIG_PATH ]]; then
    source $CONFIG_PATH
else
    echo "Configuration file not found. Please run the install.sh first."
    exit 1
fi

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

# Check for errors in the API response
error_code=$(echo "$weather_data" | jq -r '.cod')
if [[ $error_code != "200" ]]; then
    error_message=$(echo "$weather_data" | jq -r '.message')
    echo -e "\e[31mError in Weatherly: $error_message\e[0m"
else
    # Parse and display the weather data
    desc=$(echo "$weather_data" | jq -r '.weather[0].description')
    temp=$(echo "$weather_data" | jq -r '.main.temp')
    city=$(echo "$weather_data" | jq -r '.name')
    rounded_temp=$(printf "%.0f" $temp)                               # Round off to nearest integer
    echo -e "\e[32m$city | $rounded_temp$temp_symbol | ${desc^}\e[0m" # Capitalize the first letter of the description
fi

# Add a separator for clarity
echo "---------------------------------------------"