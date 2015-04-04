part of atom;

class Workspace {
  final js.JsObject obj;

  Workspace(this.obj);

  TextEditor get activeTextEditor => new TextEditor.wrap(obj.callMethod("getActiveTextEditor"));
  List<TextEditor> get textEditors => obj.callMethod("getTextEditors").map((it) => new TextEditor.wrap(it)).toList();

  Disposable observeTextEditors(Consumer<TextEditor> callback) {
    return new Disposable(obj.callMethod("observeTextEditors", [(o) => callback(new TextEditor.wrap(o))]));
  }

  Future<TextEditor> open(String uri, {int initialLine, int initialColumn, String split, bool activatePane, bool searchAllPanes}) async {
    var map = omap({
      "initialLine": initialLine,
      "initialColumn": initialColumn,
      "split": split,
      "activatePane": activatePane,
      "searchAllPanes": searchAllPanes
    });

    return new TextEditor.wrap(await promiseToFuture(
      obj.callMethod("open", [uri, map])
    ));
  }

  Future reopenItem() => promiseToFuture(obj.callMethod("reopenItem"));
  Disposable addOpener(callback(String uri)) {
    return new Disposable(obj.callMethod("addOpener", [callback]));
  }

  Panel addTopPanel(Element item, {bool visible: true, int priority: 100}) =>
    _addPanel("addTopPanel", item, visible, priority);

  Panel addRightPanel(Element item, {bool visible: true, int priority: 100}) =>
    _addPanel("addRightPanel", item, visible, priority);

  Panel addLeftPanel(Element item, {bool visible: true, int priority: 100}) =>
    _addPanel("addLeftPanel", item, visible, priority);

  Panel addBottomPanel(Element item, {bool visible: true, int priority: 100}) =>
    _addPanel("addBottomPanel", item, visible, priority);

  Panel addModalPanel(Element item, {bool visible: true, int priority: 100}) =>
    _addPanel("addModalPanel", item, visible, priority);

  List<Pane> get panes => obj.callMethod("getPanes").map((it) => new Pane(it)).toList();
  Pane get activePane => new Pane(obj.callMethod("getActivePane"));
  void activateNextPane() {
    obj.callMethod("activateNextPane");
  }

  void activatePreviousPane() {
    obj.callMethod("activatePreviousPane");
  }

  Pane paneForUri(String uri) {
    var e = obj.callMethod("paneForURI", [uri]);
    if (e == null) {
      return null;
    }
    return new Pane(e);
  }

  List<dynamic> get paneItems => obj.callMethod("getPaneItems");
  dynamic get activePaneItem => obj.callMethod("getActivePaneItem");

  Pane paneForItem(item) {
    var e = obj.callMethod("paneForItem", [item]);
    if (e == null) {
      return null;
    }
    return new Pane(e);
  }

  List<Panel> get bottomPanels => _panels("getBottomPanels");
  List<Panel> get topPanels => _panels("getTopPanels");
  List<Panel> get leftPanels => _panels("getLeftPanels");
  List<Panel> get rightPanels => _panels("getRightPanels");
  List<Panel> get modalPanels => _panels("getModalPanels");
  Panel panelForItem(item) {
    var e = obj.callMethod("panelForItem", [item]);

    if (e == null) {
      return null;
    }

    return new Panel(e);
  }

  Panel _addPanel(String type, Element item, bool visible, int priority) {
    return new Panel(obj.callMethod(type, [
      toJsObject({
        "item": item,
        "visible": visible,
        "priority": priority
      })
    ]));
  }

  List<Panel> _panels(String type) {
    return obj.callMethod(type).map((it) {
      return new Panel(it);
    }).toList();
  }
}

typedef void Consumer<T>(T input);
