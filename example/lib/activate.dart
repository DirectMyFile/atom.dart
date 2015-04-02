part of atom.example;

void activate() {
  atom.workspace.observeTextEditors((TextEditor editor) {
    print("Text Editor for file ${editor.path}");

    editor.onDidSave(() {
      print("${editor.path} saved.");
    });
  });
}
