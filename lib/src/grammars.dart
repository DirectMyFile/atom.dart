part of atom;

class Grammar {
  final js.JsObject obj;

  Grammar(this.obj);

  Disposable onDidUpdate(Action callback) {
    return new Disposable(obj.callMethod("onDidUpdate", [callback]));
  }

  List<List<Token>> tokenizeLines(String text) {
    return obj.callMethod("tokenizeLines", [text]).map((it) {
      return it.map((x) {
        return new Token(x);
      }).toList();
    }).toList();
  }
}

class Token {
  final js.JsObject obj;

  Token(this.obj);

  String get value => obj["value"];
}

class GrammarRegistry {
  final js.JsObject obj;

  GrammarRegistry(this.obj);

  List<Grammar> get grammars => obj.callMethod("getGrammars").map((it) => new Grammar(it)).toList();
  Grammar grammarForScopeName(String scope) => new Grammar(obj.callMethod("grammarForScopeName", [scope]));
  Grammar selectGrammar(String path, String content) => new Grammar(obj.callMethod("selectGrammar", [path, content]));
  Disposable addGrammar(Grammar grammar) => new Disposable(obj.callMethod("addGrammar", [grammar.obj]));
  Grammar readGrammarSync(String path) => new Grammar(obj.callMethod("readGrammarSync", [path]));
  void readGrammar(String path, void callback(Grammar grammar)) {
    obj.callMethod("readGrammar", [path, (e, g) => callback(new Grammar(g))]);
  }

  Disposable onDidAddGrammar(Consumer<Grammar> callback) {
    return new Disposable(obj.callMethod("onDidAddGrammar", [callback]));
  }

  Disposable onDidUpdateGrammar(Consumer<Grammar> callback) {
    return new Disposable(obj.callMethod("onDidUpdateGrammar", [callback]));
  }

  Grammar grammarOverrideForPath(String path) {
    return new Grammar(obj.callMethod("grammarOverrideForPath", [path]));
  }

  Grammar setGrammarOverrideForPath(String path, String scope) {
    return new Grammar(obj.callMethod("setGrammarOverrideForPath", [path, scope]));
  }

  void clearGrammarOverrideForPath(String path) {
    obj.callMethod("clearGrammarOverrideForPath", [path]);
  }

  void clearGrammarOverrides() {
    obj.callMethod("clearGrammarOverrides");
  }
}
