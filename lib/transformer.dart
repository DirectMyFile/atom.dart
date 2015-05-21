import 'dart:async';
import 'dart:io';
import 'package:barback/barback.dart';

class AtomBuildTransformer extends Transformer {
  String get allowedExtensions => '.js';

  AtomBuildTransformer.asPlugin();

  Future apply(Transform transform) async {
    var id = transform.primaryInput.id;
    print('[AtomBuildTransformer] Processing $id');
    var content = await transform.readInputAsString(id);
    var newContent = _fixScript(content);
    transform.addOutput(new Asset.fromString(id, newContent));
  }

  String _fixScript(String input) {
    return HEADER +
        "\n" +
        input.replaceAll(
            r'if (typeof document === "undefined") {', "if (true) {");
  }

  final String HEADER = """
var self = Object.create(this);
self.require = require;
self.module = module;
self.window = window;
self.atom = atom;
self.exports = exports;
self.Object = Object;
  """;
}
