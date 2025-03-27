{
  lib,
  hostname,
  ...
}: rec {
  sysMap = import ../systems.nix;
  sysInfo = (sysMap.${hostname} or (throw "Unknown system: ${hostname}")) // {hostname = hostname;};

  listNixFiles = basePath: let
    files = builtins.readDir basePath;
    nixFiles = lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".nix" name) files;
    paths = map (name: basePath + "/${name}") (builtins.attrNames nixFiles);
  in
    paths;

  getImports = basePath: let
    commonModuleDir = basePath + "/common";
    systemModuleDir = basePath + "/${sysInfo.profile}";
    commonModule = basePath + "/common.nix";
    systemModule = basePath + "/${sysInfo.profile}.nix";
    modules =
      lib.optional (builtins.pathExists commonModule) commonModule
      ++ lib.optional (builtins.pathExists commonModuleDir) commonModuleDir
      ++ lib.optional (builtins.pathExists systemModule) systemModule
      ++ lib.optional (builtins.pathExists systemModuleDir) systemModuleDir;
  in
    modules;

  getImports' = basePath:
    lib.concatMap (
      dir: listNixFiles dir
    ) (getImports basePath);

  dirToAttrs = basePath: args: let
    files = builtins.readDir basePath;
    nixFiles = lib.filterAttrs (name: type: type == "regular" && lib.hasSuffix ".nix" name) files;
    attrs =
      lib.mapAttrs' (
        name: _:
          lib.nameValuePair
          (lib.removeSuffix ".nix" name)
          (import (basePath + "/${name}") args)
      )
      nixFiles;
  in
    attrs;
}
