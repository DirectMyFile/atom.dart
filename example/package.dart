import "package:atom/builder.dart";

void main() {
  menu("dart")
    .createMenu("Packages")
      .createSubMenu("Dart Example Package")
        .createCommand("Reverse Text", "dart-example:reverse");

  keymap("dart")
    .map("atom-text-editor", "cmd-alt-r", "dart-example:reverse");

  stylesheet("dart")
    .block(".test")
      .property("color", "blue");

  build();
}
