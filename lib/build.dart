/**
 * Note: This is not the builder, this is the build script that packages use to compile, and run package scripts.
 */
library atom.tool.build;

import "dart:async";
import "dart:io";
import "dart:convert";

final List<String> scripts = [];
bool isDevEnabled = false;

main(List<String> args) async {
  isDevEnabled = args.contains("--dev") || args.contains("-d");

  await runPackageScript();
  await findScripts();
  await compile();
  await cleanup();
  await checkPackageJson();
}

findScripts() async {
  var dir = new Directory("lib");
  scripts.addAll(
    await dir.list(recursive: true)
      .where((it) => it is File && it.path.endsWith(".dart"))
      .map((it) => it.path.replaceAll(dir.parent.path + "/", ""))
      .where((it) => !it.contains("packages/"))
      .toList()
  );

  var a = [];
  for (var p in scripts) {
    var f = new File(p);
    if ((await f.readAsString()).trim().startsWith("part of")) {
      a.add(p);
    }
  }
  scripts.removeWhere((it) => a.contains(it));
}

checkPackageJson() async {
  var pkg;
  try {
    pkg = await loadPackageJson();
  } on FormatException catch (e) {
    print("[package.json] Syntax Error: ${e.toString()}");
    exit(1);
  }

  var hasErrors = false;
  var main = pkg["main"] != null ? pkg["main"] : "index.js";

  var mainScript = new File(main);
  if (!await mainScript.exists()) {
    print("[package.json] ERROR: Unknown Main Script: ${main}");
    hasErrors = true;
  }

  if (hasErrors) {
    exit(1);
  }
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
  stdout.addStream(process.stdout);
  stderr.addStream(process.stderr);
  var code = await process.exitCode;
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
      ["${it}.deps"]
        ..addAll(includeScripts ? [it] : [])
        ..addAll((includeScripts && !isDevEnabled) ? ["${it}.map"] : [])
    );
  for (var name in files) {
    var file =  new File(name);
    if (await file.exists()) {
      await file.delete();
    }
  }
}

runPackageScript() async {
  var f = new File("package.dart");

  if (await f.exists()) {
    print("[Package Script] Running Script");
    await exec("dart package.dart");
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
self.Object = Object;
""";
