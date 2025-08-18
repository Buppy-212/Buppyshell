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
        item: rectangle
    }
    WlrLayershell.namespace: "buppyshell:rightbar"
    anchors {
        top: true
        right: true
        bottom: true
    }
    implicitWidth: Theme.width.doubleBlock + Theme.radius.normalAdjusted
    exclusiveZone: Theme.width.doubleBlock
    color: "transparent"
    Rectangle {
        id: rectangle
        color: Theme.color.black
        anchors {
            fill: parent
            leftMargin: Theme.radius.normalAdjusted
        }
        ColumnLayout {
            anchors.fill: parent
            spacing: 2
            Os {
                Layout.fillWidth: true
                Layout.preferredHeight: Theme.height.block
            }
            Bell {
                Layout.fillWidth: true
                Layout.preferredHeight: Theme.height.block
            }
            Workspaces {
                Layout.fillWidth: true
                orientation: Workspaces.Right
            }
            Tray {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
            Volume {
                Layout.fillWidth: true
                Layout.preferredHeight: Theme.height.block
            }
            Bluetooth {
                Layout.fillWidth: true
                Layout.preferredHeight: Theme.height.block
            }
            Inhibitor {
                Layout.fillWidth: true
                Layout.preferredHeight: Theme.height.block
            }
            Network {
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
    RoundCorner {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        corner: RoundCorner.BottomRight
    }
    RoundCorner {
        anchors.top: parent.top
        anchors.left: parent.left
        corner: RoundCorner.TopRight
    }
}
