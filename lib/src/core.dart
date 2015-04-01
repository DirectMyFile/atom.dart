part of atom;

final Atom atom = new Atom();

typedef void ObjectConsumer(js.JsObject obj);
typedef void Action();

final ModuleExports exports = new ModuleExports();

class ModuleExports {
  js.JsObject obj;

  ModuleExports() {
    obj = global["module"]["exports"];
  }

  Function get activate => obj["activate"];
  set activate(Function function) {
    if (function is Action) {
      var x = function;
      function = ([state]) => x();
    }

    obj["activate"] = function;
  }

  Function get deactivate => obj["deactivate"];

  set deactivate(Action function) {
    obj["deactivate"] = function;
  }
}

class Atom {
  static final js.JsObject o = js.context["atom"];

  final CommandRegistry commands = new CommandRegistry();

  Atom();

  void open(List<String> paths, {bool newWindow, bool devMode, bool safeMode}) {
    var opts = omap({
      "pathsToOpen": paths,
      "newWindow": newWindow,
      "devMode": devMode,
      "safeMode": safeMode
    });

    o.callMethod("open", [opts]);
  }

  void close() {
    o.callMethod("close");
  }

  WindowSize get size => new WindowSize.fromJS(o.callMethod("getSize"));
  set size(WindowSize size) {
    o.callMethod("setSize", [size.width, size.height]);
  }

  Position get position => new Position.fromJS(o.callMethod("getPosition"));
  set position(Position pos) {
    o.callMethod("setPosition", [pos.x, pos.y]);
  }

  void beep() {
    o.callMethod("beep");
  }

  int confirm(String message, {String detailedMessage, buttons}) {
    if (buttons != null) {
      if (buttons is! List<String> && buttons is! Map<String, Function>) {
        throw new ArgumentError.value(buttons, "buttons", "Should be either a List<String> or a Map<String, Function>");
      }
    }

    o.callMethod("confirm", [
      omap({
        "message": message,
        "detailedMessage": detailedMessage,
        "buttons": buttons
      })
    ]);
  }
}

class WindowSize {
  final int width;
  final int height;

  WindowSize(this.width, this.height);
  WindowSize.fromJS(js.JsObject obj) : this(obj["width"], obj["height"]);
}

class Position {
  final int x;
  final int y;

  Position(this.x, this.y);
  Position.fromJS(js.JsObject obj) : this(obj["x"], obj["y"]);
}

class Disposable {
  final js.JsObject obj;

  Disposable(this.obj);

  void dispose() {
    obj.callMethod("dispose");
  }
}
