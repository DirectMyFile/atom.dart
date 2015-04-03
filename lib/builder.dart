library atom.builder;

import "dart:io";
import "dart:convert";

class Menu {
  final String selector;
  final String label;
  final List<Menu> submenus;
  final bool contextMenu;

  bool _root = false;
  bool get isRoot => _root;

  String command;

  Menu(this.label) : submenus = [], contextMenu = false, selector = null;
  Menu.root(this.label, {this.contextMenu: false, this.selector}) : _root = true, submenus = [];

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
      if (contextMenu) {
        return {
          "context-menu": {
            selector: submenus.map((it) => it.toJSON()).toList()
          }
        };
      } else {
        return {
          "menu": submenus.map((it) => it.toJSON()).toList()
        };
      }
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

Menu menu(String name, {bool contextMenu: false, String selector}) {
  var m = new Menu.root(name, contextMenu: contextMenu, selector: selector);
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

class Package {
  final Map<String, dynamic> json;

  Package(String name, String version) : json = {} {
    json["name"] = name;
    json["version"] = version;
    json["dependencies"] = {};
    json["engines"] = {};
    json["scripts"] = {};
  }

  String get name => json["name"];
  set name(String value) => json["name"] = value;

  Map<String, String> get dependencies => json["dependencies"];
  Map<String, String> get engines => json["engines"];
  Map<String, String> get scripts => json["scripts"];

  String encodeJSON() => new JsonEncoder.withIndent("  ").convert(json);

  String get main => json["main"];
  set main(String value) => json["main"] = value;

  String get license => json["license"];
  set license(String value) => json["license"] = value;

  String get repository => json["repository"];
  set repository(String value) => json["repository"] = value;

  String get description => json["description"];
  set description(String value) => json["description"] = value;

  Package dependency(String name, String version) {
    dependencies[name] = version;
    return this;
  }

  Package engine(String name, String version) {
    engines[name] = version;
    return this;
  }

  Package script(String hook, String command) {
    scripts[hook] = command;
    return this;
  }

  Package atom(String version) {
    engine("atom", version);
    return this;
  }
}

Package _package;
List<Grammar> _grammars = [];

Package package(String name, String version, {String main, String license, String repository, String description}) {
  var m = new Package(name, version);

  if (main != null) {
    m.main = main;
  }

  if (license != null) {
    m.license = license;
  }

  if (repository != null) {
    m.repository = repository;
  }

  if (m.description != null) {
    m.description = description;
  }

  _package = m;
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

  for (var m in _grammars) {
    var file = new File("grammars/${m.name}.json");
    file.createSync(recursive: true);
    file.writeAsStringSync(new JsonEncoder.withIndent("  ").convert(m.toJSON()));
  }

  if (_package != null) {
    var file = new File("package.json");

    file.writeAsStringSync(_package.encodeJSON());
  }
}

class Grammar {
  final String name;
  final String scope;
  final List<String> fileTypes;
  final List<GrammarPattern> patterns = [];

  Grammar(this.name, this.scope, this.fileTypes);

  Grammar pattern(GrammarPattern pattern) {
    patterns.add(pattern);
    return this;
  }

  void load(void handler(void match(String name, String pattern), void beginEnd(name, String begin, String end, [patterns]))) {
    handler((name, p) => pattern(new MatchGrammarPattern(name, p)), (name, begin, end, [patterns]) {
      pattern(new BeginEndGrammarPattern(name, begin, end, patterns));
    });
  }

  Map toJSON() => {
    "name": name,
    "scope": scope,
    "fileTypes": fileTypes,
    "patterns": patterns.map((it) => it.toJSON()).toList()
  };
}

Grammar grammar(String name, String scope, {List<String> fileTypes: const []}) {
  var m = new Grammar(name, scope, fileTypes);
  _grammars.add(m);
  return m;
}

abstract class GrammarPattern {
  Map toJSON();
}

class MatchGrammarPattern extends GrammarPattern {
  final String name;
  final String match;

  MatchGrammarPattern(this.name, this.match);

  @override
  Map toJSON() => {
    "name": name,
    "match": match
  };
}

class BeginEndGrammarPattern extends GrammarPattern {
  final String name;
  final String begin;
  final String end;
  final List<GrammarPattern> patterns;

  BeginEndGrammarPattern(this.name, this.begin, this.end, [this.patterns]);

  @override
  Map toJSON() {
    var map = {
      "name": name,
      "begin": begin,
      "end": end
    };

    if (patterns != null) {
      map["patterns"] = patterns.map((it) => it.toJSON()).toList();
    }

    return map;
  }
}
