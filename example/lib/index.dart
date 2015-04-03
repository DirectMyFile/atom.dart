library atom.example.text;

import "dart:convert";
import "package:atom/atom.dart";
import "package:crypto/crypto.dart";

part "activate.dart";

void main() {
  onPackageActivated(() {
    activate();
  });
}
