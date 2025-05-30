{lib, ...}: rec {
  formatList = template: list:
    map (item: lib.replaceStrings ["%s"] [item] template) list;
  formatListJoin = template: list: sep:
    lib.concatStringsSep sep (formatList template list);
}
