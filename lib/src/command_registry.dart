part of atom;

class CommandRegistry extends ProxyHolder {
  CommandRegistry(js.JsObject obj) : super(obj);

  Disposable add(String target, String command, void callback(event)) {
    return new Disposable(invoke("add", target, command, callback));
  }
}
