import Quickshell.Services.Notifications

NotificationServer {
  id: notificationServer
  property int maxNotifications: 6
  bodySupported: true
  actionsSupported: true
  imageSupported: true
  keepOnReload: false
  persistenceSupported: true

  onNotification: notification => {
    notification.tracked = true
    if (trackedNotifications.values.length > maxNotifications) {
      var excess = trackedNotifications.values.length - maxNotifications
      for (var i = 0; i < excess; i++) {
        trackedNotifications.values[i].dismiss()
      }
    }
  }
}
