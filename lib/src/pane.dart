part of atom;

class PaneItemAddRemoveEvent {
  final dynamic item;
  final int index;

  PaneItemAddRemoveEvent(this.item, this.index);
}

class PaneItemWillDestroyEvent {
  final dynamic item;
  final int index;

  PaneItemWillDestroyEvent(this.item, this.index);
}

class PaneItemMoveEvent {
  final dynamic item;
  final int oldIndex;
  final int newIndex;

  PaneItemMoveEvent(this.item, this.oldIndex, this.newIndex);
}

class Pane {
  final js.JsObject obj;

  Pane(this.obj);

  Disposable onDidActivate(Action callback) {
    return new Disposable(obj.callMethod("onDidActivate", [callback]));
  }

  Disposable onDidDestroy(Action callback) {
    return new Disposable(obj.callMethod("onDidDestroy", [callback]));
  }

  Disposable onDidChangeActive(Consumer<bool> callback) {
    return new Disposable(obj.callMethod("onDidChangeActive", [callback]));
  }

  Disposable observeActive(Consumer<bool> callback) {
    return new Disposable(obj.callMethod("observeActive", [callback]));
  }

  Disposable onDidAddItem(Consumer<PaneItemAddRemoveEvent> callback) {
    return new Disposable(obj.callMethod("onDidAddItem", [
      (e) => callback(new PaneItemAddRemoveEvent(e["item"], e["index"]))
    ]));
  }

  Disposable onDidRemoveItem(Consumer<PaneItemAddRemoveEvent> callback) {
    return new Disposable(obj.callMethod("onDidRemoveItem", [
        (e) => callback(new PaneItemAddRemoveEvent(e["item"], e["index"]))
    ]));
  }

  Disposable onDidMoveItem(Consumer<PaneItemMoveEvent> callback) {
    return new Disposable(obj.callMethod("onDidMoveItem", [
        (e) => callback(new PaneItemMoveEvent(e["item"], e["oldIndex"], e["newIndex"]))
    ]));
  }

  Disposable observeItems(Consumer<dynamic> callback) {
    return new Disposable(obj.callMethod("observeItems", [callback]));
  }

  Disposable onDidChangeActiveItem(Consumer<dynamic> callback) {
    return new Disposable(obj.callMethod("onDidChangeActiveItem", [callback]));
  }

  Disposable observeActiveItem(Consumer<dynamic> callback) {
    return new Disposable(obj.callMethod("observeActiveItem", [callback]));
  }

  Disposable onWillDestroyItem(Consumer<PaneItemWillDestroyEvent> callback) {
    return new Disposable(obj.callMethod("onWillDestroyItem", [
        (e) => callback(new PaneItemWillDestroyEvent(e["item"], e["index"]))
    ]));
  }

  List<dynamic> get items => obj.callMethod("getItems");
  dynamic get activeItem => obj.callMethod("getActiveItem");
  dynamic itemAt(int index) => obj.callMethod("itemAtIndex", [index]);

  void activateNextItem() {
    obj.callMethod("activateNextItem");
  }

  void activatePreviousItem() {
    obj.callMethod("activatePreviousItem");
  }

  void moveItemRight() {
    obj.callMethod("moveItemRight");
  }

  void moveItemLeft() {
    obj.callMethod("moveItemLeft");
  }

  int get activeItemIndex => obj.callMethod("getActiveItemIndex");

  dynamic addItem(dynamic item, [int index]) {
    return obj.callMethod("addItem", [item, index]);
  }

  dynamic addItems(List<dynamic> items, [int index]) {
    return obj.callMethod("addItems", [items, index]);
  }

  void moveItem(item, int index) {
    obj.callMethod("moveItem", [item, index]);
  }

  void moveItemToPane(item, Pane pane, int index) {
    obj.callMethod("moveItemToPane", [item, pane.obj, index]);
  }

  void destroyActiveItem() {
    obj.callMethod("destroyActiveItem");
  }

  void destroyItem(item) {
    obj.callMethod("destroyItem", [item]);
  }

  void destroyItems() {
    obj.callMethod("destroyAllItems");
  }

  void destroyInactiveItems() {
    obj.callMethod("destroyInactiveItems");
  }

  void saveActiveItem() {
    obj.callMethod("saveActiveItem");
  }

  void saveActiveItemAs([void next()]) {
    obj.callMethod("saveActiveItemAs", [next]);
  }

  void saveItem(item, [void next()]) {
    obj.callMethod("saveItem", [item, next]);
  }

  void saveItemAs(item, [void next()]) {
    obj.callMethod("saveItemAs", [item, next]);
  }

  void saveItems() {
    obj.callMethod("saveItems");
  }

  dynamic itemForUri(String uri) {
    return obj.callMethod("itemForURI", [uri]);
  }

  void activateItem(item) {
    obj.callMethod("activateItem", [item]);
  }

  void activateItemAtIndex(int index) {
    obj.callMethod("activateItemAtIndex", [index]);
  }

  bool activateItemForUri(String uri) {
    return obj.callMethod("activateItemForURI", [uri]);
  }

  bool get isActive => obj.callMethod("isActive");
  void activate() => obj.callMethod("activate");
  void destroy() => obj.callMethod("destroy");

  Pane splitLeft({List<dynamic> items, bool copyActiveItem}) {
    return new Pane(obj.callMethod("splitLeft", [toJsObject({
      "items": items,
      "copyActiveItem": copyActiveItem
    })]));
  }

  Pane splitRight({List<dynamic> items, bool copyActiveItem}) {
    return new Pane(obj.callMethod("splitRight", [toJsObject({
      "items": items,
      "copyActiveItem": copyActiveItem
    })]));
  }

  Pane splitUp({List<dynamic> items, bool copyActiveItem}) {
    return new Pane(obj.callMethod("splitUp", [toJsObject({
      "items": items,
      "copyActiveItem": copyActiveItem
    })]));
  }

  Pane splitDown({List<dynamic> items, bool copyActiveItem}) {
    return new Pane(obj.callMethod("splitUp", [toJsObject({
      "items": items,
      "copyActiveItem": copyActiveItem
    })]));
  }
}
