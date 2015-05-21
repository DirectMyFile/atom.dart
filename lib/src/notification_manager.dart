part of atom;

class NotificationManager extends ProxyHolder {
  NotificationManager(js.JsObject obj) : super(obj);

  // Events
  // Stream get onDidAddNotification;

  // Getting Notifications
  // TODO: What should this return?
  dynamic get notifications => obj.callMethod('getNotifications', []);

  // Adding Notifications
  void addSuccess(String message, Map options) {
    invoke('addSuccess', message, options);
  }

  void addInfo(String message, Map options) {
    invoke('addInfo', message, options);
  }

  void addWarning(String message, Map options) {
    invoke('addWarning', message, options);
  }

  void addError(String message, Map options) {
    invoke('addError', message, options);
  }

  void addFatalError(String message, Map options) {
    invoke('addFatalError', message, options);
  }
}
