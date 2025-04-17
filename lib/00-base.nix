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
}
