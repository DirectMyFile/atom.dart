part of atom;

class KeymapManager {
  final js.JsObject obj;

  KeymapManager(this.obj);

  void add(String selector, Map<String, Map<String, String>> bindings) {
    var o = jsify(bindings);

    obj.callMethod("add", [selector, o]);
  }
}
