import Quickshell
import Quickshell.Services.Notifications
import "root:/windows"
import "./"

Scope {
  NotificationServer {
    id: notificationServer
    onNotification: notification => {
      notification.tracked = true
      notificationPopup.showNotification(notification)
    }
  }
  NotificationPopup {
    id: notificationPopup
    function showNotification(notification) {
      currentNotification = notification
      visible = true
    }
  }
}
