part of atom;

final Atom atom = new Atom();

typedef void ObjectConsumer(js.JsObject obj);
typedef void Action();

final ModuleExports exports = new ModuleExports();

List<Function> _onActivate = [];
List<Action> _onDeactivate = [];
bool _activateHooked = false;
bool _deactivateHooked = false;

void onPackageActivated(Function function) {
  if (!_activateHooked) {
    exports.activate = ([state]) {
      for (var c in _onActivate) {
        if (c is Action) {
          c();
        } else {
          c(state);
        }
      }
    };
    _activateHooked = true;
  }

  _onActivate.add(function);
}

void onPackageDeactivated(Action action) {
  if (!_deactivateHooked) {
    exports.deactivate = () {
      for (var f in _onDeactivate) {
        f();
      }
    };
    _deactivateHooked = true;
  }
  _onDeactivate.add(action);
}

class ModuleExports extends ProxyHolder {
  ModuleExports() : super(global["module"]["exports"]);

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

  dynamic add(name, value) => obj[name.toString()] = value;
  dynamic get(name) => obj[name.toString()];

  js.JsObject get config => obj["config"];
  set config(input) => obj["config"] = jsify(input);

  operator [](name) {
    return get(name);
  }

  operator []=(name, value) => add(name, value);
}

class ClipboardContent {
  final String text;
  final Map metadata;

  ClipboardContent(this.text, this.metadata);
}

class Clipboard extends ProxyHolder {
  Clipboard(js.JsObject obj) : super(obj);

  String read() => invoke("read");
  ClipboardContent readWithMetadata() =>
      new ClipboardContent(obj["text"], obj["metadata"]);

  void write(String text, [Map metadata = const {}]) {
    invoke("write", text, metadata);
  }
}

class Atom extends ProxyHolder {
  Workspace _workspace;
  CommandRegistry _commands;
  PackageManager _packages;
  StyleManager _styles;
  ThemeManager _themes;
  MenuManager _menu;
  Clipboard _clipboard;
  ContextMenuManager _contextMenu;
  TooltipManager _tooltips;
  Config _config;

  Atom() : super(global["atom"]) {
    _workspace = new Workspace(obj["workspace"]);
    _commands = new CommandRegistry(obj["commands"]);
    _packages = new PackageManager(obj["packages"]);
    _styles = new StyleManager(obj["styles"]);
    _themes = new ThemeManager(obj["themes"]);
    _menu = new MenuManager(obj["menu"]);
    _clipboard = new Clipboard(obj["clipboard"]);
    _contextMenu = new ContextMenuManager(obj["contextMenu"]);
    _tooltips = new TooltipManager(obj["tooltips"]);
    _config = new Config(obj["config"]);
  }

  Workspace get workspace => _workspace;
  CommandRegistry get commands => _commands;
  PackageManager get packages => _packages;
  StyleManager get styles => _styles;
  ThemeManager get themes => _themes;
  MenuManager get menu => _menu;
  Clipboard get clipboard => _clipboard;
  ContextMenuManager get contextMenu => _contextMenu;
  TooltipManager get tooltips => _tooltips;
  Config get config => _config;

  Project get project => new Project(obj["project"]);
  NotificationManager get notifications =>
      new NotificationManager(obj['notifications']);

  void open(List<String> paths, {bool newWindow, bool devMode, bool safeMode}) {
    var opts = omap({
      "pathsToOpen": paths,
      "newWindow": newWindow,
      "devMode": devMode,
      "safeMode": safeMode
    });

    invoke("open", opts);
  }

  void reopenItem() => invoke("reopenItem");

  Disposable onDidBeep(Action callback) {
    return new Disposable(invoke("onDidBeep", callback));
  }

  void close() => invoke("close");

  WindowSize get size => new WindowSize.fromJS(invoke("getSize"));
  set size(WindowSize size) {
    invoke("setSize", size.width, size.height);
  }

  Position get position => new Position.fromJS(invoke("getPosition"));
  set position(Position pos) {
    invoke("setPosition", pos.x, pos.y);
  }

  void beep() => invoke("beep");

  int confirm(String message, {String detailedMessage, buttons}) {
    if (buttons != null) {
      if (buttons is! List<String> && buttons is! Map<String, Function>) {
        throw new ArgumentError.value(buttons, "buttons",
            "Should be either a List<String> or a Map<String, Function>");
      }
    }

    return invoke("confirm", omap({
      "message": message,
      "detailedMessage": detailedMessage,
      "buttons": buttons
    }));
  }

  bool get isDevMode => invoke("isDevMode");
  bool get isSafeMode => invoke("isSafeMode");
  bool get isSpecMode => invoke("isSpecMode");

  String get version => invoke("getVersion");
  bool get isReleasedVersion => invoke("isReleasedVersion");

  num get windowLoadTime => invoke("getWindowLoadTime");

  void openDevTools() => invoke("openDevTools");
  void toggleDevTools() => invoke("toggleDevTools");
  void executeJavaScriptInDevTools(String code) =>
      invoke("executeJavaScriptInDevTools", code);

  void show() => invoke("show");
  void hide() => invoke("hide");
  void center() => invoke("center");
  void reload() => invoke("reload");
  bool get isMaximized => invoke("isMaximized");
  bool get isFullscreen => invoke("isFullscreen");
  set isFullscreen(bool value) => invoke("setFullscreen", value);
  bool toggleFullscreen() => invoke("toggleFullscreen");
}

final Console console = new Console();

class Console extends ProxyHolder {
  Console() : super(global["console"]);

  void log(String text) => invoke("log", text);
  void error(String text) => invoke("error", text);
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

class Disposable extends ProxyHolder {
  Disposable(js.JsObject obj) : super(obj);

  void dispose() => invoke("dispose");
}
