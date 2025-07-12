import QtQuick
import Quickshell.Services.Notifications
import Quickshell.Hyprland
import Quickshell.Widgets
import "../../services"
import "../../widgets"
import "../notifications"

Rectangle {
    implicitWidth: parent.width
    radius: Theme.rounding
    color: Theme.color.bg
    Server {
        id: notificationServer
    }
    ClippingRectangle {
        id: notificationList
        anchors {
            fill: parent
            topMargin: title.height
            margins: 36
        }
        radius: Theme.rounding
        color: Theme.color.bgalt
        ListView {
            implicitHeight: parent.height
            implicitWidth: Theme.notification.width
            anchors.horizontalCenter: parent.horizontalCenter
            model: notificationServer.trackedNotifications
            spacing: Theme.border * 2
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
        implicitHeight: 48
        color: Theme.color.bg
        radius: Theme.rounding
        StyledText {
            text: "Notifications"
            font.pointSize: 26
        }
        Block {
            hovered: dismissMouse.containsMouse
            anchors.top: parent.top
            anchors.right: parent.right
            implicitHeight: 48
            implicitWidth: 48
            StyledText {
                text: "󰆴"
                font.pointSize: 26
            }
            MouseBlock {
                id: dismissMouse
                onClicked: Hyprland.dispatch("global buppyshell:clearNotifs")
            }
        }
    }
}
