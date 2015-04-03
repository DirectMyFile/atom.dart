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
    [range.start.row, range.start.column],
    [range.end.row, range.end.column]
  ]);

  void insertText(value) {
    obj.callMethod("insertText", [value.toString()]);
  }

  void insertNewLine() => obj.callMethod("insertNewline");
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

  void save() {
    obj.callMethod("save");
  }

  void saveAs(String path) {
    obj.callMethod("saveAs", [path]);
  }

  void transpose() {
    obj.callMethod("transpose");
  }

  void uppercase() {
    obj.callMethod("upperCase");
  }

  void lowercase() {
    obj.callMethod("lowerCase");
  }

  void toggleLineCommentsInSelection() {
    obj.callMethod("toggleLineCommentsInSelection");
  }

  void insertNewLineBelow() {
    obj.callMethod("insertNewLineBelow");
  }

  void insertNewLineAbove() {
    obj.callMethod("insertNewLineAbove");
  }

  void deleteLine() {
    obj.callMethod("deleteLine");
  }

  void deleteToBeginningOfLine() {
    obj.callMethod("deleteToBeginningOfLine");
  }

  void deleteToBeginningOfWord() {
    obj.callMethod("deleteToBeginningOfWord");
  }

  void deleteToEndOfLine() {
    obj.callMethod("deleteToEndOfLine");
  }

  void deleteToEndOfWord() {
    obj.callMethod("deleteToEndOfWord");
  }

  String get encoding => obj.callMethod("getEncoding");
  set encoding(String name) => obj.callMethod("setEncoding", [name]);

  Disposable onDidAddCursor(Consumer<Cursor> callback) {
    return new Disposable(obj.callMethod("onDidAddCursor", [
        (e) => callback(new Cursor(e))
    ]));
  }

  Disposable onDidRemoveCursor(Consumer<Cursor> callback) {
    return new Disposable(obj.callMethod("onDidRemoveCursor", [
        (e) => callback(new Cursor(e))
    ]));
  }

  Disposable onWillInsertText(Consumer<WillInsertTextEvent> callback) {
    return new Disposable(obj.callMethod("onWillInsertText", [
      (e) => callback(new WillInsertTextEvent(e))
    ]));
  }

  Disposable onDidConflict(Action callback) => new Disposable(obj.callMethod("onDidConflict", [callback]));
  Disposable onDidInsertText(Consumer<DidInsertTextEvent> callback) => new Disposable(obj.callMethod("onDidInsertText", [
    (e) => new DidInsertTextEvent(e)
  ]));

  Disposable onDidChangeGrammar(Consumer<Grammar> callback) {
    return new Disposable(obj.callMethod("onDidChangeGrammar", [(e) => callback(new Grammar(e))]));
  }

  Disposable onDidAddSelection(Consumer<Selection> callback) {
    return new Disposable(obj.callMethod("onDidAddSelection", [(e) => callback(new Selection(e))]));
  }

  Disposable onDidRemoveSelection(Consumer<Selection> callback) {
    return new Disposable(obj.callMethod("onDidRemoveSelection", [(e) => callback(new Selection(e))]));
  }

  ScopeDescriptor get rootScopeDescriptor => new ScopeDescriptor.wrap(obj.callMethod("getRootScopeDescriptor"));
  ScopeDescriptor scopeDescriptorForBufferPosition(f) =>
    new ScopeDescriptor.wrap(obj.callMethod("scopeDescriptorForBufferPosition", [f is Point ? f.toJS() : f]));

  Disposable observeGrammar(Consumer<Grammar> callback) {
    return new Disposable(obj.callMethod("observeGrammar", [(e) => callback(new Grammar(e))]));
  }

  Disposable observeCursors(Consumer<Cursor> callback) {
    return new Disposable(obj.callMethod("observeCursors", [
        (e) => callback(new Cursor(e))
    ]));
  }

  bool get isSoftWrapped => obj.callMethod("isSoftWrapped");
  set isSoftWrapped(bool value) => obj.callMethod("setSoftWrapped", [value]);

  bool toggleSoftWrapped() {
    return obj.callMethod("toggleSoftWrapped");
  }

  int get softWrapColumn => obj.callMethod("getSoftWrapColumn");

  bool get softTabs => obj.callMethod("getSoftTabs");
  set softTabs(bool value) => obj.callMethod("setSoftTabs", [value]);

  bool toggleSoftTabs() {
    return obj.callMethod("toggleSoftTabs");
  }

  int get tabLength => obj.callMethod("getTabLength");
  set tabLength(int value) => obj.callMethod("setTabLength", [value]);

  bool get usesSoftTabs => obj.callMethod("usesSoftTabs");
  String get tabText => obj.callMethod("getTabText");

  Grammar get grammar => new Grammar(obj.callMethod("getGrammar"));
  set grammar(Grammar g) => obj.callMethod("setGrammar", [g.obj]);

  void copySelectedText() {
    obj.callMethod("copySelectedText");
  }

  void cutSelectedText() {
    obj.callMethod("cutSelectedText");
  }

  void cutToEndOfLine() {
    obj.callMethod("cutSelectedText");
  }

  void pasteText() {
    obj.callMethod("pasteText");
  }

  void foldCurrentRow() {
    obj.callMethod("foldCurrentRow");
  }

  void unfoldCurrentRow() {
    obj.callMethod("unfoldCurrentRow");
  }

  void foldBufferRow(int row) {
    obj.callMethod("foldBufferRow", [row]);
  }

  void unfoldBufferRow(int row) {
    obj.callMethod("unfoldBufferRow", [row]);
  }

  void foldSelectedLines() {
    obj.callMethod("foldSelectedLines");
  }

  void foldAll() => obj.callMethod("foldAll");
  void unfoldAll() => obj.callMethod("unfoldAll");

  String get placeholderText => obj.callMethod("getPlaceholderText");
  set placeholderText(String text) => obj.callMethod("setPlaceholderText", [text]);

  void scrollToTop() {
    obj.callMethod("scrollToTop");
  }

  void scrollToBottom() {
    obj.callMethod("scrollToBottom");
  }

  bool get hasMultipleCursors => obj.callMethod("hasMultipleCursors");

  Point get cursorBufferPosition => new Point.fromJS(obj.callMethod("getCursorBufferPosition"));
  List<Point> get cursorBufferPositions =>
    obj.callMethod("getCursorBufferPositions").map((it) => new Position.fromJS(it)).toList();

  List<Cursor> get cursors => obj.callMethod("getCursors").map((it) => new Cursor(it)).toList();
  Cursor get lastCursor => new Cursor(obj.callMethod("getLastCursor"));

  void moveUp([int lineCount]) {
    obj.callMethod("moveUp", [lineCount]);
  }

  void moveDown([int lineCount]) {
    obj.callMethod("moveDown", [lineCount]);
  }

  void moveLeft([int columnCount]) {
    obj.callMethod("moveLeft", [columnCount]);
  }

  void moveRight([int columnCount]) {
    obj.callMethod("moveRight", [columnCount]);
  }

  void moveToBeginningOfLine() {
    obj.callMethod("moveToBeginningOfLine");
  }

  void moveToEndOfLine() {
    obj.callMethod("moveToEndOfLine");
  }

  void moveToTop() {
    obj.callMethod("moveToTop");
  }

  void moveToBottom() {
    obj.callMethod("moveToBottom");
  }

  Selection get lastSelection => new Selection(obj.callMethod("getLastSelection"));
  List<Selection> get selections => obj.callMethod("getSelections").map((it) =>
    new Selection(it)
  ).toList();

  Disposable observeDecorations(Consumer<Decoration> callback) {
    return new Disposable(obj.callMethod("observeDecorations", [
      (e) => callback(new Decoration(e))
    ]));
  }

  Disposable onDidAddDecoration(Consumer<Decoration> callback) {
    return new Disposable(obj.callMethod("onDidAddDecoration", [
      (e) => callback(new Decoration(e))
    ]));
  }

  Disposable onDidRemoveDecoration(Consumer<Decoration> callback) {
    return new Disposable(obj.callMethod("onDidRemoveDecoration", [
        (e) => callback(new Decoration(e))
    ]));
  }

  Disposable onDidChangePlaceholderText(Consumer<String> callback) {
    return new Disposable(obj.callMethod("onDidChangePlaceholderText", [
      (e) => callback(e)
    ]));
  }
}

class Selection {
  final js.JsObject obj;

  Selection(this.obj);

  Disposable onDidDestroy(Action callback) {
    return new Disposable(obj.callMethod("onDidDestroy", [callback]));
  }

  Range get screenRange => new RangeProxy(obj.callMethod("getScreenRange"));
  Range get bufferRange => new RangeProxy(obj.callMethod("getBufferRange"));
  void setScreenRange(Range range, {bool preserveFolds, bool autoScroll}) => obj.callMethod("setScreenRange", [
    [
      [range.start.row, range.start.column],
      [range.end.row, range.end.column]
    ],
    omap({
      "preserveFolds": preserveFolds,
      "autoScroll": autoScroll
    })
  ]);

  void setBufferRange(Range range, {bool preserveFolds, bool autoScroll}) => obj.callMethod("setScreenRange", [
    [
      [range.start.row, range.start.column],
      [range.end.row, range.end.column]
    ],
    omap({
      "preserveFolds": preserveFolds,
      "autoScroll": autoScroll
    })
  ]);

  bool get isEmpty => obj.callMethod("isEmpty");
  bool get isReversed => obj.callMethod("isReversed");
  String get text => obj.callMethod("getText");
  bool get isSingleScreenLine => obj.callMethod("isSingleScreenLine");
  bool intersectsBufferRange(Range range) => obj.callMethod("intersectsBufferRange", [
    [range.start.row, range.start.column],
    [range.end.row, range.end.column]
  ]);
  bool intersectsWith(Selection selection) => intersectsBufferRange(selection.bufferRange);

  void insertText(String text) {
    obj.callMethod("insertText", [text]);
  }

  void addSelectionBelow() {
    obj.callMethod("addSelectionBelow");
  }

  void addSelectionAbove() {
    obj.callMethod("addSelectionAbove");
  }

  void fold() {
    obj.callMethod("fold");
  }

  void joinLines() {
    obj.callMethod("joinLines");
  }

  void deleteLine() {
    obj.callMethod("deleteLine");
  }

  void delete() {
    obj.callMethod("delete");
  }

  void backspace() {
    obj.callMethod("backspace");
  }

  void clear() {
    obj.callMethod("clear");
  }

  void selectAll() {
    obj.callMethod("selectAll");
  }
}

class Range {
  final Point start;
  final Point end;

  Range(this.start, this.end);

  bool get isEmpty => start == end;
  int get rowCount => end.row - start.row + 1;
  bool get isSingleLine => start.row == end.row;
}

class RangeProxy implements Range {
  final js.JsObject obj;

  RangeProxy(this.obj);

  @override
  Point get end => new Point.fromJS(obj["end"]);

  @override
  bool get isEmpty => obj.callMethod("isEmpty");

  @override
  bool get isSingleLine => obj.callMethod("isSingleLine");


  @override
  int get rowCount => obj.callMethod("getRowCount");

  @override
  Point get start => new Point.fromJS(obj["start"]);
}

class Cursor {
  final js.JsObject obj;

  Cursor(this.obj);

  void destroy() {
    obj.callMethod("destroy");
  }

  Disposable onDidDestroy(Action callback) {
    return new Disposable(obj.callMethod("onDidDestroy", [callback]));
  }

  Disposable onDidChangePosition(Consumer<CursorPositionChangedEvent> callback) {
    return new Disposable(obj.callMethod("onDidChangePosition", [
      (e) => callback(new CursorPositionChangedEvent(e))
    ]));
  }

  Disposable onDidChangeVisibility(Consumer<bool> callback) {
    return new Disposable(obj.callMethod("onDidChangeVisibility", [
      (e) => callback(e["visibility"])
    ]));
  }

  bool get isLastCursor => obj.callMethod("isLastCursor");
  int get indentLevel => obj.callMethod("getIndentLevel");
  bool get isSurroundedByWhitespace => obj.callMethod("isSurroundedByWhitespace");
  bool get isBetweenWordAndNonWord => obj.callMethod("isBetweenWordAndNonWord");
  bool get isVisible => obj.callMethod("isVisible");
  bool get hasPrecedingCharactersOnLine => obj.callMethod("hasPrecedingCharactersOnLine");

  bool get isAtBeginningOfLine => obj.callMethod("isAtBeginningOfLine");
  bool get isAtEndOfLine => obj.callMethod("isAtEndOfLine");

  set isVisible(bool visible) => obj.callMethod("setVisible", [visible]);

  void moveToTop() => obj.callMethod("moveToTop");
  void moveToBottom() => obj.callMethod("moveToBottom");
  void skipLeadingWhitespace() => obj.callMethod("skipLeadingWhitespace");

  int get bufferRow => obj.callMethod("getBufferRow");
  int get bufferColumn => obj.callMethod("getBufferColumn");
  int get screenRow => obj.callMethod("getScreenRow");
  int get screenColumn => obj.callMethod("getScreenColumn");

  void setScreenPosition(int row, int column, {bool autoscroll}) {
    obj.callMethod("setScreenPosition", [[row, column], omap({
      "autoscroll": autoscroll
    })]);
  }

  void setBufferPosition(int row, int column, {bool autoscroll}) {
    obj.callMethod("setBufferPosition", [[row, column], omap({
      "autoscroll": autoscroll
    })]);
  }

  String get currentWordPrefix => obj.callMethod("getCurrentWordPrefix");

  void clearAutoscroll() => obj.callMethod("clearAutoscroll");
  void clearSelection() => obj.callMethod("clearSelection");
}

class CursorPositionChangedEvent {
  final js.JsObject obj;

  CursorPositionChangedEvent(this.obj);

  Point get oldBufferPosition => new Point.fromJS(obj["oldBufferPosition"]);
  Point get newBufferPosition => new Point.fromJS(obj["newBufferPosition"]);

  Point get oldScreenPosition => new Point.fromJS(obj["oldScreenPosition"]);
  Point get newScreenPosition => new Point.fromJS(obj["newScreenPosition"]);

  bool get textChanged => obj["textChanged"];
  Cursor get cursor => new Cursor(obj["cursor"]);
}

class Point {
  final int row;
  final int column;

  Point(this.row, this.column);
  Point.fromJS(js.JsObject obj) : this(obj["row"], obj["column"]);

  js.JsObject toJS() {
    return new js.JsObject.jsify({
      "row": row,
      "column": column
    });
  }
}

class WillInsertTextEvent {
  final js.JsObject obj;

  WillInsertTextEvent(this.obj);

  String get text => obj["text"];

  void cancel() {
    obj.callMethod("cancel");
  }
}

class DidInsertTextEvent {
  final js.JsObject obj;

  DidInsertTextEvent(this.obj);

  String get text => obj["text"];
}

class Decoration {
  final js.JsObject obj;

  Decoration(this.obj);

  void destroy() {
    obj.callMethod("destroy");
  }

  Disposable onDidDestroy(Action callback) {
    return new Disposable(obj.callMethod("onDidDestroy", [callback]));
  }

  Disposable onDidChangeProperties(Consumer<DecorationPropertiesChangeEvent> callback) {
    return new Disposable(obj.callMethod("onDidChangeProperties", [(o) {
      return callback(new DecorationPropertiesChangeEvent(o["oldProperties"], o["newProperties"]));
    }]));
  }

  get id => obj.callMethod("getId");

  js.JsObject get properties => obj.callMethod("getProperties");
  set properties(js.JsObject properties) => obj.callMethod("setProperties", [properties]);
}

class DecorationPropertiesChangeEvent {
  final js.JsObject oldProperties;
  final js.JsObject newProperties;

  DecorationPropertiesChangeEvent(this.oldProperties, this.newProperties);
}
