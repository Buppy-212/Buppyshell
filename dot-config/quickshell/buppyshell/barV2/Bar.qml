import Quickshell
import QtQuick
import QtQuick.Layouts
import "../services"

Variants {
    model: Quickshell.screens
    Scope {
        id: scope
        required property ShellScreen modelData
        PanelWindow {
            id: bar
            screen: scope.modelData
            anchors {
                left: true
                right: true
                top: true
            }
            implicitHeight: 24
            color: Theme.color.black
            RowLayout {
                anchors.fill: parent
                Row {
                  Layout.fillWidth: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    spacing: 2
                    Os {}
                    Workspaces {}
                    Tray {}
                    Mpris {}
                    Bluetooth {}
                    Title { implicitWidth: modelData.width }
                }
                Row {
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    spacing: 2
                    WindowControls {}
                    Volume {}
                    Inhibitor {}
                    Battery {}
                    Light {}
                    Update {}
                    Clock {}
                    Bell {}
                    Power {}
                }
            }
        }
    }
}
