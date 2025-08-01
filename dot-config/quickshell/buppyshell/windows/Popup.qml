pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import qs.services
import qs.modules.notifications

Scope {
    id: scope
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
            if (!GlobalState.sidebar) {
                notificationPopup.showNotification(notification);
            }
        }
    }
    PanelWindow {
        id: notificationPopup
        function showNotification(notification) {
            currentNotification = notification;
        }
        property Notification currentNotification: null
        anchors {
            top: true
            right: true
            bottom: true
        }
        margins {
            top: Theme.margin.tiny
            right: Theme.margin.tiny
            bottom: Theme.margin.tiny
        }
        Timer {
            id: timeoutTimer
            interval: 3000
            running: notificationPopup.currentNotification !== null
            onTriggered: {
                if (notificationPopup.currentNotification) {
                    notificationPopup.currentNotification = null;
                    content.x = 0;
                }
            }
        }
        color: "transparent"
        exclusiveZone: 0
        implicitWidth: screen.width / 4
        mask: Region {
            item: content
        }
        visible: currentNotification === null ? false : true
        WlrLayershell.namespace: "buppyshell:notification"
        WlrLayershell.layer: WlrLayer.Overlay
        Content {
            id: content
            implicitWidth: parent.width
            notification: notificationPopup.currentNotification
        }
    }
    function clearNotifs(): void {
        if (GlobalState.sidebar) {
            var notifications = notificationServer.trackedNotifications.values.slice();
            for (var i = 0; i < notifications.length; i++) {
                notifications[i].dismiss();
            }
        }
    }
    GlobalShortcut {
        name: "clearNotifs"
        description: "Dismiss all notifications"
        appid: "buppyshell"
        onPressed: scope.clearNotifs()
    }
}
