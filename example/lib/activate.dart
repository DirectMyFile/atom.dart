part of atom.example.text;

typedef void TextReplacer(String text);
typedef void SelectionModifier(Selection selection, String text, TextReplacer replace);

void addSelectionModifier(String name, SelectionModifier handler) {
  atom.commands.add("atom-workspace", "dart-text:${name}", (e) {
    var editor = atom.workspace.activeTextEditor;
    var selection = editor.lastSelection;

    if (selection.obj == null) {
      console.error("No Selection");
      return;
    }

    handler(selection, selection.text, (m) => selection.insertText(m));
  });
}

void activate() {
  addSelectionModifier("reverse", (selection, text, replace) {
    replace(new String.fromCharCodes(text.codeUnits.reversed));
  });

  addSelectionModifier("encode_base64", (selection, text, replace) {
    replace(CryptoUtils.bytesToBase64(UTF8.encode(text)));
  });

  addSelectionModifier("decode_base64", (selection, text, replace) {
    replace(UTF8.decode(CryptoUtils.base64StringToBytes(text)));
  });

  addSelectionModifier("lowercase", (selection, String text, replace) {
    replace(text.toLowerCase());
  });

  addSelectionModifier("uppercase", (selection, String text, replace) {
    replace(text.toUpperCase());
  });

  addSelectionModifier("switchcase", (selection, text, replace) {
    var x = new List<String>.generate(text.length, (i) => text[i])
      .map((it) => it.toUpperCase() == it ? it.toLowerCase() : it.toUpperCase())
      .join();

    replace(x);
  });

  addSelectionModifier("uppercase", (selection, text, replace) {
    replace(text.toUpperCase());
  });
}
