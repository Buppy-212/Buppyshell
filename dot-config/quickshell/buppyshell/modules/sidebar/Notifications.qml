import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Notifications
import Quickshell.Hyprland
import qs.services
import qs.widgets
import qs.modules.notifications

GridLayout {
    columns: 2
    rows: 2
    columnSpacing: 0
    rowSpacing: 0
    NotificationServer {
        id: notificationServer
    }
    StyledText {
        text: "Notifications"
        Layout.preferredHeight: Theme.height.doubleBlock
        Layout.fillWidth: true
        Layout.leftMargin: Theme.height.doubleBlock
        font.pixelSize: Theme.font.size.doubled
    }
    StyledButton {
        Layout.preferredHeight: Theme.height.doubleBlock
        Layout.preferredWidth: height
        text: "󰆴"
        font.pixelSize: height * 0.75
        function tapped(): void {
            Hyprland.dispatch("global buppyshell:clearNotifs");
        }
    }
    Rectangle {
        Layout.columnSpan: 2
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
