import QtQuick
import Quickshell.Services.Notifications
import Quickshell.Hyprland
import qs.services
import qs.widgets
import qs.modules.notifications

Rectangle {
    radius: Theme.radius.normal
    color: Theme.color.bg
    NotificationServer {
        id: notificationServer
    }
    Rectangle {
        anchors {
            fill: parent
            topMargin: title.height
            margins: 36
        }
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
    Rectangle {
        id: title
        anchors.top: parent.top
        implicitWidth: parent.width
        implicitHeight: Theme.height.doubleBlock
        color: Theme.color.bg
        radius: Theme.radius.normal
        StyledText {
            text: "Notifications"
            font.pixelSize: Theme.font.size.doubled
        }
        Block {
            hovered: dismissMouse.containsMouse
            anchors.top: parent.top
            anchors.right: parent.right
            implicitHeight: Theme.height.doubleBlock
            implicitWidth: implicitHeight
            StyledText {
                text: "󰆴"
                font.pixelSize: Theme.font.size.doubled
            }
            MouseBlock {
                id: dismissMouse
                onClicked: Hyprland.dispatch("global buppyshell:clearNotifs")
            }
        }
    }
}
