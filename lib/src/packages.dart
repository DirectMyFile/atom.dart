part of atom;

class PackageManager {
  final js.JsObject obj;

  PackageManager(this.obj);

  String get apmPath => obj.callMethod("getApmPath");
  List<String> get packageDirPaths => obj.callMethod("getPackageDirPaths");

  String resolvePackagePath(String name) {
    return obj.callMethod("resolvePackagePath", [name]);
  }

  bool isBundledPackage(String name) {
    return obj.callMethod("isBundledPackage", [name]);
  }

  bool isPackageDisabled(String name) {
    return obj.callMethod("isPackageDisabled", [name]);
  }

  bool isPackageActive(String name) {
    return obj.callMethod("isPackageActive", [name]);
  }

  bool isPackageLoaded(String name) {
    return obj.callMethod("isPackageLoaded", [name]);
  }

  List<String> get availablePackagePaths => obj.callMethod("getAvailablePackagePath");
  List<String> get availablePackageNames => obj.callMethod("getAvailablePackageNames");
  List<String> get availablePackageMetadata => obj.callMethod("getAvailablePackageMetadata");
}
