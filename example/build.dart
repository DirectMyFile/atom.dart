import "dart:async";
import "dart:io";
import "dart:convert";

const List<String> scripts = const [
  "lib/index.dart"
];

main() async {
  await compile();
  await cleanup();
}

Future<dynamic> loadPackageJson([String path = "package.json"]) async {
  return JSON.decode(await new File(path).readAsString());
}

fetchDependencies() async {
  var pubspec = new File("pubspec.yaml");

  if (await pubspec.exists()) {
    await exec("pub get");
  }
}

compile() async {
  await cleanup(includeScripts: true);

  for (var script in scripts) {
    var js = getJsName(script);
    print("[Compile] ${script}");
    await exec("dart2js --csp -o ${js} ${script}");
    var file = new File(js);
    var content = await file.readAsString();
    content = fixScript(content);
    await file.writeAsString(content);
  }
}

exec(String command) async {
  var split = command.split(" ");
  var executable = split.first;
  var args = split.skip(1).toList();
  var process = await Process.start(executable, args);
  var sub = stdin.listen((data) {
    process.stdin.add(data);
  });
  stdout.addStream(process.stdout);
  stderr.addStream(process.stderr);
  var code = await process.exitCode;
  await sub.cancel();
  if (code != 0) {
    print("Process exited with code: ${code}");
    exit(code);
  }
}

String getJsName(String file) => file.replaceAll(".dart", ".js");

cleanup({bool includeScripts: false}) async {
  var files = scripts
    .map(getJsName)
    .expand((it) =>
      ["${it}.deps"]..addAll(includeScripts ? [it, "${it}.map"] : []));
  for (var name in files) {
    var file =  new File(name);
    if (await file.exists()) {
      await file.delete();
    }
  }
}

String fixScript(String input) {
  return HEADER + "\n" + input.replaceAll(r'if (typeof document === "undefined") {', "if (true) {");
}

final String HEADER = """
var self = Object.create(this);
self.require = require;
self.module = module;
self.window = window;
self.atom = atom;
self.exports = exports;
""";
