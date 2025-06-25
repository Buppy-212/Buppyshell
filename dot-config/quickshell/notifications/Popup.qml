import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Notifications
import "."

Scope {
  Server {
    id: notificationServer
    onNotification: notification => {
      if (sidebar.visible === false) {notificationPopup.showNotification(notification)};
    }
  }
  NotificationPopup {
    id: notificationPopup
    function showNotification(notification) {
      currentNotification = notification;
    }
  }
  Sidebar {id: sidebar}
  GlobalShortcut {
    name: "clearNotifs"
    description: "Dismiss all notifications"
    triggerDescription: "Super+Ctrl+N"
    appid: "buppyshell"
    onPressed: {
      if (sidebar.visible) {
        console.log("sidebar")
        var notifications = notificationServer.trackedNotifications.values.slice();
        for (var i = 0; i < notifications.length; i++) {
          notifications[i].dismiss();
        }
      }
    }
  }
}
