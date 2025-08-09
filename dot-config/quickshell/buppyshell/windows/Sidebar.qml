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
                    spacing: 0
                    focus: true
                    Keys.onTabPressed: {
                        var i = GlobalState.sidebarModule;
                        i += 1;
                        if (i > 3) {
                            i = 0;
                        }
                        GlobalState.sidebarModule = i;
                    }
                    Keys.onBacktabPressed: {
                        var i = GlobalState.sidebarModule;
                        i -= 1;
                        if (i < 0) {
                            i = 3;
                        }
                        GlobalState.sidebarModule = i;
                    }
                    Keys.onEscapePressed: {
                        GlobalState.sidebar = false;
                    }
                    Keys.forwardTo: [stackView.currentItem]
                    Tabs {
                        Layout.fillWidth: true
                        Layout.preferredHeight: Theme.height.doubleBlock
                        Layout.maximumHeight: Theme.height.doubleBlock
                    }
                    StackView {
                        id: stackView
                        readonly property int sidebarModule: GlobalState.sidebarModule
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        initialItem: getSidebarModule()
                        onSidebarModuleChanged: getSidebarModule()
                        function getSidebarModule(): Item {
                            switch (sidebarModule) {
                            case GlobalState.SidebarModule.Notifications:
                                stackView.replaceCurrentItem(Quickshell.shellPath("modules/sidebar/Notifications.qml"));
                                break;
                            case GlobalState.SidebarModule.Volume:
                                stackView.replaceCurrentItem(Quickshell.shellPath("modules/sidebar/Volume.qml"));
                                break;
                            case GlobalState.SidebarModule.Bluetooth:
                                stackView.replaceCurrentItem(Quickshell.shellPath("modules/sidebar/Bluetooth.qml"));
                                break;
                            case GlobalState.SidebarModule.Network:
                                stackView.replaceCurrentItem(Quickshell.shellPath("modules/sidebar/Network.qml"));
                                break;
                            }
                        }
                    }
                    Player {
                        Layout.fillWidth: true
                    }
                }
            }
        }
    }
}
