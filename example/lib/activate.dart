part of atom.example;

void activate() {
  print("Dart Package Activated");

  atom.commands.add("atom-workspace", "dart-example:reverse", (e) {
    var editor = atom.workspace.activeTextEditor;
    editor.lastSelection.insertText(new String.fromCharCodes(editor.lastSelection.text.codeUnits.reversed));
  });
}
