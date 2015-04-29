part of atom;

typedef void StdioHandler(String data);
typedef void ExitCodeHandler(int exitCode);

class BufferedProcess {
  final js.JsObject obj;

  factory BufferedProcess(String command, List<String> args, {
    StdioHandler stdout,
    StdioHandler stderr,
    ExitCodeHandler exit
  }) {
    var map = {
      "command": command,
      "args": args
    };

    if (stdout != null) {
      map["stdout"] = stdout;
    }

    if (stderr != null) {
      map["stderr"] = stderr;
    }

    if (exit != null) {
      map["exit"] = exit;
    }

    return new BufferedProcess.wrap(global.callMethod("BufferedProcess", [map]));
  }

  BufferedProcess.wrap(this.obj);

  void kill() {
    obj.callMethod("kill");
  }
}
