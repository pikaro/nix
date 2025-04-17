{
  lib,
  utils,
  ...
}: rec {
  # Get all present default.nix from common + profile directory or common / <profile>.nix directly
  getImports = basePath: let
    commonModuleDir = basePath + "/common";
    systemModuleDir = basePath + "/${utils.base.sysInfo.profile}";
    commonModule = basePath + "/common.nix";
    systemModule = basePath + "/${utils.base.sysInfo.profile}.nix";
    modules =
      lib.optional (builtins.pathExists commonModule) commonModule
      ++ lib.optional (builtins.pathExists commonModuleDir) commonModuleDir
      ++ lib.optional (builtins.pathExists systemModule) systemModule
      ++ lib.optional (builtins.pathExists systemModuleDir) systemModuleDir;
  in
    modules;

  # Import all present default.nix from common + profile directory or common / <profile>.nix directly
  doImports = basePath: args: let
    imports = getImports basePath;
  in
    lib.foldl (acc: path: lib.recursiveUpdate acc (import path args)) {} imports;

  # Get all present *.nix files from common + profile directory
  getImports' = basePath:
    lib.concatMap (
      dir: utils.base.listNixFiles dir
    ) (getImports basePath);

  # Import all present *.nix files from common + profile directory
  doImports' = basePath: args: let
    imports = getImports' basePath;
  in
    lib.foldl (acc: path: lib.recursiveUpdate acc (import path args)) {} imports;

  # Import all foo.nix from basePath to {foo = ...}
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

  # Import all foo.nix from basePath
  importDir = basePath: args: let
    files = utils.base.listNixFiles basePath;
  in
    lib.foldl (acc: path: lib.recursiveUpdate acc (import path args)) {} files;
}
