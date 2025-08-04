import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.modules.bar

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
            implicitWidth: Theme.width.block + Theme.radius.normalAdjusted
            exclusiveZone: Theme.width.block
            color: "transparent"
            Rectangle {
                id: leftRect
                color: Theme.color.black
                implicitHeight: parent.height
                implicitWidth: Theme.width.block
                ColumnLayout {
                    anchors.fill: parent
                    spacing: 0
                    Os {
                        Layout.preferredHeight: Theme.height.block
                    }
                    Workspaces {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }
                    Column {
                        Layout.alignment: Qt.AlignBottom
                        Layout.fillWidth: true
                        spacing: Theme.margin.tiny
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
                anchors.leftMargin: Theme.width.block
                size: Theme.radius.normalAdjusted
                corner: cornerEnum.bottomLeft
            }
            RoundCorner {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.leftMargin: Theme.width.block
                size: Theme.radius.normalAdjusted
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
            implicitWidth: Theme.width.block + Theme.radius.normalAdjusted
            exclusiveZone: Theme.width.block
            color: "transparent"
            Rectangle {
                id: rightRect
                color: Theme.color.black
                implicitHeight: parent.height
                implicitWidth: Theme.width.block
                anchors.right: parent.right
                ColumnLayout {
                    anchors.fill: parent
                    Column {
                        spacing: Theme.margin.tiny
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
                anchors.rightMargin: Theme.width.block
                size: Theme.radius.normalAdjusted
                corner: cornerEnum.bottomRight
            }
            RoundCorner {
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.rightMargin: Theme.width.block
                size: Theme.radius.normalAdjusted
                corner: cornerEnum.topRight
            }
        }
    }
}
