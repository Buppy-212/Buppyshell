import Quickshell.Services.Notifications

NotificationServer {
  id: notificationServer
  bodySupported: true
  bodyMarkupSupported: true
  actionsSupported: true
  keepOnReload: false
  persistenceSupported: true

  onNotification: notification => {
    notification.tracked = true;
      for (var i = 0; i < trackedNotifications.values.length; i++) {
        if (trackedNotifications.values[i].transient) {
          trackedNotifications.values[i].dismiss();
        }
      }
    if (trackedNotifications.values.length > 9) {
      var excess = trackedNotifications.values.length - 9;
      for (var i = 0; i < excess; i++) {
        trackedNotifications.values[i].dismiss();
      }
    }
  }
}
