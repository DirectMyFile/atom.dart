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
  String get path => obj.callMethod("getPath");
  String get workingDirectory => obj.callMethod("getWorkingDirectory");
  bool get isProjectAtRoot => obj.callMethod("isProjectAtRoot");
  String relativize() => obj.callMethod("relativize");
  bool get hasBranch => obj.callMethod("hasBranch");
  String getShortHead(String path) => obj.callMethod("getShortHead", [path]);
  bool isSubmodule(String path) => obj.callMethod("isSubmodule", [path]);
  int getAheadBehindCount(String ref, String path) => obj.callMethod("getAheadBehindCount", [ref, path]);
  int getCachedUpstreamAheadBehindCount(String path) => obj.callMethod("getCachedUpstreamAheadBehindCount", [path]);
  dynamic getConfigValue(String path) => obj.callMethod("getConfigValue", [path]);
  String getOriginUrl([String path]) => obj.callMethod("getOriginURL", [path]);
  String getUpstreamBranch(String path) => obj.callMethod("getUpstreamBranch", [path]);
  GitReferences getReferences(String path) => new GitReferences(obj.callMethod("getReferences", [path]));

  bool isPathModified(String path) => obj.callMethod("isPathModified", [path]);
  bool isPathNew(String path) => obj.callMethod("isPathNew", [path]);
  bool isPathIgnored(String path) => obj.callMethod("isPathIgnored", [path]);
  int getDirectoryStatus(String path) => obj.callMethod("getDirectoryStatus", [path]);
  int getPathStatus(String path) => obj.callMethod("getPathStatus", [path]);
  int getCachedPathStatus(String path) => obj.callMethod("getCachedPathStatus", [path]);
  bool isStatusModified(int status) => obj.callMethod("isStatusModified", [status]);
  bool isStatusNew(int status) => obj.callMethod("isStatusNew", [status]);
  bool checkoutHead(String path) => obj.callMethod("checkoutHead", [path]);
  bool checkoutReference(String reference, [bool create = true]) {
    return obj.callMethod("checkoutReference", [reference, create]);
  }
}

class GitReferences {
  final js.JsObject obj;

  GitReferences(this.obj);

  List<String> get heads => obj["heads"];
  List<String> get remotes => obj["remotes"];
  List<String> get tags => obj["tags"];
}

class Directory {
  final js.JsObject obj;

  Directory(this.obj);

  String get path => obj.callMethod("getPath");
  Future<bool> exists() => promiseToFuture(obj.callMethod("exists"));
  bool get isRoot => obj.callMethod("isRoot");
  String get baseName => obj.callMethod("getBaseName");
}
