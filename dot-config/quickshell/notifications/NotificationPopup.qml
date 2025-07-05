import Quickshell
import Quickshell.Wayland
import QtQuick
import "../services"

PanelWindow {
    id: notificationPopup
    property var currentNotification: null
    anchors {
        top: true
        right: true
    }
    margins {
        top: Theme.border
        right: Theme.border
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
    implicitWidth: content.width
    implicitHeight: content.height
    visible: currentNotification === null ? false : true
    WlrLayershell.namespace: "buppyshell:notification"
    WlrLayershell.layer: WlrLayer.Overlay
    Content {
        id: content
        notification: notificationPopup.currentNotification
    }
}
