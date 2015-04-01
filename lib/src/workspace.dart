part of atom;

class Workspace {
  final js.JsObject obj;

  Workspace(this.obj);

  TextEditor get activeTextEditor => new TextEditor.wrap(obj.callMethod("getActiveTextEditor"));
  List<TextEditor> get textEditors => obj.callMethod("getTextEditors").map((it) => new TextEditor.wrap(it)).toList();

  Disposable observeTextEditors(Consumer<TextEditor> callback) {
    return new Disposable(obj.callMethod("observeTextEditors", [(o) => callback(new TextEditor.wrap(o))]));
  }
}

typedef void Consumer<T>(T input);
