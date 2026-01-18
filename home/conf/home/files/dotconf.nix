{...}: {
  ".config/aerospace/workspaces.json".text = ''
    {
      "k": {
        "apps": ["kitty"],
        "monitors": ["EB321HQU"]
      },
      "w": {
        "apps": ["Firefox"],
        "monitors": ["EB321HQU"]
      },
      "c": {
        "apps": ["Signal", "WhatsApp", "Telegram"],
        "monitors": []
      },
      "t": {
        "apps": ["Vikunja", "Joplin"],
        "monitors": ["Acer CB241HY"]
      },
      "m": {
        "apps": ["Mail"],
        "monitors": []
      },
      "a": {
        "apps": ["ChatGPT"],
        "monitors": []
      },
      "s": {
        "apps": ["Spotify", "Nuage"],
        "monitors": ["Acer CB241HY"]
      }
    }
  '';

  ".sketchybar_system.lua".text = ''
    return {
        notifications = {
            "WhatsApp",
            "Signal",
            "Telegram",
        },
    }
  '';
}
