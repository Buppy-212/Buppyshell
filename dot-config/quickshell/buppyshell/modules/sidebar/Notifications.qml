import QtQuick
import Quickshell.Services.Notifications
import Quickshell.Hyprland
import Quickshell.Widgets
import qs.services
import qs.widgets
import qs.modules.notifications

Rectangle {
    implicitWidth: parent.width
    radius: Theme.radius.normal
    color: Theme.color.bg
    NotificationServer {
        id: notificationServer
    }
    ClippingRectangle {
        id: notificationList
        anchors {
            fill: parent
            topMargin: title.height
            margins: 36
        }
        radius: Theme.radius.normal
        color: Theme.color.bgalt
        ListView {
            implicitHeight: parent.height
            implicitWidth: Theme.width.notification
            anchors.horizontalCenter: parent.horizontalCenter
            model: notificationServer.trackedNotifications
            spacing: Theme.margin.small
            delegate: Content {
                id: content
                required property Notification modelData
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
    Rectangle {
        id: title
        anchors.top: parent.top
        implicitWidth: parent.implicitWidth
        implicitHeight: Theme.height.doubleBlock
        color: Theme.color.bg
        radius: Theme.radius.normal
        StyledText {
            text: "Notifications"
            font.pointSize: Theme.font.size.doubled
        }
        Block {
            hovered: dismissMouse.containsMouse
            anchors.top: parent.top
            anchors.right: parent.right
            implicitHeight: Theme.height.doubleBlock
            implicitWidth: implicitHeight
            StyledText {
                text: "󰆴"
                font.pointSize: Theme.font.size.doubled
            }
            MouseBlock {
                id: dismissMouse
                onClicked: Hyprland.dispatch("global buppyshell:clearNotifs")
            }
        }
    }
}
