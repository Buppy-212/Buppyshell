import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import "root:/services"
import "."

Block {
  id: root
  readonly property var process: Process {
    command: ["rofi", "-show", "drun", "-config", "~/.config/rofi/menu.rasi"]
  }
  IconImage {
    implicitSize: Theme.blockHeight - Theme.border
    anchors.centerIn: parent
    source: Qt.resolvedUrl("root:/assets/archlinux.svg")
  }
  MouseBlock {
    id: mouse
    onClicked: process.startDetached() 
  }
}
