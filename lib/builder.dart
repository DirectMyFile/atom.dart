library atom.builder;

import "dart:io";
import "dart:convert";

class Menu {
  final String label;
  final List<Menu> submenus;

  bool _root = false;
  bool get isRoot => _root;

  String command;

  Menu(this.label) : submenus = [];
  Menu.root(this.label) : _root = true, submenus = [];

  void addSubMenu(Menu menu) {
    submenus.add(menu);
  }

  Menu createSubMenu(String label) {
    var m = new Menu(label);
    addSubMenu(m);
    return m;
  }

  /// This returns [this].
  Menu createCommand(String label, String command) {
    createSubMenu(label)..command = command;
    return this;
  }

  void addMenu(Menu menu) {
    submenus.add(menu);
  }

  Menu createMenu(String label) {
    var m = new Menu(label);
    addMenu(m);
    return m;
  }

  Map toJSON() {
    if (isRoot) {
      return {
        "menu": submenus.map((it) => it.toJSON()).toList()
      };
    }

    var map = {
      "label": label
    };

    if (command != null) {
      map["command"] = command;
    }

    if (submenus != null && submenus.isNotEmpty) {
      map["submenu"] = submenus.map((it) => it.toJSON()).toList();
    }

    return map;
  }
}

class KeyMap {
  final String name;
  final Map<String, Map<String, String>> mappings;

  KeyMap(this.name) : mappings = {};

  KeyMap map(String block, String key, String command) {
    if (!mappings.containsKey(block)) {
      mappings[block] = {};
    }

    mappings[block][key] = command;
    return this;
  }

  KeyMap add(String block, String key, String command) => map(block, key, command);

  Map toJSON() => mappings;
}

class Stylesheet {
  final String name;
  final List<StyleBlock> blocks = [];

  Stylesheet(this.name);

  StyleBlock block(String selector) {
    var b = new StyleBlock(selector);
    blocks.add(b);
    return b;
  }

  String build() {
    var buff = new StringBuffer();
    for (var block in blocks) {
      buff.writeln("${block.selector} {");
      var str = block.build();

      buff.writeln((str.isNotEmpty ? "  " : "") + str.split("\n").map((it) => "  ${it}").join("\n").trim());
      buff.writeln("}");
    }
    return buff.toString();
  }
}

class StyleBlock {
  final String selector;
  final List<StyleBlock> blocks = [];
  final Map<String, String> properties = {};

  StyleBlock(this.selector);

  StyleBlock block(String selector) {
    var b = new StyleBlock(selector);
    blocks.add(b);
    return b;
  }

  StyleBlock property(String key, value) {
    properties[key] = value.toString();
    return this;
  }

  String build() {
    var buff = new StringBuffer();
    for (var block in blocks) {
      buff.writeln("${block.selector} {");
      var str = block.build();

      buff.writeln((str.isNotEmpty ? "  " : "") + str.split("\n").map((it) => "  ${it}").join("\n"));
      buff.writeln("}");
    }

    for (var prop in properties.keys) {
      buff.writeln("${prop}: ${properties[prop]};");
    }

    return buff.toString();
  }
}

List<Menu> _menuFiles = [];
List<KeyMap> _keymaps = [];
List<Stylesheet> _stylesheets = [];

Menu menu(String name) {
  var m = new Menu.root(name);
  _menuFiles.add(m);
  return m;
}

KeyMap keymap(String name) {
  var m = new KeyMap(name);
  _keymaps.add(m);
  return m;
}

Stylesheet stylesheet(String name) {
  var m = new Stylesheet(name);
  _stylesheets.add(m);
  return m;
}

void build() {
  for (var m in _menuFiles) {
    var file = new File("menus/${m.label}.json");
    file.createSync(recursive: true);
    file.writeAsStringSync(new JsonEncoder.withIndent("  ").convert(m.toJSON()));
  }

  for (var m in _keymaps) {
    var file = new File("keymaps/${m.name}.json");
    file.createSync(recursive: true);
    file.writeAsStringSync(new JsonEncoder.withIndent("  ").convert(m.toJSON()));
  }

  for (var m in _stylesheets) {
    var file = new File("styles/${m.name}.less");
    file.createSync(recursive: true);
    file.writeAsStringSync(m.build());
  }
}
