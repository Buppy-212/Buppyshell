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
                Tray {
                    bar: root
                }
            }
        }
    }
    RoundCorner {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.rightMargin: Theme.width.block
        size: Theme.radius.normalAdjusted
        corner: RoundCorner.Corner.BottomRight
    }
    RoundCorner {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.rightMargin: Theme.width.block
        size: Theme.radius.normalAdjusted
        corner: RoundCorner.Corner.TopRight
    }
}
