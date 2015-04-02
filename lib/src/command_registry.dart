part of atom;

class CommandRegistry {
  static final js.JsObject o = js.context["atom"]["commands"];

  Disposable add(String target, String command, void callback(event)) {
    return new Disposable(
      o.callMethod("add", [
        target,
        command,
        callback
      ])
    );
  }
}
