pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.modules.sidebar
import qs.services
import qs.widgets

Variants {
    model: Quickshell.screens
    Loader {
        id: sidebarLoader
        asynchronous: true
        required property ShellScreen modelData
        readonly property bool sidebarVisible: GlobalState.sidebar
        property string monitor
        onSidebarVisibleChanged: monitor = Hyprland.focusedMonitor?.name ?? ""
        active: GlobalState.sidebar && monitor === modelData.name
        sourceComponent: PanelWindow {
            screen: sidebarLoader.modelData
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
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
            exclusiveZone: 0
            color: "transparent"
            implicitWidth: screen.width / 4
            Rectangle {
                id: sidebar
                implicitWidth: parent.width - Theme.margin.tiny
                implicitHeight: parent.height
                radius: Theme.radius.normal
                color: Theme.color.bg
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
                    TabBar {
                      id: bar
                        width: parent.width
                        Repeater {
                          id: repeater
                            model: [
                                {
                                    _text: "󰂚",
                                    state: GlobalState.sidebarModule == GlobalState.SidebarModule.Notifications,
                                    command: "notifications"
                                },
                                {
                                    _text: "",
                                    state: GlobalState.sidebarModule == GlobalState.SidebarModule.Volume,
                                    command: "volume"
                                },
                                {
                                    _text: "󰂯",
                                    state: GlobalState.sidebarModule == GlobalState.SidebarModule.Bluetooth,
                                    command: "bluetooth"
                                },
                                {
                                    _text: "󰖩",
                                    state: GlobalState.sidebarModule == GlobalState.SidebarModule.Network,
                                    command: "network"
                                },
                            ]
                            delegate: TabButton {
                                required property string _text
                                required property string command
                                required property bool state
                                text: _text
                                width: bar.width / repeater.count
                                font.pixelSize: height
                            }
                        }
                    }
                    // Repeater {
                    //     model: [
                    //         {
                    //             text: "󰂚",
                    //             state: GlobalState.sidebarModule == GlobalState.SidebarModule.Notifications,
                    //             command: "notifications"
                    //         },
                    //         {
                    //             text: "",
                    //             state: GlobalState.sidebarModule == GlobalState.SidebarModule.Volume,
                    //             command: "volume"
                    //         },
                    //         {
                    //             text: "󰂯",
                    //             state: GlobalState.sidebarModule == GlobalState.SidebarModule.Bluetooth,
                    //             command: "bluetooth"
                    //         },
                    //         {
                    //             text: "󰖩",
                    //             state: GlobalState.sidebarModule == GlobalState.SidebarModule.Network,
                    //             command: "network"
                    //         },
                    //     ]
                    //     delegate: Block {
                    //         id: delegateBlock
                    //         required property string text
                    //         required property string command
                    //         required property bool state
                    //         hovered: mouse.containsMouse
                    //         color: hovered ? Theme.color.grey : state ? Theme.color.bgalt : "transparent"
                    //         Layout.preferredHeight: Theme.height.doubleBlock
                    //         Layout.fillWidth: true
                    //         Rectangle {
                    //             visible: delegateBlock.state
                    //             anchors {
                    //                 fill: parent
                    //                 topMargin: parent.height * 0.96
                    //             }
                    //             color: Theme.color.accent
                    //         }
                    //         StyledText {
                    //             text: delegateBlock.text
                    //             anchors.fill: parent
                    //             font.pixelSize: Theme.font.size.doubled
                    //         }
                    //         MouseBlock {
                    //             id: mouse
                    //             onClicked: GlobalState.toggle(delegateBlock.command)
                    //         }
                    //     }
                    // }
                    Loader {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.columnSpan: 4
                        source: {
                            switch (GlobalState.sidebarModule) {
                            case GlobalState.SidebarModule.Notifications:
                                return Quickshell.shellPath("modules/sidebar/Notifications.qml");
                                break;
                            case GlobalState.SidebarModule.Volume:
                                return Quickshell.shellPath("modules/sidebar/Volume.qml");
                                break;
                            case GlobalState.SidebarModule.Bluetooth:
                                return Quickshell.shellPath("modules/sidebar/Bluetooth.qml");
                                break;
                            case GlobalState.SidebarModule.Network:
                                return Quickshell.shellPath("modules/sidebar/Network.qml");
                                break;
                            default:
                                return undefined;
                            }
                        }
                    }
                    Player {
                        Layout.fillWidth: true
                        Layout.columnSpan: 4
                    }
                }
            }
        }
    }
}
