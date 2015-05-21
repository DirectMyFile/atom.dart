part of atom;

typedef void StdioHandler(String data);
typedef void ExitCodeHandler(int exitCode);

class BufferedProcess {
  final js.JsObject obj;

  factory BufferedProcess(String command, List<String> args, {Map options,
      StdioHandler stdout, StdioHandler stderr, ExitCodeHandler exit}) {
    var map = {"command": command, "args": args};

    if (stdout != null) {
      map["stdout"] = stdout;
    }

    if (stderr != null) {
      map["stderr"] = stderr;
    }

    if (exit != null) {
      map["exit"] = exit;
    }

    if (options != null) {
      map["options"] = options;
    }

    var jsBufferedProcess = require('atom')['BufferedProcess'];

    return new BufferedProcess.wrap(
        new js.JsObject(jsBufferedProcess, [new js.JsObject.jsify(map)]));
  }

  BufferedProcess.wrap(this.obj);

  void kill() {
    obj.callMethod("kill");
  }
}
