part of atom;

class StyleManager {
  final js.JsObject obj;

  StyleManager(this.obj);

  String get userStyleSheetPath => obj.callMethod("getUserStyleSheetPath");
}
