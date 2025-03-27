# nix-darwin-config

https://nixcademy.com/de/posts/nix-on-macos/

- Install Nix with shell installer, select no on Determinante prompt:

```bash
curl \
  --proto '=https' \
  --tlsv1.2 \
  -sSf \
  -L https://install.determinate.systems/nix \
  | sh -s -- install
```

- Install Homebrew:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

    echo >> /Users/david.reis/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/david.reis/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"

- Make sure your hostname is set to one of those listed in flake.nix
- Close and reopen the terminal
- Run `nix run nix-darwin -- switch --flake .`
- Close and reopen the terminal
- Run `./apply.sh -u`
- Reboot
- For future changes, run `apply.sh [-u]`
