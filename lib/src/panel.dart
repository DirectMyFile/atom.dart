part of atom;

class Panel {
  final js.JsObject obj;

  Panel(this.obj);

  void destroy() {
    obj.callMethod("destroy");
  }

  get item => obj.callMethod("getItem");
  int get priority => obj.callMethod("getPriority");
  void show() => obj.callMethod("show");
  void hide() => obj.callMethod("hide");

  bool get isVisible => obj.callMethod("isVisible");

  Disposable onDidDestroy(Action callback) {
    return new Disposable(obj.callMethod("onDidDestroy", [callback]));
  }

  Disposable onDidChangeVisible(Consumer<bool> callback) {
    return new Disposable(obj.callMethod("onDidChangeVisible", [callback]));
  }
}
