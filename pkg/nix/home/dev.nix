{pkgs}:
with pkgs; [
  protobuf
  android-tools
  # FIXME: BROKEN PACKAGE (CSTD23 incompatibility)
  # protoc-gen-js
]
