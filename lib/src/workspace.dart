part of atom;

class Workspace {
  final js.JsObject obj;

  Workspace(this.obj);

  TextEditor get activeTextEditor => new TextEditor.wrap(obj.callMethod("getActiveTextEditor"));
  List<TextEditor> get textEditors => obj.callMethod("getTextEditors").map((it) => new TextEditor.wrap(it)).toList();

  Disposable observeTextEditors(Consumer<TextEditor> callback) {
    return new Disposable(obj.callMethod("observeTextEditors", [(o) => callback(new TextEditor.wrap(o))]));
  }

  Future<TextEditor> open(String uri, {int initialLine, int initialColumn, String split, bool activatePane, bool searchAllPanes}) async {
    var map = omap({
      "initialLine": initialLine,
      "initialColumn": initialColumn,
      "split": split,
      "activatePane": activatePane,
      "searchAllPanes": searchAllPanes
    });

    return new TextEditor.wrap(await promiseToFuture(
      obj.callMethod("open", [uri, map])
    ));
  }

  Future reopenItem() => promiseToFuture(obj.callMethod("reopenItem"));
  Disposable addOpener(callback(String uri)) {
    return new Disposable(obj.callMethod("addOpener", [callback]));
  }
}

typedef void Consumer<T>(T input);
