import "package:atom/builder.dart";

void main() {
  package("language-badger", "0.1.0",
      license: "MIT",
      repository: "https://github.com/badger/atom-language-badger",
      description: "Badger Support for Atom",
      main: "lib/index.js").atom(">0.180.0");

  buildBadgerGrammar();

  build();
}

void buildBadgerGrammar() {
  var g = grammar("badger", "source.badger", fileTypes: ["badger"]);
  g.load((match, beginEnd) {
    match("constant.language.badger", r"\b(true|false)\b");
    match("storage.modifier.badger", r"\b(let|var)\b");

    g.pattern(new BeginEndGrammarPattern("string.badger", '"', '"', [
      new MatchGrammarPattern(
          "constant.character.escape.badger", r"\\([bfnrt\\])"),
      new MatchGrammarPattern(
          "constant.character.escape.badger", r"\\u([0-9a-fA-F]{4})"),
      new MatchGrammarPattern("variable.parameter.badger", r"\$\((\w+)\)")
    ]));

    match("punctuation.terminator.statement.badger", r"\;");
    beginEnd("string.native.badger", "```", "```");
    match("meta.delimiter.object.comma.badger", ",");
    match("storage.type.function.badger", r"(?<!\.)\b(func)(?!\s*:)\b");
    match("meta.delimiter.method.period.badger", r"\.");
    match("constant.numeric.badger",
        r"\b((0(x|X)[0-9a-fA-F]*)|(([0-9]+\.?[0-9]*)|(\.[0-9]+))((e|E)(\+|-)?[0-9]+)?)\b");
    match("keyword.control.badger",
        r"(?<!\.)\b(for|while|if|else|return|break|switch|case)(?!\s*:)\b");
    match("keyword.operator.assignment.badger", "(=)");
    match("keyword.operator.badger", r"(in|==|!=|\+|-|>|<|>=|<=|\*|\/|<<|>>)");
    match("constant.language.boolean.true.badger", r"(?<!\.)\btrue(?!\s*:)\b");
    match(
        "constant.language.boolean.false.badger", r"(?<!\.)\bfalse(?!\s*:)\b");
    match("support.function.badger", r"(?<!\.)\b(print|async|run)(?!\s*:)\b");
  });
}
