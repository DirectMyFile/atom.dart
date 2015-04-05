library atom;

import "dart:async";
import "dart:html" hide Selection;
export "dart:html" hide Selection;

import "dart:js" as js;

import "utils.dart";

part "src/core.dart";
part "src/command_registry.dart";
part "src/config.dart";
part "src/text_editor.dart";
part "src/workspace.dart";
part "src/packages.dart";
part "src/themes.dart";
part "src/styles.dart";
part "src/menu.dart";
part "src/grammars.dart";
part "src/tooltips.dart";
part "src/project.dart";
part "src/panel.dart";
part "src/pane.dart";
part "src/color.dart";
part "src/keymap.dart";

js.JsObject require(String input) => js.context.callMethod("require", [input]);
js.JsObject get global => js.context;

js.JsObject toJsObject(Map map) {
  return new js.JsObject.jsify(map);
}
