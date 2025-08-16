import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.services
import qs.widgets
import qs.modules.bar

PanelWindow {
    id: root
    required property ShellScreen modelData
    visible: GlobalState.bar
    screen: modelData
    mask: Region {
        item: rectangle
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
        id: rectangle
        color: Theme.color.black
        implicitHeight: parent.height
        implicitWidth: Theme.width.block
        ColumnLayout {
            anchors.fill: parent
            spacing: 0
            Os {
                Layout.fillWidth: true
                Layout.preferredHeight: Theme.height.block
            }
            Workspaces {
                bar: root
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
            ColumnLayout {
                Layout.alignment: Qt.AlignBottom
                Layout.fillWidth: true
                spacing: 2
                Inhibitor {
                    Layout.fillWidth: true
                    Layout.preferredHeight: Theme.height.block
                }
                Battery {
                    Layout.fillWidth: true
                    Layout.preferredHeight: Theme.height.block
                }
                Light {
                    Layout.fillWidth: true
                    Layout.preferredHeight: Theme.height.block
                }
                Update {
                    Layout.fillWidth: true
                    Layout.preferredHeight: hovered ? Theme.height.doubleBlock : Theme.height.block
                }
                StyledText {
                    Layout.fillWidth: true
                    Layout.preferredHeight: Theme.height.doubleBlock
                    text: Time.timeGrid
                }
                Power {
                    Layout.fillWidth: true
                    Layout.preferredHeight: Theme.height.block
                }
            }
        }
    }
    RoundCorner {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        corner: RoundCorner.BottomLeft
    }
    RoundCorner {
        anchors.top: parent.top
        anchors.right: parent.right
        corner: RoundCorner.TopLeft
    }
}
