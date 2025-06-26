import Quickshell
import QtQuick
import "root:/services"
import "."

Block {
  Text{
    text: "notifications"
    color: Theme.color.fg
    font.family: Theme.font.family.material
    font.pointSize: Theme.font.size.large
    font.bold: true
    anchors.centerIn: parent
  }
  MouseBlock {
    id: mouse
    onClicked: (mouse) => {
      if (mouse.button == Qt.MiddleButton) {
        Hyprland.dispatch("global buppyshell:clearNotifs");
      } else {
        Hyprland.dispatch("global buppyshell:toggleSidebar");
      }
    }
  }
}
