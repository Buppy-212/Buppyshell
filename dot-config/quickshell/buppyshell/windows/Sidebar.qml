pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import qs.modules.sidebar
import qs.services
import qs.widgets

Loader {
    id: root

    required property ShellScreen modelData
    readonly property bool sidebarVisible: GlobalState.sidebar
    property string monitor

    asynchronous: true
    onSidebarVisibleChanged: {
        root.monitor = Hyprland.focusedMonitor?.name ?? "";
    }
    active: GlobalState.sidebar && modelData.name === monitor
    sourceComponent: PanelWindow {
        anchors {
            top: true
            right: Theme.barOnRight
            bottom: true
            left: !Theme.barOnRight
        }
        color: "transparent"
        implicitWidth: screen.width / 4
        exclusiveZone: 0
        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.namespace: "buppyshell:sidebar"
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand

        ClippingWrapperRectangle {
            anchors {
                top: parent.top
                bottom: parent.bottom
                margins: Theme.border
            }
            implicitWidth: parent.width - Theme.border
            radius: Theme.radius
            color: "transparent"

            Rectangle {
                id: sidebar

                radius: Theme.radius
                color: "transparent"

                GlassBackground {
                    id: background

                    anchors.fill: parent
                    sourceSize: Qt.size(root.modelData.width, root.modelData.height)
                    sourceClipRect: Qt.rect(root.modelData.width - sidebar.width, root.modelData.height - sidebar.height, width, height)
                }

                MultiEffect {
                    anchors.fill: parent
                    source: background
                    autoPaddingEnabled: false
                    blur: 1
                    blurMultiplier: 2
                    blurMax: 24
                    blurEnabled: true
                }

                DragHandler {
                    cursorShape: Qt.ClosedHandCursor
                    xAxis.minimum: Theme.barOnRight ? 0 : -sidebar.width
                    xAxis.maximum: Theme.barOnRight ? sidebar.width : 0
                    yAxis.enabled: false
                    onGrabChanged: (transition, point) => {
                        if (transition === PointerDevice.GrabExclusive) {
                            behavior.enabled = false;
                        } else if (transition === PointerDevice.UngrabExclusive && sidebar.x !== 0) {
                            behavior.enabled = true;
                            Theme.barOnRight ? sidebar.x = sidebar.width : sidebar.x = -sidebar.width
                        }
                    }
                }

                Behavior on x {
                    id: behavior

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
                        Layout.preferredHeight: Theme.doubledBlockHeight
                        Layout.maximumHeight: Theme.doubledBlockHeight
                    }

                    StackView {
                        id: stackView

                        readonly property int sidebarModule: GlobalState.sidebarModule

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

                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.bottomMargin: Theme.blockHeight
                        initialItem: getSidebarModule()
                        onSidebarModuleChanged: getSidebarModule()
                    }

                    Player {
                        Layout.fillWidth: true
                    }
                }
            }
        }
    }
}
