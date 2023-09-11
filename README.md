# Daily Greets

## Shell script to greet the user and display the current date, time, and weather conditions.

### Installation

1. Copy the content of `install.sh` to the end of the `~/.profile` file. If `~/.profile` isn't present, paste it at the end of the `~/.bashrc` file.

2. Visit [OpenWeather](https://home.openweathermap.org/api_keys) for API key, then udpate the file with the API key, city, units, and language.
```bash
OPEN_WEATHER_API_KEY="YOUR_API_KEY" # Your API key | required
CITY="New Delhi"                    # Your city | required
UNITS="metric"                      # metric: C, imperial: F, standard: K (default)
LANG="en"                           # hi: Hindi, en: English (default)
```

3. Install `curl` and `jq` packages using the following commands:

```bash
sudo apt install curl
sudo apt install jq
```

4. Restart the terminal, Enjoy the daily greets :)
