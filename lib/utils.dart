library atom.utils;

Map<String, dynamic> omap(Map<String, dynamic> map) {
  var copy = new Map.from(map);
  map.keys.where((it) => map[it] == null).forEach((k) => copy.remove(k));
  return copy;
}
