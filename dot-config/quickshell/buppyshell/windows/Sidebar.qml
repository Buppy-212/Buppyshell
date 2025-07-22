pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts
import "../modules/sidebar"
import "../services"
import "../widgets"

PanelWindow {
    anchors {
        top: true
        right: true
        bottom: true
    }
    margins {
        top: Theme.margin.tiny
        bottom: Theme.margin.tiny
    }
    exclusiveZone: 0
    color: "transparent"
    implicitWidth: Theme.width.sidebar + Theme.margin.tiny
    visible: GlobalState.sidebar
    Rectangle {
        id: sidebar
        implicitWidth: parent.width - Theme.margin.tiny
        implicitHeight: parent.height
        radius: Theme.radius.normal
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
            spacing: Theme.margin.tiny
            Rectangle {
                Layout.fillWidth: true
                implicitHeight: Theme.height.doubleBlock
                color: Theme.color.bg
                radius: Theme.radius.normal
                Row {
                    id: row
                    width: parent.width - Theme.margin.medium
                    height: parent.height - Theme.margin.medium
                    x: Theme.margin.small
                    y: Theme.margin.small
                    spacing: Theme.margin.small
                    Repeater {
                        model: [
                            {
                                text: "󰂚",
                                state: GlobalState.sidebarModule == GlobalState.SidebarModule.Notifications,
                                command: "notifications"
                            },
                            {
                                text: "",
                                state: GlobalState.sidebarModule == GlobalState.SidebarModule.Volume,
                                command: "volume"
                            },
                            {
                                text: "󰂯",
                                state: GlobalState.sidebarModule == GlobalState.SidebarModule.Bluetooth,
                                command: "bluetooth"
                            },
                            {
                                text: "󰖩",
                                state: GlobalState.sidebarModule == GlobalState.SidebarModule.Network,
                                command: "network"
                            },
                        ]
                        delegate: Block {
                            id: delegateBlock
                            required property string text
                            required property string command
                            required property bool state
                            hovered: mouse.containsMouse
                            color: hovered ? Theme.color.grey : state ? Theme.color.accent : "transparent"
                            implicitHeight: row.height
                            implicitWidth: implicitHeight
                            StyledText {
                                text: delegateBlock.text
                                font.pointSize: Theme.font.size.doubled
                            }
                            MouseBlock {
                                id: mouse
                                onClicked: GlobalState.toggle(delegateBlock.command)
                            }
                        }
                    }
                }
            }
            Notifications {
                visible: GlobalState.sidebarModule == GlobalState.SidebarModule.Notifications
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
            Volume {
                visible: GlobalState.sidebarModule == GlobalState.SidebarModule.Volume
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
            Bluetooth {
                visible: GlobalState.sidebarModule == GlobalState.SidebarModule.Bluetooth
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
            Network {
                visible: GlobalState.sidebarModule == GlobalState.SidebarModule.Network
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
            Player {
                id: player
                Layout.fillWidth: true
            }
        }
    }
}
