{pkgs}:
with pkgs; [
  bitwarden-cli
  # FIXME: BROKEN
  #choose-gui
  coreutils
  fd
  graphviz
  imagemagick
  jd-diff-patch
  jless
  marp-cli
  mcp-proxy
  # md2pdf
  mermaid-cli
  nix-tree
  pandoc
  plantuml
  rlwrap
  sketchybar
  sqlite
  starship
  tenv
  # FIXME: OUTDATED
  # tree-sitter
  weechat
  yq-go
]
