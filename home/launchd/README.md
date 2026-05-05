# Launchd Agents

Add Home Manager user LaunchAgents as `.nix` files under:

- `agents/common` for every machine
- `agents/home` for the home profile
- `agents/work` for the work profile

Each file returns an attrset keyed by the Home Manager agent name:

```nix
{
  mkAgent,
  pkgs,
  ...
}: {
  update-cache = mkAgent {
    name = "update-cache";
    packages = with pkgs; [
      coreutils
      curl
    ];
    startInterval = 86400;
    runAtLoad = true;
    text = ''
      mkdir -p "$HOME/.local/state"
      curl --fail --silent --show-error https://example.com/cache > "$HOME/.local/state/cache"
    '';
  };
}
```

Use `extraConfig` for launchd keys that are not covered by the helper.
