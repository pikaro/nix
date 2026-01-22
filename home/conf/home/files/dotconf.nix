{...}: {
  ".config/aerospace/workspaces.json".text = ''
    {
      "k": {
        "apps": ["kitty"],
        "monitors": ["EB321HQU", "DELL P3421W"]
      },
      "w": {
        "apps": ["Firefox"],
        "monitors": ["EB321HQU", "DELL P3421W"]
      },
      "c": {
        "apps": ["Signal", "WhatsApp", "Telegram"],
        "monitors": []
      },
      "t": {
        "apps": ["Vikunja", "Joplin"],
        "monitors": ["Acer CB241HY", "DELL U2718Q"]
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
        "monitors": ["Acer CB241HY", "DELL U2718Q"]
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
