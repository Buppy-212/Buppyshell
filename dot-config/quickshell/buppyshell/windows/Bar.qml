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
    property bool onRight: true
    visible: GlobalState.bar
    screen: root.modelData
    mask: Region {
        item: rectangle
    }
    WlrLayershell.namespace: "buppyshell:rightbar"
    anchors {
        top: true
        right: root.onRight
        bottom: true
        left: !root.onRight
    }
    implicitWidth: modelData.width
    exclusiveZone: Theme.width.bar
    color: "transparent"
    Rectangle {
        id: rectangle
        color: Theme.color.black
        anchors {
            top: parent.top
            right: root.onRight ? parent.right : undefined
            bottom: parent.bottom
            left: !root.onRight ? parent.left : undefined
        }
        implicitWidth: Theme.width.bar
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
                Layout.fillHeight: true
                onRight: root.onRight
            }
            Tray {
                Layout.fillWidth: true
                onRight: root.onRight
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
        anchors.top: parent.top
        anchors.left: root.onRight ? parent.left : rectangle.right
        corner: RoundCorner.TopLeft
    }
    RoundCorner {
        anchors.bottom: parent.bottom
        anchors.left: root.onRight ? parent.left : rectangle.right
        corner: RoundCorner.BottomLeft
    }
    RoundCorner {
        anchors.bottom: parent.bottom
        anchors.right: root.onRight ? rectangle.left : parent.right
        corner: RoundCorner.BottomRight
    }
    RoundCorner {
        anchors.top: parent.top
        anchors.right: root.onRight ? rectangle.left : parent.right
        corner: RoundCorner.TopRight
    }
}
