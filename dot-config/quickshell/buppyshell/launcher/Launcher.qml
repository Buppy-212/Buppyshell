pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import Quickshell.Wayland
import Quickshell.Hyprland

Scope {
    id: root
    required property bool visible
    required property string source
    LazyLoader {
        id: loader
        loading: root.visible
        component: PanelWindow {
            id: panel
            visible: root.visible
            WlrLayershell.layer: WlrLayer.Overlay
            WlrLayershell.namespace: "buppyshell:launcher"
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand
            exclusionMode: ExclusionMode.Ignore
            color: "#aa222436"
            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
                onClicked: root.visible = false
            }
            anchors {
                top: true
                right: true
                bottom: true
                left: true
            }
            Loader {
                active: root.visible
                focus: true
                anchors.fill: parent
                source: root.source
            }
        }
    }
    GlobalShortcut {
        name: "launcher"
        description: "Toggle application launcher"
        appid: "buppyshell"
        onPressed: {
            root.visible = !root.visible;
            root.source = "Applications.qml";
        }
    }
    GlobalShortcut {
        name: "windows"
        description: "Toggle window switcher"
        appid: "buppyshell"
        onPressed: {
            root.visible = !root.visible;
            root.source = "Windows.qml";
        }
    }
    GlobalShortcut {
        name: "logout"
        description: "Toggle logout menu"
        appid: "buppyshell"
        onPressed: {
            root.visible = !root.visible;
            root.source = "Logout.qml";
        }
    }
}
