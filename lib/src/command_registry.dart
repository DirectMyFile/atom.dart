part of atom;

class CommandRegistry {
  final js.JsObject o;

  CommandRegistry(this.o);

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
