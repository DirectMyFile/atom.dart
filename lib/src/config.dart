part of atom;

class Config extends ProxyHolder {
  Config(js.JsObject obj) : super(obj);

  dynamic get(String key, {dynamic defaultValue, List<String> sources,
      List<String> excludeSources, ScopeDescriptor scope}) => invoke(
          "get",
    key,
    defaultValue,
    {"sources": sources, "excludeSources": excludeSources, "scope": scope.obj}
  );

  void set(String key, dynamic value, {String scopeSelector, String source}) =>
      invoke("set",
    key,
    value,
    {"scopeSelector": scopeSelector, "source": source}
  );

  void unset(String key, {String scopeSelector, String source}) => invoke(
          "unset", key, {"scopeSelector": scopeSelector, "source": source});
}

class ScopeDescriptor extends ProxyHolder {
  ScopeDescriptor(List<String> scopes) : super(global.callMethod(
          "ScopeDescriptor", [new js.JsArray.from(scopes)]));
  ScopeDescriptor.wrap(js.JsObject obj) : super(obj);

  List<String> get scopes => invoke("getScopesArray");
}
