import QtQuick
import Quickshell.Services.Notifications
import Quickshell.Hyprland
import "../../services"
import "../../widgets"

Rectangle {
    implicitWidth: parent.width
    radius: Theme.rounding
    color: Theme.color.bg
    Server {
        id: notificationServer
    }
    Rectangle {
        id: notificationList
        anchors {
          fill: parent
          topMargin: title.height
          margins: 36
        }
        radius: Theme.rounding
        color: Theme.color.bgalt
        ListView {
            anchors.fill: parent
            model: notificationServer.trackedNotifications
            spacing: Theme.border * 2
            delegate: Item {
                id: listItem
                required property Notification modelData
                implicitWidth: content.width
                implicitHeight: content.height
                Content {
                    id: content
                    notification: listItem.modelData
                }
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
