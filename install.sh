#!/bin/bash

: '
To uninstall Weatherly, run this script in your terminal:
rm -rf ~/.weatherly ~/.weatherly_config
'

# Check for required dependencies
if ! command -v curl &>/dev/null; then
    echo "Error: curl is not installed, to install run: sudo apt install curl"
    exit 1
fi
if ! command -v jq &>/dev/null; then
    echo "Error: jq is not installed, to install run: sudo apt install jq"
    exit 1
fi

# Prompt user for configuration details
read -p "API Key: " OPEN_WEATHER_API_KEY

# Set default city
read -p "City (default: New Delhi): " CITY
CITY=${CITY:-"New Delhi"}

# Provide a selection menu for units with default as metric
echo "1. Metric (C)"
echo "2. Imperial (F)"
echo "3. Standard (K)"
read -p "Choose unit (default: 1 for Metric): " UNIT_CHOICE

case $UNIT_CHOICE in
1 | "") UNITS="metric" ;;
2) UNITS="imperial" ;;
3) UNITS="standard" ;;
*)
    echo "Invalid choice. Defaulting to metric."
    UNITS="metric"
    ;;
esac

# Set default language
echo -e "\e[36mMore language options : https://openweathermap.org/current#multi\e[0m"
read -p "Language (default: en for English): " LANG
LANG=${LANG:-"en"}

# Create a configuration file with the provided details
cat <<EOL >"$HOME/.weatherly_config"
OPEN_WEATHER_API_KEY="$OPEN_WEATHER_API_KEY"
CITY="$CITY"
UNITS="$UNITS"
LANG="$LANG"
EOL

# Create a directory for the script
mkdir -p "$HOME/.weatherly"

# Copy the main script to a suitable location
SCRIPT_PATH="$HOME/.weatherly/main.sh"
cp main.sh $SCRIPT_PATH && chmod +x $SCRIPT_PATH

# Add the script to ~/.bashrc
if ! grep -q "source $SCRIPT_PATH" "$HOME/.bashrc"; then
    echo -e "\nsource $SCRIPT_PATH" >>"$HOME/.bashrc"
fi

# Success!
echo "Installed! Restart terminal."
