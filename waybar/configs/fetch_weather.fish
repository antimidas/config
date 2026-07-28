#!/usr/bin/env python3
import urllib.request
import urllib.parse
import json
import sys

host_url = "https://api.openweathermap.org/data/2.5/weather"
query_params = {
    "q": "Pittsburgh",
    "appid": "1cd5cc01b13655aba53cedce7fad6f9f",
    "units": "imperial"
}

try:
    full_url = f"{host_url}?{urllib.parse.urlencode(query_params)}"
    req = urllib.request.Request(full_url, headers={"User-Agent": "Mozilla/5.0"})
    
    # Set a strict 5-second timeout so the system panel never lags or hangs up
    with urllib.request.urlopen(req, timeout=5) as response:
        raw_data = response.read().decode("utf-8")
        
        if not raw_data.strip():
            raise ValueError("Empty server response received")
            
        payload = json.loads(raw_data)
        temp = round(payload["main"]["temp"])
        humidity = payload["main"]["humidity"]
        
        # Valid i3blocks specification lines for Waybar engine ingestion
        print(f"{temp}°F {humidity}%")
        print("Location: Pittsburgh")
        
except Exception:
    # Fail gracefully: display basic dashes instead of crashing the layout thread
    print("--°F --%")
    print("Network Connection Offline")
    sys.exit(0)
