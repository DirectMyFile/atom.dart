library atom.example;

import "package:atom/atom.dart";

part "activate.dart";

void main() {
  exports.activate = activate;

  exports.deactivate = () {
    print("Package Deactivated");
  };

  require("./required").callMethod("hello");
}
