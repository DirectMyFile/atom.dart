part of atom;

class Menu {
  final String label;
  final List<Menu> submenu;
  final String command;

  Menu(this.label, {this.command}) : submenu = [];
  Menu.fromJS(js.JsObject obj)
      : label = obj["label"],
        command = obj["command"],
        submenu = (obj["submenu"] == null ? null : fromArray(obj["submenu"]));

  static List<Menu> fromArray(List<js.JsObject> objs) {
    return objs.map((it) => new Menu.fromJS(it)).toList();
  }

  js.JsObject toJS() {
    var m = {};

    if (label != null) {
      m["label"] = label;
    }

    if (command != null) {
      m["command"] = command;
    }

    if (submenu != null && submenu.isNotEmpty) {
      m["submenu"] = toArray(submenu);
    }

    return m;
  }

  static js.JsArray toArray(List<Menu> menus) {
    return new js.JsObject.jsify(menus.map((it) => it.toJS()).toList());
  }
}

class MenuManager {
  final js.JsObject obj;

  MenuManager(this.obj);

  Disposable add(List<Menu> menus) {
    return new Disposable(obj.callMethod("add", [Menu.toArray(menus)]));
  }

  void update() {
    obj.callMethod("update");
  }
}

class ContextMenuManager {
  final js.JsObject obj;

  ContextMenuManager(this.obj);

  Disposable add(List<Menu> menus) {
    return new Disposable(obj.callMethod("add", [Menu.toArray(menus)]));
  }
}
