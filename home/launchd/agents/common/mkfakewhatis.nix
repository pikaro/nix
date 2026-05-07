{
  mkAgent,
  pkgs,
  ...
}: {
  update-cache = mkAgent {
    name = "update-whatis-cache";
    packages = with pkgs; [
      coreutils
      curl
    ];
    startInterval = 86400;
    runAtLoad = true;
    text = ''
      DB="$HOME/.local/cache/qman/db.txt"
      mkdir -p "$(dirname "$DB")"
      /usr/bin/apropos "." >"$DB"
      exit $?
    '';
  };
}
