{lib, ...}: {
  formatList = template: list:
    lib.concatStringsSep "\n" (map (item: lib.replaceStrings ["%s"] [item] template) list);
}
