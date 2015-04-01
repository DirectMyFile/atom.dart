import "package:atom/atom.dart";

void main() {
  exports.activate = () {
    print("Package Activated");
  };

  exports.deactivate = () {
    print("Package Deactivated");
  };
}
