# Atom

Make Atom Packages in Dart

## Features

- Atom API Bindings
- Super Awesome Package Builder

## Example Code

```dart
import "package:atom/atom.dart";

void main() {
  onPackageActivated(activate);
}

void activate() {
  atom.workspace.observeTextEditors((TextEditor editor) {
    print("Text Editor Opened");
    editor.onWillInsertText((WillInsertTextEvent event) {
      print("Inserting Text: ${event.text}");
    });
  });
}
```

## Example Package

See the [example package](https://github.com/DirectMyFile/atom.dart/tree/master/example) for more information.

## Package Builder

The package builder is a script that builds your package using the instructions you give it.

It generates the following:

- Styles
- KeyMaps
- Menus
- Context Menus
- Grammars
- package.json

And it also compiles your code to JavaScript and lints your package.json!

### Example

```dart
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

  build();
}

void addTextModifier(String name, String cmd) {
  textMenu.createCommand(name, "dart-text:${cmd}");
}
```
