import "package:atom/builder.dart";

void main() {
  menu("dart")
    .createMenu("Packages")
      .createSubMenu("Dart Example Package")
        .createCommand("Test", "dart-example:test");

  keymap("dart")
    .map("atom-text-editor", "cmd-alt-m", "dart-example:test");

  stylesheet("dart")
    .block(".test")
      .property("color", "blue");

  build();
}
