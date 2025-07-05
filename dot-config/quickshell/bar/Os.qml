import Quickshell
import Quickshell.Widgets
import "root:/services"

Block {
  id: root
  IconImage {
    implicitSize: Theme.blockHeight - Theme.border
    anchors.centerIn: parent
    source: Qt.resolvedUrl("root:/assets/archlinux.svg")
  }
  MouseBlock {
    id: mouse
    onClicked: Hyprland.dispatch("global buppyshell:launcher");
  }
}
