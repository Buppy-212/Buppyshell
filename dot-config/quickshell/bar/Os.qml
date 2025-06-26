import Quickshell
import Quickshell.Io
import QtQuick
import "root:/services"
import "."

Block {
  id: root
  readonly property var process: Process {
    command: ["rofi", "-show", "drun", "-config", "~/.config/rofi/menu.rasi"]
  }
  Image {
    fillMode: Image.PreserveAspectCrop
    sourceSize.width: Theme.blockHeight - Theme.border
    sourceSize.height: Theme.blockHeight - Theme.border
    anchors.centerIn: parent
    source: Qt.resolvedUrl("root:/assets/archlinux.svg")
  }
  MouseBlock {
    id: mouse
    onClicked: process.startDetached() 
  }
}
