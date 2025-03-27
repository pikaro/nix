{
  lib,
  utils,
  ...
}: {pkgs, ...}: {
  environment.systemPackages = lib.concatMap (file: import file {inherit pkgs;}) (utils.getImports' ./nix);

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    casks = lib.concatMap (path: import path) (utils.getImports' ./brew/casks);
    brews = lib.concatMap (path: import path) (utils.getImports' ./brew/brews);
    masApps = lib.foldl lib.recursiveUpdate {} (map (path: import path) (utils.getImports' ./appstore));
  };
}
