{
  description = "Darwin configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    kitty = {
      url = "github:pikaro/kitty/master";
      flake = false;
    };
    nvim = {
      url = "github:pikaro/nvim/master";
      flake = false;
    };
    dotbin = {
      url = "github:pikaro/dotbin/master";
      flake = false;
    };
    dotconf = {
      url = "github:pikaro/dotconf/master";
      flake = false;
    };
    dotinc = {
      url = "github:pikaro/dotinc/master";
      flake = false;
    };
    keyboard = {
      url = "https://sourceforge.net/projects/uscustom/files/uscustom.2012-08-30.zip/download";
      type = "tarball";
      flake = false;
    };
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    home-manager,
    ...
  }: let
    systems = import ./systems.nix;
    mkDarwinSystem = hostname: sysInfo: let
      utils = import ./lib/utils.nix {
        inherit (nixpkgs) lib;
        inherit hostname;
      };

      context = {
        inherit self inputs utils;
        sysInfo = utils.sysInfo;
        lib = nixpkgs.lib;
      };
      confModules = map (path: import path context) (utils.getImports ./conf);
      pkgModules = [(import ./pkg context)];
      homeModules = import ./home context;
    in
      nix-darwin.lib.darwinSystem {
        system = utils.sysInfo.platform;
        modules = confModules ++ pkgModules ++ homeModules;
      };
  in {
    darwinConfigurations = nixpkgs.lib.mapAttrs mkDarwinSystem systems;
  };
}
