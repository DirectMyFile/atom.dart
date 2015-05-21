part of atom;

class Config extends ProxyHolder {
  Config(js.JsObject obj) : super(obj);

  dynamic get(String key, {dynamic defaultValue, List<String> sources,
      List<String> excludeSources, ScopeDescriptor scope}) {
    Map map = {};
    if (sources != null) map['sources'] = sources;
    if (excludeSources != null) map['excludeSources'] = excludeSources;
    if (scope != null) map['scope'] = scope.obj;
    return invoke("get", key, defaultValue, map.isEmpty ? null : map);
  }

  /// A conveinence method for [get] when it is known to return a String. This
  /// will return `null` if the return type is anything but a [String].
  String getString(String key, {dynamic defaultValue, List<String> sources,
      List<String> excludeSources, ScopeDescriptor scope}) {
    var result = get(key,
        defaultValue: defaultValue,
        sources: sources,
        excludeSources: excludeSources,
        scope: scope);
    if (result is String || result == null) return result;
    if (result is js.JsObject) {
      window.console.log(result);
      return result.callMethod('toString');
    }
    return '${result}';
  }

  void set(String key, dynamic value, {String scopeSelector, String source}) {
    Map map = {};
    if (scopeSelector != null) map['scopeSelector'] = scopeSelector;
    if (source != null) map['source'] = source;
    invoke("set", key, value, map.isEmpty ? null : map);
  }

  // TODO: observe

  // TODO: onDidChange

  void unset(String key, {String scopeSelector, String source}) {
    Map map = {};
    if (scopeSelector != null) map['scopeSelector'] = scopeSelector;
    if (source != null) map['source'] = source;
    invoke("unset", key, map.isEmpty ? null : map);
  }
}

class ScopeDescriptor extends ProxyHolder {
  ScopeDescriptor(List<String> scopes) : super(
          global.callMethod("ScopeDescriptor", [new js.JsArray.from(scopes)]));
  ScopeDescriptor.wrap(js.JsObject obj) : super(obj);

  List<String> get scopes => invoke("getScopesArray");
}
