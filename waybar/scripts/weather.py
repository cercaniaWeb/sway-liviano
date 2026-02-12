#!/usr/bin/env python

import json
import requests
import sys
from datetime import datetime

WEATHER_CODES = {
    '113': '󰖙',
    '116': '󰖕',
    '119': '󰖐',
    '122': '󰖐',
    '143': '󰖑',
    '176': '󰖗',
    '179': '󰼶',
    '182': '󰖒',
    '185': '󰖒',
    '200': '󰖓',
    '227': '󰼶',
    '230': '󰼶',
    '248': '󰖑',
    '260': '󰖑',
    '263': '󰖗',
    '266': '󰖗',
    '281': '󰖒',
    '284': '󰖒',
    '293': '󰖗',
    '296': '󰖗',
    '299': '󰖗',
    '302': '󰖗',
    '305': '󰖖',
    '308': '󰖖',
    '311': '󰖒',
    '314': '󰖒',
    '317': '󰖒',
    '320': '󰼶',
    '323': '󰼶',
    '326': '󰼶',
    '329': '󰼶',
    '332': '󰼶',
    '335': '󰼶',
    '338': '󰼶',
    '350': '󰖒',
    '353': '󰖗',
    '356': '󰖖',
    '359': '󰖖',
    '362': '󰖒',
    '365': '󰖒',
    '368': '󰼶',
    '371': '󰼶',
    '374': '󰖒',
    '377': '󰖒',
    '386': '󰖓',
    '389': '󰖓',
    '392': '󰼶',
    '395': '󰼶'
}

def format_time(time):
    return time.replace("00", "").zfill(2)

def format_temp(temp):
    return (str(temp)+"°").ljust(3)

def format_chances(hour):
    chances = {
        "chanceoffog": "Fog",
        "chanceoffrost": "Frost",
        "chanceofovercast": "Overcast",
        "chanceofrain": "Rain",
        "chanceofsnow": "Snow",
        "chanceofsunshine": "Sunshine",
        "chanceofthunder": "Thunder",
        "chanceofwindy": "Wind"
    }

    conditions = []
    for event in chances.keys():
        if int(hour.get(event, 0)) > 0:
            conditions.append(chances[event]+" "+hour[event]+"%")
    return ", ".join(conditions)

def main():
    data = {}
    try:
        response = requests.get("https://wttr.in/?format=j1", timeout=10)
        response.raise_for_status()
        weather = response.json()

        current = weather['current_condition'][0]
        data['text'] = WEATHER_CODES.get(current['weatherCode'], "󰖐") + " " + current['FeelsLikeC'] + "°"
        
        tooltip = f"<b>{current['weatherDesc'][0]['value']} {current['temp_C']}°C</b>\n"
        tooltip += f"Feels like: {current['FeelsLikeC']}°C\n"
        tooltip += f"Wind: {current['windspeedKmph']}Km/h\n"
        tooltip += f"Humidity: {current['humidity']}%\n"
        
        for i, day in enumerate(weather['weather']):
            tooltip += f"\n<b>"
            if i == 0:
                tooltip += "Today, "
            elif i == 1:
                tooltip += "Tomorrow, "
            tooltip += f"{day['date']}</b>\n"
            tooltip += f"⬆️ {day['maxtempC']}° ⬇️ {day['mintempC']}° "
            tooltip += f"🌅 {day['astronomy'][0]['sunrise']} 🌇 {day['astronomy'][0]['sunset']}\n"
            for hour in day['hourly']:
                if i == 0:
                    if int(format_time(hour['time'])) < datetime.now().hour-2:
                        continue
                tooltip += f"{format_time(hour['time'])} {WEATHER_CODES.get(hour['weatherCode'], '󰖐')} {format_temp(hour['FeelsLikeC'])} {hour['weatherDesc'][0]['value']}, {format_chances(hour)}\n"
        
        data['tooltip'] = tooltip
        
    except Exception as e:
        data['text'] = "󰖐 N/A"
        data['tooltip'] = f"Error fetching weather: {str(e)}"

    print(json.dumps(data))

if __name__ == "__main__":
    main()
