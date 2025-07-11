import Quickshell
import QtQuick
import QtQuick.Layouts
import "../services"
import "../notifications"

PanelWindow {
    anchors {
        top: true
        right: true
        bottom: true
    }
    margins {
        top: 2
        right: 2
        bottom: 2
    }
    exclusiveZone: 0
    color: "transparent"
    implicitWidth: 600
    visible: GlobalState.sidebar
    Rectangle {
        id: sidebar
        implicitWidth: parent.width
        implicitHeight: parent.height
        radius: Theme.rounding
        color: Theme.color.black
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            drag.target: parent
            drag.axis: Drag.XAxis
            drag.minimumX: 0
            drag.maximumX: parent.width
            drag.filterChildren: false
            onReleased: {
                parent.x = parent.width;
            }
        }
        Behavior on x {
            NumberAnimation {
                duration: Theme.animation.elementMoveExit.duration
                easing.type: Theme.animation.elementMoveExit.type
                easing.bezierCurve: Theme.animation.elementMoveExit.bezierCurve
                onRunningChanged: {
                    if (!running) {
                        sidebar.x = 0;
                        GlobalState.sidebar = false;
                    }
                }
            }
        }
        ColumnLayout {
            anchors.fill: parent
            spacing: 2
            List {
                Layout.fillHeight: true
            }
            Bluetooth {
                id: bluetooth
            }
            Player {
                id: player
            }
        }
    }
}
