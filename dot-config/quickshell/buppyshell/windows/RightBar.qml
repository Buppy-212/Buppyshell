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
    implicitWidth: Theme.width.block + Theme.radius.normalAdjusted
    exclusiveZone: Theme.width.block
    color: "transparent"
    Rectangle {
        id: rectangle
        color: Theme.color.black
        implicitHeight: parent.height
        implicitWidth: Theme.width.block
        anchors.right: parent.right
        ColumnLayout {
            anchors.fill: parent
            spacing: 2
            Bell {
                Layout.fillWidth: true
                Layout.preferredHeight: Theme.height.block
            }
            Volume {
                Layout.fillWidth: true
                Layout.preferredHeight: Theme.height.block
            }
            Bluetooth {
                Layout.fillWidth: true
                Layout.preferredHeight: Theme.height.block
            }
            Network {
                Layout.fillWidth: true
                Layout.preferredHeight: Theme.height.block
            }
            Tray {
                Layout.fillWidth: true
                Layout.fillHeight: true
                bar: root
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
