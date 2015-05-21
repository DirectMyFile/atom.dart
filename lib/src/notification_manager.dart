part of atom;

class NotificationManager {
  final js.JsObject obj;

  NotificationManager(this.obj);

  // Events
  // Stream get onDidAddNotification;

  // Getting Notifications
  void get notifications => obj.callMethod('getNotifications', []);

  // Adding Notifications
  void addSuccess(String message, Map options) {
    var optionsJsObj = new js.JsObject.jsify(options);
    obj.callMethod('addSuccess', [message, optionsJsObj]);
  }

  void addInfo(String message, Map options) {
    var optionsJsObj = new js.JsObject.jsify(options);
    obj.callMethod('addInfo', [message, optionsJsObj]);
  }

  void addWarning(String message, Map options) {
    var optionsJsObj = new js.JsObject.jsify(options);
    obj.callMethod('addWarning', [message, optionsJsObj]);
  }

  void addError(String message, Map options) {
    var optionsJsObj = new js.JsObject.jsify(options);
    obj.callMethod('addError', [message, optionsJsObj]);
  }

  void addFatalError(String message, Map options) {
    var optionsJsObj = new js.JsObject.jsify(options);
    obj.callMethod('addFatalError', [message, optionsJsObj]);
  }
}
