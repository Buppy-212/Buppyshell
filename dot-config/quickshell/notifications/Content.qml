import Quickshell
import Quickshell.Widgets
import QtQuick
import "../services"

Rectangle {
    id: notifictionContent
    required property var notification
    implicitWidth: Theme.notification.width
    implicitHeight: row.height > Theme.notification.height - 20 ? row.height + 20 : Theme.notification.height
    color: Theme.color.bg
    radius: Theme.rounding
    border.width: Theme.border
    border.color: Theme.color.blue
    Row {
        id: row
        width: column.width
        height: column.height
        spacing: Theme.notification.margin
        x: Theme.notification.margin
        anchors.verticalCenter: parent.verticalCenter
        IconImage {
            source: Quickshell.iconPath(notifictionContent.notification?.appIcon, "preferences-desktop-notification-bell")
            implicitSize: Theme.notification.iconSize
            anchors.verticalCenter: column.verticalCenter
        }
        Column {
            id: column
            width: Theme.notification.width - Theme.notification.iconSize * 2
            height: summary.height + body.height
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: summary
                wrapMode: Text.Wrap
                width: column.width
                text: notifictionContent.notification?.summary ?? ""
                font.pointSize: Theme.font.size.large
                font.bold: true
                color: Theme.color.fg
            }
            Text {
                id: body
                wrapMode: Text.Wrap
                width: column.width
                text: notifictionContent.notification?.body ?? ""
                font.pointSize: Theme.font.size.normal
                color: Theme.color.fg
            }
        }
    }
    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        drag.target: parent
        drag.axis: Drag.XAxis
        drag.minimumX: 0
        drag.maximumX: Theme.notification.sidebarWidth
        drag.filterChildren: true
        onReleased: {
            notifictionContent.x = Theme.notification.sidebarWidth;
            notifictionContent.notification.actions?.invoke();
        }
    }
    Behavior on x {
        NumberAnimation {
            duration: Theme.animation.elementMoveExit.duration
            easing.type: Theme.animation.elementMoveExit.type
            easing.bezierCurve: Theme.animation.elementMoveExit.bezierCurve
            onRunningChanged: {
                if (!running) {
                    notifictionContent.x = 0;
                    notifictionContent.notification?.dismiss();
                }
            }
        }
    }
}
