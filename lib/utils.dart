library atom.utils;

import "dart:async";
import "dart:js" as js;

Map<String, dynamic> omap(Map<String, dynamic> map) {
  var copy = new Map.from(map);
  map.keys.where((it) => map[it] == null).forEach((k) => copy.remove(k));
  return copy;
}

js.JsObject jsify(Map map) => new js.JsObject.jsify(map);

Future promiseToFuture(promise) {
  if (promise is js.JsObject) {
    promise = new Promise(promise);
  }

  if (promise is! Promise) {
    throw new Exception("Unknown Promise Type");
  }

  var completer = new Completer();
  promise.then(([e]) {
    completer.complete(e);
  });

  promise.catchError(([e]) {
    completer.completeError(e);
  });

  return completer.future;
}

class Promise {
  static Promise all(List input) {
    return js.context["Promise"].callMethod("all", [input]);
  }

  final js.JsObject obj;

  Promise(this.obj);

  void then(Function func) {
    obj.callMethod("then", [func]);
  }

  void catchError(Function func) {
    obj.callMethod("catch", [func]);
  }
}

abstract class ProxyHolder extends Object {
  final js.JsObject obj;
  ProxyHolder(this.obj);

  dynamic invoke(String method, [dynamic arg1, dynamic arg2, dynamic arg3]) {
    if (arg1 is Map) arg1 = jsify(arg1);
    if (arg2 is Map) arg2 = jsify(arg2);
    if (arg3 is Map) arg3 = jsify(arg3);

    if (arg3 != null) {
      return obj.callMethod(method, [arg1, arg2, arg3]);
    } else if (arg2 != null) {
      return obj.callMethod(method, [arg1, arg2]);
    } else if (arg2 != null) {
      return obj.callMethod(method, [arg1]);
    } else {
      return obj.callMethod(method);
    }
  }
}
