import "package:atom/atom.dart";

void main() {
  exports.activate = activate;

  exports.deactivate = () {
    print("Package Deactivated");
  };
}

void activate() {
  atom.workspace.observeTextEditors((editor) {
    print("Text Editor Opened");
  });
}
