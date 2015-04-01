part of atom;

class TextEditor {
  final js.JsObject obj;

  TextEditor.wrap(this.obj);

  String get title => obj.callMethod("getTitle");
  String get longTitle => obj.callMethod("getLongTitle");
  String get path => obj.callMethod("getPath");
  bool get isModified => obj.callMethod("isModified");
  bool get isEmpty => obj.callMethod("isEmpty");

  String get text => obj.callMethod("getText");
  String getTextInBufferRange(int ax, int ay, int bx, int by) {
    return obj.callMethod("getTextInBufferRange", [[ax, ay], [bx, by]]);
  }

  int get lineCount => obj.callMethod("getLineCount");
  int get screenLineCount => obj.callMethod("getScreenLineCount");
  int get lastScreenRow => obj.callMethod("getLastScreenRow");

  String lineTextForBufferRow(int row) => obj.callMethod("lineTextForBufferRow", [row]);
  String lineTextForScreenRow(int row) => obj.callMethod("lineTextForScreenRow", [row]);

  set text(value) => obj.callMethod("setText", [value.toString()]);
  void setTextInBufferRange(Range range, String text) => obj.callMethod("setTextInBufferRange", [
    [range.ax, range.ay],
    [range.bx, range.by]
  ]);

  void insertText(value) {
    obj.callMethod("insertText", [value.toString()]);
  }

  void insertNewLine() => obj.callMethod("insertNewLine");
  void delete() => obj.callMethod("delete");
  void backspace() => obj.callMethod("backspace");
  void undo() => obj.callMethod("undo");
  void redo() => obj.callMethod("redo");

  String get selectedText => obj.callMethod("getSelectedText");

  Disposable onDidChange(Action callback) => new Disposable(obj.callMethod("onDidChange", [callback]));
  Disposable onDidChangePath(Action callback) => new Disposable(obj.callMethod("onDidChangePath", [callback]));
  Disposable onDidChangeTitle(Action callback) => new Disposable(obj.callMethod("onDidChangeTitle", [callback]));
  Disposable onDidStopChanging(Action callback) => new Disposable(obj.callMethod("onDidStopChanging", [callback]));
  Disposable onDidSave(Action callback) => new Disposable(obj.callMethod("onDidSave", [(e) => callback()]));
  Disposable onDidDestroy(Action callback) => new Disposable(obj.callMethod("onDidDestroy", [callback]));
}

class Range {
  final int ax;
  final int ay;
  final int bx;
  final int by;

  Range(this.ax, this.ay, this.bx, this.by);

  js.JsObject toJS() => global.callMethod("Range", [[ax, ay], [bx, by]]);
}
