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
    implicitHeight: row.height > Theme.height.notification - 16 ? column.height + 16 : Theme.height.notification
    color: Theme.color.bg
    radius: Theme.radius.normal
    border.width: Theme.border
    border.color: Theme.color.blue
    Drag.active: dragHandler.active
    RowLayout {
        id: row
        anchors {
            top: parent.top
            right: parent.right
            left: parent.left
            margins: Theme.margin.medium
        }
        spacing: Theme.margin.medium
        IconImage {
            source: Quickshell.iconPath(root.notification?.appIcon, "preferences-desktop-notification-bell")
            Layout.preferredWidth: Theme.iconSize.medium
            Layout.preferredHeight: width
            Layout.alignment: Qt.AlignVCenter
        }
        Column {
            id: column
            Layout.fillWidth: true
            Layout.fillHeight: true
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
            } else if (transition === PointerDevice.UngrabExclusive) {
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
