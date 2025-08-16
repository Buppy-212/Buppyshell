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

PanelWindow {
    id: root
    required property ShellScreen modelData
    readonly property bool sidebarVisible: GlobalState.sidebar
    property string monitor
    anchors {
        top: true
        right: true
        bottom: true
    }
    onSidebarVisibleChanged: {
        root.monitor = Hyprland.focusedMonitor?.name ?? "";
    }
    visible: GlobalState.sidebar && modelData.name === monitor
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "buppyshell:sidebar"
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
    exclusiveZone: 0
    color: "transparent"
    implicitWidth: screen.width / 4
    Rectangle {
        id: sidebar
        anchors {
            top: parent.top
            bottom: parent.bottom
            margins: 2
        }
        implicitWidth: parent.width - 2
        radius: Theme.radius.normal
        color: Theme.color.bg
        DragHandler {
            cursorShape: Qt.ClosedHandCursor
            xAxis.minimum: 0
            yAxis.enabled: false
            onGrabChanged: (transition, point) => {
                if (transition === PointerDevice.GrabExclusive) {
                    behavior.enabled = false;
                } else if (transition === PointerDevice.UngrabExclusive && sidebar.x !== 0) {
                    behavior.enabled = true;
                    sidebar.x = sidebar.width;
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
                Layout.preferredHeight: sidebar.height / 30
                Layout.maximumHeight: sidebar.height / 30
            }
            StackView {
                id: stackView
                readonly property int sidebarModule: GlobalState.sidebarModule
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.bottomMargin: sidebar.width / 20
                Layout.rightMargin: sidebar.width / 20
                Layout.leftMargin: sidebar.width / 20
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
                Layout.preferredHeight: sidebar.height / 10
            }
        }
    }
}
