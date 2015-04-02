library atom.example.required;

import "package:atom/atom.dart";

void main() {
  exports.add("hello", () {
    print("Hello World");
  });
}
