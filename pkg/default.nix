{
  lib,
  utils,
  ...
}: {pkgs, ...}: {
  environment.systemPackages = lib.concatMap (file: import file {inherit pkgs;}) (utils.imp.getImports' ./nix);

  homebrew = let
    casks = lib.concatMap (path: import path) (utils.imp.getImports' ./brew/casks);
    brews = lib.concatMap (path: import path) (utils.imp.getImports' ./brew/brews);
    taps = lib.concatMap (path: import path) (utils.imp.getImports' ./brew/taps);
    masApps = utils.imp.doImports' ./appstore {};
  in {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    casks = casks;
    brews = brews;
    taps = taps;
    masApps = masApps;
  };
}
