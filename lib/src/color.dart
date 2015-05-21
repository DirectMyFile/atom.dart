part of atom;

class Color extends ProxyHolder {
  static Color parse(String input) =>
      new Color(global["Color"].callMethod("parse"));

  Color(js.JsObject obj) : super(obj);

  String toHexString() => invoke("toHexString");
  String toRGBAString() => invoke("toRGBAString");

  int get red => obj["red"];
  int get green => obj["green"];
  int get blue => obj["blue"];
  int get alpha => obj["alpha"];
}
