import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.widgets

Rectangle {
    id: root

    required property Notification notification
    readonly property alias hovered: hoverHandler.hovered

    implicitHeight: row.height
    color: Theme.color.bg
    radius: Theme.radius
    border.width: Theme.border
    border.color: Theme.color.blue
    Drag.active: dragHandler.active

    RowLayout {
        id: row

        anchors {
            top: parent.top
            right: parent.right
            left: parent.left
        }
        spacing: 0

        IconImage {
            Layout.preferredWidth: Theme.iconSize
            Layout.preferredHeight: Theme.iconSize
            Layout.margins: Theme.margin
            Layout.alignment: Qt.AlignVCenter
            source: Quickshell.iconPath(root.notification?.appIcon, "preferences-desktop-notification-bell")
        }

        Column {
            id: column

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.margins: Theme.margin

            Text {
                id: summary

                wrapMode: Text.Wrap
                width: column.width
                text: root.notification?.summary ?? ""
                font.pixelSize: Theme.font.size.large
                font.bold: true
                color: Theme.color.fg
            }

            Text {
                id: body

                wrapMode: Text.Wrap
                visible: contentWidth > 0
                width: column.width
                text: root.notification?.body ?? ""
                font.pixelSize: Theme.font.size.normal
                color: Theme.color.fg
            }
        }
    }

    DragHandler {
        id: dragHandler

        xAxis.minimum: 0
        yAxis.enabled: false
        cursorShape: Qt.ClosedHandCursor
        onGrabChanged: (transition, point) => {
            if (transition === PointerDevice.GrabExclusive) {
                behavior.enabled = false;
            } else if (transition === PointerDevice.UngrabExclusive && root.x !== 0) {
                behavior.enabled = true;
                root.x = root.width;
            }
        }
    }

    HoverHandler {
        id: hoverHandler

        cursorShape: Qt.OpenHandCursor
    }

    Behavior on x {
        id: behavior

        NumberAnimation {
            duration: Theme.animation.elementMoveExit.duration
            easing.type: Theme.animation.elementMoveExit.type
            easing.bezierCurve: Theme.animation.elementMoveExit.bezierCurve
            onRunningChanged: {
                if (!running) {
                    root.x = 0;
                    root.notification?.dismiss();
                }
            }
        }
    }
}
