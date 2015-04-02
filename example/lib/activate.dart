part of atom.example;

void activate() {
  print("Dart Package Activated");

  atom.commands.add("atom-workspace", "dart-example:test", (e) {
    var editor = atom.workspace.activeTextEditor;
    editor.insertText("Hello World");
    editor.insertNewLine();
    editor.insertText("Goodbye World");
    editor.moveToTop();
  });
}
