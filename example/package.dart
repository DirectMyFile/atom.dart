import "package:atom/builder.dart";

Menu textMenu = menu("dart-text")
  .createMenu("Packages")
  .createSubMenu("Dart Text Utilities");

void main() {
  add("Reverse", "reverse");
  add("Base64 Encode", "encode_base64");
  add("Base64 Decode", "decode_base64");
  add("Uppercase", "uppercase");
  add("Lowercase", "lowercase");
  add("Switchcase", "switchcase");

  build();
}

void add(String name, String cmd) {
  textMenu.createCommand(name, "dart-text:${cmd}");
}
