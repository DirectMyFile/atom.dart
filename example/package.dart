import "package:atom/builder.dart";

Menu textMenu = menu("dart-text", contextMenu: true, selector: "atom-workspace")
  .createMenu("Text Utilities");

void main() {
  package(
    "dart-text",
    "0.1.0",
    license: "MIT",
    repository: "https://github.com/DirectMyFile/atom.dart",
    description: "Text Utilities in Dart",
    main: "lib/index.js"
  ).atom(">0.180.0");

  addTextModifier("Reverse", "reverse");
  addTextModifier("Base64 Encode", "encode_base64");
  addTextModifier("Base64 Decode", "decode_base64");
  addTextModifier("Uppercase", "uppercase");
  addTextModifier("Lowercase", "lowercase");
  addTextModifier("Switchcase", "switchcase");
  addTextModifier("Tokenize Syntax", "tokenize");

  build();
}

void addTextModifier(String name, String cmd) {
  textMenu.createCommand(name, "dart-text:${cmd}");
}
