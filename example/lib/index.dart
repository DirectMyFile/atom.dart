library atom.example.text;

import "dart:convert";
import "package:atom/atom.dart";
import "package:crypto/crypto.dart";

part "activate.dart";

void main() {
  exports.activate = activate;
}
