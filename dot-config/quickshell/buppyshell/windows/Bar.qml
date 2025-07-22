import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "../services"
import "../modules/bar"

Variants {
    model: Quickshell.screens
    Scope {
        id: scope
        required property ShellScreen modelData
        PanelWindow {
            id: leftBar
            visible: GlobalState.bar
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
                anchors.leftMargin: leftRect.visible ? Theme.blockWidth : 0
                size: Theme.rounding + 3
                corner: cornerEnum.bottomLeft
            }
            RoundCorner {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.leftMargin: leftRect.visible ? Theme.blockWidth : 0
                size: Theme.rounding + 3
                corner: cornerEnum.topLeft
            }
        }
        PanelWindow {
            id: rightBar
            visible: GlobalState.bar
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
                        Volume {}
                        Bluetooth {}
                        Network {}
                        Player {}
                        Tray {}
                    }
                }
            }
            RoundCorner {
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.rightMargin: rightRect.visible ? Theme.blockWidth : 0
                size: Theme.rounding + 3
                corner: cornerEnum.bottomRight
            }
            RoundCorner {
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.rightMargin: rightRect.visible ? Theme.blockWidth : 0
                size: Theme.rounding + 3
                corner: cornerEnum.topRight
            }
        }
    }
}
