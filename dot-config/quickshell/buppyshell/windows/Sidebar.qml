pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.modules.sidebar
import qs.services
import qs.widgets

Variants {
    model: Quickshell.screens
    PanelWindow {
        id: sidebarWindow
        required property ShellScreen modelData
        property string monitor
        readonly property bool sidebar: GlobalState.sidebar
        screen: modelData
        anchors {
            top: true
            right: true
            bottom: true
        }
        margins {
            top: Theme.margin.tiny
            bottom: Theme.margin.tiny
        }
        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.namespace: "buppyshell:sidebar"
        exclusiveZone: 0
        color: "transparent"
        implicitWidth: screen.width / 4
        onSidebarChanged: monitor = Hyprland.focusedMonitor.name
        visible: this.sidebar && monitor === modelData.name
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
                                    font.pixelSize: Theme.font.size.doubled
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
}
