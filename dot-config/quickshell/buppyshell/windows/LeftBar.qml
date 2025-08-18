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
        anchors {
          fill: parent
          rightMargin: Theme.radius.normalAdjusted
        }
        Workspaces {
          anchors.fill: parent
          orientation: Workspaces.Left
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
