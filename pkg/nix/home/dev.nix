{pkgs}:
with pkgs; [
  protobuf
  # FIXME: BROKEN PACKAGE (CSTD23 incompatibility)
  # protoc-gen-js
]
