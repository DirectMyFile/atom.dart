part of atom.example;

void activate() {
  print("Dart Package Activated");

  atom.commands.add("atom-workspace", "dart-example:reverse", (e) {
    var editor = atom.workspace.activeTextEditor;
    var selection = editor.lastSelection;

    if (selection.obj == null) {
      console.error("No Selection");
      return;
    }

    editor.lastSelection.insertText(new String.fromCharCodes(editor.lastSelection.text.codeUnits.reversed));
  });
}
