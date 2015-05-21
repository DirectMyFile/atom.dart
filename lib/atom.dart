library atom;

import "dart:async";
import "dart:html" hide Selection;
export "dart:html" hide Selection;

import "dart:js" as js;

import "utils.dart";

part "src/color.dart";
part "src/command_registry.dart";
part "src/config.dart";
part "src/core.dart";
part "src/grammars.dart";
part "src/keymap.dart";
part "src/menu.dart";
part "src/notification_manager.dart";
part "src/packages.dart";
part "src/pane.dart";
part "src/panel.dart";
part "src/process.dart";
part "src/project.dart";
part "src/styles.dart";
part "src/text_editor.dart";
part "src/themes.dart";
part "src/tooltips.dart";
part "src/workspace.dart";

js.JsObject require(String input) => js.context.callMethod("require", [input]);
js.JsObject get global => js.context;
