import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "../services"

Variants {
    model: Quickshell.screens
    Scope {
        id: scope
        required property ShellScreen modelData
        PanelWindow {
            screen: scope.modelData
            mask: Region {
                item: leftRect
            }
            WlrLayershell.namespace: "buppyshell:leftbar"
            anchors {
                top: true
                left: true
                bottom: true
            }
            implicitWidth: Theme.blockWidth + Theme.rounding + 3
            exclusiveZone: Theme.blockWidth
            color: "transparent"
            Rectangle {
                id: leftRect
                color: Theme.color.black
                implicitHeight: parent.height
                implicitWidth: Theme.blockWidth
                anchors.left: parent.left
                ColumnLayout {
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
            RoundCorner {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.leftMargin: Theme.blockWidth
                size: Theme.rounding + 3
                corner: cornerEnum.bottomLeft
            }
            RoundCorner {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.topMargin: Theme.blockHeight
                anchors.leftMargin: Theme.blockWidth
                size: Theme.rounding + 3
                corner: cornerEnum.topLeft
            }
        }
        PanelWindow {
            id: rightBar
            screen: scope.modelData
            mask: Region {
                item: rightRect
            }
            WlrLayershell.namespace: "buppyshell:rightbar"
            anchors {
                top: true
                right: true
                bottom: true
            }
            implicitWidth: Theme.blockWidth + Theme.rounding + 3
            exclusiveZone: Theme.blockWidth
            color: "transparent"
            Rectangle {
                id: rightRect
                color: Theme.color.black
                implicitHeight: parent.height
                implicitWidth: Theme.blockWidth
                anchors.right: parent.right
                ColumnLayout {
                    anchors.fill: parent
                    Column {
                        spacing: 2
                        Layout.alignment: Qt.AlignTop
                        Bell {}
                        Bluetooth {}
                        Tray {}
                        Mpris {}
                    }
                }
            }
            RoundCorner {
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.rightMargin: Theme.blockWidth
                size: Theme.rounding + 3
                corner: cornerEnum.bottomRight
            }
            RoundCorner {
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.topMargin: Theme.blockHeight
                anchors.rightMargin: Theme.blockWidth
                size: Theme.rounding + 3
                corner: cornerEnum.topRight
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
