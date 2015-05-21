part of atom;

class Config {
  final js.JsObject obj;

  Config(this.obj);

  dynamic get(String key, {dynamic defaultValue, List<String> sources,
      List<String> excludeSources, ScopeDescriptor scope}) => obj.callMethod(
          "get", [
    key,
    defaultValue,
    {"sources": sources, "excludeSources": excludeSources, "scope": scope.obj}
  ]);

  void set(String key, dynamic value, {String scopeSelector, String source}) =>
      obj.callMethod("set", [
    key,
    value,
    {"scopeSelector": scopeSelector, "source": source}
  ]);

  void unset(String key, {String scopeSelector, String source}) => obj
      .callMethod(
          "unset", [key, {"scopeSelector": scopeSelector, "source": source}]);
}

class ScopeDescriptor {
  final js.JsObject obj;

  ScopeDescriptor(List<String> scopes) : obj = global.callMethod(
          "ScopeDescriptor", [new js.JsArray.from(scopes)]);
  ScopeDescriptor.wrap(this.obj);

  List<String> get scopes => obj.callMethod("getScopesArray");
}
