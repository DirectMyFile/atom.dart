library atom.utils;

import "dart:async";
import "dart:js" as js;

Map<String, dynamic> omap(Map<String, dynamic> map) {
  var copy = new Map.from(map);
  map.keys.where((it) => map[it] == null).forEach((k) => copy.remove(k));
  return copy;
}

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
