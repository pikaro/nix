# FIXME: NOT WORKING - How to copy these?
{inputs, ...}: {
  "${inputs.keyboard}/USCustom.keylayout" = "Library/Keyboard Layouts/USCustom.keylayout";
  "${inputs.keyboard}/USCustom.icns" = "Library/Keyboard Layouts/USCustom.icns";
  "Library/Fonts/sketchybar-app-font.ttf".source = "${inputs.sketchybar-app-font}";
}
