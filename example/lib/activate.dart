part of atom.example;

void activate() {
  atom.workspace.observeTextEditors((editor) {
    print("Text Editor Opened");
  });
}
