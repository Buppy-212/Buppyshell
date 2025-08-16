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
    screen: root.modelData
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
                bar: root
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
            ColumnLayout {
                Layout.alignment: Qt.AlignBottom
                Layout.fillWidth: true
                spacing: Theme.margin.tiny
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
        anchors.left: parent.left
        anchors.leftMargin: Theme.width.block
        size: Theme.radius.normalAdjusted
        corner: RoundCorner.Corner.BottomLeft
    }
    RoundCorner {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: Theme.width.block
        size: Theme.radius.normalAdjusted
        corner: RoundCorner.Corner.TopLeft
    }
}
