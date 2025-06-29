import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import "root:/services"
import "."

Block {
  Text {
    text: Idle.active ? "visibility_off" : "visibility"
    color: Theme.color.cyan
    font.pointSize: Theme.font.size.large
    font.family: Theme.font.family.material
    anchors.centerIn: parent
  }
  MouseBlock {
    id: mouse
    onClicked: Idle.toggleInhibitor()
  }
}
