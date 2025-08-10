import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Widgets
import QtQuick
import qs.services
import qs.widgets

Rectangle {
    id: notificationContent
    required property Notification notification
    readonly property alias hovered: mouseArea.containsMouse
    implicitHeight: row.height > Theme.height.notification - 20 ? row.height + 20 : Theme.height.notification
    color: Theme.color.bg
    radius: Theme.radius.normal
    border.width: Theme.border
    border.color: Theme.color.blue
    Row {
        id: row
        width: column.width
        height: column.height
        spacing: Theme.margin.large
        x: Theme.margin.large
        anchors.verticalCenter: parent.verticalCenter
        IconImage {
            source: Quickshell.iconPath(notificationContent.notification?.appIcon, "preferences-desktop-notification-bell")
            implicitSize: Theme.iconSize.medium
            anchors.verticalCenter: column.verticalCenter
        }
        Column {
            id: column
            width: notificationContent.width - Theme.iconSize.medium * 2
            height: body.visible ? summary.height + body.height : summary.height
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: summary
                wrapMode: Text.Wrap
                width: column.width
                text: notificationContent.notification?.summary ?? ""
                font.pixelSize: Theme.font.size.large
                font.bold: true
                color: Theme.color.fg
            }
            Text {
                id: body
                wrapMode: Text.Wrap
                visible: contentWidth > 0
                width: column.width
                text: notificationContent.notification?.body ?? ""
                font.pixelSize: Theme.font.size.normal
                color: Theme.color.fg
            }
        }
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        drag.target: parent
        drag.axis: Drag.XAxis
        drag.minimumX: 0
        drag.filterChildren: true
        onReleased: {
            notificationContent.notification.actions?.invoke();
            notificationContent.x = parent.width;
        }
    }
    Behavior on x {
        NumberAnimation {
            duration: Theme.animation.elementMoveExit.duration
            easing.type: Theme.animation.elementMoveExit.type
            easing.bezierCurve: Theme.animation.elementMoveExit.bezierCurve
            onRunningChanged: {
                if (!running) {
                    notificationContent.x = 0;
                    notificationContent.notification?.dismiss();
                }
            }
        }
    }
}
