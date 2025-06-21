import Quickshell.Services.Notifications

NotificationServer {
  id: notificationServer
  property int maxNotifications: 7
  bodySupported: true
  bodyMarkupSupported: true
  actionsSupported: true
  imageSupported: true
  keepOnReload: false
  persistenceSupported: true

  onNotification: notification => {
    notification.tracked = true;
      for (var i = 0; i < trackedNotifications.values.length; i++) {
        if (trackedNotifications.values[i].transient) {
          trackedNotifications.values[i].dismiss();
        }
      }
    if (trackedNotifications.values.length > maxNotifications) {
      var excess = trackedNotifications.values.length - maxNotifications;
      for (var i = 0; i < excess; i++) {
        trackedNotifications.values[i].dismiss();
      }
    }
  }
}
