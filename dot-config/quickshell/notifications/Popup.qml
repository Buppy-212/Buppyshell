pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland
import QtQuick

Scope {
    Server {
        id: notificationServer
        onNotification: notification => {
            if (!sidebar.visible) {
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
    Sidebar {
        id: sidebar
        visible: false
    }
    GlobalShortcut {
        name: "sidebar"
        description: "Toggle sidebar"
        appid: "buppyshell"
        onPressed: {
            sidebar.visible = !sidebar.visible;
        }
    }
    GlobalShortcut {
        name: "clearNotifs"
        description: "Dismiss all notifications"
        appid: "buppyshell"
        onPressed: {
            if (sidebar.visible) {
                var notifications = notificationServer.trackedNotifications.values.slice();
                for (var i = 0; i < notifications.length; i++) {
                    notifications[i].dismiss();
                }
            }
        }
    }
}
