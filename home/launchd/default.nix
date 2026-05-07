{
  config,
  lib,
  pkgs,
  utils,
  ...
} @ context: let
  mkAgent = {
    name,
    text,
    packages ? [],
    extraPath ? [],
    label ? "home.${name}",
    startInterval ? null,
    startCalendarInterval ? null,
    runAtLoad ? false,
    keepAlive ? null,
    workingDirectory ? null,
    stdout ? "${config.home.homeDirectory}/.local/state/${name}.log",
    stderr ? "${config.home.homeDirectory}/.local/state/${name}.err.log",
    environment ? {},
    extraConfig ? {},
  }: let
    path = lib.concatStringsSep ":" (
      lib.filter (entry: entry != "") (
        [(lib.makeBinPath packages)]
        ++ extraPath
        ++ [
          "/usr/bin"
          "/bin"
          "/usr/sbin"
          "/sbin"
        ]
      )
    );

    program = pkgs.writeShellScript name ''
      set -euo pipefail

      export HOME="${config.home.homeDirectory}"
      export PATH="${path}"

      ${text}
    '';
  in {
    enable = true;
    config =
      {
        Label = label;
        ProgramArguments = ["${program}"];
        RunAtLoad = runAtLoad;
        StandardOutPath = stdout;
        StandardErrorPath = stderr;
      }
      // lib.optionalAttrs (startInterval != null) {
        StartInterval = startInterval;
      }
      // lib.optionalAttrs (startCalendarInterval != null) {
        StartCalendarInterval = startCalendarInterval;
      }
      // lib.optionalAttrs (keepAlive != null) {
        KeepAlive = keepAlive;
      }
      // lib.optionalAttrs (workingDirectory != null) {
        WorkingDirectory = workingDirectory;
      }
      // lib.optionalAttrs (environment != {}) {
        EnvironmentVariables = environment;
      }
      // extraConfig;
  };
in {
  launchd.agents = utils.imp.doImports' ./agents (context // {inherit mkAgent;});
}
