part of atom;

class TooltipManager {
  final js.JsObject obj;

  TooltipManager(this.obj);

  Disposable add(target, String title, {String keyBindingCommand}) {
    return new Disposable(obj.callMethod("add", [
      target,
      omap({"title": title, "keyBindingCommand": keyBindingCommand})
    ]));
  }
}
