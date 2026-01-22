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
        "apps": ["Teams"],
        "monitors": []
      },
      "t": {
        "apps": ["OneNote", "To Do"],
        "monitors": ["Acer CB241HY", "DELL U2718Q"]
      },
      "m": {
        "apps": ["Outlook"],
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
            "Microsoft Teams",
            "Microsoft Outlook",
            "Microsoft To Do",
        },
    }
  '';
}
