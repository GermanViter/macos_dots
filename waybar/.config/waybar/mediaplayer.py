#!/usr/bin/env python3
import json
import subprocess
import sys

def get_player_data():
    try:
        status = subprocess.check_output(["playerctl", "status"], stderr=subprocess.DEVNULL).decode("utf-8").strip()
        if not status:
            return None
        
        try:
            artist = subprocess.check_output(["playerctl", "metadata", "artist"], stderr=subprocess.DEVNULL).decode("utf-8").strip()
        except:
            artist = "Unknown"
            
        try:
            title = subprocess.check_output(["playerctl", "metadata", "title"], stderr=subprocess.DEVNULL).decode("utf-8").strip()
        except:
            title = "Unknown"
            
        try:
            player = subprocess.check_output(["playerctl", "metadata", "--format", "{{playerName}}"], stderr=subprocess.DEVNULL).decode("utf-8").strip()
        except:
            player = "default"

        text = f"{artist} - {title}"
        return {
            "text": text,
            "class": player,
            "alt": player
        }
    except Exception:
        return None

data = get_player_data()
if data:
    print(json.dumps(data))
else:
    print(json.dumps({"text": "", "class": "stopped"}))
