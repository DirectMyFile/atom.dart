part of atom;

class Color {
  static Color parse(String input) => new Color(global["Color"].callMethod("parse"));

  final js.JsObject obj;

  Color(this.obj);

  String toHexString() => obj.callMethod("toHexString");
  String toRGBAString() => obj.callMethod("toRGBAString");

  int get red => obj["red"];
  int get green => obj["green"];
  int get blue => obj["blue"];
  int get alpha => obj["alpha"];
}
