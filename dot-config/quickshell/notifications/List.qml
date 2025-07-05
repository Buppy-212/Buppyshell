import QtQuick
import Quickshell.Services.Notifications
import "../services"

ListView {
    id: notificationList
    Server {
        id: notificationServer
    }
    anchors.top: parent.top
    anchors.topMargin: Theme.border * 4
    anchors.bottom: parent.bottom
    width: Theme.notification.width
    anchors.horizontalCenter: parent.horizontalCenter
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
