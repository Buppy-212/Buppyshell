import Quickshell
import QtQuick
import QtQuick.Layouts
import "../services"
import "../modules/notifications"
import "../modules/sidebar"
import "../widgets"

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
            Rectangle {
                Layout.fillWidth: true
                implicitHeight: 48
                color: Theme.color.bg
                radius: Theme.rounding
                Row {
                    spacing: 4
                    Repeater {
                        model: [
                            {
                                text: "󰂚",
                                state: GlobalState.sidebarModule == GlobalState.SidebarModule.Notifications,
                                command: "notifications"
                            },
                            {
                                text: "󰂯",
                                state: GlobalState.sidebarModule == GlobalState.SidebarModule.Bluetooth,
                                command: "bluetooth"
                            },
                            {
                                text: "",
                                state: GlobalState.sidebarModule == GlobalState.SidebarModule.Volume,
                                command: "volume"
                            },
                        ]
                        delegate: Block {
                            id: delegateBlock
                            required property string text
                            required property string command
                            required property bool state
                            hovered: mouse.containsMouse
                            color: hovered ? Theme.color.grey : state ? Theme.color.accent : "transparent"
                            implicitHeight: 48
                            implicitWidth: 48
                            StyledText {
                                text: delegateBlock.text
                                font.pointSize: 26
                            }
                            MouseBlock {
                                id: mouse
                                onClicked: GlobalState.toggle(delegateBlock.command)
                            }
                        }
                    }
                }
            }
            Loader {
                active: true
                sourceComponent: {
                    switch (GlobalState.sidebarModule) {
                    case GlobalState.SidebarModule.Notifications:
                        list;
                        break;
                    case GlobalState.SidebarModule.Volume:
                        volumeMixer;
                        break;
                    case GlobalState.SidebarModule.Bluetooth:
                        bluetooth;
                        break;
                    }
                }
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
            Component {
                id: list
                List {}
            }
            Component {
                id: volumeMixer
                VolumeMixer {}
            }
            Component {
                id: bluetooth
                Bluetooth {}
            }
            Player {
                id: player
                Layout.fillWidth: true
            }
        }
    }
}
