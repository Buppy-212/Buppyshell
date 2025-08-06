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
                GridLayout {
                    anchors.fill: parent
                    columns: 4
                    rows: 3
                    rowSpacing: 0
                    columnSpacing: 0
                    Repeater {
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
                        delegate: StyledTabButton {
                            id: delegateButton
                            required property string _text
                            required property string command
                            required property bool state
                            selected: state
                            text: delegateButton._text
                            font.pixelSize: Theme.font.size.doubled
                            Layout.preferredHeight: Theme.height.doubleBlock
                            Layout.fillWidth: true
                            function tapped() {
                                GlobalState.toggle(delegateButton.command);
                            }
                        }
                    }
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
