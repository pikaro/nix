{
  sysInfo,
  inputs,
  utils,
  lib,
  ...
} @ context: [
  inputs.home-manager.darwinModules.home-manager
  {
    imports = [../modules/dock];

    home-manager = {
      backupFileExtension = "bak";
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = builtins.removeAttrs context ["lib"];
      users.${sysInfo.user}.imports = utils.imp.getImports ./conf;
    };

    local = {
      dock = {
        enable = true;
        entries = lib.concatMap (path: import path) (utils.imp.getImports ./dock);
      };
    };
  }
]
