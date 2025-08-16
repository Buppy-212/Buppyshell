pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Wayland
import QtQuick
import qs.services
import qs.modules.notifications

PanelWindow {
    id: root
    property Notification currentNotification: null
    function clearNotifs(): void {
        if (GlobalState.sidebar) {
            var notifications = notificationServer.trackedNotifications.values.slice();
            for (var i = 0; i < notifications.length; i++) {
                notifications[i].dismiss();
            }
        }
    }
    anchors {
        top: true
        right: true
        bottom: true
    }
    margins {
        top: 2
        right: 2
        bottom: 2
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
    Timer {
        interval: 3000
        running: root.currentNotification !== null && !content.Drag.active
        onTriggered: {
            if (root.currentNotification) {
                root.currentNotification = null;
                content.x = 0;
            }
        }
    }
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
            if (!GlobalState.sidebar && !GlobalState.doNotDisturb) {
                root.currentNotification = notification;
            }
        }
    }
    Content {
        id: content
        anchors.top: parent.top
        implicitWidth: parent.width
        notification: root.currentNotification
    }
}
