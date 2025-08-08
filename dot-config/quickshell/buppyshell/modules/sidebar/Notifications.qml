import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Notifications
import Quickshell.Hyprland
import qs.services
import qs.widgets
import qs.modules.notifications

ColumnLayout {
    spacing: 0
    NotificationServer {
        id: notificationServer
    }
    Header {
        Layout.preferredHeight: Theme.height.doubleBlock
        Layout.fillWidth: true
        title: "Notifications"
        rightButtonText: "󰆴"
        function rightButtonTapped(): void {
            Hyprland.dispatch("global buppyshell:clearNotifs");
        }
    }
    Rectangle {
        Layout.fillHeight: true
        Layout.fillWidth: true
        Layout.rightMargin: 36
        Layout.bottomMargin: 36
        Layout.leftMargin: 36
        radius: Theme.radius.normal
        color: Theme.color.bgalt
        ListView {
            id: notificationList
            clip: true
            anchors.fill: parent
            anchors.horizontalCenter: parent.horizontalCenter
            model: notificationServer.trackedNotifications
            spacing: Theme.margin.small
            delegate: Content {
                id: content
                required property Notification modelData
                implicitWidth: notificationList.width
                notification: modelData
            }
            removeDisplaced: Transition {
                NumberAnimation {
                    property: "y"
                    duration: Theme.animation.elementMoveFast.duration
                    easing.type: Theme.animation.elementMoveFast.type
                    easing.bezierCurve: Theme.animation.elementMoveFast.bezierCurve
                }
            }
        }
    }
}
