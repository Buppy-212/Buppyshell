import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "../services"

Variants {
    model: Quickshell.screens
    Scope {
        id: scope
        property var modelData
        PanelWindow {
            screen: scope.modelData
            WlrLayershell.namespace: "buppyshell:leftbar"
            anchors {
                top: true
                left: true
                bottom: true
            }
            implicitWidth: Theme.blockWidth
            color: Theme.color.black
            ColumnLayout {
                anchors.topMargin: 2
                anchors.fill: parent
                Column {
                    spacing: 2
                    Layout.alignment: Qt.AlignTop
                    Os {}
                    Workspaces {}
                }
                Column {
                    Layout.alignment: Qt.AlignBottom
                    spacing: 2
                    Volume {}
                    Inhibitor {}
                    Battery {}
                    Light {}
                    Update {}
                    Clock {}
                    Power {}
                }
            }
        }
        PanelWindow {
            id: rightBar
            screen: scope.modelData
            WlrLayershell.namespace: "buppyshell:rightbar"
            anchors {
                top: true
                right: true
                bottom: true
            }
            implicitWidth: Theme.blockWidth
            color: Theme.color.black
            Column {
                anchors.top: parent.top
                spacing: 2
                Bell {}
                Bluetooth {}
                Tray {}
                Mpris {}
            }
        }
        PanelWindow {
            id: bar
            screen: scope.modelData
            WlrLayershell.namespace: "buppyshell:topbar"
            anchors {
                top: true
                right: true
                left: true
            }
            implicitHeight: Theme.blockHeight
            color: Theme.color.black
            Title {
                anchors.centerIn: parent
            }
            WindowControls {
                anchors.right: parent.right
            }
        }
    }
}
