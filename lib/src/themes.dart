part of atom;

class ThemeManager {
  final js.JsObject obj;

  ThemeManager(this.obj);

  List<String> get loadedThemeNames => obj.callMethod("getLoadedThemeNames");
  List<String> get activeThemeNames => obj.callMethod("getActiveThemeNames");
  List<String> get enabledThemeNames => obj.callMethod("getEnabledThemeNames");

  void onDidChangeActiveThemes(Action action) {
    obj.callMethod("onDidChangeActiveThemes", [action]);
  }
}
