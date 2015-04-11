import "dart:io";
import "dart:convert";

void main() {
  var aapi = loadAtomAPI();
  var oapi = loadOurAPI();

  for (var c in aapi.classNames) {
    if (!oapi.containsKey(c) || oapi[c] != "class") {
      print("Missing Class: ${c}");
    }
  }
}

Map<String, String> loadOurAPI() {
  var result = Process.runSync(
    Platform.isWindows ? "dartdocgen.bat" : "dartdocgen",
    "--no-include-sdk --package-root=packages --indent-json lib/atom.dart".split(" ")
  );

  if (result.exitCode != 0) {
    print("Failed to generate our documentation!");
    print("STDOUT:");
    print(result.stdout);
    print("STDERR:");
    print(result.stderr);
    exit(1);
  }

  var json = JSON.decode(new File("docs/index.json").readAsStringSync());
  var map = {};
  for (var k in json.keys) {
    if (k.startsWith("atom/atom.")) {
      map[k.substring("atom/atom.".length)] = json[k];
    }
  }
  return map;
}

class AtomApi {
  final List<AtomClass> classes;

  AtomApi(this.classes);

  factory AtomApi.fromJSON(api) {
    var classes = [];
    var cl = api["classes"];
    for (var name in cl.keys) {
      var ac = new AtomClass.fromJSON(cl[name]);
      classes.add(ac);
    }

    return new AtomApi(classes);
  }

  List<String> get classNames => classes.map((it) => it.name).toList();
  bool hasClass(String name) {
    return classNames.contains(name);
  }
}

class AtomClass {
  final String name;

  AtomClass(this.name);
  factory AtomClass.fromJSON(c) {
    return new AtomClass(c["name"]);
  }
}

AtomApi loadAtomAPI() {
  return new AtomApi.fromJSON(JSON.decode(new File("tool/atom-api.json").readAsStringSync()));
}
