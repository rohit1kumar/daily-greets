# Weatherly

###  A shell script for daily greetings, date, time, and weather updates.

![terminal's screenshot](https://i.imgur.com/6UXx2q7.png)
### Installation

1. Clone the repository and change the directory

```bash
git clone https://github.com/rohit1kumar/weatherly.git && cd weatherly
```

2. Get an API key from [OpenWeather](https://home.openweathermap.org/api_keys), additional [languages](https://openweathermap.org/current#multi)
```bash
OPEN_WEATHER_API_KEY="YOUR_API_KEY" # Your API key | required
CITY="New Delhi"                    # Your city | required
UNITS="metric"                      # metric: C, imperial: F, standard: K (default)
LANG="en"                           # hi: Hindi, en: English (default)
```

3. Install `curl` and `jq` packages if not installed already

```bash
sudo apt install curl
sudo apt install jq
```

4. Run the script and make it executable and follow the instructions
```bash
chmod +x main.sh && ./main.sh
```

5. Restart the terminal, Enjoy the weather report :)

---
*Note: To uninstall Weatherly, run*
```bash
rm -rf ~/.weatherly ~/.weatherly_config
```
then open `~/.bashrc` and remove `source /home/$USER/.weatherly/main.sh`
