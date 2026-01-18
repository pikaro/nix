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
        "apps": ["Teams"],
        "monitors": []
      },
      "t": {
        "apps": ["OneNote", "To Do"],
        "monitors": ["Acer CB241HY"]
      },
      "m": {
        "apps": ["Outlook"],
        "monitors": []
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
