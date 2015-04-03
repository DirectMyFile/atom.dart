part of atom;

class Project {
  final js.JsObject obj;

  Project(this.obj);

  List<String> get paths => obj.callMethod("getPaths");
  set paths(List<String> value) => obj.callMethod("setPaths", [value]);
  void addPath(String path) {
    obj.callMethod("addPath", [path]);
  }

  void removePath(String path) {
    obj.callMethod("removePath", [path]);
  }

  Future<List<GitRepository>> getRepositories() async {
    var dirs = await getDirectories();

    var dirobjs = dirs.map((it) => it.obj).toList();
    var objs = await promiseToFuture(Promise.all(dirobjs.map((it) => obj.callMethod("repositoryForDirectory", [it])).toList()));

    return objs.map((it) => new GitRepository(it)).toList();
  }

  Future<List<Directory>> getDirectories() async {
    var objs = await promiseToFuture(obj.callMethod("getDirectories"));
    return objs.map((it) => new Directory(it)).toList();
  }

  bool contains(String path) => obj.callMethod("contains", [path]);
}

class GitRepository {
  final js.JsObject obj;

  GitRepository(this.obj);

  String get type => obj.callMethod("getType");
}

class Directory {
  final js.JsObject obj;

  Directory(this.obj);

  String get path => obj.callMethod("getPath");
  Future<bool> exists() => promiseToFuture(obj.callMethod("exists"));
  bool get isRoot => obj.callMethod("isRoot");
  String get baseName => obj.callMethod("getBaseName");
}
