{
  self,
  sysInfo,
  utils,
  lib,
  ...
}: {
  config,
  pkgs,
  ...
}: {
  system = {
    configurationRevision = self.rev or self.dirtyRev or null;
    stateVersion = 6;
    primaryUser = sysInfo.user;
  };
  nixpkgs.hostPlatform = sysInfo.platform;

  security.pam.services.sudo_local.touchIdAuth = true;

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
    };
    gc = {
      automatic = true;
      interval = [
        {
          Hour = 3;
          Minute = 15;
          Weekday = 7;
        }
      ];
    };
    optimise = {
      automatic = true;
      interval = [
        {
          Hour = 4;
          Minute = 15;
          Weekday = 7;
        }
      ];
    };
  };

  networking = {
    computerName = sysInfo.hostname;
    hostName = sysInfo.hostname;
    localHostName = sysInfo.hostname;
    knownNetworkServices = [
      "Wi-Fi"
    ];
    dns = [
      "127.0.0.1"
      "9.9.9.9"
      "1.1.1.1"
    ];
  };

  programs = {
    bash = {
      enable = true;
      completion = {
        enable = true;
      };
    };
  };

  environment = {
    shellAliases = {
      "cat" = "bat --no-pager --theme=gruvbox-dark --style=-numbers";
      "d" = "docker";
      "dc" = "docker-compose";
      "g" = "git";
      "grep" = "rg";
      "hi" = "helm upgrade --install";
      "k" = "kubectl";
      "ka" = "kubectl apply";
      "kb" = "kubectl debug -it --image=busybox";
      "kc" = "kubectl create";
      "kd" = "kubectl describe";
      "kdn" = "kubectl describe nodes";
      "kdd" = "kubectl describe deployments";
      "kds" = "kubectl describe services";
      "kdi" = "kubectl describe ingresses";
      "kdp" = "kubectl describe pods";
      "ke" = "kubectl edit";
      "kE" = "kubectl explain";
      "kf" = "kubectl port-forward";
      "kg" = "kubectl get";
      "kgn" = "kubectl get nodes";
      "kgd" = "kubectl get deployments";
      "kgs" = "kubectl get services";
      "kgi" = "kubectl get ingresses";
      "kgp" = "kubectl get pods";
      "kl" = "kubectl logs";
      "kr" = "kubectl run";
      "ks" = "kubectl scale";
      "kt" = "kubectl top";
      "kv" = "kubectl events";
      "kx" = "kubectl exec -it";
      "l" = "ls -CF --color=auto";
      "ls" = "ls --color=auto";
      "la" = "ls -A --color=yes";
      "ll" = "ls -lAh --color=yes";
      "pci" = "pre-commit install --install-hooks";
      "pcr" = "pre-commit run --all-files --verbose";
      "pcu" = "pre-commit autoupdate";
      "tf" = "terraform";
      "vim" = "nvim";
      "vim-dev" = "XDG_CONFIG_HOME=~/src/dre/dotfiles/ XDG_DATA_HOME=~/src/dre/dotfiles/nvim/local nvim -u ~/src/dre/dotfiles/nvim/init.lua";
      "venv" = "source ~/.local/gitbin/_venv";
      "t" = "talosctl";
      "td" = "talosctl get -o yaml";
      "te" = "talosctl edit";
      "tg" = "talosctl get";
      "tl" = "talosctl logs";
      "tm" = "talosctl mounts";
      "tM" = "talosctl memory";
      "tn" = "talosctl nodes";
      "tN" = "talosctl netstat";
      "tp" = "talosctl processes";
      "tR" = "talosctl read";
      "ts" = "talosctl services";
      "tS" = "talosctl stats";
      "tu" = "talosctl usage";
      "tv" = "talosctl events";
      "zsh-plain" = "/usr/bin/env -i PATH=\"$HOME/.local/bin-plain:/usr/bin:/bin:/usr/sbin:/sbin\" USER=\"\$USER\" HOME=\"$HOME\" TERM=\"xterm\" /bin/zsh -df";
    };
    shells = [pkgs.bashInteractive pkgs.zsh];
  };

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    PAGER = "bat";
    BAT_PAGER = "ov -FH3";
    LANG = "en_US.UTF-8";
    AWS_EC2_METADATA_DISABLED = "true";
    DOCKER_CLI_EXPERIMENTAL = "1";
    BUILDX_EXPERIMENTAL = "1";
  };

  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    fira-mono
    nerd-fonts.fira-code
  ];

  power = {
    sleep = {
      allowSleepByPowerButton = true;
      display = 5;
      computer = 10;
    };
  };

  services = {
    dnsmasq = {
      enable = true;
      addresses = {
        docker = "127.0.0.1";
      };
    };
  };

  system = {
    activationScripts = {
      extraActivation = let
        loginTpl = "osascript -e 'tell application \"System Events\" to make login item at end with properties {path:\"%s\", hidden:false}'";
        commands = [
          "/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u"
        ];
        loginItems = [
          "/Applications/UnnaturalScrollWheels.app"
        ];
        loginItemCommands = utils.misc.formatList loginTpl loginItems;
        activationCommands = loginItemCommands ++ commands;
        activationCommand = lib.concatStringsSep "\n" activationCommands;
        activationScript = pkgs.writeShellScript "activation-script" activationCommand;
      in {
        enable = true;
        text = ''
          sudo -u '${sysInfo.user}' ${activationScript}
          launchctl config user path $HOME/.local/gitbin:$HOME/.local/bin:$HOME/.bin:$HOME/.nix-profile/bin:/etc/profiles/per-user/david.reis/bin:/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin:/opt/homebrew/bin:/opt/homebrew/sbin::/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
        '';
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
      userKeyMapping = [
        {
          # Map fn -> Control
          HIDKeyboardModifierMappingSrc = 1095216660483;
          HIDKeyboardModifierMappingDst = 30064771296;
        }
      ];
    };

    defaults = {
      screencapture = {
        type = "png";
        target = "preview";
      };

      screensaver = {
        askForPassword = true;
        askForPasswordDelay = 300;
      };

      finder = {
        AppleShowAllFiles = true;
        CreateDesktop = false;
        FXRemoveOldTrashItems = true;
        FXPreferredViewStyle = "Nlsv";
        ShowPathbar = true;
        ShowStatusBar = true;
        FXDefaultSearchScope = "SCcf";
        FXEnableExtensionChangeWarning = false;
        _FXSortFoldersFirst = true;
        _FXShowPosixPathInTitle = true;
      };

      hitoolbox = {
        AppleFnUsageType = "Do Nothing";
      };

      dock = {
        autohide = true;
        autohide-delay = 0.1;
        autohide-time-modifier = 0.1;
        magnification = false;
        minimize-to-application = true;
        show-recents = true;
      };

      NSGlobalDomain = {
        _HIHideMenuBar = true;
        "com.apple.swipescrolldirection" = false;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticInlinePredictionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        "com.apple.trackpad.trackpadCornerClickBehavior" = 1;
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
        AppleInterfaceStyleSwitchesAutomatically = true;
      };

      SoftwareUpdate = {
        AutomaticallyInstallMacOSUpdates = true;
      };

      WindowManager = {
        EnableStandardClickToShowDesktop = false;
      };

      controlcenter = {
        AirDrop = false;
        NowPlaying = false;
      };

      CustomUserPreferences = {
        NSGlobalDomain = {
          WebKitDeveloperExtras = true;
          NSWindowShouldDragOnGesture = true;
        };

        "com.apple.desktopservices" = {
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };

        "com.apple.AdLib" = {
          allowApplePersonalizedAdvertising = false;
        };

        "com.apple.SoftwareUpdate" = {
          AutomaticCheckEnabled = true;
          ScheduleFrequency = 1;
          AutomaticDownload = 1;
          CriticalUpdateInstall = 1;
        };

        "com.apple.symbolichotkeys" = {
          AppleSymbolicHotKeys = {
            # Mission control / windows (C+Up/Down)
            "32" = {enabled = false;};
            "33" = {enabled = false;};

            # Next / prev input source (C+Space)
            "60" = {enabled = false;};
            "61" = {enabled = false;};

            # Context window (C+Enter)
            "159" = {enabled = false;};

            # Map Space left/right to C+S instead of C
            "81" = {
              enabled = true;
              value = {
                parameters = [
                  65535
                  123
                  10878976
                ];
                type = "standard";
              };
            };
            "82" = {
              enabled = true;
              value = {
                parameters = [
                  65535
                  124
                  8781824
                ];
                type = "standard";
              };
            };
          };
        };
      };
    };
  };

  users = {
    users = {
      ${sysInfo.user} = {
        home = "/Users/${sysInfo.user}";
      };
    };
  };
}
