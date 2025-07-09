pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland
import QtQuick
import "../services"

Scope {
    Server {
        id: notificationServer
        onNotification: notification => {
            if (!GlobalState.sidebar) {
                notificationPopup.showNotification(notification);
            }
            ;
        }
    }
    NotificationPopup {
        id: notificationPopup
        function showNotification(notification) {
            currentNotification = notification;
        }
    }
    GlobalShortcut {
        name: "clearNotifs"
        description: "Dismiss all notifications"
        appid: "buppyshell"
        onPressed: {
            if (GlobalState.sidebar) {
                var notifications = notificationServer.trackedNotifications.values.slice();
                for (var i = 0; i < notifications.length; i++) {
                    notifications[i].dismiss();
                }
            }
        }
    }
}
